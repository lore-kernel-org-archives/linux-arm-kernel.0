From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:35:02 +0000
Subject: [PATCH 6/6] arm64: dts: db820c: add support to volume up key
In-Reply-To: <1483536902-21450-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536902-21450-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536902-21450-7-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to volume-up key found on the board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi          | 19 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
index 6c1628c..b1142c4 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi
@@ -12,4 +12,16 @@
 			power-source = <2>; // PM8994_GPIO_S4, 1.8V
 		};
 	};
+
+	volume_up_gpio: pm8996_gpio2 {
+		pinconf {
+			pins = "gpio2";
+			function = "normal";
+			input-enable;
+			drive-push-pull;
+			bias-pull-up;
+			qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+			power-source = <PM8994_GPIO_S4>; // 1.8V
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 422959b..d2196fc 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -15,6 +15,8 @@
 #include "pm8994.dtsi"
 #include "apq8096-db820c-pins.dtsi"
 #include "apq8096-db820c-pmic-pins.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	aliases {
@@ -87,4 +89,21 @@
 			status = "okay";
 		};
 	};
+
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&volume_up_gpio>;
+
+		button at 0 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8994_gpios 2 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
-- 
2.10.1
