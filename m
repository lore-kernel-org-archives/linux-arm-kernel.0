From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Fri, 24 Jul 2015 17:21:21 -0700
Subject: [RFCv2 2/3] dts: zynq: Add devicetree entry for Xilinx Zynq reset
 controller.
In-Reply-To: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
References: <1437783682-13632-1-git-send-email-moritz.fischer@ettus.com>
Message-ID: <1437783682-13632-3-git-send-email-moritz.fischer@ettus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi            | 43 ++++++++++++-
 arch/arm/boot/dts/zynq-parallella.dts       |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts            |  2 +-
 arch/arm/boot/dts/zynq-zc706.dts            |  2 +-
 arch/arm/boot/dts/zynq-zed.dts              |  2 +-
 arch/arm/boot/dts/zynq-zybo.dts             |  2 +-
 include/dt-bindings/reset/xlnx,zynq-reset.h | 94 +++++++++++++++++++++++++++++
 7 files changed, 141 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/reset/xlnx,zynq-reset.h

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index b429e1d..1d4faa2 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -1,5 +1,6 @@
 /*
  *  Copyright (C) 2011 - 2014 Xilinx
+ *  Copyright (C) 2015 National Instruments Corp.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -10,7 +11,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
+#include <dt-bindings/reset/xlnx,zynq-reset.h>
 
 / {
 	compatible = "xlnx,zynq-7000";
@@ -77,6 +79,8 @@
 			status = "disabled";
 			clocks = <&clkc 19>, <&clkc 36>;
 			clock-names = "can_clk", "pclk";
+			resets = <&rstc CAN0_RESET>, <&rstc CAN0_REF_RESET>;
+			reset-names = "reset", "ref_reset";
 			reg = <0xe0008000 0x1000>;
 			interrupts = <0 28 4>;
 			interrupt-parent = <&intc>;
@@ -89,6 +93,8 @@
 			status = "disabled";
 			clocks = <&clkc 20>, <&clkc 37>;
 			clock-names = "can_clk", "pclk";
+			resets = <&rstc CAN1_RESET>, <&rstc CAN1_REF_RESET>;
+			reset-names = "reset", "ref_reset";
 			reg = <0xe0009000 0x1000>;
 			interrupts = <0 51 4>;
 			interrupt-parent = <&intc>;
@@ -100,6 +106,8 @@
 			compatible = "xlnx,zynq-gpio-1.0";
 			#gpio-cells = <2>;
 			clocks = <&clkc 42>;
+			resets = <&rstc GPIO_RESET>;
+			reset-names = "reset";
 			gpio-controller;
 			interrupt-parent = <&intc>;
 			interrupts = <0 20 4>;
@@ -110,6 +118,8 @@
 			compatible = "cdns,i2c-r1p10";
 			status = "disabled";
 			clocks = <&clkc 38>;
+			reset = <&rstc I2C0_RESET>;
+			reset-names = "reset";
 			interrupt-parent = <&intc>;
 			interrupts = <0 25 4>;
 			reg = <0xe0004000 0x1000>;
@@ -121,6 +131,8 @@
 			compatible = "cdns,i2c-r1p10";
 			status = "disabled";
 			clocks = <&clkc 39>;
+			resets = <&rstc I2C1_RESET>;
+			reset-names = "reset";
 			interrupt-parent = <&intc>;
 			interrupts = <0 48 4>;
 			reg = <0xe0005000 0x1000>;
@@ -148,6 +160,8 @@
 		mc: memory-controller at f8006000 {
 			compatible = "xlnx,zynq-ddrc-a05";
 			reg = <0xf8006000 0x1000>;
+			resets = <&rstc DDR_RESET>;
+			reset-names = "reset";
 		};
 
 		uart0: serial at e0000000 {
@@ -155,6 +169,8 @@
 			status = "disabled";
 			clocks = <&clkc 23>, <&clkc 40>;
 			clock-names = "uart_clk", "pclk";
+			resets = <&rstc UART0_RESET>, <&rstc UART0_REF_RESET>;
+			reset-names = "reset", "ref_reset";
 			reg = <0xE0000000 0x1000>;
 			interrupts = <0 27 4>;
 		};
@@ -164,6 +180,8 @@
 			status = "disabled";
 			clocks = <&clkc 24>, <&clkc 41>;
 			clock-names = "uart_clk", "pclk";
+			resets = <&rstc UART1_RESET>, <&rstc UART1_REF_RESET>;
+			reset-names = "reset", "ref_reset";
 			reg = <0xE0001000 0x1000>;
 			interrupts = <0 50 4>;
 		};
@@ -176,6 +194,8 @@
 			interrupts = <0 26 4>;
 			clocks = <&clkc 25>, <&clkc 34>;
 			clock-names = "ref_clk", "pclk";
+			resets = <&rstc SPI0_RESET>, <&rstc SPI0_REF_RESET>;
+			reset-names = "reset", "ref_reset";
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -188,6 +208,8 @@
 			interrupts = <0 49 4>;
 			clocks = <&clkc 26>, <&clkc 35>;
 			clock-names = "ref_clk", "pclk";
+			resets = <&rstc SPI1_RESET>, <&rstc SPI1_REF_RESET>;
+			reset-names = "reset", "ref_reset";
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -199,6 +221,9 @@
 			interrupts = <0 22 4>;
 			clocks = <&clkc 30>, <&clkc 30>, <&clkc 13>;
 			clock-names = "pclk", "hclk", "tx_clk";
+			resets = <&rstc GEM0_RESET>, <&rstc GEM0_REF_RESET>,
+				<&rstc GEM0_RX_RESET>;
+			reset-names = "reset", "ref_reset", "rx_reset";
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -210,6 +235,9 @@
 			interrupts = <0 45 4>;
 			clocks = <&clkc 31>, <&clkc 31>, <&clkc 14>;
 			clock-names = "pclk", "hclk", "tx_clk";
+			resets = <&rstc GEM1_RESET>, <&rstc GEM1_REF_RESET>,
+				<&rstc GEM1_RX_RESET>;
+			reset-names = "reset", "ref_reset", "rx_reset";
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
@@ -258,6 +286,13 @@
 				reg = <0x100 0x100>;
 			};
 
+			rstc: rstc at 200 {
+				compatible = "xlnx,zynq-reset";
+				reg = <0x200 0x50>;
+				#reset-cells = <1>;
+				syscon = <&slcr>;
+			};
+
 			pinctrl0: pinctrl at 700 {
 				compatible = "xlnx,pinctrl-zynq";
 				reg = <0x700 0x200>;
@@ -281,6 +316,8 @@
 			#dma-requests = <4>;
 			clocks = <&clkc 27>;
 			clock-names = "apb_pclk";
+			resets = <&rstc DMAC_RESET>;
+			reset-names = "dmac_reset";
 		};
 
 		devcfg: devcfg at f8007000 {
@@ -333,6 +370,8 @@
 			interrupts = <0 21 4>;
 			reg = <0xe0002000 0x1000>;
 			phy_type = "ulpi";
+			resets = <&rstc USB0_RESET>;
+			reset-names = "usb_reset";
 		};
 
 		usb1: usb at e0003000 {
@@ -343,6 +382,8 @@
 			interrupts = <0 44 4>;
 			reg = <0xe0003000 0x1000>;
 			phy_type = "ulpi";
+			resets = <&rstc USB1_RESET>;
+			reset-names = "usb_reset";
 		};
 
 		watchdog0: watchdog at f8005000 {
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 9efd16c..adb0f6e 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -17,7 +17,7 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-7000.dtsi"
 
 / {
 	model = "Adapteva Parallella Board";
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index fb59d34..3a08b47 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -12,7 +12,7 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-7000.dtsi"
 
 / {
 	model = "Zynq ZC702 Development Board";
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index abf5d23..b238be3 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -12,7 +12,7 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-7000.dtsi"
 
 / {
 	model = "Zynq ZC706 Development Board";
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index b9f2522..38c15ca 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -12,7 +12,7 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-7000.dtsi"
 
 / {
 	model = "Zynq Zed Development Board";
diff --git a/arch/arm/boot/dts/zynq-zybo.dts b/arch/arm/boot/dts/zynq-zybo.dts
index 16c9cac..5192e41 100644
--- a/arch/arm/boot/dts/zynq-zybo.dts
+++ b/arch/arm/boot/dts/zynq-zybo.dts
@@ -12,7 +12,7 @@
  * GNU General Public License for more details.
  */
 /dts-v1/;
