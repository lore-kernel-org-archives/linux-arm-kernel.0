From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 11 Feb 2016 13:26:27 +0100
Subject: [PATCH 2/3] ARM64: zynqmp: Extract clock information from EP108
In-Reply-To: <2f160e012080d5d6de11238ade239bb0bb224f64.1455193571.git.michal.simek@xilinx.com>
References: <2f160e012080d5d6de11238ade239bb0bb224f64.1455193571.git.michal.simek@xilinx.com>
Message-ID: <9232f2d8a45114a6d26b6fc18d454723930cadca.1455193571.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extract clocks and put it specific file to help with platform
autogeneration.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi | 88 ++++++++++++++++++++++++
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts      |  1 +
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi           | 43 +-----------
 3 files changed, 90 insertions(+), 42 deletions(-)
 create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
new file mode 100644
index 000000000000..cdc6a437dcc7
--- /dev/null
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi
@@ -0,0 +1,88 @@
+/*
+ * clock specification for Xilinx ZynqMP ep108 development board
+ *
+ * (C) Copyright 2015, Xilinx, Inc.
+ *
+ * Michal Simek <michal.simek@xilinx.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+&amba {
+	misc_clk: misc_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
+	i2c_clk: i2c_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0x0>;
+		clock-frequency = <111111111>;
+	};
+
+	sata_clk: sata_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <75000000>;
+	};
+};
+
+&can0 {
+	clocks = <&misc_clk &misc_clk>;
+};
+
+&gem0 {
+	clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
+};
+
+&gpio {
+	clocks = <&misc_clk>;
+};
+
+&i2c0 {
+	clocks = <&i2c_clk>;
+};
+
+&i2c1 {
+	clocks = <&i2c_clk>;
+};
+
+&sata {
+	clocks = <&sata_clk>;
+};
+
+&sdhci0 {
+	clocks = <&misc_clk>, <&misc_clk>;
+};
+
+&sdhci1 {
+	clocks = <&misc_clk>, <&misc_clk>;
+};
+
+&spi0 {
+	clocks = <&misc_clk &misc_clk>;
+};
+
+&spi1 {
+	clocks = <&misc_clk &misc_clk>;
+};
+
+&uart0 {
+	clocks = <&misc_clk &misc_clk>;
+};
+
+&usb0 {
+	clocks = <&misc_clk>, <&misc_clk>;
+};
+
+&usb1 {
+	clocks = <&misc_clk>, <&misc_clk>;
+};
+
+&watchdog0 {
+	clocks= <&misc_clk>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index ce5d848251fa..acb0527fdc4a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 
 /include/ "zynqmp.dtsi"
+/include/ "zynqmp-ep108-clk.dtsi"
 
 / {
 	model = "ZynqMP EP108";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 7bc65e391530..e595f22e7e4b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -90,7 +90,7 @@
 		};
 	};
 
-	amba {
+	amba: amba {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <1>;
@@ -99,7 +99,6 @@
 		can0: can at ff060000 {
 			compatible = "xlnx,zynq-can-1.0";
 			status = "disabled";
-			clocks = <&misc_clk &misc_clk>;
 			clock-names = "can_clk", "pclk";
 			reg = <0x0 0xff060000 0x1000>;
 			interrupts = <0 23 4>;
@@ -111,7 +110,6 @@
 		can1: can at ff070000 {
 			compatible = "xlnx,zynq-can-1.0";
 			status = "disabled";
-			clocks = <&misc_clk &misc_clk>;
 			clock-names = "can_clk", "pclk";
 			reg = <0x0 0xff070000 0x1000>;
 			interrupts = <0 24 4>;
@@ -120,12 +118,6 @@
 			rx-fifo-depth = <0x40>;
 		};
 
-		misc_clk: misc_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <25000000>;
-		};
-
 		gem0: ethernet at ff0b0000 {
 			compatible = "cdns,gem";
 			status = "disabled";
@@ -133,7 +125,6 @@
 			interrupts = <0 57 4>, <0 57 4>;
 			reg = <0x0 0xff0b0000 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk";
-			clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -145,7 +136,6 @@
 			interrupts = <0 59 4>, <0 59 4>;
 			reg = <0x0 0xff0c0000 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk";
-			clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -157,7 +147,6 @@
 			interrupts = <0 61 4>, <0 61 4>;
 			reg = <0x0 0xff0d0000 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk";
-			clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -169,7 +158,6 @@
 			interrupts = <0 63 4>, <0 63 4>;
 			reg = <0x0 0xff0e0000 0x1000>;
 			clock-names = "pclk", "hclk", "tx_clk";
-			clocks = <&misc_clk>, <&misc_clk>, <&misc_clk>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -178,7 +166,6 @@
 			compatible = "xlnx,zynqmp-gpio-1.0";
 			status = "disabled";
 			#gpio-cells = <0x2>;
-			clocks = <&misc_clk>;
 			interrupt-parent = <&gic>;
 			interrupts = <0 16 4>;
 			interrupt-controller;
@@ -186,19 +173,12 @@
 			reg = <0x0 0xff0a0000 0x1000>;
 		};
 
-		i2c_clk: i2c_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0x0>;
-			clock-frequency = <111111111>;
-		};
-
 		i2c0: i2c at ff020000 {
 			compatible = "cdns,i2c-r1p10";
 			status = "disabled";
 			interrupt-parent = <&gic>;
 			interrupts = <0 17 4>;
 			reg = <0x0 0xff020000 0x1000>;
-			clocks = <&i2c_clk>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -209,24 +189,16 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0 18 4>;
 			reg = <0x0 0xff030000 0x1000>;
-			clocks = <&i2c_clk>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
 
-		sata_clk: sata_clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <75000000>;
-		};
-
 		sata: ahci at fd0c0000 {
 			compatible = "ceva,ahci-1v84";
 			status = "disabled";
 			reg = <0x0 0xfd0c0000 0x2000>;
 			interrupt-parent = <&gic>;
 			interrupts = <0 133 4>;
-			clocks = <&sata_clk>;
 		};
 
 		sdhci0: sdhci at ff160000 {
@@ -236,7 +208,6 @@
 			interrupts = <0 48 4>;
 			reg = <0x0 0xff160000 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&misc_clk>, <&misc_clk>;
 		};
 
 		sdhci1: sdhci at ff170000 {
@@ -246,7 +217,6 @@
 			interrupts = <0 49 4>;
 			reg = <0x0 0xff170000 0x1000>;
 			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&misc_clk>, <&misc_clk>;
 		};
 
 		smmu: smmu at fd800000 {
@@ -268,7 +238,6 @@
 			interrupts = <0 19 4>;
 			reg = <0x0 0xff040000 0x1000>;
 			clock-names = "ref_clk", "pclk";
-			clocks = <&misc_clk &misc_clk>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -280,7 +249,6 @@
 			interrupts = <0 20 4>;
 			reg = <0x0 0xff050000 0x1000>;
 			clock-names = "ref_clk", "pclk";
-			clocks = <&misc_clk &misc_clk>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -291,7 +259,6 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0 36 4>, <0 37 4>, <0 38 4>;
 			reg = <0x0 0xff110000 0x1000>;
-			clocks = <&misc_clk>;
 			timer-width = <32>;
 		};
 
@@ -301,7 +268,6 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0 39 4>, <0 40 4>, <0 41 4>;
 			reg = <0x0 0xff120000 0x1000>;
-			clocks = <&misc_clk>;
 			timer-width = <32>;
 		};
 
@@ -311,7 +277,6 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0 42 4>, <0 43 4>, <0 44 4>;
 			reg = <0x0 0xff130000 0x1000>;
-			clocks = <&misc_clk>;
 			timer-width = <32>;
 		};
 
@@ -321,7 +286,6 @@
 			interrupt-parent = <&gic>;
 			interrupts = <0 45 4>, <0 46 4>, <0 47 4>;
 			reg = <0x0 0xff140000 0x1000>;
-			clocks = <&misc_clk>;
 			timer-width = <32>;
 		};
 
@@ -332,7 +296,6 @@
 			interrupts = <0 21 4>;
 			reg = <0x0 0xff000000 0x1000>;
 			clock-names = "uart_clk", "pclk";
-			clocks = <&misc_clk &misc_clk>;
 		};
 
 		uart1: serial at ff010000 {
@@ -342,7 +305,6 @@
 			interrupts = <0 22 4>;
 			reg = <0x0 0xff010000 0x1000>;
 			clock-names = "uart_clk", "pclk";
-			clocks = <&misc_clk &misc_clk>;
 		};
 
 		usb0: usb at fe200000 {
@@ -352,7 +314,6 @@
 			interrupts = <0 65 4>;
 			reg = <0x0 0xfe200000 0x40000>;
 			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&misc_clk>, <&misc_clk>;
 		};
 
 		usb1: usb at fe300000 {
@@ -362,13 +323,11 @@
 			interrupts = <0 70 4>;
 			reg = <0x0 0xfe300000 0x40000>;
 			clock-names = "clk_xin", "clk_ahb";
-			clocks = <&misc_clk>, <&misc_clk>;
 		};
 
 		watchdog0: watchdog at fd4d0000 {
 			compatible = "cdns,wdt-r1p2";
 			status = "disabled";
-			clocks= <&misc_clk>;
 			interrupt-parent = <&gic>;
 			interrupts = <0 52 1>;
 			reg = <0x0 0xfd4d0000 0x1000>;
-- 
1.9.1
