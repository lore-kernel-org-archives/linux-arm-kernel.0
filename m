From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Thu,  4 Jun 2015 12:19:06 +0300
Subject: [PATCH 7/7] arm64: dts: qcom: Add apq8016-sbc board LED's related
 device nodes
In-Reply-To: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
References: <1433409546-23995-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1433409546-23995-8-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APQ8016 SBC board have 6 user controllable LED's.

Add following devices:

LED1 green LED triggered by system heartbeat.
LED2 green LED triggered by access to eMMC device.
LED3 green LED triggered by access to SD card.
LED4 green LED no trigger assigned.
LED5 yellow LED triggered by access to WLAN.
LED6 blue LED triggered by access to Bluetooth.

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 .../arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi | 19 ++++++++
 arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi | 11 ++---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          | 51 ++++++++++++++++++++++
 3 files changed, 73 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
index b568c49..e03c11d 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi
@@ -18,4 +18,23 @@
 			input-disable;
 		};
 	};
+
+	pm8916_gpios_leds: pm8916_gpios_leds {
+		pinconf {
+			pins = "gpio1", "gpio2";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+		};
+	};
+};
+
+&pm8916_mpps {
+
+	pm8916_mpps_leds: pm8916_mpps_leds {
+		pinconf {
+			pins = "mpp2", "mpp3";
+			function = PMIC_GPIO_FUNC_NORMAL;
+			output-low;
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
index 27087cf..cbeee0b 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-soc-pins.dtsi
@@ -3,14 +3,9 @@

 &msmgpio {

-	soc_gpios_default: default {
-		usr_led_1_ctrl_default: usr_led_1_ctrl_default {
-			pins = "gpio21";
-			function = "gpio";
-			output-low;
-		};
-		usr_led_2_ctrl_default: usr_led_2_ctrl_default {
-			pins = "gpio120";
+	msmgpio_leds: msmgpio_leds {
+		pinconf {
+			pins = "gpio21", "gpio120";
 			function = "gpio";
 			output-low;
 		};
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 98abece..66804ff 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -32,5 +32,56 @@
 			pinctrl-0 = <&blsp1_uart2_default>;
 			pinctrl-1 = <&blsp1_uart2_sleep>;
 		};
+
+		leds {
+			pinctrl-names = "default";
+			pinctrl-0 = <&msmgpio_leds>,
+				    <&pm8916_gpios_leds>,
+				    <&pm8916_mpps_leds>;
+
+			compatible = "gpio-leds";
+
+			led at 1 {
+				label = "apq8016-sbc:green:user1";
+				gpios = <&msmgpio 21 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "heartbeat";
+				default-state = "off";
+			};
+
+			led at 2 {
+				label = "apq8016-sbc:green:user2";
+				gpios = <&msmgpio 120 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+
+			led at 3 {
+				label = "apq8016-sbc:green:user3";
+				gpios = <&pm8916_gpios 1 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc1";
+				default-state = "off";
+			};
+
+			led at 4 {
+				label = "apq8016-sbc:green:user4";
+				gpios = <&pm8916_gpios 2 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "none";
+				default-state = "off";
+			};
+
+			led at 5 {
+				label = "apq8016-sbc:yellow:wlan";
+				gpios = <&pm8916_mpps 2 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "wlan";
+				default-state = "off";
+			};
+
+			led at 6 {
+				label = "apq8016-sbc:blue:bt";
+				gpios = <&pm8916_mpps 3 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "bt";
+				default-state = "off";
+			};
+		};
 	};
 };
--
1.9.1
