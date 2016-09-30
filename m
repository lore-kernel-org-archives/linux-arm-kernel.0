From: muhammadabdul.wahab@supelec.fr (Muhammad Abdul WAHAB)
Date: Fri, 30 Sep 2016 09:39:51 +0200
Subject: [PATCH] Adding Support for Coresight Components on Zynq 7000.
In-Reply-To: <20160929143411.GE16583@xsjsorenbubuntu>
References: <c6836102-9b7e-a9d9-bad9-34b100d4ae49@supelec.fr>
 <20160929143411.GE16583@xsjsorenbubuntu>
Message-ID: <920cac6c-e56a-60d5-4882-22892058346d@supelec.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi S?ren,

Thank you for your remarks. I corrected a few things as you suggested.

 > I'm curious, did you test that with external debug tools. I have the
 > feeling the kernel using the debug HW could interfere with JTAG
 > debuggers, external trace tools, etc.

I did not test with any external debug tools. For testing, I obtained
trace for simple function (e.g. loop) on Xilinx standalone and I then
traced the same function under Linux. Then, I compare both traces
obtained under standalone and under Linux. I decoded the trace to make
  sure that the trace I get corresponds to my function. The instructions
for testing here only allows users to see that coresight components
are enabled and generating traces. The trace still need to be decoded
to make sure whether the trace is correct or not. It can be done by
openCSD[1] library.

 > Use labels please.
I changed the entries to use labels. I don't need phandle anymore.

 >> +        tpiu at F8803000 {
 >>>
 >>> +            compatible = "arm,coresight-tpiu", "arm,primecell";
 >>> +            reg = <0xf8803000 0x1000>;
 >>> +            clocks = <&clkc 47>, <&clkc 16>;
 >>
 >
 > I'm not sure this is correct for every setup. Sorry, that I don't recall
 > all the details, I haven't used tracing in a long time. But I guess this
 > clock is configurable as you're referring an fclk here. The other thing
 > that makes me a little suspicious is, that nothing in here uses the
 > 'dbg_trc' clock that the clock controller provides.

The TPIU setup included in my patch is specific to my configuration of TPIU.
The second clock is configurable but I didn't know how to do so. As in
Vivado setup I chose "fclk1" as the clock for TPIU, I decided to put fclk1.
But, I am not sure about this. I am having some problems when I recover the
trace from TPIU: it is not the same as in ETB even though it resembles a 
lot.
I don't know if the problem is coming from the device tree or from the 
driver.
I will have a look at 'dbg_trc' clock.

 >>
 >> +            clock-names = "apb_pclk", "fclk1";
 >>
 > Those names (at least fclk1) is not a good name for tpiu to identify
 > it's input. fclk1 is a zynq-specific clock, and as mentioned above, it
 > seems likely that this could easily become a different one. The
 > clock-names are meant to identify an input from the consumer's
 > perspective. The correct names should be documented in the DT binding.

The first name was chosen as "apb_pclk" because it was recommended in
Documentation. On the second name, I agree with you but again for TPIU DT
entry, I am not sure how to make this clock configurable. So, that's why
I put the same clock name as I had in my Vivado setup. If you have any
leads on how to make it configurable, I will be happy to take a look
into it.

 >> +            clock-frequency=<0xee6b280>;
 >>
 > I cannot find this property in the binding.
 >

This property was described in clock binding (in an example [2]) and the
value here (250MHz) corresponds to the value I had chosen in Vivado for
TPIU input clock.

 > I think nodes were ordered alphabetically in our DTs.

Yes, I modified the patch to take care of it. Thank you.

Muhammad Abdul WAHAB

[1]: https://github.com/Linaro/OpenCSD
[2]: Documentation/devicetree/bindings/clock/clock-bindings.txt
---
--- linux-4.7/arch/arm/boot/dts/zynq-7000.dtsi.orig    2016-07-24 
21:23:50.000000000 +0200
+++ linux-4.7/arch/arm/boot/dts/zynq-7000.dtsi    2016-09-29 
20:42:44.286322433 +0200
@@ -96,6 +96,57 @@
              rx-fifo-depth = <0x40>;
          };

