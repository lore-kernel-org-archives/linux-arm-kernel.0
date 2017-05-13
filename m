From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 13 May 2017 16:15:43 +0200
Subject: [PATCH 1/2 v6] ARM: dts: add XOADC and IIO HWMON to MSM8660/APQ8060
Message-ID: <20170513141543.24759-1-linus.walleij@linaro.org>
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
ChangeLog v5->v6:
- Fix two typos in the DTSI file.
- The driver is now merged, all dependencies are in place upstream.
ChangeLog v1->v5:
- Switch to the twocell addressing scheme specified in the new
  bindings.
- The bindings and IIO driver are both queued for v4.12 in the
  IIO tree and pending in linux-next
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index 747669a62aa8..f5631e810e9d 100644
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
+		io-channels = <&xoadc 0x00 0x01>, /* Battery */
+			    <&xoadc 0x00 0x02>, /* DC in (charger) */
+			    <&xoadc 0x00 0x04>, /* VPH the main system voltage */
+			    <&xoadc 0x00 0x0b>, /* Die temperature */
+			    <&xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
+			    <&xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
+			    <&xoadc 0x00 0x0e>; /* Reference voltage 0.325V */
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
+					#address-cells = <2>;
+					#size-cells = <0>;
+					#io-channel-cells = <2>;
+
+					vcoin: adc-channel at 00 {
+						reg = <0x00 0x00>;
+					};
+					vbat: adc-channel at 01 {
+						reg = <0x00 0x01>;
+					};
+					dcin: adc-channel at 02 {
+						reg = <0x00 0x02>;
+					};
+					ichg: adc-channel at 03 {
+						reg = <0x00 0x03>;
+					};
+					vph_pwr: adc-channel at 04 {
+						reg = <0x00 0x04>;
+					};
+					usb_vbus: adc-channel at 0a {
+						reg = <0x00 0x0a>;
+					};
+					die_temp: adc-channel at 0b {
+						reg = <0x00 0x0b>;
+					};
+					ref_625mv: adc-channel at 0c {
+						reg = <0x00 0x0c>;
+					};
+					ref_1250mv: adc-channel at 0d {
+						reg = <0x00 0x0d>;
+					};
+					ref_325mv: adc-channel at 0e {
+						reg = <0x00 0x0e>;
+					};
+					ref_muxoff: adc-channel at 0f {
+						reg = <0x00 0x0f>;
+					};
+				};
+
 				rtc at 1e8 {
 					compatible = "qcom,pm8058-rtc";
 					reg = <0x1e8>;
-- 
2.9.3
