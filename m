From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Aug 2011 03:17:31 +0800
Subject: [PATCH v3 1/2] arm/mx5: add device tree support for imx53 boards
In-Reply-To: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
References: <1312226252-8566-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1312226252-8566-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@freescale.com>

It adds device tree support for imx53 boards.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/arm/fsl/boards.txt         |   15 ++
 arch/arm/boot/dts/imx53-ard.dts                    |  158 +++++++++++++
 arch/arm/boot/dts/imx53-evk.dts                    |  144 ++++++++++++
 arch/arm/boot/dts/imx53-qsb.dts                    |  148 ++++++++++++
 arch/arm/boot/dts/imx53-smd.dts                    |  169 ++++++++++++++
 arch/arm/boot/dts/imx53.dtsi                       |  244 ++++++++++++++++++++
 arch/arm/mach-mx5/Kconfig                          |   12 +
 arch/arm/mach-mx5/Makefile                         |    2 +
 arch/arm/mach-mx5/board-mx53_ard.c                 |    9 +-
 arch/arm/mach-mx5/board-mx53_evk.c                 |    5 +
 arch/arm/mach-mx5/board-mx53_loco.c                |    5 +
 arch/arm/mach-mx5/board-mx53_smd.c                 |    5 +
 arch/arm/mach-mx5/imx53-dt.c                       |  143 ++++++++++++
 arch/arm/plat-mxc/include/mach/common.h            |    2 +
 arch/arm/plat-mxc/include/mach/iomux-mx53.h        |    5 +
 arch/arm/plat-mxc/include/mach/iomux-v3.h          |    5 +
 16 files changed, 1069 insertions(+), 2 deletions(-)
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
index 0000000..fd0cf2c
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-ard.dts
@@ -0,0 +1,158 @@
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
+			compatible = "fsl,imx53-iomuxc-ard";
+			reg = <0x53fa8000 0x4000>;
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
index 0000000..5b51588
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -0,0 +1,144 @@
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
+			compatible = "fsl,imx53-iomuxc-evk";
+			reg = <0x53fa8000 0x4000>;
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
index 0000000..035de71
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -0,0 +1,148 @@
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
+			compatible = "fsl,imx53-iomuxc-qsb";
+			reg = <0x53fa8000 0x4000>;
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
index 0000000..b2af475
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
+			compatible = "fsl,imx53-iomuxc-smd";
+			reg = <0x53fa8000 0x4000>;
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
index 0000000..41383b5
--- /dev/null
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -0,0 +1,244 @@
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
index b4e7c58..0ac676c 100644
--- a/arch/arm/mach-mx5/Kconfig
+++ b/arch/arm/mach-mx5/Kconfig
@@ -172,6 +172,18 @@ endif # ARCH_MX51
 if ARCH_MX53_SUPPORTED
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
index 383e7cd..3dbe5e2 100644
--- a/arch/arm/mach-mx5/Makefile
+++ b/arch/arm/mach-mx5/Makefile
@@ -22,3 +22,5 @@ obj-$(CONFIG_MX51_EFIKA_COMMON) += mx51_efika.o
 obj-$(CONFIG_MACH_MX51_EFIKAMX) += board-mx51_efikamx.o
 obj-$(CONFIG_MACH_MX51_EFIKASB) += board-mx51_efikasb.o
 obj-$(CONFIG_MACH_MX50_RDP) += board-mx50_rdp.o
+
+obj-$(CONFIG_MACH_IMX53_DT) += imx53-dt.o
diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index 76a67c4..71e61f9 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -104,6 +104,11 @@ static iomux_v3_cfg_t mx53_ard_pads[] = {
 	MX53_PAD_GPIO_10__GPIO4_0,		/* vol down */
 };
 
+struct iomux_v3_pad_data imx53_ard_pad_data = {
+	.pads = mx53_ard_pads,
+	.num = ARRAY_SIZE(mx53_ard_pads),
+};
+
 #define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
 {							\
 	.gpio		= gpio_num,				\
@@ -182,7 +187,7 @@ static void __init mx53_ard_io_init(void)
 }
 
 /* Config CS1 settings for ethernet controller */
-static int weim_cs_config(void)
+int imx53_ard_weim_cs_config(void)
 {
 	u32 reg;
 	void __iomem *weim_base, *iomuxc_base;
@@ -226,7 +231,7 @@ static void __init mx53_ard_board_init(void)
 	imx53_add_imx_uart(0, NULL);
 
 	mx53_ard_io_init();
-	weim_cs_config();
+	imx53_ard_weim_cs_config();
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
 	imx53_add_sdhci_esdhc_imx(0, &mx53_ard_sd1_data);
diff --git a/arch/arm/mach-mx5/board-mx53_evk.c b/arch/arm/mach-mx5/board-mx53_evk.c
index 1b417b0..09c293f 100644
--- a/arch/arm/mach-mx5/board-mx53_evk.c
+++ b/arch/arm/mach-mx5/board-mx53_evk.c
@@ -63,6 +63,11 @@ static iomux_v3_cfg_t mx53_evk_pads[] = {
 	MX53_PAD_PATA_DA_1__GPIO7_7,
 };
 
+struct iomux_v3_pad_data imx53_evk_pad_data = {
+	.pads = mx53_evk_pads,
+	.num = ARRAY_SIZE(mx53_evk_pads),
+};
+
 static const struct imxuart_platform_data mx53_evk_uart_pdata __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 4e1d51d..bf0196b 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -187,6 +187,11 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
 	MX53_PAD_GPIO_8__GPIO1_8,
 };
 
