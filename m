From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 31 Jul 2011 02:53:20 +0800
Subject: [PATCH v2 2/3] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <1312052001-16660-1-git-send-email-shawn.guo@linaro.org>
References: <1312052001-16660-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1312052001-16660-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree support for imx53 boards.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/arm/fsl/boards.txt         |   15 +
 arch/arm/boot/dts/imx53-ard.dts                    |  365 +++++++
 arch/arm/boot/dts/imx53-evk.dts                    |  353 +++++++
 arch/arm/boot/dts/imx53-qsb.dts                    |  357 +++++++
 arch/arm/boot/dts/imx53-smd.dts                    |  443 ++++++++
 arch/arm/boot/dts/imx53.dtsi                       | 1055 ++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                          |    8 +
 arch/arm/mach-mx5/Makefile                         |    1 +
 arch/arm/mach-mx5/imx53-dt.c                       |  161 +++
 9 files changed, 2758 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/fsl/boards.txt
 create mode 100644 arch/arm/boot/dts/imx53-ard.dts
 create mode 100644 arch/arm/boot/dts/imx53-evk.dts
 create mode 100644 arch/arm/boot/dts/imx53-qsb.dts
 create mode 100644 arch/arm/boot/dts/imx53-smd.dts
 create mode 100644 arch/arm/boot/dts/imx53.dtsi
 create mode 100644 arch/arm/mach-mx5/imx53-dt.c

