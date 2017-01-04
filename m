From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:34:59 +0000
Subject: [PATCH 3/6] arm64: dts: apq8016-sbc: Add Volume Up key device node
In-Reply-To: <1483536902-21450-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536902-21450-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536902-21450-4-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>

VOL/ZOOM+ button on DB410c is connected to
SoC GPIO 104. Add support for it.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi | 13 +++++++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
index e1e6c6b..185388d 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
@@ -72,4 +72,17 @@
 			bias-disable;
 		};
 	};
+
+	msm_key_volp_n_default: msm_key_volp_n_default {
+		pinmux {
+			function = "gpio";
+			pins = "gpio107";
+		};
+		pinconf {
+			pins = "gpio107";
+			drive-strength = <8>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 5ab277f..d05382a 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -15,6 +15,8 @@
 #include "pm8916.dtsi"
 #include "apq8016-sbc-soc-pins.dtsi"
 #include "apq8016-sbc-pmic-pins.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/sound/apq8016-lpass.h>
 
 / {
@@ -341,6 +343,22 @@
 			};
 		};
 	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&msm_key_volp_n_default>;
+
+		button at 0 {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&msmgpio 107 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &wcd_codec {
-- 
2.10.1
