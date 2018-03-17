From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Mar 2018 17:28:55 +0800
Subject: [PATCH net-next 10/12] ARM: dts: sun8i: r40: bananapi-m2-ultra: Sort
 device node dereferences
In-Reply-To: <20180317092857.4396-1-wens@csie.org>
References: <20180317092857.4396-1-wens@csie.org>
Message-ID: <20180317092857.4396-11-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device nodes dereference (&foo) usages should be sorted by the label
names, barring any parsing order issues such as the #include statement
for the PMIC's .dtsi file that must come after the PMIC.

Move the mmc and ohci blocks in front of the PMIC's regulator blocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 69 ++++++++++++-----------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 27d9ccd0ef2f..c6da21e43572 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -114,6 +114,41 @@
 
 #include "axp22x.dtsi"
 
+&mmc0 {
+	vmmc-supply = <&reg_dcdc1>;
+	bus-width = <4>;
+	cd-gpios = <&pio 7 13 GPIO_ACTIVE_HIGH>; /* PH13 */
+	cd-inverted;
+	status = "okay";
+};
+
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pg_pins>;
+	vmmc-supply = <&reg_dldo2>;
+	vqmmc-supply = <&reg_dldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
 &reg_aldo3 {
 	regulator-always-on;
 	regulator-min-microvolt = <2700000>;
@@ -161,40 +196,6 @@
 	regulator-name = "vcc-wifi";
 };
 
-&mmc0 {
-	vmmc-supply = <&reg_dcdc1>;
-	bus-width = <4>;
-	cd-gpios = <&pio 7 13 GPIO_ACTIVE_LOW>; /* PH13 */
-	status = "okay";
-};
-
-&mmc1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pg_pins>;
-	vmmc-supply = <&reg_dldo2>;
-	vqmmc-supply = <&reg_dldo1>;
-	mmc-pwrseq = <&wifi_pwrseq>;
-	bus-width = <4>;
-	non-removable;
-	status = "okay";
-};
-
-&mmc2 {
-	vmmc-supply = <&reg_dcdc1>;
-	vqmmc-supply = <&reg_dcdc1>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-};
-
-&ohci1 {
-	status = "okay";
-};
-
-&ohci2 {
-	status = "okay";
-};
-
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.16.2
