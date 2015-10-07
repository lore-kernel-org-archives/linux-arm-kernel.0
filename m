From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Thu,  8 Oct 2015 00:18:36 +0200
Subject: [PATCH v3] ARM: dts: sunxi: Add regulators for LeMaker BananaPi
Message-ID: <1444256316-2278-1-git-send-email-public_timo.s@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun7i-a20-bananapi.dts doesn't contain regulator nodes for the AXP209 PMU
driver, so add them to allow for voltage-scaling with cpufreq-dt. Also
add board-specific OPP to use slightly higher voltages at lower
frequencies since Kevin Hilman reported that not all BananaPi boards run
stable at the default voltages inherited by sun7i-a20.dtsi.

Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
---
Changes since v2:

- (Re)Added board-specific OPP after Kevin Hilman reported problems with
the default voltages at lower frequencies
---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts | 45 +++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index 9f7b472..39b6b67b 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -92,6 +92,20 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+	operating-points = <
+		/* kHz	  uV */
+		960000	1400000
+		912000	1400000
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
@@ -119,13 +133,9 @@
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
 
@@ -182,6 +192,33 @@
 	};
 };
 
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
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
 &reg_usb1_vbus {
 	status = "okay";
 };
-- 
2.1.4
