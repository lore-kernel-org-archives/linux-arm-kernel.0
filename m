From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 28 Jul 2015 13:53:50 +0100
Subject: [PATCH v1 2/7] ARM: dts: qs600: add pwrseq support to WLAN
In-Reply-To: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438087956-17307-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438088030-17395-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pwrseq support to sdcc4 which would enable a proper reset of WLAN
without ugly hacks in the board support file.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
index 34ccb26..3ca1b80 100644
--- a/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts
@@ -1,4 +1,6 @@
 #include "qcom-apq8064-v2.0.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 
 / {
 	model = "CompuLab CM-QS600";
@@ -155,6 +157,29 @@
 			regulator-always-on;
 		};
 
+		qcom,ssbi at 500000 {
+			pmicintc: pmic at 0 {
+				pm8921_gpio: gpio at 150 {
+					pinctrl-names = "default";
+					pinctrl-0 = <&wlan_default_gpios>;
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
+		sdcc4_pwrseq:pwrseq {
+			compatible = "mmc-pwrseq-simple";
+			/* WLAN reset */
+			reset-gpios = <&pm8921_gpio 42 GPIO_ACTIVE_LOW>;
+		};
+
 		amba {
 			/* eMMC */
 			sdcc1: sdcc at 12400000 {
@@ -173,6 +198,7 @@
 				status = "okay";
 				vmmc-supply = <&v3p3_fixed>;
 				vqmmc-supply = <&v3p3_fixed>;
+				mmc-pwrseq = <&sdcc4_pwrseq>;
 			};
 		};
 	};
-- 
1.9.1
