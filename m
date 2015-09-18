From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 18 Sep 2015 13:32:05 +0100
Subject: [PATCH 12/14] ARM: dts: qs600: add pwrseq support to WLAN
In-Reply-To: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1442579371-19822-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1442579525-20440-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwrseq support to sdcc4 which would enable a proper reset of WLAN
without ugly hacks in the board support file.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 8aac3be..cc9d942 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -1,4 +1,6 @@
 #include "qcom-apq8064-v2.0.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
 	model = "CompuLab CM-QS600";
@@ -12,6 +14,20 @@
 		stdout-path = "serial0:115200n8";
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
 		rpm at 108000 {
 			regulators {
@@ -154,6 +170,21 @@
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
@@ -172,6 +203,7 @@
 				status = "okay";
 				vmmc-supply = <&v3p3_fixed>;
 				vqmmc-supply = <&v3p3_fixed>;
+				mmc-pwrseq = <&sdcc4_pwrseq>;
 			};
 		};
 	};
-- 
1.9.1