+        etb at F8801000 {
+            compatible = "arm,coresight-etb10", "arm,primecell";
+            reg = <0xf8801000 0x1000>;
+
+            coresight-default-sink;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+
+            port {
+                etb_in_port: endpoint at 0 {
+                    slave-mode;
+                    remote-endpoint = <&replicator_out_port0>;
+                };
+            };
+        };
+
+        funnel at F8804000 {
+            compatible = "arm,coresight-funnel", "arm,primecell";
+            reg = <0xf8804000 0x1000>;
+
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+            ports {
+                #address-cells = <0x1>;
+                #size-cells = <0x0>;
+
+                port at 0 {
+                    reg = <0x0>;
+                    funnel_out_port0: endpoint {
+                        remote-endpoint = <&replicator_in_port0>;
+                    };
+                };
+
+                port at 1 {
+                    reg = <0x0>;
+                    funnel_in_port0: endpoint {
+                        slave-mode;
+                        remote-endpoint = <&ptm0_out_port>;
+                    };
+                };
+
+                port at 2 {
+                    reg = <0x1>;
+                    funnel_in_port1: endpoint {
+                        slave-mode;
+                        remote-endpoint = <&ptm1_out_port>;
+                    };
+                };
+            };
+        };
+
          gpio0: gpio at e000a000 {
              compatible = "xlnx,zynq-gpio-1.0";
              #gpio-cells = <2>;
@@ -311,6 +362,82 @@
              clocks = <&clkc 4>;
          };

+        ptm0 at F889C000 {
+            compatible = "arm,coresight-etm3x", "arm,primecell";
+            reg = <0xf889c000 0x1000>;
+
+            cpu = <&cpu0>;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+
+            port {
+                ptm0_out_port: endpoint {
+                    remote-endpoint = <&funnel_in_port0>;
+                };
+            };
+        };
+
+        ptm1 at F889D000 {
+            compatible = "arm,coresight-etm3x", "arm,primecell";
+            reg = <0xf889d000 0x1000>;
+
+            cpu = <&cpu1>;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+
+            port {
+                ptm1_out_port: endpoint {
+                    remote-endpoint = <&funnel_in_port1>;
+                };
+            };
+        };
+
+        replicator {
+            compatible = "arm,coresight-replicator";
+
+            ports {
+                #address-cells = <0x1>;
+                #size-cells = <0x0>;
+
+                port at 0 {
+                    reg = <0x0>;
+                    replicator_out_port0: endpoint {
+                        remote-endpoint = <&etb_in_port>;
+                    };
+                };
+
+                port at 1 {
+                    reg = <0x1>;
+                    replicator_out_port1: endpoint {
+                        remote-endpoint = <&tpiu_in_port>;
+                    };
+                };
+
+                port at 2 {
+                    reg = <0x0>;
+                    replicator_in_port0: endpoint {
+                        slave-mode;
+                        remote-endpoint = <&funnel_out_port0>;
+                    };
+                };
+            };
+        };
+
+        tpiu at F8803000 {
+            compatible = "arm,coresight-tpiu", "arm,primecell";
+            reg = <0xf8803000 0x1000>;
+
+            clocks = <&clkc 47>, <&clkc 46>;
+            clock-names = "apb_pclk", "configurable_clk";
+            clock-frequency=<0xee6b280>;
+
+            port {
+                tpiu_in_port: endpoint at 0 {
+                    slave-mode;
+                    remote-endpoint = <&replicator_out_port0>;
+                };
+            };
+        };
+
          ttc0: timer at f8001000 {
              interrupt-parent = <&intc>;
              interrupts = <0 10 4>, <0 11 4>, <0 12 4>;
