From: muhammadabdul.wahab@supelec.fr (Muhammad Abdul WAHAB)
Date: Thu, 29 Sep 2016 12:26:13 +0200
Subject: [PATCH] Adding Support for Coresight Components on Zynq 7000.
Message-ID: <c6836102-9b7e-a9d9-bad9-34b100d4ae49@supelec.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Coresight components are present on the Zynq SoC but the corresponding
device tree entries are missing. This patch adds device tree entries for
coresight components while explaining how it was done in order to allow
porting towards other boards easily.

By adding the entries for Coresight components in the device tree: if no
files are created in sysfile system, you need to contact the board designer
to sort out the problem. On some boards, Coresight components are not
powered on boot.

Signed-off-by: Muhammad Abdul Wahab <muhammadabdul.wahab@centralesupelec.fr>
---
The documentation file was very helpful
(Documentation/devicetree/bindings/arm/coresight.txt). However, few details
can be added to make it more clear for beginners.

Things to modify in device tree when changing the board are mainly:

- address
- `clocks` field
- some references in other entries may be missing (e.g. for `CPU` field in
   ETM/PTM component, references need to be created)

Furthermore, the `reg` field should be adapted according to
`#address-cells` and `#size-cells`. It may appear obvious, not for
beginners.

## Testing

The trace sink components need to be enabled by accessing through sysfile
system.

     echo 1 > /sys/bus/coresight/devices/@addr.etb/enable\_sink

Then enable the CS source component:

     echo 1 > /sys/bus/coresight/devices/@addr.ptm/enable\_source

By default, CS Source components are configured to trace the kernel.

Then the trace can be read by dumping ETB.

     dd if=/dev/@addr.etb of=trace_kernel.bin

The trace can be visualized by:

     hexdump -C trace_kernel.bin

Or stored using:

     hexdump -C trace_kernel.bin > trace_kernel.txt

The trace need to be decoded to be readable. All these above steps can now
be performed with Perf Library which was not available at the time I was
playing with DT entries.

--- linux-4.7/arch/arm/boot/dts/zynq-7000.dtsi.orig     2016-07-24 
21:23:50.000000000 +0200
+++ linux-4.7/arch/arm/boot/dts/zynq-7000.dtsi    2016-09-28 
19:13:52.651881000 +0200
@@ -363,5 +363,159 @@
              reg = <0xf8005000 0x1000>;
              timeout-sec = <10>;
          };
+
+        etb at F8801000 {
+            compatible = "arm,coresight-etb10", "arm,primecell";
+            reg = <0xf8801000 0x1000>;
+            coresight-default-sink;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+
+            port {
+
+                endpoint at 0 {
+                    slave-mode;
+                    remote-endpoint = <0x8>;
+                    linux,phandle = <0xd>;
+                    phandle = <0xd>;
+                };
+            };
+        };
+
+        tpiu at F8803000 {
+            compatible = "arm,coresight-tpiu", "arm,primecell";
+            reg = <0xf8803000 0x1000>;
+            clocks = <&clkc 47>, <&clkc 16>;
+            clock-names = "apb_pclk", "fclk1";
+            clock-frequency=<0xee6b280>;
+
+            port {
+
+                endpoint at 0 {
+                    slave-mode;
+                    remote-endpoint = <0x9>;
+                    linux,phandle = <0xe>;
+                    phandle = <0xe>;
+                };
+            };
+        };
+
+        funnel at F8804000 {
+            compatible = "arm,coresight-funnel", "arm,primecell";
+            reg = <0xf8804000 0x1000>;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+
+            ports {
+                #address-cells = <0x1>;
+                #size-cells = <0x0>;
+
+                port at 0 {
+                    reg = <0x0>;
+
+                    endpoint {
+                        remote-endpoint = <0xa>;
+                        linux,phandle = <0xf>;
+                        phandle = <0xf>;
+                    };
+                };
+
+                port at 1 {
+                    reg = <0x0>;
+
+                    endpoint {
+                        slave-mode;
+                        remote-endpoint = <0xb>;
+                        linux,phandle = <0x11>;
+                        phandle = <0x11>;
+                    };
+                };
+
+                port at 2 {
+                    reg = <0x1>;
+
+                    endpoint {
+                        slave-mode;
+                        remote-endpoint = <0xc>;
+                        linux,phandle = <0x13>;
+                        phandle = <0x13>;
+                    };
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
+
+                    endpoint {
+                        remote-endpoint = <0xd>;
+                        linux,phandle = <0x8>;
+                        phandle = <0x8>;
+                    };
+                };
+
+                port at 1 {
+                    reg = <0x1>;
+
+                    endpoint {
+                        remote-endpoint = <0xe>;
+                        linux,phandle = <0x9>;
+                        phandle = <0x9>;
+                    };
+                };
+
+                port at 2 {
+                    reg = <0x0>;
+
+                    endpoint {
+                        slave-mode;
+                        remote-endpoint = <0xf>;
+                        linux,phandle = <0xa>;
+                        phandle = <0xa>;
+                    };
+                };
+            };
+        };
+
+        ptm0 at F889C000 {
+            compatible = "arm,coresight-etm3x", "arm,primecell";
+            reg = <0xf889c000 0x1000>;
+            cpu = <0x10>;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+
+            port {
+
+                endpoint {
+                    remote-endpoint = <0x11>;
+                    linux,phandle = <0xb>;
+                    phandle = <0xb>;
+                };
+            };
+        };
+
+        ptm1 at F889D000 {
+            compatible = "arm,coresight-etm3x", "arm,primecell";
+            reg = <0xf889d000 0x1000>;
+            cpu = <0x12>;
+            clocks = <&clkc 47>;
+            clock-names = "apb_pclk";
+
+            port {
+
+                endpoint {
+                    remote-endpoint = <0x13>;
+                    linux,phandle = <0xc>;
+                    phandle = <0xc>;
+                };
+            };
+        };
      };
  };
