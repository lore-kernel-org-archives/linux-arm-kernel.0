From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 31 Jul 2011 02:53:21 +0800
Subject: [PATCH v2 3/3] arm/mx5: add device tree support for imx51 babbage
In-Reply-To: <1312052001-16660-1-git-send-email-shawn.guo@linaro.org>
References: <1312052001-16660-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1312052001-16660-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree support for imx51 babbage board.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/arm/fsl/boards.txt         |    4 +
 arch/arm/boot/dts/imx51-babbage.dts                |  548 +++++++++
 arch/arm/boot/dts/imx51.dtsi                       | 1190 ++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                          |    8 +
 arch/arm/mach-mx5/Makefile                         |    1 +
 arch/arm/mach-mx5/imx51-dt.c                       |  101 ++
 6 files changed, 1852 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx51-babbage.dts
 create mode 100644 arch/arm/boot/dts/imx51.dtsi
 create mode 100644 arch/arm/mach-mx5/imx51-dt.c

diff --git a/Documentation/devicetree/bindings/arm/fsl/boards.txt b/Documentation/devicetree/bindings/arm/fsl/boards.txt
index d1e8d6f..e2401cd 100644
--- a/Documentation/devicetree/bindings/arm/fsl/boards.txt
+++ b/Documentation/devicetree/bindings/arm/fsl/boards.txt
@@ -1,3 +1,7 @@
+i.MX51 Babbage Board
+Required root node properties:
+    - compatible = "fsl,imx51-babbage", "fsl,imx51";
+
 i.MX53 Automotive Reference Design Board
 Required root node properties:
     - compatible = "fsl,imx53-ard", "fsl,imx53";
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
new file mode 100644
index 0000000..114253d
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -0,0 +1,548 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx51.dtsi"
+
+/ {
+	model = "Freescale i.MX51 Babbage Board";
+	compatible = "fsl,imx51-babbage", "fsl,imx51";
+
+	chosen {
+		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
+	};
+
+	memory {
+		reg = <0x90000000 0x20000000>;
+	};
+
+	aips at 70000000 { /* aips-1 */
+		spba at 70000000 {
+			esdhc at 70004000 { /* ESDHC1 */
+				fsl,cd-internal;
+				fsl,wp-internal;
+			};
+
+			esdhc at 70008000 { /* ESDHC2 */
+				cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
+				wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
+			};
+
+			uart2: uart at 7000c000 { /* UART3 */
+				fsl,uart-has-rtscts;
+			};
+
+			ecspi at 70010000 { /* ECSPI1 */
+				fsl,spi-num-chipselects = <2>;
+				cs-gpios = <&gpio3 24 0>, /* GPIO4_24 */
+					   <&gpio3 25 0>; /* GPIO4_25 */
+
+				pmic: mc13892 at 0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,mc13892";
+					spi-max-frequency = <6000000>;
+					reg = <0>;
+					mc13xxx-irq-gpios = <&gpio0 8 0>; /* GPIO1_8 */
+					fsl,mc13xxx-uses-regulator;
+				};
+
+				flash: at45db321d at 1 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <25000000>;
+					reg = <1>;
+
+					partition at 0 {
+						label = "U-Boot";
+						reg = <0x0 0x40000>;
+						read-only;
+					};
+
+					partition at 40000 {
+						label = "Kernel";
+						reg = <0x40000 0x3c0000>;
+					};
+				};
+			};
+
+			esdhc at 70020000 { /* ESDHC3 */
+				status = "disabled";
+			};
+
+			esdhc at 70024000 { /* ESDHC4 */
+				status = "disabled";
+			};
+
+			i2c at 70038000 { /* HS-I2C */
+				status = "disabled";
+			};
+		};
+
+		iomuxc at 73fa8000 {
+			/*
+			 * UART1
+			 */
+			uart1-rxd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-select-input = <0x9e4 0x0>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			uart1-txd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			uart1-rts {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-select-input = <0x9e0 0x0>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			uart1-cts {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			/*
+			 * UART2
+			 */
+			uart2-rxd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-select-input = <0x9ec 0x2>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			uart2-txd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			/*
+			 * UART3
+			 */
+			eim-d25 { /* UART3_RXD */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-select-input = <0x9f4 0x0>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			eim-d26 { /* UART3_TXD */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			eim-d27 { /* UART3_RTS */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-select-input = <0x9f0 0x3>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			eim-d24 { /* UART3_CTS */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-pad-ctl = <0x1c5>;
+			};
+
+			/*
+			 * I2C1
+			 */
+			eim-d16 { /* I2C1_SDA */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x9b4 0x0>;
+				fsl,iomuxc-pad-ctl = <0x1ec>;
+			};
+
+			eim-d19 { /* I2C1_SCL */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x9b0 0x0>;
+				fsl,iomuxc-pad-ctl = <0x1ec>;
+			};
+
+			/*
+			 * I2C2
+			 */
+			key-col4 { /* I2C2_SCL */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x9b8 0x1>;
+				fsl,iomuxc-pad-ctl = <0x1ec>;
+			};
+
+			key-col5 { /* I2C2_SDA */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x9bc 0x1>;
+				fsl,iomuxc-pad-ctl = <0x1ec>;
+			};
+
+			/*
+			 * HS-I2C
+			 */
+			i2c1-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x1ec>;
+			};
+
+			i2c1-dat {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x1ec>;
+			};
+
+			/*
+			 * USB HOST1
+			 */
+			usbh1-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-dir {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-stp {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-nxt {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-data0 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-data1 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-data2 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-data3 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-data4 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-data5 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-data6 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			usbh1-data7 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			gpio1-7 { /* RST_USB_HUB_B */
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d21 { /* GPIO2_5: RST_USB_PHY_B */
+				fsl,iomuxc-mux-mode = <1>;
+				fsl,iomuxc-pad-ctl = <0x85>;
+			};
+
+			/*
+			 * FEC
+			 */
+			eim-eb2 { /* FEC_MDIO */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-select-input = <0x954 0x0>;
+				fsl,iomuxc-pad-ctl = <0x1e5>;
+			};
+
+			eim-eb3 { /* FEC_RDATA1 */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-select-input = <0x95c 0x0>;
+			};
+
+			eim-cs2 { /* FEC_RDATA2 */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-select-input = <0x960 0x0>;
+			};
+
+			eim-cs3 { /* FEC_RDATA3 */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-select-input = <0x964 0x0>;
+			};
+
+			eim-cs4 { /* FEC_RX_ER */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-select-input = <0x970 0x0>;
+				fsl,iomuxc-pad-ctl = <0x185>;
+			};
+
+			eim-cs5 { /* FEC_CRS */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-select-input = <0x950 0x0>;
+				fsl,iomuxc-pad-ctl = <0x185>;
+			};
+
+			nandf-rb2 { /* FEC_COL */
+				fsl,iomuxc-mux-mode = <1>;
+				fsl,iomuxc-select-input = <0x94c 0x0>;
+				fsl,iomuxc-pad-ctl = <0x185>;
+			};
+
+			nandf-rb3 { /* FEC_RX_CLK */
+				fsl,iomuxc-mux-mode = <1>;
+				fsl,iomuxc-select-input = <0x968 0x0>;
+				fsl,iomuxc-pad-ctl = <0x185>;
+			};
+
+			nandf-d9 { /* FEC_RDATA0 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x958 0x0>;
+				fsl,iomuxc-pad-ctl = <0x2180>;
+			};
+
+			nandf-d8 { /* FEC_TDATA0 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x2004>;
+			};
+
+			nandf-cs2 { /* FEC_TX_ER */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x2004>;
+			};
+
+			nandf-cs3 { /* FEC_MDC */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x2004>;
+			};
+
+			nandf-cs4 { /* FEC_TDATA1 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x2004>;
+			};
+
+			nandf-cs5 { /* FEC_TDATA2 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x2004>;
+			};
+
+			nandf-cs6 { /* FEC_TDATA3 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x2004>;
+			};
+
+			nandf-cs7 { /* FEC_TX_EN */
+				fsl,iomuxc-mux-mode = <1>;
+				fsl,iomuxc-pad-ctl = <0x2004>;
+			};
+
+			nandf-rdy-int { /* FEC_TX_CLK */
+				fsl,iomuxc-mux-mode = <1>;
+				fsl,iomuxc-select-input = <0x974 0x0>;
+				fsl,iomuxc-pad-ctl = <0x2180>;
+			};
+
+			eim-a20 { /* GPIO2_14: RST_ENET_B */
+				fsl,iomuxc-mux-mode = <1>;
+				fsl,iomuxc-pad-ctl = <0x85>;
+			};
+
+			/*
+			 * SD1
+			 */
+			sd1-cmd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			sd1-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x21d5>;
+			};
+
+			sd1-data0 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			sd1-data1 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			sd1-data2 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			sd1-data3 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			gpio1-0 { /* SD1_CD */
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			gpio1-1 { /* SD1_WP */
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			/*
+			 * SD2
+			 */
+			sd2-cmd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			sd2-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x21d5>;
+			};
+
+			sd2-data0 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			sd2-data1 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			sd2-data2 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			sd2-data3 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x20d5>;
+			};
+
+			gpio1-5 { /* SD2_WP */
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			gpio1-6 { /* SD2_CD */
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			/*
+			 * ECSPI1
+			 */
+			cspi1-mosi {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x185>;
+			};
+
+			cspi1-miso {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x185>;
+			};
+
+			cspi1-sclk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x185>;
+			};
+
+			cspi1-ss0 { /* GPIO4_24 */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-pad-ctl = <0x85>;
+			};
+
+			cspi1-ss1 { /* GPIO4_25 */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-pad-ctl = <0x85>;
+			};
+		};
+
+		uart0: uart at 73fbc000 {
+			fsl,uart-has-rtscts;
+		};
+	};
+
+	aips at 80000000 {	/* aips-2 */
+		ecspi at 83fac000 { /* ECSPI2 */
+			status = "disabled";
+		};
+
+		sdma at 83fb0000 {
+			fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
+		};
+
+		cspi at 83fc0000 {
+			status = "disabled";
+		};
+
+		i2c at 83fc4000 { /* I2C2 */
+			codec: sgtl5000 at 0a {
+				compatible = "fsl,sgtl5000";
+				reg = <0x0a>;
+			};
+		};
+
+		i2c at 83fc8000 { /* I2C1 */
+			status = "disabled";
+		};
+
+		fec at 83fec000 {
+			phy-mode = "mii";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power Button";
+			gpios = <&gpio1 21 0>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
new file mode 100644
index 0000000..484d145
--- /dev/null
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -0,0 +1,1190 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	interrupt-parent = <&tzic>;
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+
+	tzic: tz-interrupt-controller at e0000000 {
+		compatible = "fsl,imx51-tzic", "fsl,tzic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0xe0000000 0x4000>;
+	};
+
+	aips at 70000000 { /* AIPS1 */
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x70000000 0x10000000>;
+		ranges;
+
+		spba at 70000000 {
+			compatible = "fsl,spba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x70000000 0x40000>;
+			ranges;
+
+			esdhc at 70004000 { /* ESDHC1 */
+				compatible = "fsl,imx51-esdhc";
+				reg = <0x70004000 0x4000>;
+				interrupts = <1>;
+			};
+
+			esdhc at 70008000 { /* ESDHC2 */
+				compatible = "fsl,imx51-esdhc";
+				reg = <0x70008000 0x4000>;
+				interrupts = <2>;
+			};
+
+			uart2: uart at 7000c000 { /* UART3 */
+				compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+				reg = <0x7000c000 0x4000>;
+				interrupts = <33>;
+			};
+
+			ecspi at 70010000 { /* ECSPI1 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx51-ecspi";
+				reg = <0x70010000 0x4000>;
+				interrupts = <36>;
+			};
+
+			esdhc at 70020000 { /* ESDHC3 */
+				compatible = "fsl,imx51-esdhc";
+				reg = <0x70020000 0x4000>;
+				interrupts = <3>;
+			};
+
+			esdhc at 70024000 { /* ESDHC4 */
+				compatible = "fsl,imx51-esdhc";
+				reg = <0x70024000 0x4000>;
+				interrupts = <4>;
+			};
+
+			i2c at 70038000 { /* HS-I2C */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+				reg = <0x70038000 0x4000>;
+				interrupts = <64>;
+				clock-frequency = <400000>;
+			};
+		};
+
+		gpio0: gpio at 73f84000 { /* GPIO1 */
+			compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+			reg = <0x73f84000 0x4000>;
+			interrupts = <50 51>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio1: gpio at 73f88000 { /* GPIO2 */
+			compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+			reg = <0x73f88000 0x4000>;
+			interrupts = <52 53>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio at 73f8c000 { /* GPIO3 */
+			compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+			reg = <0x73f8c000 0x4000>;
+			interrupts = <54 55>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio at 73f90000 { /* GPIO4 */
+			compatible = "fsl,imx51-gpio", "fsl,imx31-gpio";
+			reg = <0x73f90000 0x4000>;
+			interrupts = <56 57>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		wdt at 73f98000 { /* WDOG1 */
+			compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+			reg = <0x73f98000 0x4000>;
+			interrupts = <58>;
+		};
+
+		iomuxc at 73fa8000 {
+			#address-cells = <2>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-iomuxc";
+			reg = <0x73fa8000 0x4000>;
+
+			eim-d16 {
+				reg = <0x5c 0x3f0>;
+			};
+
+			eim-d17 {
+				reg = <0x60 0x3f4>;
+			};
+
+			eim-d18 {
+				reg = <0x64 0x3f8>;
+			};
+
+			eim-d19 {
+				reg = <0x68 0x3fc>;
+			};
+
+			eim-d20 {
+				reg = <0x6c 0x400>;
+			};
+
+			eim-d21 {
+				reg = <0x70 0x404>;
+			};
+
+			eim-d22 {
+				reg = <0x74 0x408>;
+			};
+
+			eim-d23 {
+				reg = <0x78 0x40c>;
+			};
+
+			eim-d24 {
+				reg = <0x7c 0x410>;
+			};
+
+			eim-d25 {
+				reg = <0x80 0x414>;
+			};
+
+			eim-d26 {
+				reg = <0x84 0x418>;
+			};
+
+			eim-d27 {
+				reg = <0x88 0x41c>;
+			};
+
+			eim-d28 {
+				reg = <0x8c 0x420>;
+			};
+
+			eim-d29 {
+				reg = <0x90 0x424>;
+			};
+
+			eim-d30 {
+				reg = <0x94 0x428>;
+			};
+
+			eim-d31 {
+				reg = <0x98 0x42c>;
+			};
+
+			eim-a16 {
+				reg = <0x9c 0x430>;
+			};
+
+			eim-a17 {
+				reg = <0xa0 0x434>;
+			};
+
+			eim-a18 {
+				reg = <0xa4 0x438>;
+			};
+
+			eim-a19 {
+				reg = <0xa8 0x43c>;
+			};
+
+			eim-a20 {
+				reg = <0xac 0x440>;
+			};
+
+			eim-a21 {
+				reg = <0xb0 0x444>;
+			};
+
+			eim-a22 {
+				reg = <0xb4 0x448>;
+			};
+
+			eim-a23 {
+				reg = <0xb8 0x44c>;
+			};
+
+			eim-a24 {
+				reg = <0xbc 0x450>;
+			};
+
+			eim-a25 {
+				reg = <0xc0 0x454>;
+			};
+
+			eim-a26 {
+				reg = <0xc4 0x458>;
+			};
+
+			eim-a27 {
+				reg = <0xc8 0x45c>;
+			};
+
+			eim-eb0 {
+				reg = <0xcc 0x460>;
+			};
+
+			eim-eb1 {
+				reg = <0xd0 0x464>;
+			};
+
+			eim-eb2 {
+				reg = <0xd4 0x468>;
+			};
+
+			eim-eb3 {
+				reg = <0xd8 0x46c>;
+			};
+
+			eim-oe {
+				reg = <0xdc 0x470>;
+			};
+
+			eim-cs0 {
+				reg = <0xe0 0x474>;
+			};
+
+			eim-cs1 {
+				reg = <0xe4 0x478>;
+			};
+
+			eim-cs2 {
+				reg = <0xe8 0x47c>;
+			};
+
+			eim-cs3 {
+				reg = <0xec 0x480>;
+			};
+
+			eim-cs4 {
+				reg = <0xf0 0x484>;
+			};
+
+			eim-cs5 {
+				reg = <0xf4 0x488>;
+			};
+
+			eim-dtack {
+				reg = <0xf8 0x48c>;
+			};
+
+			eim-lba {
+				reg = <0xfc 0x494>;
+			};
+
+			eim-cre {
+				reg = <0x100 0x4a0>;
+			};
+
+			dram-cs1 {
+				reg = <0x104 0x4d0>;
+			};
+
+			nandf-we-b {
+				reg = <0x108 0x4e4>;
+			};
+
+			nandf-re-b {
+				reg = <0x10c 0x4e8>;
+			};
+
+			nandf-ale {
+				reg = <0x110 0x4ec>;
+			};
+
+			nandf-cle {
+				reg = <0x114 0x4f0>;
+			};
+
+			nandf-wp-b {
+				reg = <0x118 0x4f4>;
+			};
+
+			nandf-rb0 {
+				reg = <0x11c 0x4f8>;
+			};
+
+			nandf-rb1 {
+				reg = <0x120 0x4fc>;
+			};
+
+			nandf-rb2 {
+				reg = <0x124 0x500>;
+			};
+
+			nandf-rb3 {
+				reg = <0x128 0x504>;
+			};
+
+			gpio-nand {
+				reg = <0x12c 0x514>;
+			};
+
+			nandf-cs0 {
+				reg = <0x130 0x518>;
+			};
+
+			nandf-cs1 {
+				reg = <0x134 0x51c>;
+			};
+
+			nandf-cs2 {
+				reg = <0x138 0x520>;
+			};
+
+			nandf-cs3 {
+				reg = <0x13c 0x524>;
+			};
+
+			nandf-cs4 {
+				reg = <0x140 0x528>;
+			};
+
+			nandf-cs5 {
+				reg = <0x144 0x52c>;
+			};
+
+			nandf-cs6 {
+				reg = <0x148 0x530>;
+			};
+
+			nandf-cs7 {
+				reg = <0x14c 0x534>;
+			};
+
+			nandf-rdy-int {
+				reg = <0x150 0x538>;
+			};
+
+			nandf-d15 {
+				reg = <0x154 0x53c>;
+			};
+
+			nandf-d14 {
+				reg = <0x158 0x540>;
+			};
+
+			nandf-d13 {
+				reg = <0x15c 0x544>;
+			};
+
+			nandf-d12 {
+				reg = <0x160 0x548>;
+			};
+
+			nandf-d11 {
+				reg = <0x164 0x54c>;
+			};
+
+			nandf-d10 {
+				reg = <0x168 0x550>;
+			};
+
+			nandf-d9 {
+				reg = <0x16c 0x554>;
+			};
+
+			nandf-d8 {
+				reg = <0x170 0x558>;
+			};
+
+			nandf-d7 {
+				reg = <0x174 0x55c>;
+			};
+
+			nandf-d6 {
+				reg = <0x178 0x560>;
+			};
+
+			nandf-d5 {
+				reg = <0x17c 0x564>;
+			};
+
+			nandf-d4 {
+				reg = <0x180 0x568>;
+			};
+
+			nandf-d3 {
+				reg = <0x184 0x56c>;
+			};
+
+			nandf-d2 {
+				reg = <0x188 0x570>;
+			};
+
+			nandf-d1 {
+				reg = <0x18c 0x574>;
+			};
+
+			nandf-d0 {
+				reg = <0x190 0x578>;
+			};
+
+			csi1-d8 {
+				reg = <0x194 0x57c>;
+			};
+
+			csi1-d9 {
+				reg = <0x198 0x580>;
+			};
+
+			csi1-d10 {
+				reg = <0x19c 0x584>;
+			};
+
+			csi1-d11 {
+				reg = <0x1a0 0x588>;
+			};
+
+			csi1-d12 {
+				reg = <0x1a4 0x58c>;
+			};
+
+			csi1-d13 {
+				reg = <0x1a8 0x590>;
+			};
+
+			csi1-d14 {
+				reg = <0x1ac 0x594>;
+			};
+
+			csi1-d15 {
+				reg = <0x1b0 0x598>;
+			};
+
+			csi1-d16 {
+				reg = <0x1b4 0x59c>;
+			};
+
+			csi1-d17 {
+				reg = <0x1b8 0x5a0>;
+			};
+
+			csi1-d18 {
+				reg = <0x1bc 0x5a4>;
+			};
+
+			csi1-d19 {
+				reg = <0x1c0 0x5a8>;
+			};
+
+			csi1-vsync {
+				reg = <0x1c4 0x5ac>;
+			};
+
+			csi1-hsync {
+				reg = <0x1c8 0x5b0>;
+			};
+
+			csi1-pixclk {
+				reg = <0x000 0x5b4>;
+			};
+
+			csi1-mclk {
+				reg = <0x000 0x5b8>;
+			};
+
+			csi2-d12 {
+				reg = <0x1cc 0x5bc>;
+			};
+
+			csi2-d13 {
+				reg = <0x1d0 0x5c0>;
+			};
+
+			csi2-d14 {
+				reg = <0x1d4 0x5c4>;
+			};
+
+			csi2-d15 {
+				reg = <0x1d8 0x5c8>;
+			};
+
+			csi2-d16 {
+				reg = <0x1dc 0x5cc>;
+			};
+
+			csi2-d17 {
+				reg = <0x1e0 0x5d0>;
+			};
+
+			csi2-d18 {
+				reg = <0x1e4 0x5d4>;
+			};
+
+			csi2-d19 {
+				reg = <0x1e8 0x5d8>;
+			};
+
+			csi2-vsync {
+				reg = <0x1ec 0x5dc>;
+			};
+
+			csi2-hsync {
+				reg = <0x1f0 0x5e0>;
+			};
+
+			csi2-pixclk {
+				reg = <0x1f4 0x5e4>;
+			};
+
+			i2c1-clk {
+				reg = <0x1f8 0x5e8>;
+			};
+
+			i2c1-dat {
+				reg = <0x1fc 0x5ec>;
+			};
+
+			aud3-bb-txd {
+				reg = <0x200 0x5f0>;
+			};
+
+			aud3-bb-rxd {
+				reg = <0x204 0x5f4>;
+			};
+
+			aud3-bb-ck {
+				reg = <0x208 0x5f8>;
+			};
+
+			aud3-bb-fs {
+				reg = <0x20c 0x5fc>;
+			};
+
+			cspi1-mosi {
+				reg = <0x210 0x600>;
+			};
+
+			cspi1-miso {
+				reg = <0x214 0x604>;
+			};
+
+			cspi1-ss0 {
+				reg = <0x218 0x608>;
+			};
+
+			cspi1-ss1 {
+				reg = <0x21c 0x60c>;
+			};
+
+			cspi1-rdy {
+				reg = <0x220 0x610>;
+			};
+
+			cspi1-sclk {
+				reg = <0x224 0x614>;
+			};
+
+			uart1-rxd {
+				reg = <0x228 0x618>;
+			};
+
+			uart1-txd {
+				reg = <0x22c 0x61c>;
+			};
+
+			uart1-rts {
+				reg = <0x230 0x620>;
+			};
+
+			uart1-cts {
+				reg = <0x234 0x624>;
+			};
+
+			uart2-rxd {
+				reg = <0x238 0x628>;
+			};
+
+			uart2-txd {
+				reg = <0x23c 0x62c>;
+			};
+
+			uart3-rxd {
+				reg = <0x240 0x630>;
+			};
+
+			uart3-txd {
+				reg = <0x244 0x634>;
+			};
+
+			owire-line {
+				reg = <0x248 0x638>;
+			};
+
+			key-row0 {
+				reg = <0x24c 0x63c>;
+			};
+
+			key-row1 {
+				reg = <0x250 0x640>;
+			};
+
+			key-row2 {
+				reg = <0x254 0x644>;
+			};
+
+			key-row3 {
+				reg = <0x258 0x648>;
+			};
+
+			key-col0 {
+				reg = <0x25c 0x64c>;
+			};
+
+			key-col1 {
+				reg = <0x260 0x650>;
+			};
+
+			key-col2 {
+				reg = <0x264 0x654>;
+			};
+
+			key-col3 {
+				reg = <0x268 0x658>;
+			};
+
+			key-col4 {
+				reg = <0x26c 0x65c>;
+			};
+
+			key-col5 {
+				reg = <0x270 0x660>;
+			};
+
+			usbh1-clk {
+				reg = <0x278 0x678>;
+			};
+
+			usbh1-dir {
+				reg = <0x27c 0x67c>;
+			};
+
+			usbh1-stp {
+				reg = <0x280 0x680>;
+			};
+
+			usbh1-nxt {
+				reg = <0x284 0x684>;
+			};
+
+			usbh1-data0 {
+				reg = <0x288 0x688>;
+			};
+
+			usbh1-data1 {
+				reg = <0x28c 0x68c>;
+			};
+
+			usbh1-data2 {
+				reg = <0x290 0x690>;
+			};
+
+			usbh1-data3 {
+				reg = <0x294 0x694>;
+			};
+
+			usbh1-data4 {
+				reg = <0x298 0x698>;
+			};
+
+			usbh1-data5 {
+				reg = <0x29c 0x69c>;
+			};
+
+			usbh1-data6 {
+				reg = <0x2a0 0x6a0>;
+			};
+
+			usbh1-data7 {
+				reg = <0x2a4 0x6a4>;
+			};
+
+			di1-pin11 {
+				reg = <0x2a8 0x6a8>;
+			};
+
+			di1-pin12 {
+				reg = <0x2ac 0x6ac>;
+			};
+
+			di1-pin13 {
+				reg = <0x2b0 0x6b0>;
+			};
+
+			di1-d0-cs {
+				reg = <0x2b4 0x6b4>;
+			};
+
+			di1-d1-cs {
+				reg = <0x2b8 0x6b8>;
+			};
+
+			dispb2-ser-din {
+				reg = <0x2bc 0x6bc>;
+			};
+
+			dispb2-ser-dio {
+				reg = <0x2c0 0x6c0>;
+			};
+
+			dispb2-ser-clk {
+				reg = <0x2c4 0x6c4>;
+			};
+
+			dispb2-ser-rs {
+				reg = <0x2c8 0x6c8>;
+			};
+
+			disp1-dat0 {
+				reg = <0x2cc 0x6cc>;
+			};
+
+			disp1-dat1 {
+				reg = <0x2d0 0x6d0>;
+			};
+
+			disp1-dat2 {
+				reg = <0x2d4 0x6d4>;
+			};
+
+			disp1-dat3 {
+				reg = <0x2d8 0x6d8>;
+			};
+
+			disp1-dat4 {
+				reg = <0x2dc 0x6dc>;
+			};
+
+			disp1-dat5 {
+				reg = <0x2e0 0x6e0>;
+			};
+
+			disp1-dat6 {
+				reg = <0x2e4 0x6e4>;
+			};
+
+			disp1-dat7 {
+				reg = <0x2e8 0x6e8>;
+			};
+
+			disp1-dat8 {
+				reg = <0x2ec 0x6ec>;
+			};
+
+			disp1-dat9 {
+				reg = <0x2f0 0x6f0>;
+			};
+
+			disp1-dat10 {
+				reg = <0x2f4 0x6f4>;
+			};
+
+			disp1-dat11 {
+				reg = <0x2f8 0x6f8>;
+			};
+
+			disp1-dat12 {
+				reg = <0x2fc 0x6fc>;
+			};
+
+			disp1-dat13 {
+				reg = <0x300 0x700>;
+			};
+
+			disp1-dat14 {
+				reg = <0x304 0x704>;
+			};
+
+			disp1-dat15 {
+				reg = <0x308 0x708>;
+			};
+
+			disp1-dat16 {
+				reg = <0x30c 0x70c>;
+			};
+
+			disp1-dat17 {
+				reg = <0x310 0x710>;
+			};
+
+			disp1-dat18 {
+				reg = <0x314 0x714>;
+			};
+
+			disp1-dat19 {
+				reg = <0x318 0x718>;
+			};
+
+			disp1-dat20 {
+				reg = <0x31c 0x71c>;
+			};
+
+			disp1-dat21 {
+				reg = <0x320 0x720>;
+			};
+
+			disp1-dat22 {
+				reg = <0x324 0x724>;
+			};
+
+			disp1-dat23 {
+				reg = <0x328 0x728>;
+			};
+
+			di1-pin3 {
+				reg = <0x32c 0x72c>;
+			};
+
+			di1-pin2 {
+				reg = <0x330 0x734>;
+			};
+
+			di-gp2 {
+				reg = <0x338 0x740>;
+			};
+
+			di-gp3 {
+				reg = <0x33c 0x744>;
+			};
+
+			di2-pin4 {
+				reg = <0x340 0x748>;
+			};
+
+			di2-pin2 {
+				reg = <0x344 0x74c>;
+			};
+
+			di2-pin3 {
+				reg = <0x348 0x750>;
+			};
+
+			di2-disp-clk {
+				reg = <0x34c 0x754>;
+			};
+
+			di-gp4 {
+				reg = <0x350 0x758>;
+			};
+
+			disp2-dat0 {
+				reg = <0x354 0x75c>;
+			};
+
+			disp2-dat1 {
+				reg = <0x358 0x760>;
+			};
+
+			disp2-dat2 {
+				reg = <0x35c 0x764>;
+			};
+
+			disp2-dat3 {
+				reg = <0x360 0x768>;
+			};
+
+			disp2-dat4 {
+				reg = <0x364 0x76c>;
+			};
+
+			disp2-dat5 {
+				reg = <0x368 0x770>;
+			};
+
+			disp2-dat6 {
+				reg = <0x36c 0x774>;
+			};
+
+			disp2-dat7 {
+				reg = <0x370 0x778>;
+			};
+
+			disp2-dat8 {
+				reg = <0x374 0x77c>;
+			};
+
+			disp2-dat9 {
+				reg = <0x378 0x780>;
+			};
+
+			disp2-dat10 {
+				reg = <0x37c 0x784>;
+			};
+
+			disp2-dat11 {
+				reg = <0x380 0x788>;
+			};
+
+			disp2-dat12 {
+				reg = <0x384 0x78c>;
+			};
+
+			disp2-dat13 {
+				reg = <0x388 0x790>;
+			};
+
+			disp2-dat14 {
+				reg = <0x38c 0x794>;
+			};
+
+			disp2-dat15 {
+				reg = <0x390 0x798>;
+			};
+
+			sd1-cmd {
+				reg = <0x394 0x79c>;
+			};
+
+			sd1-clk {
+				reg = <0x398 0x7a0>;
+			};
+
+			sd1-data0 {
+				reg = <0x39c 0x7a4>;
+			};
+
+			eim-da0 {
+				reg = <0x01c 0x000>;
+			};
+
+			eim-da1 {
+				reg = <0x020 0x000>;
+			};
+
+			eim-da2 {
+				reg = <0x024 0x000>;
+			};
+
+			eim-da3 {
+				reg = <0x028 0x000>;
+			};
+
+			sd1-data1 {
+				reg = <0x3a0 0x7a8>;
+			};
+
+			eim-da4 {
+				reg = <0x02c 0x000>;
+			};
+
+			eim-da5 {
+				reg = <0x030 0x000>;
+			};
+
+			eim-da6 {
+				reg = <0x034 0x000>;
+			};
+
+			eim-da7 {
+				reg = <0x038 0x000>;
+			};
+
+			sd1-data2 {
+				reg = <0x3a4 0x7ac>;
+			};
+
+			eim-da10 {
+				reg = <0x044 0x000>;
+			};
+
+			eim-da11 {
+				reg = <0x048 0x000>;
+			};
+
+			eim-da8 {
+				reg = <0x03c 0x000>;
+			};
+
+			eim-da9 {
+				reg = <0x040 0x000>;
+			};
+
+			sd1-data3 {
+				reg = <0x3a8 0x7b0>;
+			};
+
+			gpio1-0 {
+				reg = <0x3ac 0x7b4>;
+			};
+
+			gpio1-1 {
+				reg = <0x3b0 0x7b8>;
+			};
+
+			eim-da12 {
+				reg = <0x04c 0x000>;
+			};
+
+			eim-da13 {
+				reg = <0x050 0x000>;
+			};
+
+			eim-da14 {
+				reg = <0x054 0x000>;
+			};
+
+			eim-da15 {
+				reg = <0x058 0x000>;
+			};
+
+			sd2-cmd {
+				reg = <0x3b4 0x000>;
+			};
+
+			sd2-clk {
+				reg = <0x3b8 0x7c0>;
+			};
+
+			sd2-data0 {
+				reg = <0x3bc 0x7c4>;
+			};
+
+			sd2-data1 {
+				reg = <0x3c0 0x7c8>;
+			};
+
+			sd2-data2 {
+				reg = <0x3c4 0x7cc>;
+			};
+
+			sd2-data3 {
+				reg = <0x3c8 0x7d0>;
+			};
+
+			gpio1-2 {
+				reg = <0x3cc 0x7d4>;
+			};
+
+			gpio1-3 {
+				reg = <0x3d0 0x7d8>;
+			};
+
+			pmic-int-req {
+				reg = <0x3d4 0x7fc>;
+			};
+
+			gpio1-4 {
+				reg = <0x3d8 0x804>;
+			};
+
+			gpio1-5 {
+				reg = <0x3dc 0x808>;
+			};
+
+			gpio1-6 {
+				reg = <0x3e0 0x80c>;
+			};
+
+			gpio1-7 {
+				reg = <0x3e4 0x810>;
+			};
+
+			gpio1-8 {
+				reg = <0x3e8 0x814>;
+			};
+
+			gpio1-9 {
+				reg = <0x3ec 0x818>;
+			};
+		};
+
+		uart0: uart at 73fbc000 {
+			compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+			reg = <0x73fbc000 0x4000>;
+			interrupts = <31>;
+		};
+
+		uart1: uart at 73fc0000 {
+			compatible = "fsl,imx51-uart", "fsl,imx21-uart";
+			reg = <0x73fc0000 0x4000>;
+			interrupts = <32>;
+		};
+	};
+
+	aips at 80000000 {	/* AIPS2 */
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x80000000 0x10000000>;
+		ranges;
+
+		ecspi at 83fac000 { /* ECSPI2 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-ecspi";
+			reg = <0x83fac000 0x4000>;
+			interrupts = <37>;
+		};
+
+		sdma at 83fb0000 {
+			compatible = "fsl,imx51-sdma", "fsl,imx35-sdma";
+			reg = <0x83fb0000 0x4000>;
+			interrupts = <6>;
+		};
+
+		cspi at 83fc0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-cspi", "fsl,imx35-cspi";
+			reg = <0x83fc0000 0x4000>;
+			interrupts = <38>;
+		};
+
+		i2c at 83fc4000 { /* I2C2 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+			reg = <0x83fc4000 0x4000>;
+			interrupts = <63>;
+		};
+
+		i2c at 83fc8000 { /* I2C1 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx51-i2c", "fsl,imx1-i2c";
+			reg = <0x83fc8000 0x4000>;
+			interrupts = <62>;
+		};
+
+		fec at 83fec000 {
+			compatible = "fsl,imx51-fec", "fsl,imx27-fec";
+			reg = <0x83fec000 0x4000>;
+			interrupts = <87>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 9f60dc1..a2e8f3a 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -62,6 +62,14 @@ endif # ARCH_MX50_SUPPORTED
 if ARCH_MX51
 comment "i.MX51 machines:"
 
+config MACH_IMX51_DT
+	bool "Support i.MX51 platforms from device tree"
+	select SOC_IMX51
+	select USE_OF
+	help
+	  Include support for Freescale i.MX51 based platforms
+	  using the device tree for discovery
+
 config MACH_MX51_BABBAGE
 	bool "Support MX51 BABBAGE platforms"
 	select SOC_IMX51
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index a1fd712..f751115 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -24,4 +24,5 @@ obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
 obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
 
 obj-$(CONFIG_OF) += iomuxc-dt.o
+obj-$(CONFIG_MACH_IMX51_DT) += imx51-dt.o
 obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
new file mode 100644
index 0000000..99effcf
--- /dev/null
+++ b/arch/arm/mach-mx5/imx51-dt.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+#include <mach/mx51.h>
+
+/*
+ * Lookup table for attaching a specific name and platform_data pointer to
+ * devices as they get created by of_platform_populate().  Ideally this table
+ * would not exist, but the current clock implementation depends on some devices
+ * having a specific name.
+ */
+static const struct of_dev_auxdata imx51_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART1_BASE_ADDR, "imx21-uart.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART2_BASE_ADDR, "imx21-uart.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-uart", MX51_UART3_BASE_ADDR, "imx21-uart.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-fec", MX51_FEC_BASE_ADDR, "imx27-fec.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx51.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx51.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx51.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-esdhc", MX51_ESDHC4_BASE_ADDR, "sdhci-esdhc-imx51.3", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-ecspi", MX51_ECSPI1_BASE_ADDR, "imx51-ecspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-ecspi", MX51_ECSPI2_BASE_ADDR, "imx51-ecspi.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-cspi", MX51_CSPI_BASE_ADDR, "imx35-cspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-i2c", MX51_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-i2c", MX51_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-sdma", MX51_SDMA_BASE_ADDR, "imx35-sdma", NULL),
+	OF_DEV_AUXDATA("fsl,imx51-wdt", MX51_WDOG1_BASE_ADDR, "imx2-wdt.0", NULL),
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx51_tzic_of_match[] __initconst = {
+	{ .compatible = "fsl,imx51-tzic", },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx51_gpio_of_match[] __initconst = {
+	{ .compatible = "fsl,imx51-gpio", },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx51_iomuxc_of_match[] __initconst = {
+	{ .compatible = "fsl,imx51-iomuxc", },
+	{ /* sentinel */ }
+};
+
+static void __init imx51_dt_init(void)
+{
+	int gpio_irq = MXC_INTERNAL_IRQS + ARCH_NR_GPIOS;
+
+	mxc_iomuxc_dt_init(imx51_iomuxc_of_match);
+
+	irq_domain_generate_simple(imx51_tzic_of_match, MX51_TZIC_BASE_ADDR, 0);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx51_gpio_of_match, MX51_GPIO1_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx51_gpio_of_match, MX51_GPIO2_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx51_gpio_of_match, MX51_GPIO3_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx51_gpio_of_match, MX51_GPIO4_BASE_ADDR, gpio_irq);
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     imx51_auxdata_lookup, NULL);
+}
+
+static void __init imx51_timer_init(void)
+{
+	mx51_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer imx51_timer = {
+	.init = imx51_timer_init,
+};
+
+static const char *imx51_dt_board_compat[] __initdata = {
+	"fsl,imx51-babbage",
+	NULL
+};
+
+DT_MACHINE_START(IMX51_DT, "Freescale i.MX51 (Device Tree Support)")
+	.map_io		= mx51_map_io,
+	.init_early	= imx51_init_early,
+	.init_irq	= mx51_init_irq,
+	.timer		= &imx51_timer,
+	.init_machine	= imx51_dt_init,
+	.dt_compat	= imx51_dt_board_compat,
+MACHINE_END
-- 
1.7.4.1
