From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 18 Aug 2015 14:10:01 +0100
Subject: [PATCH v2 2/6] ARM: dts: qs600: add pwrseq support to WLAN
In-Reply-To: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1439903401-20189-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwrseq support to sdcc4 which would enable a proper reset of WLAN
without ugly hacks in the board support file.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 34ccb26..ebde2b7 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -1,9 +1,25 @@
 #include "qcom-apq8064-v2.0.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
 	model = "CompuLab CM-QS600";
 	compatible = "qcom,apq8064-cm-qs600", "qcom,apq8064";
 
+	pwrseq {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		compatible = "simple-bus";
+
+		sdcc4_pwrseq: sdcc4_pwrseq {
+			pinctrl-names = "default";
+			pinctrl-0 = <&wlan_default_gpios>;
+			compatible = "mmc-pwrseq-simple";
+			reset-gpios = <&pm8921_gpio 43 GPIO_ACTIVE_LOW>;
+		};
+	};
+
 	soc {
 		pinctrl at 800000 {
 			i2c1_pins: i2c1 {
@@ -155,6 +171,21 @@
 			regulator-always-on;
 		};
 
+		qcom,ssbi at 500000 {
+			pmic at 0 {
+				gpio at 150 {
+					wlan_default_gpios: wlan-gpios {
+						pios {
+							pins = "gpio43";
+							function = "normal";
+							bias-disable;
+							power-source = <PM8921_GPIO_S4>;
+						};
+					};
+				};
+			};
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
@@ -173,6 +204,7 @@
 				status = "okay";
 				vmmc-supply = <&v3p3_fixed>;
 				vqmmc-supply = <&v3p3_fixed>;
+				mmc-pwrseq = <&sdcc4_pwrseq>;
 			};
 		};
 	};
-- 
1.9.1
