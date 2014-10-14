From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 Oct 2014 15:04:08 +0200
Subject: [PATCH 1/8] ARM: realview: move DT GIC to FPGA node
Message-ID: <1413291855-499-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This creates a node in the device tree to hold the FPGA devices
as a "simple-bus" and moves the GIC found on the FPGA to this
node, so it reflects the actual topology of the system.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/arm-realview-pb1176.dts | 32 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index 3135939cd13f..f780adde2332 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -153,18 +153,6 @@
 			      <0x10120000 0x100>;
 		};
 
-		/* This GIC on the board is cascaded off the DevChip GIC */
-		intc_pb1176: interrupt-controller at 10040000 {
-			compatible = "arm,arm1176jzf-devchip-gic", "arm,arm11mp-gic";
-			#interrupt-cells = <3>;
-			#address-cells = <1>;
-			interrupt-controller;
-			reg = <0x10041000 0x1000>,
-			      <0x10040000 0x100>;
-			interrupt-parent = <&intc_dc1176>;
-			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		L2: l2-cache {
 			compatible = "arm,l220-cache";
 			reg = <0x10110000 0x1000>;
@@ -244,4 +232,24 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 	};
+
+	/* These peripherals are inside the FPGA rather than the DevChip */
+	fpga {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		ranges;
+
+		/* This GIC on the board is cascaded off the DevChip GIC */
+		intc_fpga1176: interrupt-controller at 10040000 {
+			compatible = "arm,arm1176jzf-devchip-gic", "arm,arm11mp-gic";
+			#interrupt-cells = <3>;
+			#address-cells = <1>;
+			interrupt-controller;
+			reg = <0x10041000 0x1000>,
+			      <0x10040000 0x100>;
+			interrupt-parent = <&intc_dc1176>;
+			interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
 };
-- 
1.9.3