diff --git a/Documentation/devicetree/bindings/arm/fsl/boards.txt b/Documentation/devicetree/bindings/arm/fsl/boards.txt
new file mode 100644
index 0000000..d1e8d6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/fsl/boards.txt
@@ -0,0 +1,15 @@
+i.MX53 Automotive Reference Design Board
+Required root node properties:
+    - compatible = "fsl,imx53-ard", "fsl,imx53";
+
+i.MX53 Evaluation Kit
+Required root node properties:
+    - compatible = "fsl,imx53-evk", "fsl,imx53";
+
+i.MX53 Quick Start Board
+Required root node properties:
+    - compatible = "fsl,imx53-qsb", "fsl,imx53";
+
+i.MX53 Smart Mobile Reference Design Board
+Required root node properties:
+    - compatible = "fsl,imx53-smd", "fsl,imx53";
diff --git a/arch/arm/boot/dts/imx53-ard.dts b/arch/arm/boot/dts/imx53-ard.dts
new file mode 100644
index 0000000..9d177bb
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -0,0 +1,365 @@
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
+/include/ "imx53.dtsi"
+
+/ {
+	model = "Freescale i.MX53 Automotive Reference Design Board";
+	compatible = "fsl,imx53-ard", "fsl,imx53";
+
+	chosen {
+		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
+	};
+
+	memory {
+		reg = <0x70000000 0x40000000>;
+	};
+
+	aips at 50000000 { /* AIPS1 */
+		spba at 50000000 {
+			esdhc at 50004000 { /* ESDHC1 */
+				cd-gpios = <&gpio0 1 0>; /* GPIO1_1 */
+				wp-gpios = <&gpio0 9 0>; /* GPIO1_9 */
+			};
+
+			esdhc at 50008000 { /* ESDHC2 */
+				status = "disabled";
+			};
+
+			uart2: uart at 5000c000 { /* UART3 */
+				status = "disabled";
+			};
+
+			ecspi at 50010000 { /* ECSPI1 */
+				status = "disabled";
+			};
+
+			esdhc at 50020000 { /* ESDHC3 */
+				status = "disabled";
+			};
+
+			esdhc at 50024000 { /* ESDHC4 */
+				status = "disabled";
+			};
+		};
+
+		iomuxc at 53fa8000 {
+			/*
+			 * UART1
+			 */
+			pata-diow { /* UART1_TXD_MUX */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-dmack { /* UART1_RXD_MUX */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+				fsl,iomuxc-select-input = <0x878 0x3>;
+			};
+
+			/*
+			 * EIM CS1
+			 */
+			eim-d16 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d17 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d18 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d19 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d20 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d21 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d22 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d23 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d24 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d25 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d26 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d27 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d28 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d29 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d30 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-d31 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-da0 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-da1 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-da2 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-da3 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-da4 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-da5 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-da6 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-oe {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-rw {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-cs1 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			eim-eb3 { /* GPIO2_31: ETHERNET_INT_B */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * SD1
+			 */
+			sd1-cmd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data0 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data1 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data2 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data3 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data8 { /* ESDHC1_DAT4 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data9 { /* ESDHC1_DAT5 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data10 { /* ESDHC1_DAT6 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data11 { /* ESDHC1_DAT7 */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			gpio-1 { /* GPIO1_1: SD1_CD */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			gpio-9 { /* GPIO1_9: SD1_WP */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * Buttons
+			 */
+			disp0-dat16 { /* GPIO5_10: Home */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			disp0-dat17 { /* GPIO5_11: Back */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			disp0-dat18 { /* GPIO5_12: Program */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			disp0-dat19 { /* GPIO5_13: Volumn Up */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			gpio-10 { /* GPIO4_0: Volume Down */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+		};
+
+		uart1: uart at 53fc0000 { /* UART2 */
+			status = "disabled";
+		};
+
+		i2c at 53fec000 { /* I2C3 */
+			status = "disabled";
+		};
+
+		uart3: uart at 53ff0000 { /* UART4 */
+			status = "disabled";
+		};
+	};
+
+	aips at 60000000 {	/* AIPS2 */
+		uart4: uart at 63f90000 { /* UART5 */
+			status = "disabled";
+		};
+
+		ecspi at 63fac000 { /* ECSPI2 */
+			status = "disabled";
+		};
+
+		sdma at 63fb0000 {
+			fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+		};
+
+		cspi at 63fc0000 {
+			status = "disabled";
+		};
+
+		i2c at 63fc4000 { /* I2C2 */
+			status = "disabled";
+		};
+
+		i2c at 63fc8000 { /* I2C1 */
+			status = "disabled";
+		};
+
+		fec at 63fec000 {
+			status = "disabled";
+		};
+	};
+
+	eim-cs1 at f4000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "fsl,eim-bus", "simple-bus";
+		reg = <0xf4000000 0x3ff0000>;
+		ranges;
+
+		lan9220 at f4000000 {
+			compatible = "smsc,lan9220", "smsc,lan9115";
+			reg = <0xf4000000 0x2000000>;
+			phy-mode = "mii";
+			interrupt-parent = <&gpio1>;
+			interrupts = <31>;
+			reg-io-width = <4>;
+			smsc,irq-push-pull;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		home {
+			label = "Home";
+			gpios = <&gpio4 10 0>; /* GPIO5_10 */
+			linux,code = <102>; /* KEY_HOME */
+			gpio-key,wakeup;
+		};
+
+		back {
+			label = "Back";
+			gpios = <&gpio4 11 0>; /* GPIO5_11 */
+			linux,code = <158>; /* KEY_BACK */
+			gpio-key,wakeup;
+		};
+
+		program {
+			label = "Program";
+			gpios = <&gpio4 12 0>; /* GPIO5_12 */
+			linux,code = <362>; /* KEY_PROGRAM */
+			gpio-key,wakeup;
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio4 13 0>; /* GPIO5_13 */
+			linux,code = <115>; /* KEY_VOLUMEUP */
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio3 0 0>; /* GPIO4_0 */
+			linux,code = <114>; /* KEY_VOLUMEDOWN */
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
new file mode 100644
index 0000000..8474100
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -0,0 +1,353 @@
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
+/include/ "imx53.dtsi"
+
+/ {
+	model = "Freescale i.MX53 Evaluation Kit";
+	compatible = "fsl,imx53-evk", "fsl,imx53";
+
+	chosen {
+		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
+	};
+
+	memory {
+		reg = <0x70000000 0x80000000>;
+	};
+
+	aips at 50000000 { /* AIPS1 */
+		spba at 50000000 {
+			esdhc at 50004000 { /* ESDHC1 */
+				cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
+				wp-gpios = <&gpio2 14 0>; /* GPIO3_14 */
+			};
+
+			esdhc at 50008000 { /* ESDHC2 */
+				status = "disabled";
+			};
+
+			uart2: uart at 5000c000 { /* UART3 */
+				status = "disabled";
+			};
+
+			ecspi at 50010000 { /* ECSPI1 */
+				fsl,spi-num-chipselects = <2>;
+				cs-gpios = <&gpio1 30 0>, /* GPIO2_30 */
+					   <&gpio2 19 0>; /* GPIO3_19 */
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
+			esdhc at 50020000 { /* ESDHC3 */
+				cd-gpios = <&gpio2 11 0>; /* GPIO3_11 */
+				wp-gpios = <&gpio2 12 0>; /* GPIO3_12 */
+			};
+
+			esdhc at 50024000 { /* ESDHC4 */
+				status = "disabled";
+			};
+		};
+
+		iomuxc at 53fa8000 {
+			/*
+			 * UART1
+			 */
+			csi0-dat10 { /* UART1_TXD_MUX */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			csi0-dat11 { /* UART1_RXD_MUX */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			/*
+			 * FEC
+			 */
+			fec-mdc {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-mdio {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-select-input = <0x804 0x1>;
+			};
+
+			fec-ref-clk {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rx-er {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-crs-dv {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rxd1 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rxd0 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-tx-en {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-txd1 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-txd0 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			pdata-da-0 { /* GPIO7_6: FEC_nRST */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * I2C2
+			 */
+			key-col3 { /* I2C2_SCL */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x81c 0x0>;
+			};
+
+			key-row3 { /* I2C2_SDA */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x820 0x0>;
+			};
+
+			/*
+			 * ECSPI1
+			 */
+			eim-d16 { /* ECSPI1_SCLK */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-select-input = <0x79c 0x3>;
+			};
+
+			eim-d17 { /* ECSPI1_MISO */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-select-input = <0x7a0 0x3>;
+			};
+
+			eim-d18 { /* ECSPI1_MOSI */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-select-input = <0x7a4 0x3>;
+			};
+
+			eim-eb2 { /* GPIO2_30: eCSPI1_SS0 */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			eim-d19 { /* GPIO3_19: eCSPI1_SS1 */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * SD1
+			 */
+			sd1-cmd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data0 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data1 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data2 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data3 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			eim-da13 { /* GPIO3_13: SD1_CD */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			eim-da14 { /* GPIO3_14: SD1_WP */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * SD3
+			 */
+			pata-reset-b { /* ESDHC3_CMD */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-iordy { /* ESDHC3_CLK */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data8 { /* ESDHC3_DAT0 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data9 { /* ESDHC3_DAT1 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data10 { /* ESDHC3_DAT2 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data11 { /* ESDHC3_DAT3 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data0 { /* ESDHC3_DAT4 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data1 { /* ESDHC3_DAT5 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data2 { /* ESDHC3_DAT6 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data3 { /* ESDHC3_DAT7 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			eim-da11 { /* GPIO3_11: SD3_CD */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			eim-da12 { /* GPIO3_12: SD3_WP */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * LED
+			 */
+			pata-da-1 { /* GPIO7_7: GPIO_LED */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+		};
+
+		uart1: uart at 53fc0000 { /* UART2 */
+			status = "disabled";
+		};
+
+		i2c at 53fec000 { /* I2C3 */
+			status = "disabled";
+		};
+
+		uart3: uart at 53ff0000 { /* UART4 */
+			status = "disabled";
+		};
+	};
+
+	aips at 60000000 {	/* AIPS2 */
+		uart4: uart at 63f90000 { /* UART5 */
+			status = "disabled";
+		};
+
+		ecspi at 63fac000 { /* ECSPI2 */
+			status = "disabled";
+		};
+
+		sdma at 63fb0000 {
+			fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+		};
+
+		cspi at 63fc0000 {
+			status = "disabled";
+		};
+
+		i2c at 63fc4000 { /* I2C2 */
+			pmic: mc13892 at 08 {
+				compatible = "fsl,mc13892", "fsl,mc13xxx";
+				reg = <0x08>;
+			};
+
+			codec: sgtl5000 at 0a {
+				compatible = "fsl,sgtl5000";
+				reg = <0x0a>;
+			};
+		};
+
+		i2c at 63fc8000 { /* I2C1 */
+			status = "disabled";
+		};
+
+		fec at 63fec000 {
+			phy-mode = "rmii";
+			phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		green {
+			label = "Heartbeat";
+			gpios = <&gpio6 7 0>; /* GPIO7_7 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
new file mode 100644
index 0000000..68e54d3
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -0,0 +1,357 @@
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
+/include/ "imx53.dtsi"
+
+/ {
+	model = "Freescale i.MX53 Quick Start Board";
+	compatible = "fsl,imx53-qsb", "fsl,imx53";
+
+	chosen {
+		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
+	};
+
+	memory {
+		reg = <0x70000000 0x40000000>;
+	};
+
+	aips at 50000000 { /* AIPS1 */
+		spba at 50000000 {
+			esdhc at 50004000 { /* ESDHC1 */
+				cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
+			};
+
+			esdhc at 50008000 { /* ESDHC2 */
+				status = "disabled";
+			};
+
+			uart2: uart at 5000c000 { /* UART3 */
+				status = "disabled";
+			};
+
+			ecspi at 50010000 { /* ECSPI1 */
+				status = "disabled";
+			};
+
+			esdhc at 50020000 { /* ESDHC3 */
+				cd-gpios = <&gpio2 11 0>; /* GPIO3_11 */
+				wp-gpios = <&gpio2 12 0>; /* GPIO3_12 */
+			};
+
+			esdhc at 50024000 { /* ESDHC4 */
+				status = "disabled";
+			};
+		};
+
+		iomuxc at 53fa8000 {
+			/*
+			 * UART1
+			 */
+			csi0-dat10 { /* UART1_TXD_MUX */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			csi0-dat11 { /* UART1_RXD_MUX */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			/*
+			 * FEC
+			 */
+			fec-mdc {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-mdio {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-select-input = <0x804 0x1>;
+			};
+
+			fec-ref-clk {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rx-er {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-crs-dv {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rxd1 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rxd0 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-tx-en {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-txd1 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-txd0 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			pdata-da-0 { /* GPIO7_6: FEC_nRST */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * I2C1
+			 */
+			csi0-dat9 { /* I2C1_SCL */
+				fsl,iomuxc-mux-mode = <5>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x814 0x0>;
+			};
+
+			csi0-dat8 { /* I2C1_SDA */
+				fsl,iomuxc-mux-mode = <5>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x818 0x0>;
+			};
+
+			/*
+			 * I2C2
+			 */
+			key-col3 { /* I2C2_SCL */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x81c 0x0>;
+			};
+
+			key-row3 { /* I2C2_SDA */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x820 0x0>;
+			};
+
+			/*
+			 * SD1
+			 */
+			sd1-cmd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data0 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data1 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data2 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data3 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			eim-da13 { /* GPIO3_13: SD1_CD */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * SD3
+			 */
+			pata-reset-b { /* ESDHC3_CMD */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-iordy { /* ESDHC3_CLK */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data8 { /* ESDHC3_DAT0 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data9 { /* ESDHC3_DAT1 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data10 { /* ESDHC3_DAT2 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data11 { /* ESDHC3_DAT3 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data0 { /* ESDHC3_DAT4 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data1 { /* ESDHC3_DAT5 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data2 { /* ESDHC3_DAT6 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data3 { /* ESDHC3_DAT7 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			eim-da11 { /* GPIO3_11: SD3_CD */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			eim-da12 { /* GPIO3_12: SD3_WP */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * Buttons
+			 */
+			gpio-8 { /* GPIO1_8: nONKEY/KEEPACT */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			pata-data14 { /* GPIO2_14: USER_UI1 */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			pata-data15 { /* GPIO2_15: USER_UI2 */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * LED
+			 */
+			pata-da-1 { /* GPIO7_7: USER_LED_EN */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+		};
+
+		uart1: uart at 53fc0000 { /* UART2 */
+			status = "disabled";
+		};
+
+		i2c at 53fec000 { /* I2C3 */
+			status = "disabled";
+		};
+
+		uart3: uart at 53ff0000 { /* UART4 */
+			status = "disabled";
+		};
+	};
+
+	aips at 60000000 {	/* AIPS2 */
+		uart4: uart at 63f90000 { /* UART5 */
+			status = "disabled";
+		};
+
+		ecspi at 63fac000 { /* ECSPI2 */
+			status = "disabled";
+		};
+
+		sdma at 63fb0000 {
+			fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+		};
+
+		cspi at 63fc0000 {
+			status = "disabled";
+		};
+
+		i2c at 63fc4000 { /* I2C2 */
+			codec: sgtl5000 at 0a {
+				compatible = "fsl,sgtl5000";
+				reg = <0x0a>;
+			};
+		};
+
+		i2c at 63fc8000 { /* I2C1 */
+			accelerometer: mma8450 at 1c {
+				compatible = "fsl,mma8450";
+				reg = <0x1c>;
+			};
+
+			pmic: dialog at 48 {
+				compatible = "dialog,da9053", "dialog,da9052";
+				reg = <0x48>;
+			};
+		};
+
+		fec at 63fec000 {
+			phy-mode = "rmii";
+			phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power Button";
+			gpios = <&gpio0 8 0>; /* GPIO1_8 */
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio1 14 0>; /* GPIO2_14 */
+			linux,code = <115>; /* KEY_VOLUMEUP */
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio1 15 0>; /* GPIO2_15 */
+			linux,code = <114>; /* KEY_VOLUMEDOWN */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "Heartbeat";
+			gpios = <&gpio6 7 0>; /* GPIO7_7 */
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
new file mode 100644
index 0000000..a700a05
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -0,0 +1,443 @@
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
+/include/ "imx53.dtsi"
+
+/ {
+	model = "Freescale i.MX53 Smart Mobile Reference Design Board";
+	compatible = "fsl,imx53-smd", "fsl,imx53";
+
+	chosen {
+		bootargs = "console=ttymxc0,115200 root=/dev/mmcblk0p3 rootwait";
+	};
+
+	memory {
+		reg = <0x70000000 0x40000000>;
+	};
+
+	aips at 50000000 { /* AIPS1 */
+		spba at 50000000 {
+			esdhc at 50004000 { /* ESDHC1 */
+				cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
+				wp-gpios = <&gpio3 11 0>; /* GPIO4_11 */
+			};
+
+			esdhc at 50008000 { /* ESDHC2 */
+				fsl,card-wired;
+			};
+
+			uart2: uart at 5000c000 { /* UART3 */
+				fsl,uart-has-rtscts;
+			};
+
+			ecspi at 50010000 { /* ECSPI1 */
+				fsl,spi-num-chipselects = <2>;
+				cs-gpios = <&gpio1 30 0>, /* GPIO2_30 */
+					   <&gpio2 19 0>; /* GPIO3_19 */
+
+				zigbee: mc1323 at 0 {
+					compatible = "fsl,mc1323";
+					spi-max-frequency = <8000000>;
+					reg = <0>;
+				};
+
+				flash: m25p32 at 1 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "st,m25p32", "st,m25p";
+					spi-max-frequency = <20000000>;
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
+			esdhc at 50020000 { /* ESDHC3 */
+				fsl,card-wired;
+			};
+
+			esdhc at 50024000 { /* ESDHC4 */
+				status = "disabled";
+			};
+		};
+
+		iomuxc at 53fa8000 {
+			/*
+			 * UART1
+			 */
+			csi0-dat10 { /* UART1_TXD_MUX */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			csi0-dat11 { /* UART1_RXD_MUX */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			/*
+			 * UART2
+			 */
+			pata-dmarq { /* UART2_TXD_MUX */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-buffer-en { /* UART2_RXD_MUX */
+				fsl,iomuxc-mux-mode = <3>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+				fsl,iomuxc-select-input = <0x880 0x3>;
+			};
+
+			/*
+			 * UART3
+			 */
+			pata-da-1 { /* UART3_CTS */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-da-2 { /* UART3_RTS */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+				fsl,iomuxc-select-input = <0x884 0x5>;
+			};
+
+			pata-cs-0 { /* UART3_TXD_MUX */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-cs-1 { /* UART3_RXD_MUX */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+				fsl,iomuxc-select-input = <0x888 0x3>;
+			};
+
+			/*
+			 * FEC
+			 */
+			fec-mdc {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-mdio {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-select-input = <0x804 0x1>;
+			};
+
+			fec-ref-clk {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rx-er {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-crs-dv {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rxd1 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-rxd0 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-tx-en {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-txd1 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			fec-txd0 {
+				fsl,iomuxc-mux-mode = <0>;
+			};
+
+			pdata-da-0 { /* GPIO7_6: FEC_nRST */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * I2C1
+			 */
+			csi0-dat9 { /* I2C1_SCL */
+				fsl,iomuxc-mux-mode = <5>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x814 0x0>;
+			};
+
+			csi0-dat8 { /* I2C1_SDA */
+				fsl,iomuxc-mux-mode = <5>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x818 0x0>;
+			};
+
+			/*
+			 * I2C2
+			 */
+			key-col3 { /* I2C2_SCL */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x81c 0x0>;
+			};
+
+			key-row3 { /* I2C2_SDA */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-select-input = <0x820 0x0>;
+			};
+
+			/*
+			 * SD1
+			 */
+			sd1-cmd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-sion;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data0 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data1 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data2 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd1-data3 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			eim-da13 { /* GPIO3_13: SD1_CD */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			key-row2 { /* GPIO4_11: SD1_WP */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * SD2
+			 */
+			sd2-clk {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd2-cmd {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd2-data3 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd2-data2 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd2-data1 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			sd2-data0 {
+				fsl,iomuxc-mux-mode = <0>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			/*
+			 * SD3
+			 */
+			pata-reset-b { /* ESDHC3_CMD */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-iordy { /* ESDHC3_CLK */
+				fsl,iomuxc-mux-mode = <2>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data8 { /* ESDHC3_DAT0 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data9 { /* ESDHC3_DAT1 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data10 { /* ESDHC3_DAT2 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data11 { /* ESDHC3_DAT3 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data0 { /* ESDHC3_DAT4 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data1 { /* ESDHC3_DAT5 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data2 { /* ESDHC3_DAT6 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			pata-data3 { /* ESDHC3_DAT7 */
+				fsl,iomuxc-mux-mode = <4>;
+				fsl,iomuxc-pad-ctl = <0x1e4>;
+			};
+
+			eim-da11 { /* GPIO3_11: SD3_CD */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			eim-da12 { /* GPIO3_12: SD3_WP */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			/*
+			 * Buttons
+			 */
+			pata-data14 { /* GPIO2_14: VOL+ */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+
+			pata-data15 { /* GPIO2_15: VOL- */
+				fsl,iomuxc-mux-mode = <1>;
+			};
+		};
+
+		i2c at 53fec000 { /* I2C3 */
+			status = "disabled";
+		};
+
+		uart3: uart at 53ff0000 { /* UART4 */
+			status = "disabled";
+		};
+	};
+
+	aips at 60000000 {	/* AIPS2 */
+		uart4: uart at 63f90000 { /* UART5 */
+			status = "disabled";
+		};
+
+		ecspi at 63fac000 { /* ECSPI2 */
+			status = "disabled";
+		};
+
+		sdma at 63fb0000 {
+			fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+		};
+
+		cspi at 63fc0000 {
+			status = "disabled";
+		};
+
+		i2c at 63fc4000 { /* I2C2 */
+			codec: sgtl5000 at 0a {
+				compatible = "fsl,sgtl5000";
+				reg = <0x0a>;
+			};
+
+			magnetometer: mag3110 at 0e {
+				compatible = "fsl,mag3110";
+				reg = <0x0e>;
+			};
+
+			touchkey: mpr121 at 5a {
+				compatible = "fsl,mpr121";
+				reg = <0x5a>;
+			};
+		};
+
+		i2c at 63fc8000 { /* I2C1 */
+			accelerometer: mma8450 at 1c {
+				compatible = "fsl,mma8450";
+				reg = <0x1c>;
+			};
+
+			camera: ov5642 at 3c {
+				compatible = "ovti,ov5642";
+				reg = <0x3c>;
+			};
+
+			pmic: dialog at 48 {
+				compatible = "dialog,da9053", "dialog,da9052";
+				reg = <0x48>;
+			};
+		};
+
+		fec at 63fec000 {
+			phy-mode = "rmii";
+			phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio1 14 0>; /* GPIO2_14 */
+			linux,code = <115>; /* KEY_VOLUMEUP */
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio1 15 0>; /* GPIO2_15 */
+			linux,code = <114>; /* KEY_VOLUMEDOWN */
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
new file mode 100644
index 0000000..80ba1c2
--- /dev/null
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -0,0 +1,1055 @@
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
+		serial3 = &uart3;
+		serial4 = &uart4;
+	};
+
+	tzic: tz-interrupt-controller at 0fffc000 {
+		compatible = "fsl,imx53-tzic", "fsl,tzic";
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		reg = <0x0fffc000 0x4000>;
+	};
+
+	aips at 50000000 { /* AIPS1 */
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x50000000 0x10000000>;
+		ranges;
+
+		spba at 50000000 {
+			compatible = "fsl,spba-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x50000000 0x40000>;
+			ranges;
+
+			esdhc at 50004000 { /* ESDHC1 */
+				compatible = "fsl,imx53-esdhc";
+				reg = <0x50004000 0x4000>;
+				interrupts = <1>;
+			};
+
+			esdhc at 50008000 { /* ESDHC2 */
+				compatible = "fsl,imx53-esdhc";
+				reg = <0x50008000 0x4000>;
+				interrupts = <2>;
+			};
+
+			uart2: uart at 5000c000 { /* UART3 */
+				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+				reg = <0x5000c000 0x4000>;
+				interrupts = <33>;
+			};
+
+			ecspi at 50010000 { /* ECSPI1 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
+				reg = <0x50010000 0x4000>;
+				interrupts = <36>;
+			};
+
+			esdhc at 50020000 { /* ESDHC3 */
+				compatible = "fsl,imx53-esdhc";
+				reg = <0x50020000 0x4000>;
+				interrupts = <3>;
+			};
+
+			esdhc at 50024000 { /* ESDHC4 */
+				compatible = "fsl,imx53-esdhc";
+				reg = <0x50024000 0x4000>;
+				interrupts = <4>;
+			};
+		};
+
+		gpio0: gpio at 53f84000 { /* GPIO1 */
+			compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+			reg = <0x53f84000 0x4000>;
+			interrupts = <50 51>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio1: gpio at 53f88000 { /* GPIO2 */
+			compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+			reg = <0x53f88000 0x4000>;
+			interrupts = <52 53>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio2: gpio at 53f8c000 { /* GPIO3 */
+			compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+			reg = <0x53f8c000 0x4000>;
+			interrupts = <54 55>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio3: gpio at 53f90000 { /* GPIO4 */
+			compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+			reg = <0x53f90000 0x4000>;
+			interrupts = <56 57>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		wdt at 53f98000 { /* WDOG1 */
+			compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
+			reg = <0x53f98000 0x4000>;
+			interrupts = <58>;
+		};
+
+		iomuxc at 53fa8000 {
+			#address-cells = <2>;
+			#size-cells = <0>;
+			compatible = "fsl,imx53-iomuxc";
+			reg = <0x53fa8000 0x4000>;
+
+			gpio-19 {
+				reg = <0x20 0x348>;
+			};
+
+			key-col0 {
+				reg = <0x24 0x34c>;
+			};
+
+			key-row0 {
+				reg = <0x28 0x350>;
+			};
+
+			key-col1 {
+				reg = <0x2c 0x354>;
+			};
+
+			key-row1 {
+				reg = <0x30 0x358>;
+			};
+
+			key-col2 {
+				reg = <0x34 0x35c>;
+			};
+
+			key-row2 {
+				reg = <0x38 0x360>;
+			};
+
+			key-col3 {
+				reg = <0x3c 0x364>;
+			};
+
+			key-row3 {
+				reg = <0x40 0x368>;
+			};
+
+			key-col4 {
+				reg = <0x44 0x36c>;
+			};
+
+			key-row4 {
+				reg = <0x48 0x370>;
+			};
+
+			di0-disp-clk {
+				reg = <0x4c 0x378>;
+			};
+
+			di0-pin15 {
+				reg = <0x50 0x37c>;
+			};
+
+			di0-pin2 {
+				reg = <0x54 0x380>;
+			};
+
+			di0-pin3 {
+				reg = <0x58 0x384>;
+			};
+
+			di0-pin4 {
+				reg = <0x5c 0x388>;
+			};
+
+			disp0-dat0 {
+				reg = <0x60 0x38c>;
+			};
+
+			disp0-dat1 {
+				reg = <0x64 0x390>;
+			};
+
+			disp0-dat2 {
+				reg = <0x68 0x394>;
+			};
+
+			disp0-dat3 {
+				reg = <0x6c 0x398>;
+			};
+
+			disp0-dat4 {
+				reg = <0x70 0x39c>;
+			};
+
+			disp0-dat5 {
+				reg = <0x74 0x3a0>;
+			};
+
+			disp0-dat6 {
+				reg = <0x78 0x3a4>;
+			};
+
+			disp0-dat7 {
+				reg = <0x7c 0x3a8>;
+			};
+
+			disp0-dat8 {
+				reg = <0x80 0x3ac>;
+			};
+
+			disp0-dat9 {
+				reg = <0x84 0x3b0>;
+			};
+
+			disp0-dat10 {
+				reg = <0x88 0x3b4>;
+			};
+
+			disp0-dat11 {
+				reg = <0x8c 0x3b8>;
+			};
+
+			disp0-dat12 {
+				reg = <0x90 0x3bc>;
+			};
+
+			disp0-dat13 {
+				reg = <0x94 0x3c0>;
+			};
+
+			disp0-dat14 {
+				reg = <0x98 0x3c4>;
+			};
+
+			disp0-dat15 {
+				reg = <0x9c 0x3c8>;
+			};
+
+			disp0-dat16 {
+				reg = <0xa0 0x3cc>;
+			};
+
+			disp0-dat17 {
+				reg = <0xa4 0x3d0>;
+			};
+
+			disp0-dat18 {
+				reg = <0xa8 0x3d4>;
+			};
+
+			disp0-dat19 {
+				reg = <0xac 0x3d8>;
+			};
+
+			disp0-dat20 {
+				reg = <0xb0 0x3dc>;
+			};
+
+			disp0-dat21 {
+				reg = <0xb4 0x3e0>;
+			};
+
+			disp0-dat22 {
+				reg = <0xb8 0x3e4>;
+			};
+
+			disp0-dat23 {
+				reg = <0xbc 0x3e8>;
+			};
+
+			csi0-pixclk {
+				reg = <0xc0 0x3ec>;
+			};
+
+			csi0-mclk {
+				reg = <0xc4 0x3f0>;
+			};
+
+			csi0-data-en {
+				reg = <0xc8 0x3f4>;
+			};
+
+			csi0-vsync {
+				reg = <0xcc 0x3f8>;
+			};
+
+			csi0-dat4 {
+				reg = <0xd0 0x3fc>;
+			};
+
+			csi0-dat5 {
+				reg = <0xd4 0x400>;
+			};
+
+			csi0-dat6 {
+				reg = <0xd8 0x404>;
+			};
+
+			csi0-dat7 {
+				reg = <0xdc 0x408>;
+			};
+
+			csi0-dat8 {
+				reg = <0xe0 0x40c>;
+			};
+
+			csi0-dat9 {
+				reg = <0xe4 0x410>;
+			};
+
+			csi0-dat10 {
+				reg = <0xe8 0x414>;
+			};
+
+			csi0-dat11 {
+				reg = <0xec 0x418>;
+			};
+
+			csi0-dat12 {
+				reg = <0xf0 0x41c>;
+			};
+
+			csi0-dat13 {
+				reg = <0xf4 0x420>;
+			};
+
+			csi0-dat14 {
+				reg = <0xf8 0x424>;
+			};
+
+			csi0-dat15 {
+				reg = <0xfc 0x428>;
+			};
+
+			csi0-dat16 {
+				reg = <0x100 0x42c>;
+			};
+
+			csi0-dat17 {
+				reg = <0x104 0x430>;
+			};
+
+			csi0-dat18 {
+				reg = <0x108 0x434>;
+			};
+
+			csi0-dat19 {
+				reg = <0x10c 0x438>;
+			};
+
+			eim-a25 {
+				reg = <0x110 0x458>;
+			};
+
+			eim-eb2 {
+				reg = <0x114 0x45c>;
+			};
+
+			eim-d16 {
+				reg = <0x118 0x460>;
+			};
+
+			eim-d17 {
+				reg = <0x11c 0x464>;
+			};
+
+			eim-d18 {
+				reg = <0x120 0x468>;
+			};
+
+			eim-d19 {
+				reg = <0x124 0x46c>;
+			};
+
+			eim-d20 {
+				reg = <0x128 0x470>;
+			};
+
+			eim-d21 {
+				reg = <0x12c 0x474>;
+			};
+
+			eim-d22 {
+				reg = <0x130 0x478>;
+			};
+
+			eim-d23 {
+				reg = <0x134 0x47c>;
+			};
+
+			eim-eb3 {
+				reg = <0x138 0x480>;
+			};
+
+			eim-d24 {
+				reg = <0x13c 0x484>;
+			};
+
+			eim-d25 {
+				reg = <0x140 0x488>;
+			};
+
+			eim-d26 {
+				reg = <0x144 0x48c>;
+			};
+
+			eim-d27 {
+				reg = <0x148 0x490>;
+			};
+
+			eim-d28 {
+				reg = <0x14c 0x494>;
+			};
+
+			eim-d29 {
+				reg = <0x150 0x498>;
+			};
+
+			eim-d30 {
+				reg = <0x154 0x49c>;
+			};
+
+			eim-d31 {
+				reg = <0x158 0x4a0>;
+			};
+
+			eim-a24 {
+				reg = <0x15c 0x4a8>;
+			};
+
+			eim-a23 {
+				reg = <0x160 0x4ac>;
+			};
+
+			eim-a22 {
+				reg = <0x164 0x4b0>;
+			};
+
+			eim-a21 {
+				reg = <0x168 0x4b4>;
+			};
+
+			eim-a20 {
+				reg = <0x16c 0x4b8>;
+			};
+
+			eim-a19 {
+				reg = <0x170 0x4bc>;
+			};
+
+			eim-a18 {
+				reg = <0x174 0x4c0>;
+			};
+
+			eim-a17 {
+				reg = <0x178 0x4c4>;
+			};
+
+			eim-a16 {
+				reg = <0x17c 0x4c8>;
+			};
+
+			eim-cs0 {
+				reg = <0x180 0x4cc>;
+			};
+
+			eim-cs1 {
+				reg = <0x184 0x4d0>;
+			};
+
+			eim-oe {
+				reg = <0x188 0x4d4>;
+			};
+
+			eim-rw {
+				reg = <0x18c 0x4d8>;
+			};
+
+			eim-lba {
+				reg = <0x190 0x4dc>;
+			};
+
+			eim-eb0 {
+				reg = <0x194 0x4e4>;
+			};
+
+			eim-eb1 {
+				reg = <0x198 0x4e8>;
+			};
+
+			eim-da0 {
+				reg = <0x19c 0x4ec>;
+			};
+
+			eim-da1 {
+				reg = <0x1a0 0x4f0>;
+			};
+
+			eim-da2 {
+				reg = <0x1a4 0x4f4>;
+			};
+
+			eim-da3 {
+				reg = <0x1a8 0x4f8>;
+			};
+
+			eim-da4 {
+				reg = <0x1ac 0x4fc>;
+			};
+
+			eim-da5 {
+				reg = <0x1b0 0x500>;
+			};
+
+			eim-da6 {
+				reg = <0x1b4 0x504>;
+			};
+
+			eim-da7 {
+				reg = <0x1b8 0x508>;
+			};
+
+			eim-da8 {
+				reg = <0x1bc 0x50c>;
+			};
+
+			eim-da9 {
+				reg = <0x1c0 0x510>;
+			};
+
+			eim-da10 {
+				reg = <0x1c4 0x514>;
+			};
+
+			eim-da11 {
+				reg = <0x1c8 0x518>;
+			};
+
+			eim-da12 {
+				reg = <0x1cc 0x51c>;
+			};
+
+			eim-da13 {
+				reg = <0x1d0 0x520>;
+			};
+
+			eim-da14 {
+				reg = <0x1d4 0x524>;
+			};
+
+			eim-da15 {
+				reg = <0x1d8 0x528>;
+			};
+
+			nandf-we-b {
+				reg = <0x1dc 0x52c>;
+			};
+
+			nandf-re-b {
+				reg = <0x1e0 0x530>;
+			};
+
+			eim-wait {
+				reg = <0x1e4 0x534>;
+			};
+
+			lvds1-tx3-p {
+				reg = <0x1ec 0x0>;
+			};
+
+			lvds1-tx2-p {
+				reg = <0x1f0 0x0>;
+			};
+
+			lvds1-clk-p {
+				reg = <0x1f4 0x0>;
+			};
+
+			lvds1-tx1-p {
+				reg = <0x1f8 0x0>;
+			};
+
+			lvds1-tx0-p {
+				reg = <0x1fc 0x0>;
+			};
+
+			lvds0-tx3-p {
+				reg = <0x200 0x0>;
+			};
+
+			lvds0-clk-p {
+				reg = <0x204 0x0>;
+			};
+
+			lvds0-tx2-p {
+				reg = <0x208 0x0>;
+			};
+
+			lvds0-tx1-p {
+				reg = <0x20c 0x0>;
+			};
+
+			lvds0-tx0-p {
+				reg = <0x210 0x0>;
+			};
+
+			gpio-10 {
+				reg = <0x214 0x540>;
+			};
+
+			gpio-11 {
+				reg = <0x218 0x544>;
+			};
+
+			gpio-12 {
+				reg = <0x21c 0x548>;
+			};
+
+			gpio-13 {
+				reg = <0x220 0x54c>;
+			};
+
+			gpio-14 {
+				reg = <0x224 0x550>;
+			};
+
+			nandf-cle {
+				reg = <0x228 0x5a0>;
+			};
+
+			nandf-ale {
+				reg = <0x22c 0x5a4>;
+			};
+
+			nandf-wp-b {
+				reg = <0x230 0x5a8>;
+			};
+
+			nandf-rb0 {
+				reg = <0x234 0x5ac>;
+			};
+
+			nandf-cs0 {
+				reg = <0x238 0x5b0>;
+			};
+
+			nandf-cs1 {
+				reg = <0x23c 0x5b4>;
+			};
+
+			nandf-cs2 {
+				reg = <0x240 0x5b8>;
+			};
+
+			nandf-cs3 {
+				reg = <0x244 0x5bc>;
+			};
+
+			fec-mdio {
+				reg = <0x248 0x5c4>;
+			};
+
+			fec-ref-clk {
+				reg = <0x24c 0x5c8>;
+			};
+
+			fec-rx-er {
+				reg = <0x250 0x5cc>;
+			};
+
+			fec-crs-dv {
+				reg = <0x254 0x5d0>;
+			};
+
+			fec-rxd1 {
+				reg = <0x258 0x5d4>;
+			};
+
+			fec-rxd0 {
+				reg = <0x25c 0x5d8>;
+			};
+
+			fec-tx-en {
+				reg = <0x260 0x5dc>;
+			};
+
+			fec-txd1 {
+				reg = <0x264 0x5e0>;
+			};
+
+			fec-txd0 {
+				reg = <0x268 0x5e4>;
+			};
+
+			fec-mdc {
+				reg = <0x26c 0x5e8>;
+			};
+
+			pata-diow {
+				reg = <0x270 0x5f0>;
+			};
+
+			pata-dmack {
+				reg = <0x274 0x5f4>;
+			};
+
+			pata-dmarq {
+				reg = <0x278 0x5f8>;
+			};
+
+			pata-buffer-en {
+				reg = <0x27c 0x5fc>;
+			};
+
+			pata-intrq {
+				reg = <0x280 0x600>;
+			};
+
+			pata-dior {
+				reg = <0x284 0x604>;
+			};
+
+			pata-reset-b {
+				reg = <0x288 0x608>;
+			};
+
+			pata-iordy {
+				reg = <0x28c 0x60c>;
+			};
+
+			pata-da-0 {
+				reg = <0x290 0x610>;
+			};
+
+			pata-da-1 {
+				reg = <0x294 0x614>;
+			};
+
+			pata-da-2 {
+				reg = <0x298 0x618>;
+			};
+
+			pata-cs-0 {
+				reg = <0x29c 0x61c>;
+			};
+
+			pata-cs-1 {
+				reg = <0x2a0 0x620>;
+			};
+
+			pata-data0 {
+				reg = <0x2a4 0x628>;
+			};
+
+			pata-data1 {
+				reg = <0x2a8 0x62c>;
+			};
+
+			pata-data2 {
+				reg = <0x2ac 0x630>;
+			};
+
+			pata-data3 {
+				reg = <0x2b0 0x634>;
+			};
+
+			pata-data4 {
+				reg = <0x2b4 0x638>;
+			};
+
+			pata-data5 {
+				reg = <0x2b8 0x63c>;
+			};
+
+			pata-data6 {
+				reg = <0x2bc 0x640>;
+			};
+
+			pata-data7 {
+				reg = <0x2c0 0x644>;
+			};
+
+			pata-data8 {
+				reg = <0x2c4 0x648>;
+			};
+
+			pata-data9 {
+				reg = <0x2c8 0x64c>;
+			};
+
+			pata-data10 {
+				reg = <0x2cc 0x650>;
+			};
+
+			pata-data11 {
+				reg = <0x2d0 0x654>;
+			};
+
+			pata-data12 {
+				reg = <0x2d4 0x658>;
+			};
+
+			pata-data13 {
+				reg = <0x2d8 0x65c>;
+			};
+
+			pata-data14 {
+				reg = <0x2dc 0x660>;
+			};
+
+			pata-data15 {
+				reg = <0x2e0 0x664>;
+			};
+
+			sd1-data0 {
+				reg = <0x2e4 0x66c>;
+			};
+
+			sd1-data1 {
+				reg = <0x2e8 0x670>;
+			};
+
+			sd1-cmd {
+				reg = <0x2ec 0x674>;
+			};
+
+			sd1-data2 {
+				reg = <0x2f0 0x678>;
+			};
+
+			sd1-clk {
+				reg = <0x2f4 0x67c>;
+			};
+
+			sd1-data3 {
+				reg = <0x2f8 0x680>;
+			};
+
+			sd2-clk {
+				reg = <0x2fc 0x688>;
+			};
+
+			sd2-cmd {
+				reg = <0x300 0x68c>;
+			};
+
+			sd2-data3 {
+				reg = <0x304 0x690>;
+			};
+
+			sd2-data2 {
+				reg = <0x308 0x694>;
+			};
+
+			sd2-data1 {
+				reg = <0x30c 0x698>;
+			};
+
+			sd2-data0 {
+				reg = <0x310 0x69c>;
+			};
+
+			gpio-0 {
+				reg = <0x314 0x6a4>;
+			};
+
+			gpio-1 {
+				reg = <0x318 0x6a8>;
+			};
+
+			gpio-9 {
+				reg = <0x31c 0x6ac>;
+			};
+
+			gpio-3 {
+				reg = <0x320 0x6b0>;
+			};
+
+			gpio-6 {
+				reg = <0x324 0x6b4>;
+			};
+
+			gpio-2 {
+				reg = <0x328 0x6b8>;
+			};
+
+			gpio-4 {
+				reg = <0x32c 0x6bc>;
+			};
+
+			gpio-5 {
+				reg = <0x330 0x6c0>;
+			};
+
+			gpio-7 {
+				reg = <0x334 0x6c4>;
+			};
+
+			gpio-8 {
+				reg = <0x338 0x6c8>;
+			};
+
+			gpio-16 {
+				reg = <0x33c 0x6cc>;
+			};
+
+			gpio-17 {
+				reg = <0x340 0x6d0>;
+			};
+
+			gpio-18 {
+				reg = <0x344 0x6d4>;
+			};
+		};
+
+		uart0: uart at 53fbc000 { /* UART1 */
+			compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+			reg = <0x53fbc000 0x4000>;
+			interrupts = <31>;
+		};
+
+		uart1: uart at 53fc0000 { /* UART2 */
+			compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+			reg = <0x53fc0000 0x4000>;
+			interrupts = <32>;
+		};
+
+		gpio4: gpio at 53fdc000 { /* GPIO5 */
+			compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+			reg = <0x53fdc000 0x4000>;
+			interrupts = <103 104>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio5: gpio at 53fe0000 { /* GPIO6 */
+			compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+			reg = <0x53fe0000 0x4000>;
+			interrupts = <105 106>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		gpio6: gpio at 53fe4000 { /* GPIO7 */
+			compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+			reg = <0x53fe4000 0x4000>;
+			interrupts = <107 108>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		i2c at 53fec000 { /* I2C3 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
+			reg = <0x53fec000 0x4000>;
+			interrupts = <64>;
+		};
+
+		uart3: uart at 53ff0000 { /* UART4 */
+			compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+			reg = <0x53ff0000 0x4000>;
+			interrupts = <13>;
+		};
+	};
+
+	aips at 60000000 {	/* AIPS2 */
+		compatible = "fsl,aips-bus", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x60000000 0x10000000>;
+		ranges;
+
+		uart4: uart at 63f90000 { /* UART5 */
+			compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+			reg = <0x63f90000 0x4000>;
+			interrupts = <86>;
+		};
+
+		ecspi at 63fac000 { /* ECSPI2 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
+			reg = <0x63fac000 0x4000>;
+			interrupts = <37>;
+		};
+
+		sdma at 63fb0000 {
+			fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+		};
+
+		cspi at 63fc0000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
+			reg = <0x63fc0000 0x4000>;
+			interrupts = <38>;
+		};
+
+		i2c at 63fc4000 { /* I2C2 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
+			reg = <0x63fc4000 0x4000>;
+			interrupts = <63>;
+		};
+
+		i2c at 63fc8000 { /* I2C1 */
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
+			reg = <0x63fc8000 0x4000>;
+			interrupts = <62>;
+		};
+
+		fec at 63fec000 {
+			compatible = "fsl,imx53-fec", "fsl,imx25-fec";
+			reg = <0x63fec000 0x4000>;
+			interrupts = <87>;
+		};
+	};
+};
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 53422d2..9f60dc1 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -173,6 +173,14 @@ endif # ARCH_MX51
 if ARCH_MX53_SUPPORTED
 comment "i.MX53 machines:"
 
+config MACH_IMX53_DT
+	bool "Support i.MX53 platforms from device tree"
+	select SOC_IMX53
+	select USE_OF
+	help
+	  Include support for Freescale i.MX53 based platforms
+	  using the device tree for discovery
+
 config MACH_MX53_EVK
 	bool "Support MX53 EVK platforms"
 	select SOC_IMX53
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 71379f6..a1fd712 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -24,3 +24,4 @@ obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
 obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
 
 obj-$(CONFIG_OF) += iomuxc-dt.o
+obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
new file mode 100644
index 0000000..a4d75fc
--- /dev/null
+++ b/arch/arm/mach-mx5/imx53-dt.c
@@ -0,0 +1,161 @@
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
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+#include <mach/mx53.h>
+
+/*
+ * Lookup table for attaching a specific name and platform_data pointer to
+ * devices as they get created by of_platform_populate().  Ideally this table
+ * would not exist, but the current clock implementation depends on some devices
+ * having a specific name.
+ */
+static const struct of_dev_auxdata imx53_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART1_BASE_ADDR, "imx21-uart.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART2_BASE_ADDR, "imx21-uart.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART3_BASE_ADDR, "imx21-uart.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART4_BASE_ADDR, "imx21-uart.3", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-uart", MX53_UART5_BASE_ADDR, "imx21-uart.4", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-fec", MX53_FEC_BASE_ADDR, "imx25-fec.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC1_BASE_ADDR, "sdhci-esdhc-imx53.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC2_BASE_ADDR, "sdhci-esdhc-imx53.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC3_BASE_ADDR, "sdhci-esdhc-imx53.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-esdhc", MX53_ESDHC4_BASE_ADDR, "sdhci-esdhc-imx53.3", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-ecspi", MX53_ECSPI1_BASE_ADDR, "imx51-ecspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-ecspi", MX53_ECSPI2_BASE_ADDR, "imx51-ecspi.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-cspi", MX53_CSPI_BASE_ADDR, "imx35-cspi.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C1_BASE_ADDR, "imx-i2c.0", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C2_BASE_ADDR, "imx-i2c.1", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-i2c", MX53_I2C3_BASE_ADDR, "imx-i2c.2", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-sdma", MX53_SDMA_BASE_ADDR, "imx35-sdma", NULL),
+	OF_DEV_AUXDATA("fsl,imx53-wdt", MX53_WDOG1_BASE_ADDR, "imx2-wdt.0", NULL),
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx53_tzic_of_match[] __initconst = {
+	{ .compatible = "fsl,imx53-tzic", },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx53_gpio_of_match[] __initconst = {
+	{ .compatible = "fsl,imx53-gpio", },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx53_iomuxc_of_match[] __initconst = {
+	{ .compatible = "fsl,imx53-iomuxc", },
+	{ /* sentinel */ }
+};
+
+/* Configure EIM for SMSC LAN9220 */
+static void __init imx53_ard_eim_config(void)
+{
+	u32 val;
+	void __iomem *eim_base, *iomuxc_base;
+
+	eim_base = ioremap(MX53_WEIM_BASE_ADDR, SZ_4K);
+	iomuxc_base = ioremap(MX53_IOMUXC_BASE_ADDR, SZ_4K);
+	if (!eim_base || !iomuxc_base) {
+		pr_warn("%s: ioremap failed\n", __func__);
+		return;
+	}
+
+	/* CS1 timings for LAN9220 */
+	writel(0x20001, (eim_base + 0x18));
+	writel(0x0, (eim_base + 0x1c));
+	writel(0x16000202, (eim_base + 0x20));
+	writel(0x00000002, (eim_base + 0x24));
+	writel(0x16002082, (eim_base + 0x28));
+	writel(0x00000000, (eim_base + 0x2c));
+	writel(0x00000000, (eim_base + 0x90));
+
+	/* specify 64 MB on CS1 and CS0 on GPR1 */
+	val = readl(iomuxc_base + 0x4);
+	val &= ~0x3f;
+	val |= 0x1b;
+	writel(val, (iomuxc_base + 0x4));
+
+	iounmap(eim_base);
+	iounmap(iomuxc_base);
+}
+
+static void __init imx53_dt_init(void)
+{
+	int gpio_irq = MXC_INTERNAL_IRQS + ARCH_NR_GPIOS;
+
+	mxc_iomuxc_dt_init(imx53_iomuxc_of_match);
+
+	irq_domain_generate_simple(imx53_tzic_of_match, MX53_TZIC_BASE_ADDR, 0);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO1_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO2_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO3_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO4_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO5_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO6_BASE_ADDR, gpio_irq);
+	gpio_irq -= 32;
+	irq_domain_generate_simple(imx53_gpio_of_match, MX53_GPIO7_BASE_ADDR, gpio_irq);
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     imx53_auxdata_lookup, NULL);
+}
+
+static void __init imx53_ard_init(void)
+{
+	imx53_ard_eim_config();
+	imx53_dt_init();
+}
+
+static void __init imx53_timer_init(void)
+{
+	mx53_clocks_init(32768, 24000000, 22579200, 0);
+}
+
+static struct sys_timer imx53_timer = {
+	.init = imx53_timer_init,
+};
+
+static const char *imx53_dt_board_compat[] __initdata = {
+	"fsl,imx53-ard",
+	"fsl,imx53-evk",
+	"fsl,imx53-qsb",
+	"fsl,imx53-smd",
+	NULL
+};
+
+DT_MACHINE_START(IMX53_DT, "Freescale i.MX53 (Device Tree Support)")
+	.map_io		= mx53_map_io,
+	.init_early	= imx53_init_early,
+	.init_irq	= mx53_init_irq,
+	.timer		= &imx53_timer,
+	.init_machine	= imx53_dt_init,
+	.dt_compat	= imx53_dt_board_compat,
+MACHINE_END
+
+DT_MACHINE_START(IMX53_DT_ARD, "Freescale i.MX53 ARD (Device Tree Support)")
+	.map_io		= mx53_map_io,
+	.init_early	= imx53_init_early,
+	.init_irq	= mx53_init_irq,
+	.timer		= &imx53_timer,
+	.init_machine	= imx53_ard_init,
+	.dt_compat	= imx53_dt_board_compat,
+MACHINE_END
-- 
1.7.4.1
