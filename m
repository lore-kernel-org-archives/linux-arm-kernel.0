From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 19 Nov 2013 19:43:15 -0500
Subject: [PATCH v2 2/4] keystone: dts: add a k2hk-evm specific dts file
In-Reply-To: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
References: <1384908197-4324-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1384908197-4324-3-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds K2 Kepler/Hawking evm (k2hk-evm) specific dts file.
To enable re-use of bindings across multiple evms of this family,
rename current keystone.dts to keystone.dtsi and include it in the
evm specific dts file.

K2 SoC has separate ref clock inputs for various clocks. So add
separate ref clock nodes for ARM, DDR3A, DDR3B and PA PLL input
clocks in k2hk-evm.dts. While at it, rename  refclkmain to
refclksys based on device User Guide naming convention

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 - addressed comments against initial version

 arch/arm/boot/dts/k2hk-evm.dts                    |   55 +++++++++++++++++++++
 arch/arm/boot/dts/keystone-clocks.dtsi            |   23 +++------
 arch/arm/boot/dts/{keystone.dts => keystone.dtsi} |    2 -
 3 files changed, 61 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/boot/dts/k2hk-evm.dts
 rename arch/arm/boot/dts/{keystone.dts => keystone.dtsi} (98%)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
new file mode 100644
index 0000000..15b3a95
--- /dev/null
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -0,0 +1,55 @@
+/*
+ * Copyright 2013 Texas Instruments, Inc.
+ *
+ * Keystone 2 Kepler/Hawking EVM device tree
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+#include "keystone.dtsi"
+
+/ {
+	compatible =  "ti,keystone-evm";
+
+	soc {
+		clock {
+			refclksys: refclksys {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <122880000>;
+				clock-output-names = "refclk-sys";
+			};
+
+			refclkpass: refclkpass {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <122880000>;
+				clock-output-names = "refclk-pass";
+			};
+
+			refclkarm: refclkarm {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <125000000>;
+				clock-output-names = "refclk-arm";
+			};
+
+			refclkddr3a: refclkddr3a {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <100000000>;
+				clock-output-names = "refclk-ddr3a";
+			};
+
+			refclkddr3b: refclkddr3b {
+				#clock-cells = <0>;
+				compatible = "fixed-clock";
+				clock-frequency = <100000000>;
+				clock-output-names = "refclk-ddr3b";
+			};
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/keystone-clocks.dtsi b/arch/arm/boot/dts/keystone-clocks.dtsi
index d6713b1..67e70ec 100644
--- a/arch/arm/boot/dts/keystone-clocks.dtsi
+++ b/arch/arm/boot/dts/keystone-clocks.dtsi
@@ -13,17 +13,10 @@ clocks {
 	#size-cells = <1>;
 	ranges;
 
-	refclkmain: refclkmain {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <122880000>;
-		clock-output-names = "refclk-main";
-	};
-
 	mainpllclk: mainpllclk at 2310110 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,main-pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclksys>;
 		reg = <0x02620350 4>, <0x02310110 4>;
 		reg-names = "control", "multiplier";
 		fixed-postdiv = <2>;
@@ -32,47 +25,43 @@ clocks {
 	papllclk: papllclk at 2620358 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkpass>;
 		clock-output-names = "pa-pll-clk";
 		reg = <0x02620358 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 	ddr3allclk: ddr3apllclk at 2620360 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkddr3a>;
 		clock-output-names = "ddr-3a-pll-clk";
 		reg = <0x02620360 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 	ddr3bllclk: ddr3bpllclk at 2620368 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkddr3b>;
 		clock-output-names = "ddr-3b-pll-clk";
 		reg = <0x02620368 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 	armpllclk: armpllclk at 2620370 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-clock";
-		clocks = <&refclkmain>;
+		clocks = <&refclkarm>;
 		clock-output-names = "arm-pll-clk";
 		reg = <0x02620370 4>;
 		reg-names = "control";
-		fixed-postdiv = <6>;
 	};
 
 	mainmuxclk: mainmuxclk at 2310108 {
 		#clock-cells = <0>;
 		compatible = "ti,keystone,pll-mux-clock";
-		clocks = <&mainpllclk>, <&refclkmain>;
+		clocks = <&mainpllclk>, <&refclksys>;
 		reg = <0x02310108 4>;
 		bit-shift = <23>;
 		bit-mask = <1>;
diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dtsi
similarity index 98%
rename from arch/arm/boot/dts/keystone.dts
rename to arch/arm/boot/dts/keystone.dtsi
index 100bdf5..c01c6fb 100644
--- a/arch/arm/boot/dts/keystone.dts
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -6,14 +6,12 @@
  * published by the Free Software Foundation.
  */
 
-/dts-v1/;
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
 
 / {
 	model = "Texas Instruments Keystone 2 SoC";
-	compatible =  "ti,keystone-evm";
 	#address-cells = <2>;
 	#size-cells = <2>;
 	interrupt-parent = <&gic>;
-- 
1.7.9.5
