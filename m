From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Oct 2011 08:42:16 +0800
Subject: [PATCH v6 1/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <1318812137-13991-1-git-send-email-shawn.guo@linaro.org>
References: <1318812137-13991-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1318812137-13991-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@freescale.com>

It adds device tree support for imx53 boards.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/fsl.txt |   15 ++
 arch/arm/boot/dts/imx53-ard.dts               |  113 +++++++++
 arch/arm/boot/dts/imx53-evk.dts               |  120 ++++++++++
 arch/arm/boot/dts/imx53-qsb.dts               |  125 ++++++++++
 arch/arm/boot/dts/imx53-smd.dts               |  169 ++++++++++++++
 arch/arm/boot/dts/imx53.dtsi                  |  301 +++++++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                     |   12 +
 arch/arm/mach-mx5/Makefile                    |    2 +
 arch/arm/mach-mx5/board-mx53_ard.c            |   12 +-
 arch/arm/mach-mx5/board-mx53_evk.c            |    9 +-
 arch/arm/mach-mx5/board-mx53_loco.c           |    9 +-
 arch/arm/mach-mx5/board-mx53_smd.c            |    9 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c           |   31 +++
 arch/arm/mach-mx5/imx53-dt.c                  |  126 +++++++++++
 arch/arm/plat-mxc/include/mach/common.h       |    6 +
 15 files changed, 1049 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/fsl.txt
 create mode 100644 arch/arm/boot/dts/imx53-ard.dts
 create mode 100644 arch/arm/boot/dts/imx53-evk.dts
 create mode 100644 arch/arm/boot/dts/imx53-qsb.dts
 create mode 100644 arch/arm/boot/dts/imx53-smd.dts
 create mode 100644 arch/arm/boot/dts/imx53.dtsi
 create mode 100644 arch/arm/mach-mx5/imx53-dt.c

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
new file mode 100644
index 0000000..d1e8d6f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
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
index 0000000..2ab7f80
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -0,0 +1,113 @@
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
+	soc {
+		aips at 50000000 { /* AIPS1 */
+			spba at 50000000 {
+				esdhc at 50004000 { /* ESDHC1 */
+					cd-gpios = <&gpio0 1 0>; /* GPIO1_1 */
+					wp-gpios = <&gpio0 9 0>; /* GPIO1_9 */
+					status = "okay";
+				};
+			};
+
+			wdog at 53f98000 { /* WDOG1 */
+				status = "okay";
+			};
+
+			iomuxc at 53fa8000 {
+				compatible = "fsl,imx53-iomuxc-ard";
+				reg = <0x53fa8000 0x4000>;
+			};
+
+			uart0: uart at 53fbc000 { /* UART1 */
+				status = "okay";
+			};
+		};
+
+		aips at 60000000 {	/* AIPS2 */
+			sdma at 63fb0000 {
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+			};
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
index 0000000..3f3a881
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -0,0 +1,120 @@
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
+	soc {
+		aips at 50000000 { /* AIPS1 */
+			spba at 50000000 {
+				esdhc at 50004000 { /* ESDHC1 */
+					cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
+					wp-gpios = <&gpio2 14 0>; /* GPIO3_14 */
+					status = "okay";
+				};
+
+				ecspi at 50010000 { /* ECSPI1 */
+					fsl,spi-num-chipselects = <2>;
+					cs-gpios = <&gpio1 30 0>, /* GPIO2_30 */
+						   <&gpio2 19 0>; /* GPIO3_19 */
+					status = "okay";
+
+					flash: at45db321d at 1 {
+						#address-cells = <1>;
+						#size-cells = <1>;
+						compatible = "atmel,at45db321d", "atmel,at45", "atmel,dataflash";
+						spi-max-frequency = <25000000>;
+						reg = <1>;
+
+						partition at 0 {
+							label = "U-Boot";
+							reg = <0x0 0x40000>;
+							read-only;
+						};
+
+						partition at 40000 {
+							label = "Kernel";
+							reg = <0x40000 0x3c0000>;
+						};
+					};
+				};
+
+				esdhc at 50020000 { /* ESDHC3 */
+					cd-gpios = <&gpio2 11 0>; /* GPIO3_11 */
+					wp-gpios = <&gpio2 12 0>; /* GPIO3_12 */
+					status = "okay";
+				};
+			};
+
+			wdog at 53f98000 { /* WDOG1 */
+				status = "okay";
+			};
+
+			iomuxc at 53fa8000 {
+				compatible = "fsl,imx53-iomuxc-evk";
+				reg = <0x53fa8000 0x4000>;
+			};
+
+			uart0: uart at 53fbc000 { /* UART1 */
+				status = "okay";
+			};
+		};
+
+		aips at 60000000 {	/* AIPS2 */
+			sdma at 63fb0000 {
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+			};
+
+			i2c at 63fc4000 { /* I2C2 */
+				status = "okay";
+
+				pmic: mc13892 at 08 {
+					compatible = "fsl,mc13892", "fsl,mc13xxx";
+					reg = <0x08>;
+				};
+
+				codec: sgtl5000 at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+				};
+			};
+
+			fec at 63fec000 {
+				phy-mode = "rmii";
+				phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+				status = "okay";
+			};
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
index 0000000..ae6de6d
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -0,0 +1,125 @@
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
+	soc {
+		aips at 50000000 { /* AIPS1 */
+			spba at 50000000 {
+				esdhc at 50004000 { /* ESDHC1 */
+					cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
+					status = "okay";
+				};
+
+				esdhc at 50020000 { /* ESDHC3 */
+					cd-gpios = <&gpio2 11 0>; /* GPIO3_11 */
+					wp-gpios = <&gpio2 12 0>; /* GPIO3_12 */
+					status = "okay";
+				};
+			};
+
+			wdog at 53f98000 { /* WDOG1 */
+				status = "okay";
+			};
+
+			iomuxc at 53fa8000 {
+				compatible = "fsl,imx53-iomuxc-qsb";
+				reg = <0x53fa8000 0x4000>;
+			};
+
+			uart0: uart at 53fbc000 { /* UART1 */
+				status = "okay";
+			};
+		};
+
+		aips at 60000000 {	/* AIPS2 */
+			sdma at 63fb0000 {
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+			};
+
+			i2c at 63fc4000 { /* I2C2 */
+				status = "okay";
+
+				codec: sgtl5000 at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+				};
+			};
+
+			i2c at 63fc8000 { /* I2C1 */
+				status = "okay";
+
+				accelerometer: mma8450 at 1c {
+					compatible = "fsl,mma8450";
+					reg = <0x1c>;
+				};
+
+				pmic: dialog at 48 {
+					compatible = "dialog,da9053", "dialog,da9052";
+					reg = <0x48>;
+				};
+			};
+
+			fec at 63fec000 {
+				phy-mode = "rmii";
+				phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+				status = "okay";
+			};
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
index 0000000..b1c062e
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -0,0 +1,169 @@
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
+	soc {
+		aips at 50000000 { /* AIPS1 */
+			spba at 50000000 {
+				esdhc at 50004000 { /* ESDHC1 */
+					cd-gpios = <&gpio2 13 0>; /* GPIO3_13 */
+					wp-gpios = <&gpio3 11 0>; /* GPIO4_11 */
+					status = "okay";
+				};
+
+				esdhc at 50008000 { /* ESDHC2 */
+					fsl,card-wired;
+					status = "okay";
+				};
+
+				uart2: uart at 5000c000 { /* UART3 */
+					fsl,uart-has-rtscts;
+					status = "okay";
+				};
+
+				ecspi at 50010000 { /* ECSPI1 */
+					fsl,spi-num-chipselects = <2>;
+					cs-gpios = <&gpio1 30 0>, /* GPIO2_30 */
+						   <&gpio2 19 0>; /* GPIO3_19 */
+					status = "okay";
+
+					zigbee: mc1323 at 0 {
+						compatible = "fsl,mc1323";
+						spi-max-frequency = <8000000>;
+						reg = <0>;
+					};
+
+					flash: m25p32 at 1 {
+						#address-cells = <1>;
+						#size-cells = <1>;
+						compatible = "st,m25p32", "st,m25p";
+						spi-max-frequency = <20000000>;
+						reg = <1>;
+
+						partition at 0 {
+							label = "U-Boot";
+							reg = <0x0 0x40000>;
+							read-only;
+						};
+
+						partition at 40000 {
+							label = "Kernel";
+							reg = <0x40000 0x3c0000>;
+						};
+					};
+				};
+
+				esdhc at 50020000 { /* ESDHC3 */
+					fsl,card-wired;
+					status = "okay";
+				};
+			};
+
+			wdog at 53f98000 { /* WDOG1 */
+				status = "okay";
+			};
+
+			iomuxc at 53fa8000 {
+				compatible = "fsl,imx53-iomuxc-smd";
+				reg = <0x53fa8000 0x4000>;
+			};
+
+			uart0: uart at 53fbc000 { /* UART1 */
+				status = "okay";
+			};
+
+			uart1: uart at 53fc0000 { /* UART2 */
+				status = "okay";
+			};
+		};
+
+		aips at 60000000 {	/* AIPS2 */
+			sdma at 63fb0000 {
+				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
+			};
+
+			i2c at 63fc4000 { /* I2C2 */
+				status = "okay";
+
+				codec: sgtl5000 at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+				};
+
+				magnetometer: mag3110 at 0e {
+					compatible = "fsl,mag3110";
+					reg = <0x0e>;
+				};
+
+				touchkey: mpr121 at 5a {
+					compatible = "fsl,mpr121";
+					reg = <0x5a>;
+				};
+			};
+
+			i2c at 63fc8000 { /* I2C1 */
+				status = "okay";
+
+				accelerometer: mma8450 at 1c {
+					compatible = "fsl,mma8450";
+					reg = <0x1c>;
+				};
+
+				camera: ov5642 at 3c {
+					compatible = "ovti,ov5642";
+					reg = <0x3c>;
+				};
+
+				pmic: dialog at 48 {
+					compatible = "dialog,da9053", "dialog,da9052";
+					reg = <0x48>;
+				};
+			};
+
+			fec at 63fec000 {
+				phy-mode = "rmii";
+				phy-reset-gpios = <&gpio6 6 0>; /* GPIO7_6 */
+				status = "okay";
+			};
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
index 0000000..099cd84
--- /dev/null
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -0,0 +1,301 @@
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
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ckil {
+			compatible = "fsl,imx-ckil", "fixed-clock";
+			clock-frequency = <32768>;
+		};
+
+		ckih1 {
+			compatible = "fsl,imx-ckih1", "fixed-clock";
+			clock-frequency = <22579200>;
+		};
+
+		ckih2 {
+			compatible = "fsl,imx-ckih2", "fixed-clock";
+			clock-frequency = <0>;
+		};
+
+		osc {
+			compatible = "fsl,imx-osc", "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+	};
+
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "simple-bus";
+		interrupt-parent = <&tzic>;
+		ranges;
+
+		aips at 50000000 { /* AIPS1 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x50000000 0x10000000>;
+			ranges;
+
+			spba at 50000000 {
+				compatible = "fsl,spba-bus", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x50000000 0x40000>;
+				ranges;
+
+				esdhc at 50004000 { /* ESDHC1 */
+					compatible = "fsl,imx53-esdhc";
+					reg = <0x50004000 0x4000>;
+					interrupts = <1>;
+					status = "disabled";
+				};
+
+				esdhc at 50008000 { /* ESDHC2 */
+					compatible = "fsl,imx53-esdhc";
+					reg = <0x50008000 0x4000>;
+					interrupts = <2>;
+					status = "disabled";
+				};
+
+				uart2: uart at 5000c000 { /* UART3 */
+					compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+					reg = <0x5000c000 0x4000>;
+					interrupts = <33>;
+					status = "disabled";
+				};
+
+				ecspi at 50010000 { /* ECSPI1 */
+					#address-cells = <1>;
+					#size-cells = <0>;
+					compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
+					reg = <0x50010000 0x4000>;
+					interrupts = <36>;
+					status = "disabled";
+				};
+
+				esdhc at 50020000 { /* ESDHC3 */
+					compatible = "fsl,imx53-esdhc";
+					reg = <0x50020000 0x4000>;
+					interrupts = <3>;
+					status = "disabled";
+				};
+
+				esdhc at 50024000 { /* ESDHC4 */
+					compatible = "fsl,imx53-esdhc";
+					reg = <0x50024000 0x4000>;
+					interrupts = <4>;
+					status = "disabled";
+				};
+			};
+
+			gpio0: gpio at 53f84000 { /* GPIO1 */
+				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				reg = <0x53f84000 0x4000>;
+				interrupts = <50 51>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio1: gpio at 53f88000 { /* GPIO2 */
+				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				reg = <0x53f88000 0x4000>;
+				interrupts = <52 53>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio2: gpio at 53f8c000 { /* GPIO3 */
+				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				reg = <0x53f8c000 0x4000>;
+				interrupts = <54 55>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio3: gpio at 53f90000 { /* GPIO4 */
+				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				reg = <0x53f90000 0x4000>;
+				interrupts = <56 57>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			wdog at 53f98000 { /* WDOG1 */
+				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
+				reg = <0x53f98000 0x4000>;
+				interrupts = <58>;
+				status = "disabled";
+			};
+
+			wdog at 53f9c000 { /* WDOG2 */
+				compatible = "fsl,imx53-wdt", "fsl,imx21-wdt";
+				reg = <0x53f9c000 0x4000>;
+				interrupts = <59>;
+				status = "disabled";
+			};
+
+			uart0: uart at 53fbc000 { /* UART1 */
+				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+				reg = <0x53fbc000 0x4000>;
+				interrupts = <31>;
+				status = "disabled";
+			};
+
+			uart1: uart at 53fc0000 { /* UART2 */
+				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+				reg = <0x53fc0000 0x4000>;
+				interrupts = <32>;
+				status = "disabled";
+			};
+
+			gpio4: gpio at 53fdc000 { /* GPIO5 */
+				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				reg = <0x53fdc000 0x4000>;
+				interrupts = <103 104>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio5: gpio at 53fe0000 { /* GPIO6 */
+				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				reg = <0x53fe0000 0x4000>;
+				interrupts = <105 106>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			gpio6: gpio at 53fe4000 { /* GPIO7 */
+				compatible = "fsl,imx53-gpio", "fsl,imx31-gpio";
+				reg = <0x53fe4000 0x4000>;
+				interrupts = <107 108>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+
+			i2c at 53fec000 { /* I2C3 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
+				reg = <0x53fec000 0x4000>;
+				interrupts = <64>;
+				status = "disabled";
+			};
+
+			uart3: uart at 53ff0000 { /* UART4 */
+				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+				reg = <0x53ff0000 0x4000>;
+				interrupts = <13>;
+				status = "disabled";
+			};
+		};
+
+		aips at 60000000 {	/* AIPS2 */
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x60000000 0x10000000>;
+			ranges;
+
+			uart4: uart at 63f90000 { /* UART5 */
+				compatible = "fsl,imx53-uart", "fsl,imx21-uart";
+				reg = <0x63f90000 0x4000>;
+				interrupts = <86>;
+				status = "disabled";
+			};
+
+			ecspi at 63fac000 { /* ECSPI2 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx53-ecspi", "fsl,imx51-ecspi";
+				reg = <0x63fac000 0x4000>;
+				interrupts = <37>;
+				status = "disabled";
+			};
+
+			sdma at 63fb0000 {
+				compatible = "fsl,imx53-sdma", "fsl,imx35-sdma";
+				reg = <0x63fb0000 0x4000>;
+				interrupts = <6>;
+			};
+
+			cspi at 63fc0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx53-cspi", "fsl,imx35-cspi";
+				reg = <0x63fc0000 0x4000>;
+				interrupts = <38>;
+				status = "disabled";
+			};
+
+			i2c at 63fc4000 { /* I2C2 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
+				reg = <0x63fc4000 0x4000>;
+				interrupts = <63>;
+				status = "disabled";
+			};
+
+			i2c at 63fc8000 { /* I2C1 */
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx53-i2c", "fsl,imx1-i2c";
+				reg = <0x63fc8000 0x4000>;
+				interrupts = <62>;
+				status = "disabled";
+			};
+
+			fec at 63fec000 {
+				compatible = "fsl,imx53-fec", "fsl,imx25-fec";
+				reg = <0x63fec000 0x4000>;
+				interrupts = <87>;
+				status = "disabled";
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
index 3d4c313..08c32a4 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -171,6 +171,18 @@ config MACH_MX51_EFIKASB
 
 comment "i.MX53 machines:"
 
+config MACH_IMX53_DT
+	bool "Support i.MX53 platforms from device tree"
+	select SOC_IMX53
+	select USE_OF
+	select MACH_MX53_ARD
+	select MACH_MX53_EVK
+	select MACH_MX53_LOCO
+	select MACH_MX53_SMD
+	help
+	  Include support for Freescale i.MX53 based platforms
+	  using the device tree for discovery
+
 config MACH_MX53_EVK
 	bool "Support MX53 EVK platforms"
 	select SOC_IMX53
diff --git a/arch/arm/mach-mx5/Makefile b/arch/arm/mach-mx5/Makefile
index 9565304..cf9d461 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -21,3 +21,5 @@ obj-$(CONFIG_MX51_EFIKA_COMMON) += mx51_efika.o
 obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
 obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
 obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
+
+obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index cb4d753..39a6bc3 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -171,9 +171,6 @@ static struct imxi2c_platform_data mx53_ard_i2c3_data = {
 
 static void __init mx53_ard_io_init(void)
 {
-	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
-				ARRAY_SIZE(mx53_ard_pads));
-
 	gpio_request(ARD_ETHERNET_INT_B, "eth-int-b");
 	gpio_direction_input(ARD_ETHERNET_INT_B);
 
@@ -216,6 +213,13 @@ static int weim_cs_config(void)
 	return 0;
 }
 
+void __init imx53_ard_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_ard_pads,
+					 ARRAY_SIZE(mx53_ard_pads));
+	weim_cs_config();
+}
+
 static struct platform_device *devices[] __initdata = {
 	&ard_smsc_lan9220_device,
 };
@@ -225,8 +229,8 @@ static void __init mx53_ard_board_init(void)
 	imx53_soc_init();
 	imx53_add_imx_uart(0, NULL);
 
+	imx53_ard_common_init();
 	mx53_ard_io_init();
-	weim_cs_config();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 6a3e616..6bea31a 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -131,12 +131,17 @@ static const struct spi_imx_master mx53_evk_spi_data __initconst = {
 	.num_chipselect = ARRAY_SIZE(mx53_evk_spi_cs),
 };
 
+void __init imx53_evk_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
+					 ARRAY_SIZE(mx53_evk_pads));
+}
+
 static void __init mx53_evk_board_init(void)
 {
 	imx53_soc_init();
+	imx53_evk_common_init();
 
-	mxc_iomux_v3_setup_multiple_pads(mx53_evk_pads,
-					ARRAY_SIZE(mx53_evk_pads));
 	mx53_evk_init_uart();
 	mx53_evk_fec_reset();
 	imx53_add_fec(&mx53_evk_fec_pdata);
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 7149416..7cbb0d5 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -269,13 +269,18 @@ static struct i2c_board_info mx53loco_i2c_devices[] = {
 	},
 };
 
+void __init imx53_qsb_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
+					 ARRAY_SIZE(mx53_loco_pads));
+}
+
 static void __init mx53_loco_board_init(void)
 {
 	int ret;
 	imx53_soc_init();
+	imx53_qsb_common_init();
 
-	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
-					ARRAY_SIZE(mx53_loco_pads));
 	imx53_add_imx_uart(0, NULL);
 	mx53_loco_fec_reset();
 	imx53_add_fec(&mx53_loco_fec_data);
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index e64fd2c..9a895a2 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -111,12 +111,17 @@ static const struct imxi2c_platform_data mx53_smd_i2c_data __initconst = {
 	.bitrate = 100000,
 };
 
+void __init imx53_smd_common_init(void)
+{
+	mxc_iomux_v3_setup_multiple_pads(mx53_smd_pads,
+					 ARRAY_SIZE(mx53_smd_pads));
+}
+
 static void __init mx53_smd_board_init(void)
 {
 	imx53_soc_init();
+	imx53_smd_common_init();
 
-	mxc_iomux_v3_setup_multiple_pads(mx53_smd_pads,
-					ARRAY_SIZE(mx53_smd_pads));
 	mx53_smd_init_uart();
 	mx53_smd_fec_reset();
 	imx53_add_fec(&mx53_smd_fec_data);
diff --git a/arch/arm/mach-mx5/clock-mx51-mx53.c b/arch/arm/mach-mx5/clock-mx51-mx53.c
index 2b9bd1f..34a6427 100644
--- a/arch/arm/mach-mx5/clock-mx51-mx53.c
+++ b/arch/arm/mach-mx5/clock-mx51-mx53.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/clkdev.h>
+#include <linux/of.h>
 
 #include <asm/div64.h>
 
@@ -1613,3 +1614,33 @@ int __init mx53_clocks_init(unsigned long ckil, unsigned long osc,
 		MX53_INT_GPT);
 	return 0;
 }
+
+static void __init clk_get_freq_dt(unsigned long *ckil, unsigned long *osc,
+				   unsigned long *ckih1, unsigned long *ckih2)
+{
+	struct device_node *np;
+
+	/* retrieve the freqency of fixed clocks from device tree */
+	for_each_compatible_node(np, NULL, "fixed-clock") {
+		u32 rate;
+		if (of_property_read_u32(np, "clock-frequency", &rate))
+			continue;
+
+		if (of_device_is_compatible(np, "fsl,imx-ckil"))
+			*ckil = rate;
+		else if (of_device_is_compatible(np, "fsl,imx-osc"))
+			*osc = rate;
+		else if (of_device_is_compatible(np, "fsl,imx-ckih1"))
+			*ckih1 = rate;
+		else if (of_device_is_compatible(np, "fsl,imx-ckih2"))
+			*ckih2 = rate;
+	}
+}
+
+int __init mx53_clocks_init_dt(void)
+{
+	unsigned long ckil, osc, ckih1, ckih2;
+
+	clk_get_freq_dt(&ckil, &osc, &ckih1, &ckih2);
+	return mx53_clocks_init(ckil, osc, ckih1, ckih2);
+}
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
new file mode 100644
index 0000000..ccaa0b8
--- /dev/null
+++ b/arch/arm/mach-mx5/imx53-dt.c
@@ -0,0 +1,126 @@
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
+#include <linux/irqdomain.h>
+#include <linux/of_irq.h>
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
+static void __init imx53_tzic_add_irq_domain(struct device_node *np,
+				struct device_node *interrupt_parent)
+{
+	irq_domain_add_simple(np, 0);
+}
+
+static void __init imx53_gpio_add_irq_domain(struct device_node *np,
+				struct device_node *interrupt_parent)
+{
+	static int gpio_irq_base = MXC_GPIO_IRQ_START + ARCH_NR_GPIOS -
+				   32 * 7; /* imx53 gets 7 gpio ports */
+
+	irq_domain_add_simple(np, gpio_irq_base);
+	gpio_irq_base += 32;
+}
+
+static const struct of_device_id imx53_irq_match[] __initconst = {
+	{ .compatible = "fsl,imx53-tzic", .data = imx53_tzic_add_irq_domain, },
+	{ .compatible = "fsl,imx53-gpio", .data = imx53_gpio_add_irq_domain, },
+	{ /* sentinel */ }
+};
+
+static const struct of_device_id imx53_iomuxc_of_match[] __initconst = {
+	{ .compatible = "fsl,imx53-iomuxc-ard", .data = imx53_ard_common_init, },
+	{ .compatible = "fsl,imx53-iomuxc-evk", .data = imx53_evk_common_init, },
+	{ .compatible = "fsl,imx53-iomuxc-qsb", .data = imx53_qsb_common_init, },
+	{ .compatible = "fsl,imx53-iomuxc-smd", .data = imx53_smd_common_init, },
+	{ /* sentinel */ }
+};
+
+static void __init imx53_dt_init(void)
+{
+	struct device_node *node;
+	const struct of_device_id *of_id;
+	void (*func)(void);
+
+	of_irq_init(imx53_irq_match);
+
+	node = of_find_matching_node(NULL, imx53_iomuxc_of_match);
+	if (node) {
+		of_id = of_match_node(imx53_iomuxc_of_match, node);
+		func = of_id->data;
+		func();
+		of_node_put(node);
+	}
+
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     imx53_auxdata_lookup, NULL);
+}
+
+static void __init imx53_timer_init(void)
+{
+	mx53_clocks_init_dt();
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
+	.handle_irq	= imx53_handle_irq,
+	.timer		= &imx53_timer,
+	.init_machine	= imx53_dt_init,
+	.dt_compat	= imx53_dt_board_compat,
+MACHINE_END
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index ace4bb5..bd14035 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -64,6 +64,7 @@ extern int mx51_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
 extern int mx53_clocks_init(unsigned long ckil, unsigned long osc,
 			unsigned long ckih1, unsigned long ckih2);
+extern int mx53_clocks_init_dt(void);
 extern struct platform_device *mxc_register_gpio(char *name, int id,
 	resource_size_t iobase, resource_size_t iosize, int irq, int irq_high);
 extern void mxc_set_cpu_type(unsigned int type);
@@ -72,6 +73,11 @@ extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
 
+extern void imx53_ard_common_init(void);
+extern void imx53_evk_common_init(void);
+extern void imx53_qsb_common_init(void);
+extern void imx53_smd_common_init(void);
+
 enum mxc_cpu_pwr_mode {
 	WAIT_CLOCKED,		/* wfi only */
 	WAIT_UNCLOCKED,		/* WAIT */
-- 
1.7.4.1
