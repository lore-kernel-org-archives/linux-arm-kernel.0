From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 06 Mar 2013 18:06:38 +0530
Subject: [PATCH 2/2] ARM: dts: add pin state information in client nodes for
 Exynos5 platforms
In-Reply-To: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
References: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1362573398-15126-3-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add default pin state information for all client nodes that require
pin configuration support using pinctrl interface.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/boot/dts/cros5250-common.dtsi    |   51 +--
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi |  783 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   33 +-
 arch/arm/boot/dts/exynos5250-snow.dts     |   22 +-
 arch/arm/boot/dts/exynos5250.dtsi         |  310 +++---------
 5 files changed, 889 insertions(+), 310 deletions(-)
 create mode 100755 arch/arm/boot/dts/exynos5250-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index 46c0980..e782706 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -19,31 +19,30 @@
 	chosen {
 	};
 
+	pinctrl at 11400000 {
+		/*
+		 * Disabled pullups since external part has its own pullups and
+		 * double-pulling gets us out of spec in some cases.
+		 */
+		i2c2_bus: i2c2-bus {
+			samsung,pin-pud = <0>;
+		};
+	};
+
 	i2c at 12C60000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
-		gpios = <&gpb3 0 2 3 0>,
-			<&gpb3 1 2 3 0>;
 	};
 
 	i2c at 12C70000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <378000>;
-		gpios = <&gpb3 2 2 3 0>,
-			<&gpb3 3 2 3 0>;
 	};
 
 	i2c at 12C80000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
 
-		/*
-		 * Disabled pullups since external part has its own pullups and
-		 * double-pulling gets us out of spec in some cases.
-		 */
-		gpios = <&gpa0 6 3 0 0>,
-			<&gpa0 7 3 0 0>;
-
 		hdmiddc at 50 {
 			compatible = "samsung,exynos5-hdmiddc";
 			reg = <0x50>;
@@ -53,8 +52,6 @@
 	i2c at 12C90000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
-		gpios = <&gpa1 2 3 3 0>,
-			<&gpa1 3 3 3 0>;
 	};
 
 	i2c at 12CA0000 {
@@ -64,8 +61,6 @@
 	i2c at 12CB0000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
-		gpios = <&gpa2 2 3 3 0>,
-			<&gpa2 3 3 3 0>;
 	};
 
 	i2c at 12CC0000 {
@@ -75,8 +70,6 @@
 	i2c at 12CD0000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
-		gpios = <&gpb2 2 3 3 0>,
-			<&gpb2 3 3 3 0>;
 	};
 
 	i2c at 12CE0000 {
@@ -98,15 +91,12 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
 
 		slot at 0 {
 			reg = <0>;
 			bus-width = <8>;
-			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
-				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
-				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
-				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
-				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
 		};
 	};
 
@@ -122,15 +112,13 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 
 		slot at 0 {
 			reg = <0>;
 			bus-width = <4>;
-			samsung,cd-pinmux-gpio = <&gpc3 2 2 3 3>;
-			wp-gpios = <&gpc2 1 0 0 3>;
-			gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
-				<&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
-				<&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>;
+			wp-gpios = <&gpc2 1 0>;
 		};
 	};
 
@@ -143,11 +131,11 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
+		/* See board-specific dts files for pin setup */
 
 		slot at 0 {
 			reg = <0>;
 			bus-width = <4>;
-			/* See board-specific dts files for GPIOs */
 		};
 	};
 
@@ -156,9 +144,6 @@
 	};
 
 	spi_1: spi at 12d30000 {
-		gpios = <&gpa2 4 2 3 0>,
-			<&gpa2 6 2 3 0>,
-			<&gpa2 7 2 3 0>;
 		samsung,spi-src-clk = <0>;
 		num-cs = <1>;
 	};