-/include/ "zynq-7000.dtsi"
+#include "zynq-7000.dtsi"
 
 / {
 	model = "Zynq ZYBO Development Board";
diff --git a/include/dt-bindings/reset/xlnx,zynq-reset.h b/include/dt-bindings/reset/xlnx,zynq-reset.h
new file mode 100644
index 0000000..09bdcef
--- /dev/null
+++ b/include/dt-bindings/reset/xlnx,zynq-reset.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright (c) 2015, National Instruments Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_RESET_XLNX_RST_H
+#define _DT_BINDINGS_RESET_XLNX_RST_H
+
+/* PSS_RST_CTRL */
+#define SOFT_RESET		0
+
+/* DDR_RST_CTRL */
+#define DDR_RESET		32
+
+/* TOPSW_RST_CTRL */
+#define TOPSW_RESET		64
+
+/* DMAC_RST_CTRL */
+#define DMAC_RESET		96
+
+/* USB_RST_CTRL */
+#define USB0_RESET	128
+#define USB1_RESET	129
+
+/* GEM_RST_CTRL */
+#define GEM0_RESET	160
+#define GEM1_RESET	161
+#define GEM0_RX_RESET		164
+#define GEM1_RX_RESET		165
+#define GEM0_REF_RESET		166
+#define GEM1_REF_RESET		167
+
+/* SDIO_RST_CTRL */
+#define SDIO0_RESET	192
+#define SDIO1_RESET	193
+#define SDIO0_REF_RESET		196
+#define SDIO1_REF_RESET		197
+
+/* SPI_RST_CTRL */
+#define SPI0_RESET	224
+#define SPI1_RESET	225
+#define SPI0_REF_RESET		226
+#define SPI1_REF_RESET		227
+
+/* CAN_RST_CTRL */
+#define CAN0_RESET	256
+#define CAN1_RESET	257
+#define CAN0_REF_RESET		258
+#define CAN1_REF_RESET		259
+
+/* I2C_RST_CTRL */
+#define I2C0_RESET	288
+#define I2C1_RESET	289
+
+/* UART_RST_CTRL */
+#define UART0_RESET	320
+#define UART1_RESET	321
+#define UART0_REF_RESET		322
+#define UART1_REF_RESET		323
+
+/* GPIO_RST_CTRL */
+#define GPIO_RESET	352
+
+/* LQSPI_RST_CTRL */
+#define LQSPI_RESET	384
+#define QSPI_REF_RESET		385
+
+/* SMC_RST_CTRL */
+#define SMC_RESET		416
+#define SMC_REF_RESET		417
+
+/* OCM_RST_CTRL */
+#define OCM_RESET		448
+
+/* FPGA_RST_CTRL */
+#define FPGA0_OUT_RESET		512
+#define FPGA1_OUT_RESET		513
+#define FPGA2_OUT_RESET		514
+#define FPGA3_OUT_RESET		515
+
+/* A9_CPU_RST_CTRL */
+#define A9_RESET0		544
+#define A9_RESET1		545
+#define PERI_RESET		552
+
+#endif
-- 
2.4.3
