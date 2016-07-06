From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  6 Jul 2016 17:10:49 +0800
Subject: [PATCH 8/9] ARM: dts: sun7i: bananapi-m1-plus: Add PMIC regulators
 and OPPs for cpufreq
In-Reply-To: <1467796250-22010-1-git-send-email-wens@csie.org>
References: <1467796250-22010-1-git-send-email-wens@csie.org>
Message-ID: <1467796250-22010-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Bananapi M1+, like other Allwinner A20 based boards, uses the AXP209
PMIC to supply its power. The vendor FEX file's DVFS table suggests the
board's CPU power rail has a voltage drop of 25 ~ 50 mV.

Add the PMIC regulator nodes and copy the DVFS table from the FEX file.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 48 ++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index ba5bca0fe997..7bb418bd1b6e 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -105,6 +105,22 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+
+	/* The custom DVFS table suggests a voltage drop of 25 ~ 50 mV */
+	operating-points = <
+		/* kHz    uV */
+		1080000	1450000
+		912000	1425000
+		864000	1350000
+		720000	1250000
+		528000	1150000
+		312000	1100000
+		144000	1050000
+		>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -132,13 +148,9 @@
 	status = "okay";
 
 	axp209: pmic at 34 {
-		compatible = "x-powers,axp209";
 		reg = <0x34>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
 	};
 };
 
@@ -222,6 +234,34 @@
 	};
 };
 
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	/* The custom DVFS table suggests a voltage drop of 25 ~ 50 mV */
+	regulator-always-on;
+	regulator-min-microvolt = <1050000>;
+	regulator-max-microvolt = <1450000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.8.1
