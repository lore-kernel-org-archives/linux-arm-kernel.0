From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 18 Aug 2015 14:06:52 +0100
Subject: [PATCH v2 1/6] ARM: dts: ifc6410: Add pwrseq support for WLAN
In-Reply-To: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1439903212-19931-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pwrseq for WLAN which resets the WLAN just before the
SDIO bus is up.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 88d6655..b1f9ddb 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -1,5 +1,6 @@
 #include "qcom-apq8064-v2.0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
 	model = "Qualcomm APQ8064/IFC6410";
@@ -10,6 +11,20 @@
 		serial1 = &gsbi6_serial;
 	};
 
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
 			card_detect: card_detect {
@@ -206,6 +221,21 @@
 			status = "okay";
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
@@ -227,6 +257,7 @@
 				status = "okay";
 				vmmc-supply = <&ext_3p3v>;
 				vqmmc-supply = <&pm8921_lvs1>;
+				mmc-pwrseq = <&sdcc4_pwrseq>;
 			};
 		};
 	};
-- 
1.9.1