@@ -168,7 +153,7 @@
 	};
 
 	hdmi {
-		hpd-gpio = <&gpx3 7 0xf 1 3>;
+		hpd-gpio = <&gpx3 7 0>;
 	};
 
 	gpio-keys {
@@ -176,7 +161,7 @@
 
 		power {
 			label = "Power";
-			gpios = <&gpx1 3 0 0x10000 0>;
+			gpios = <&gpx1 3 1>;
 			linux,code = <116>; /* KEY_POWER */
 			gpio-key,wakeup;
 		};
diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
new file mode 100755
index 0000000..d1650fb
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -0,0 +1,783 @@
+/*
+ * Samsung's Exynos5250 SoC pin-mux and pin-config device tree source
+ *
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * Samsung's Exynos5250 SoC pin-mux and pin-config optiosn are listed as device
+ * tree nodes are listed in this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+/ {
+	pinctrl at 11400000 {
+		gpa0: gpa0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpa1: gpa1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpa2: gpa2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb0: gpb0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb1: gpb1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb2: gpb2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb3: gpb3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc0: gpc0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc1: gpc1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc2: gpc2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc3: gpc3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpd0: gpd0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpd1: gpd1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpy0: gpy0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy1: gpy1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy2: gpy2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy3: gpy3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy4: gpy4 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy5: gpy5 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy6: gpy6 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpc4: gpc4 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpx0: gpx0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			interrupt-parent = <&combiner>;
+			#interrupt-cells = <2>;
+			interrupts = <23 0>, <24 0>, <25 0>, <25 1>,
+				     <26 0>, <26 1>, <27 0>, <27 1>;
+		};
+
+		gpx1: gpx1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			interrupt-parent = <&combiner>;
+			#interrupt-cells = <2>;
+			interrupts = <28 0>, <28 1>, <29 0>, <29 1>,
+				     <30 0>, <30 1>, <31 0>, <31 1>;
+		};
+
+		gpx2: gpx2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpx3: gpx3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		uart0_data: uart0-data {
+			samsung,pins = "gpa0-0", "gpa0-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		uart0_fctl: uart0-fctl {
+			samsung,pins = "gpa0-2", "gpa0-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c2_bus: i2c2-bus {
+			samsung,pins = "gpa0-6", "gpa0-7";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c2_hs_bus: i2c2-hs-bus {
+			samsung,pins = "gpa0-6", "gpa0-7";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		uart2_data: uart2-data {
+			samsung,pins = "gpa1-0", "gpa1-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		uart2_fctl: uart2-fctl {
+			samsung,pins = "gpa1-2", "gpa1-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c3_bus: i2c3-bus {
+			samsung,pins = "gpa1-2", "gpa1-3";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c3_hs_bus: i2c3-hs-bus {
+			samsung,pins = "gpa1-2", "gpa1-3";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		uart3_data: uart3-data {
+			samsung,pins = "gpa1-4", "gpa1-4";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		spi0_bus: spi0-bus {
+			samsung,pins = "gpa2-0", "gpa2-2", "gpa2-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c4_bus: i2c4-bus {
+			samsung,pins = "gpa2-0", "gpa2-1";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c5_bus: i2c5-bus {
+			samsung,pins = "gpa2-2", "gpa2-3";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		spi1_bus: spi1-bus {
+			samsung,pins = "gpa2-4", "gpa2-6", "gpa2-7";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2s1_bus: i2s1-bus {
+			samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
+					"gpb0-4";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		pcm1_bus: pcm1-bus {
+			samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
+					"gpb0-4";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		ac97_bus: ac97-bus {
+			samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
+					"gpb0-4";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2s2_bus: i2s2-bus {
+			samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
+					"gpb1-4";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		pcm2_bus: pcm2-bus {
+			samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
+					"gpb1-4";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		spdif_bus: spdif-bus {
+			samsung,pins = "gpb1-0", "gpb1-1";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		spi2_bus: spi2-bus {
+			samsung,pins = "gpb1-1", "gpb1-3", "gpb1-4";
+			samsung,pin-function = <5>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c6_bus: i2c6-bus {
+			samsung,pins = "gpb1-3", "gpb1-4";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c7_bus: i2c7-bus {
+			samsung,pins = "gpb2-2", "gpb2-3";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c0_bus: i2c0-bus {
+			samsung,pins = "gpb3-0", "gpb3-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c1_bus: i2c1-bus {
+			samsung,pins = "gpb3-2", "gpb3-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		i2c0_hs_bus: i2c0-hs-bus {
+			samsung,pins = "gpb3-0", "gpb3-1";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		i2c1_hs_bus: i2c1-hs-bus {
+			samsung,pins = "gpb3-2", "gpb3-3";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		sd0_clk: sd0-clk {
+			samsung,pins = "gpc0-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_cmd: sd0-cmd {
+			samsung,pins = "gpc0-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_cd: sd0-cd {
+			samsung,pins = "gpc0-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_bus1: sd0-bus-width1 {
+			samsung,pins = "gpc0-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_bus4: sd0-bus-width4 {
+			samsung,pins = "gpc0-3", "gpc0-4", "gpc0-5", "gpc0-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd0_bus8: sd0-bus-width8 {
+			samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_clk: sd1-clk {
+			samsung,pins = "gpc2-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_cmd: sd1-cmd {
+			samsung,pins = "gpc2-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_cd: sd1-cd {
+			samsung,pins = "gpc2-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_bus1: sd1-bus-width1 {
+			samsung,pins = "gpc2-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd1_bus4: sd1-bus-width4 {
+			samsung,pins = "gpc2-3", "gpc2-4", "gpc2-5", "gpc2-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_clk: sd2-clk {
+			samsung,pins = "gpc3-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_cmd: sd2-cmd {
+			samsung,pins = "gpc3-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_cd: sd2-cd {
+			samsung,pins = "gpc3-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_bus1: sd2-bus-width1 {
+			samsung,pins = "gpc3-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_bus4: sd2-bus-width4 {
+			samsung,pins = "gpc3-3", "gpc3-4", "gpc3-5", "gpc3-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd2_bus8: sd2-bus-width8 {
+			samsung,pins = "gpc4-3", "gpc4-4", "gpc4-5", "gpc4-6";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_clk: sd3-clk {
+			samsung,pins = "gpc4-0";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_cmd: sd3-cmd {
+			samsung,pins = "gpc4-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_cd: sd3-cd {
+			samsung,pins = "gpc4-2";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_bus1: sd3-bus-width1 {
+			samsung,pins = "gpc4-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		sd3_bus4: sd3-bus-width4 {
+			samsung,pins = "gpc4-3", "gpc4-4", "gpc4-5", "gpc4-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <3>;
+		};
+
+		uart1_data: uart1-data {
+			samsung,pins = "gpd0-0", "gpd0-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		uart1_fctl: uart1-fctl {
+			samsung,pins = "gpd0-2", "gpd0-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+	};
+
+	pinctrl at 13400000 {
+		gpe0: gpe0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpe1: gpe1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpf0: gpf0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpf1: gpf1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpg0: gpg0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpg1: gpg1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpg2: gpg2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gph0: gph0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gph1: gph1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		cam_gpio_a: cam-gpio-a {
+			samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
+				       "gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
+				       "gpe1-0", "gpe1-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+
+		cam_gpio_b: cam-gpio-b {
+			samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3",
+				       "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
+			samsung,pin-function = <3>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		cam_i2c2_bus: cam-i2c2-bus {
+			samsung,pins = "gpe0-6", "gpe1-0";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		cam_spi1_bus: cam-spi1-bus {
+			samsung,pins = "gpe0-4", "gpe0-5", "gpf0-2", "gpf0-3";
+			samsung,pin-function = <4>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		cam_i2c1_bus: cam-i2c1-bus {
+			samsung,pins = "gpf0-2", "gpf0-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		cam_i2c0_bus: cam-i2c0-bus {
+			samsung,pins = "gpf0-0", "gpf0-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <3>;
+			samaung,pin-drv = <0>;
+		};
+
+		cam_spi0_bus: cam-spi0-bus {
+			samsung,pins = "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		cam_bayrgb_bus: cam-bayrgb-bus {
+			samsung,pins = "gpg0-0", "gpg0-1", "gpg0-2", "gpg0-3",
+				       "gpg0-4", "gpg0-5", "gpg0-6", "gpg0-7",
+				       "gpg1-0", "gpg1-1", "gpg1-2", "gpg1-3",
+				       "gpg1-4", "gpg1-5", "gpg1-6", "gpg1-7",
+				       "gpg2-0", "gpg2-1";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		cam_port_a: cam-port-a {
+			samsung,pins = "gph0-0", "gph0-1", "gph0-2", "gph0-3",
+				       "gph1-0", "gph1-1", "gph1-2", "gph1-3",
+				       "gph1-4", "gph1-5", "gph1-6", "gph1-7";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+	};
+
+	pinctrl at 10d10000 {
+		gpv0: gpv0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpv1: gpv1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpv2: gpv2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpv3: gpv3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpv4: gpv4 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		c2c_rxd: c2c-rxd {
+			samsung,pins = "gpv0-0", "gpv0-1", "gpv0-2", "gpv0-3",
+				       "gpv0-4", "gpv0-5", "gpv0-6", "gpv0-7",
+				       "gpv1-0", "gpv1-1", "gpv1-2", "gpv1-3",
+				       "gpv1-4", "gpv1-5", "gpv1-6", "gpv1-7";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+
+		c2c_txd: c2c-txd {
+			samsung,pins = "gpv2-0", "gpv2-1", "gpv2-2", "gpv2-3",
+				       "gpv2-4", "gpv2-5", "gpv2-6", "gpv2-7",
+				       "gpv3-0", "gpv3-1", "gpv3-2", "gpv3-3",
+				       "gpv3-4", "gpv3-5", "gpv3-6", "gpv3-7";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samaung,pin-drv = <0>;
+		};
+	};
+
+	pinctrl at 03680000 {
+		gpz: gpz {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		i2s0_bus: i2s0-bus {
+			samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
+					"gpz-4", "gpz-5", "gpz-6";
+			samsung,pin-function = <2>;
+			samsung,pin-pud = <0>;
+			samsung,pin-drv = <0>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 1b8d410..ef35f3f 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -30,8 +30,6 @@
 	i2c at 12C60000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
-		gpios = <&gpb3 0 2 3 0>,
-			<&gpb3 1 2 3 0>;
 
 		eeprom at 50 {
 			compatible = "samsung,s524ad0xd1";
@@ -42,8 +40,6 @@
 	i2c at 12C70000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <20000>;
-		gpios = <&gpb3 2 2 3 0>,
-			<&gpb3 3 2 3 0>;
 
 		eeprom at 51 {
 			compatible = "samsung,s524ad0xd1";
@@ -74,8 +70,6 @@
 	i2c at 12C80000 {
 		samsung,i2c-sda-delay = <100>;
 		samsung,i2c-max-bus-freq = <66000>;
-		gpios = <&gpa0 6 3 3 0>,
-			<&gpa0 7 3 3 0>;
 
 		hdmiddc at 50 {
 			compatible = "samsung,exynos5-hdmiddc";
@@ -122,15 +116,12 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
 
 		slot at 0 {
 			reg = <0>;
 			bus-width = <8>;
-			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
-				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
-				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
-				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
-				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
 		};
 	};
 
@@ -146,17 +137,13 @@
 		samsung,dw-mshc-ciu-div = <3>;
 		samsung,dw-mshc-sdr-timing = <2 3>;
 		samsung,dw-mshc-ddr-timing = <1 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
 
 		slot at 0 {
 			reg = <0>;
 			bus-width = <4>;
-			samsung,cd-pinmux-gpio = <&gpc3 2 2 3 3>;
 			disable-wp;
-			gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
-				<&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
-				<&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>,
-				<&gpc4 3 3 3 3>, <&gpc4 3 3 3 3>,
-				<&gpc4 5 3 3 3>, <&gpc4 6 3 3 3>;
 		};
 	};
 
@@ -169,10 +156,6 @@
 	};
 
 	spi_1: spi at 12d30000 {
-		gpios = <&gpa2 4 2 3 0>,
-			<&gpa2 6 2 3 0>,
-			<&gpa2 7 2 3 0>;
-
 		w25q80bw at 0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -181,7 +164,7 @@
 			spi-max-frequency = <1000000>;
 
 			controller-data {
-				cs-gpio = <&gpa2 5 1 0 3>;
+				cs-gpio = <&gpa2 5 0>;
 				samsung,spi-feedback-delay = <0>;
 			};
 
@@ -203,7 +186,7 @@
 	};
 
 	hdmi {
-		hpd-gpio = <&gpx3 7 0xf 1 3>;
+		hpd-gpio = <&gpx3 7 0>;
 	};
 
 	codec at 11000000 {
@@ -212,9 +195,7 @@
 	};
 
 	i2s0: i2s at 03830000 {
-		gpios = <&gpz 0 2 0 0>, <&gpz 1 2 0 0>, <&gpz 2 2 0 0>,
-			<&gpz 3 2 0 0>, <&gpz 4 2 0 0>, <&gpz 5 2 0 0>,
-			<&gpz 6 2 0 0>;
+		status = "okay";
 	};
 
 	i2s1: i2s at 12D60000 {
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 17dd951..434e440 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -16,12 +16,27 @@
 	model = "Google Snow";
 	compatible = "google,snow", "samsung,exynos5250";
 
+	pinctrl at 11400000 {
+		sd3_clk: sd3-clk {
+			samsung,pin-drv = <0>;
+		};
+
+		sd3_cmd: sd3-cmd {
+			samsung,pin-pud = <3>;
+			samsung,pin-drv = <0>;
+		};
+
+		sd3_bus4: sd3-bus-width4 {
+			samsung,pin-drv = <0>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
 		lid-switch {
 			label = "Lid";
-			gpios = <&gpx3 5 0 0x10000 0>;
+			gpios = <&gpx3 5 1>;
 			linux,input-type = <5>; /* EV_SW */
 			linux,code = <0>; /* SW_LID */
 			debounce-interval = <1>;
@@ -35,9 +50,8 @@
 	 */
 	dwmmc3 at 12230000 {
 		slot at 0 {
-			gpios = <&gpc4 0 2 0 0>, <&gpc4 1 2 3 0>,
-				<&gpc4 3 2 3 0>, <&gpc4 4 2 3 0>,
-				<&gpc4 5 2 3 0>, <&gpc4 6 2 3 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index b1ac73e..0ea9c70 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -18,6 +18,7 @@
 */
 
 /include/ "skeleton.dtsi"
+/include/ "exynos5250-pinctrl.dtsi"
 
 / {
 	compatible = "samsung,exynos5250";
@@ -44,6 +45,10 @@
 		i2c6 = &i2c_6;
 		i2c7 = &i2c_7;
 		i2c8 = &i2c_8;
+		pinctrl0 = &pinctrl_0;
+		pinctrl1 = &pinctrl_1;
+		pinctrl2 = &pinctrl_2;
+		pinctrl3 = &pinctrl_3;
 	};
 
 	gic:interrupt-controller at 10481000 {
@@ -69,6 +74,36 @@
 			     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
 	};
 
+	pinctrl_0: pinctrl at 11400000 {
+		compatible = "samsung,exynos5250-pinctrl";
+		reg = <0x11400000 0x1000>;
+		interrupts = <0 46 0>;
+
+		wakup_eint: wakeup-interrupt-controller {
+			compatible = "samsung,exynos4210-wakeup-eint";
+			interrupt-parent = <&gic>;
+			interrupts = <0 32 0>;
+		};
+	};
+
+	pinctrl_1: pinctrl at 13400000 {
+		compatible = "samsung,exynos5250-pinctrl";
+		reg = <0x13400000 0x1000>;
+		interrupts = <0 45 0>;
+	};
+
+	pinctrl_2: pinctrl at 10d10000 {
+		compatible = "samsung,exynos5250-pinctrl";
+		reg = <0x10d10000 0x1000>;
+		interrupts = <0 50 0>;
+	};
+
+	pinctrl_3: pinctrl at 03680000 {
+		compatible = "samsung,exynos5250-pinctrl";
+		reg = <0x0368000 0x1000>;
+		interrupts = <0 47 0>;
+	};
+
 	watchdog {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x101D0000 0x100>;
@@ -134,6 +169,8 @@
 		interrupts = <0 56 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_bus>;
 	};
 
 	i2c_1: i2c at 12C70000 {
@@ -142,6 +179,8 @@
 		interrupts = <0 57 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_bus>;
 	};
 
 	i2c_2: i2c at 12C80000 {
@@ -150,6 +189,8 @@
 		interrupts = <0 58 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_bus>;
 	};
 
 	i2c_3: i2c at 12C90000 {
@@ -158,6 +199,8 @@
 		interrupts = <0 59 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c3_bus>;
 	};
 
 	i2c_4: i2c at 12CA0000 {
@@ -166,6 +209,8 @@
 		interrupts = <0 60 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c4_bus>;
 	};
 
 	i2c_5: i2c at 12CB0000 {
@@ -174,6 +219,8 @@
 		interrupts = <0 61 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c5_bus>;
 	};
 
 	i2c_6: i2c at 12CC0000 {
@@ -182,6 +229,8 @@
 		interrupts = <0 62 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c6_bus>;
 	};
 
 	i2c_7: i2c at 12CD0000 {
@@ -190,6 +239,8 @@
 		interrupts = <0 63 0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c7_bus>;
 	};
 
 	i2c_8: i2c at 12CE0000 {
@@ -216,6 +267,8 @@
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi0_bus>;
 	};
 
 	spi_1: spi at 12d30000 {
@@ -227,6 +280,8 @@
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi1_bus>;
 	};
 
 	spi_2: spi at 12d40000 {
@@ -238,6 +293,8 @@
 		dma-names = "tx", "rx";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi2_bus>;
 	};
 
 	dwmmc_0: dwmmc0 at 12200000 {
@@ -283,6 +340,8 @@
 		samsung,supports-rstclr;
 		samsung,supports-secdai;
 		samsung,idma-addr = <0x03000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s0_bus>;
 	};
 
 	i2s1: i2s at 12D60000 {
@@ -291,6 +350,8 @@
 		dmas = <&pdma1 12
 			&pdma1 11>;
 		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s1_bus>;
 	};
 
 	i2s2: i2s at 12D70000 {
@@ -299,6 +360,8 @@
 		dmas = <&pdma0 12
 			&pdma0 11>;
 		dma-names = "tx", "rx";
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s2_bus>;
 	};
 
 	amba {
@@ -345,253 +408,6 @@
 		};
 	};
 
-	gpio-controllers {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		gpio-controller;
-		ranges;
-
-		gpa0: gpio-controller at 11400000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400000 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpa1: gpio-controller at 11400020 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400020 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpa2: gpio-controller at 11400040 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400040 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb0: gpio-controller at 11400060 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400060 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb1: gpio-controller at 11400080 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400080 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb2: gpio-controller at 114000A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb3: gpio-controller at 114000C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc0: gpio-controller at 114000E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc1: gpio-controller at 11400100 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400100 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc2: gpio-controller at 11400120 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400120 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc3: gpio-controller at 11400140 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400140 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc4: gpio-controller at 114002E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114002E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpd0: gpio-controller at 11400160 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400160 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpd1: gpio-controller at 11400180 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400180 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy0: gpio-controller at 114001A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy1: gpio-controller at 114001C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy2: gpio-controller at 114001E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy3: gpio-controller at 11400200 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400200 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy4: gpio-controller at 11400220 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400220 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy5: gpio-controller at 11400240 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400240 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy6: gpio-controller at 11400260 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400260 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx0: gpio-controller at 11400C00 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400C00 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx1: gpio-controller at 11400C20 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400C20 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx2: gpio-controller at 11400C40 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400C40 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx3: gpio-controller at 11400C60 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400C60 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe0: gpio-controller at 13400000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400000 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe1: gpio-controller at 13400020 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400020 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpf0: gpio-controller at 13400040 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400040 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpf1: gpio-controller at 13400060 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400060 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpg0: gpio-controller at 13400080 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400080 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpg1: gpio-controller at 134000A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x134000A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpg2: gpio-controller at 134000C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x134000C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gph0: gpio-controller at 134000E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x134000E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gph1: gpio-controller at 13400100 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x13400100 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv0: gpio-controller at 10D10000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10000 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv1: gpio-controller at 10D10020 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10020 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv2: gpio-controller at 10D10040 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10060 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv3: gpio-controller at 10D10060 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D10080 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpv4: gpio-controller at 10D10080 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x10D100C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpz: gpio-controller at 03860000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x03860000 0x20>;
-			#gpio-cells = <4>;
-		};
-	};
-
 	gsc_0:  gsc at 0x13e00000 {
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e00000 0x1000>;
-- 
1.6.6.rc2
