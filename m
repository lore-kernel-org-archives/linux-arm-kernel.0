From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Feb 2018 11:16:58 +0100
Subject: [PATCH] ARM: dts: add XOADC and IIO HWMON to APQ8064
Message-ID: <20180228101658.28603-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the PM8921 XOADC node to the PM8921 PMIC node,
defines the channels and further also define an IIO HWMON
node for the channels that are used for housekeeping of
voltages and die temperature for the PMIC chip die.

Tested on the Nexus 7 tablet:
lsiio
Device 000: PM8921-XOADC
cd /sys/bus/iio/devices/iio:device0
cat in_voltage10_input
616461  (0.625V reference voltage)
cat in_voltage11_input
 (1.25V reference voltage)
cat temp1_input
35852 (die temperature)

Cc: John Stultz <john.stultz@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 63 +++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 3ca96e361878..5341a39c0392 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -316,6 +316,23 @@
 		};
 	};
 
+
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
+			    <&xoadc 0x00 0x0e>; /* Charger temperature */
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -770,6 +787,52 @@
 					debounce = <15625>;
 					pull-up;
 				};
+
+				xoadc: xoadc at 197 {
+					compatible = "qcom,pm8921-adc";
+					reg = <197>;
+					interrupts-extended = <&pmicintc 78 IRQ_TYPE_EDGE_RISING>;
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
+					vph_pwr: adc-channel at 04 {
+						reg = <0x00 0x04>;
+					};
+					batt_therm: adc-channel at 08 {
+						reg = <0x00 0x08>;
+					};
+					batt_id: adc-channel at 09 {
+						reg = <0x00 0x09>;
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
+					chg_temp: adc-channel at 0e {
+						reg = <0x00 0x0e>;
+					};
+					ref_muxoff: adc-channel at 0f {
+						reg = <0x00 0x0f>;
+					};
+				};
 			};
 		};
 
-- 
2.14.3
