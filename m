From: muhammadabdul.wahab@supelec.fr (Muhammad Abdul WAHAB)
Date: Mon, 3 Oct 2016 16:16:12 +0200
Subject: [PATCH] Adding Support for Coresight Components on Zynq 7000.
In-Reply-To: <20161003133019.GF7630@xsjsorenbubuntu>
References: <c6836102-9b7e-a9d9-bad9-34b100d4ae49@supelec.fr>
 <20160929143411.GE16583@xsjsorenbubuntu>
 <920cac6c-e56a-60d5-4882-22892058346d@supelec.fr>
 <20160930165325.GA7630@xsjsorenbubuntu>
 <5b56a00a-ac69-b15d-1155-bab53ed766f3@supelec.fr>
 <20161003133019.GF7630@xsjsorenbubuntu>
Message-ID: <9978f0c8-fe1b-86c1-46e2-84df268d24fa@supelec.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again S?ren,

 > Sounds good. AFAICT, the change below should be OK. Probably some
 > stylistic changes to make it blend in with the rest of the DT (e.g.
 > use lower case characters in the address parts of the node name).

The change to low characters has been made for address part. I also
deleted some empty lines to respect the style of the rest of the DT.

 > I'd say that depends on what it is about. If it is about DT and the TPIU
 > Linux driver, I'd say, keep it on list and probably even include the
 > authors of that driver (the folks the get_maintainers script is
 > identifying for that driver).
 >
 > If it's specific to Zynq, the Xilinx forums can be quite helpful as
 > there are a lot of people familiar with the device
 > (https://forums.xilinx.com/t5/Embedded-Linux/bd-p/ELINUX).
 >
 > But when in doubt, feel free to reach out to me directly.

OK. Thank you !

M.Abdul WAHAB
---
--- linux-4.7/arch/arm/boot/dts/zynq-7000.dtsi.orig    2016-07-24 
21:23:50.000000000 +0200
+++ linux-4.7/arch/arm/boot/dts/zynq-7000.dtsi    2016-10-03 
15:54:35.228460164 +0200
@@ -96,6 +96,51 @@
              rx-fifo-depth = <0x40>;
          };

+        etb at f8801000 {
+            compatible = "arm,coresight-etb10", "arm,primecell";
+            reg = <0xf8801000 0x1000>;
+            coresight-default-sink;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+            port {
+                etb_in_port: endpoint at 0 {
+                    slave-mode;
+                    remote-endpoint = <&replicator_out_port0>;
+                };
+            };
+        };
+
+        funnel at f8804000 {
+            compatible = "arm,coresight-funnel", "arm,primecell";
+            reg = <0xf8804000 0x1000>;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+            ports {
+                #address-cells = <0x1>;
+                #size-cells = <0x0>;
+                port at 0 {
+                    reg = <0x0>;
+                    funnel_out_port0: endpoint {
+                        remote-endpoint = <&replicator_in_port0>;
+                    };
+                };
+                port at 1 {
+                    reg = <0x0>;
+                    funnel_in_port0: endpoint {
+                        slave-mode;
+                        remote-endpoint = <&ptm0_out_port>;
+                    };
+                };
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
@@ -311,6 +356,59 @@
              clocks = <&clkc 4>;
          };

+        ptm0 at f889c000 {
+            compatible = "arm,coresight-etm3x", "arm,primecell";
+            reg = <0xf889c000 0x1000>;
+            cpu = <&cpu0>;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+            port {
+                ptm0_out_port: endpoint {
+                    remote-endpoint = <&funnel_in_port0>;
+                };
+            };
+        };
+
+        ptm1 at f889d000 {
+            compatible = "arm,coresight-etm3x", "arm,primecell";
+            reg = <0xf889d000 0x1000>;
+            cpu = <&cpu1>;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+            port {
+                ptm1_out_port: endpoint {
+                    remote-endpoint = <&funnel_in_port1>;
+                };
+            };
+        };
+
+        replicator {
+            compatible = "arm,coresight-replicator";
+            ports {
+                #address-cells = <0x1>;
+                #size-cells = <0x0>;
+                port at 0 {
+                    reg = <0x0>;
+                    replicator_out_port0: endpoint {
+                        remote-endpoint = <&etb_in_port>;
+                    };
+                };
+                port at 1 {
+                    reg = <0x1>;
+                    replicator_out_port1: endpoint {
+                        remote-endpoint = <&tpiu_in_port>;
+                    };
+                };
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
          ttc0: timer at f8001000 {
              interrupt-parent = <&intc>;
              interrupts = <0 10 4>, <0 11 4>, <0 12 4>;
