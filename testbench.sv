`timescale 1ns / 1ps

`include "halfadder.sv"

module testbench();

// Signals for UUT connection
reg A;
reg B;
wire S;
wire C;
reg pass;
integer tests_failed;

// Instantiate the unit under test
halfadder uut(A, B, S, C);

initial begin
    // Set up output to VCDD file
    $dumpfile("tb.vcd");
    $dumpvars(0, testbench);

    // Initialize testbench variables
end

// Write Test Stimulus
task test_00();
    begin
        A = 0;
        B = 0;
        #5;
        if (!(S == 0 & C == 0)) begin
            tests_failed = tests_failed + 1;
            pass = 0;
        end
    end
endtask

task test_01();
    begin
        A = 0;
        B = 1;
        #5;
        if (!(S == 1 & C == 0)) begin
            tests_failed = tests_failed + 1;
            pass = 0;
        end
    end
endtask

task test_10();
    begin
        A = 1;
        B = 0;
        #5;
        if (!(S == 1 & C == 0)) begin
            tests_failed = tests_failed + 1;
            pass = 0;
        end        
    end
endtask

task test_11 ();
    begin
        A = 1;
        B = 1;
        #5;
        if (!(S == 0 & C == 1)) begin
            tests_failed = tests_failed + 1;
            pass = 0;
        end
    end
endtask

// Write Checker
initial begin
    pass = 1'b1;
    tests_failed = 2'b00;
    test_00(); #15;
    test_01(); #15;
    test_10(); #15;
    test_11(); #15;

    if (pass) begin
        $display("Tests Passed!");
    end else begin
        $display("Tests Failed: %0d", tests_failed);
    end
end

endmodule
