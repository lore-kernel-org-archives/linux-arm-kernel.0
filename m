From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:31:59 +0100
Subject: [PATCH 11/14] ARM: dts: ifc6410: Add pwrseq support for WLAN
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579519-20398-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pwrseq for WLAN which resets the WLAN just before the
SDIO bus is up.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index c1d5bd7..9c71a51 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -1,5 +1,6 @@
 #include "qcom-apq8064-v2.0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
 	model = "Qualcomm APQ8064/IFC6410";
@@ -14,6 +15,17 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	pwrseq {
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
@@ -207,6 +219,21 @@
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
@@ -228,6 +255,7 @@
 				status = "okay";
 				vmmc-supply = <&ext_3p3v>;
 				vqmmc-supply = <&pm8921_lvs1>;
+				mmc-pwrseq = <&sdcc4_pwrseq>;
 			};
 		};
 	};
-- 
1.9.1