+struct iomux_v3_pad_data imx53_loco_pad_data = {
+	.pads = mx53_loco_pads,
+	.num = ARRAY_SIZE(mx53_loco_pads),
+};
+
 #define GPIO_BUTTON(gpio_num, ev_code, act_low, descr, wake)	\
 {								\
 	.gpio		= gpio_num,				\
diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
index bc02894..a3fa95d 100644
--- a/arch/arm/mach-mx5/board-mx53_smd.c
+++ b/arch/arm/mach-mx5/board-mx53_smd.c
@@ -77,6 +77,11 @@ static iomux_v3_cfg_t mx53_smd_pads[] = {
 	MX53_PAD_PATA_RESET_B__ESDHC3_CMD,
 };
 
+struct iomux_v3_pad_data imx53_smd_pad_data = {
+	.pads = mx53_smd_pads,
+	.num = ARRAY_SIZE(mx53_smd_pads),
+};
+
 static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
 	.flags = IMXUART_HAVE_RTSCTS,
 };
diff --git a/arch/arm/mach-mx5/imx53-dt.c b/arch/arm/mach-mx5/imx53-dt.c
new file mode 100644
index 0000000..eece3db
--- /dev/null
+++ b/arch/arm/mach-mx5/imx53-dt.c
@@ -0,0 +1,143 @@
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
+#include <linux/of_platform.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/time.h>
+#include <mach/common.h>
+#include <mach/mx53.h>
+#include <mach/iomux-mx53.h>
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
+	{ .compatible = "fsl,imx53-iomuxc-ard", .data = &imx53_ard_pad_data, },
+	{ .compatible = "fsl,imx53-iomuxc-evk", .data = &imx53_evk_pad_data, },
+	{ .compatible = "fsl,imx53-iomuxc-qsb", .data = &imx53_loco_pad_data, },
+	{ .compatible = "fsl,imx53-iomuxc-smd", .data = &imx53_smd_pad_data, },
+	{ /* sentinel */ }
+};
+
+static void __init imx53_dt_init(void)
+{
+	struct device_node *node;
+	const struct of_device_id *of_id;
+	struct iomux_v3_pad_data *pad_data;
+	int gpio_irq = MXC_INTERNAL_IRQS + ARCH_NR_GPIOS;
+
+	node = of_find_matching_node(NULL, imx53_iomuxc_of_match);
+	if (node) {
+		of_id = of_match_node(imx53_iomuxc_of_match, node);
+		pad_data = (struct iomux_v3_pad_data *) of_id->data;
+		mxc_iomux_v3_setup_multiple_pads(pad_data->pads, pad_data->num);
+		of_node_put(node);
+	}
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
+	imx53_ard_weim_cs_config();
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
diff --git a/arch/arm/plat-mxc/include/mach/common.h b/arch/arm/plat-mxc/include/mach/common.h
index 4e3d978..32c24a4 100644
--- a/arch/arm/plat-mxc/include/mach/common.h
+++ b/arch/arm/plat-mxc/include/mach/common.h
@@ -72,4 +72,6 @@ extern void mxc_arch_reset_init(void __iomem *);
 extern void mx51_efikamx_reset(void);
 extern int mx53_revision(void);
 extern int mx53_display_revision(void);
+extern int imx53_ard_weim_cs_config(void);
+
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index 9440b9e..adcf2c0 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -21,6 +21,11 @@
 
 #include <mach/iomux-v3.h>
 
+extern struct iomux_v3_pad_data imx53_ard_pad_data;
+extern struct iomux_v3_pad_data imx53_evk_pad_data;
+extern struct iomux_v3_pad_data imx53_loco_pad_data;
+extern struct iomux_v3_pad_data imx53_smd_pad_data;
+
 /* These 2 defines are for pins that may not have a mux register, but could
  * have a pad setting register, and vice-versa. */
 #define NON_PAD_I	0x00
diff --git a/arch/arm/plat-mxc/include/mach/iomux-v3.h b/arch/arm/plat-mxc/include/mach/iomux-v3.h
index ebbce33..5689965 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-v3.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-v3.h
@@ -55,6 +55,11 @@
 
 typedef u64 iomux_v3_cfg_t;
 
+struct iomux_v3_pad_data {
+	iomux_v3_cfg_t *pads;
+	int num;
+};
+
 #define MUX_CTRL_OFS_SHIFT	0
 #define MUX_CTRL_OFS_MASK	((iomux_v3_cfg_t)0xfff << MUX_CTRL_OFS_SHIFT)
 #define MUX_PAD_CTRL_OFS_SHIFT	12
-- 
1.7.4.1
