From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Jan 2017 11:21:13 +0100
Subject: [PATCH 1/2] ARM: dts: add XOADC and IIO HWMON to MSM8660/APQ8060
Message-ID: <20170131102114.25085-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the PM8058 XOADC node to the PM8058 PMIC node,
defines the 16 channels and further also define an IIO HWMON
node for the channels that are used for housekeeping of
voltages and die temperature for the PMIC chip die.

Tested on the APQ8060 DragonBoard:
cd /sys/class/hwmon/hwmon0
cat in2_input
4773 (DC mains ~5V)
cat in4_input
625  (0.625V reference voltage)
cat in5_input
1250 (1.25V reference voltage)
cat temp1_input
35852 (die temperature)

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Andy: these bindings have been merged to the IIO tree and ACKed
by DT maintainers.
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 27 ++++++++++++
 arch/arm/boot/dts/qcom-msm8660.dtsi            | 59 ++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 39d9e6ddefed..c04960371c5e 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -327,6 +327,33 @@
 					};
 				};
 
+				xoadc at 197 {
+					/* Reference voltage 2.2 V */
+					xoadc-ref-supply = <&pm8058_l18>;
+
+					/* Board-specific channels */
+					mpp5 {
+						/* Connected to AOUT of ALS sensor */
+						reg = <0x05>;
+					};
+					mpp6 {
+						/* Connected to test point TP43 */
+						reg = <0x06>;
+					};
+					mpp7 {
+						/* Connected to battery thermistor */
+						reg = <0x07>;
+					};
+					mpp8 {
+						/* Connected to battery ID detector */
+						reg = <0x08>;
+					};
+					mpp9 {
+						/* Connected to XO thermistor */
+						reg = <0x09>;
+					};
+				};
+
 				led at 48 {
 					/*
 					 * The keypad LED @0x48 is routed to
diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 91c9a62ae725..5ca6df54f9b5 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -63,6 +63,22 @@
 		};
 	};
 
+	/*
+	 * These channels from the ADC are simply hardware monitors.
+	 * That is why the ADC is referred to as "HKADC" - HouseKeeping
+	 * ADC.
+	 */
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&xoadc 0x01>, /* Battery */
+			    <&xoadc 0x02>, /* DC in (charger) */
+			    <&xoadc 0x04>, /* VPH the main system voltage */
+			    <&xoadc 0x0b>, /* Die temperature */
+			    <&xoadc 0x0c>, /* Reference voltage 1.25V */
+			    <&xoadc 0x0d>, /* Reference voltage 0.625V */
+			    <&xoadc 0x0e>; /* Reference voltage 0.325V */
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -267,6 +283,49 @@
 					row-hold = <91500>;
 				};
 
+				xoadc: xoadc at 197 {
+					compatible = "qcom,pm8058-adc";
+					reg = <0x197>;
+					interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#io-channel-cells = <1>;
+
+					vcoin: adc-channel at 0 {
+						reg = <0x00>;
+					};
+					vbat: adc-channel at 1 {
+						reg = <0x01>;
+					};
+					dcin: adc-channel at 2 {
+						reg = <0x02>;
+					};
+					ichg: adc-channel at 3 {
+						reg = <0x03>;
+					};
+					vph_pwr: adc-channel at 4 {
+						reg = <0x04>;
+					};
+					usb_vbus: adc-channel at a {
+						reg = <0x0a>;
+					};
+					die_temp: adc-channel at b {
+						reg = <0x0b>;
+					};
+					ref_625mv: adc-channel at c {
+						reg = <0x0c>;
+					};
+					ref_1250mv: adc-channel at d {
+						reg = <0x0d>;
+					};
+					ref_325mv: adc-channel at e {
+						reg = <0x0e>;
+					};
+					ref_muxoff: adc-channel at f {
+						reg = <0x0f>;
+					};
+				};
+
 				rtc at 1e8 {
 					compatible = "qcom,pm8058-rtc";
 					reg = <0x1e8>;
-- 
2.9.3
