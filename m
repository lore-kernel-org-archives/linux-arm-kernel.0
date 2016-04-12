From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 12 Apr 2016 10:33:59 +0100
Subject: [PATCH v2 10/13] ARM: dts: db600c: Add on board leds support
In-Reply-To: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1460453642-5809-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1460453642-5809-11-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support to 4 user leds, wlan and bt led on board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi   | 23 +++++++++++
 arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts    | 47 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
index 0610f00..3b55bb9 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c-pins.dtsi
@@ -18,4 +18,27 @@
 			bias-disable;
 		};
 	};
+
+	user_leds: user-leds {
+		mux {
+			pins = "gpio3", "gpio7", "gpio10", "gpio11";
+			function = "gpio";
+		};
+
+		conf {
+			pins = "gpio3", "gpio7", "gpio10", "gpio11";
+			function = "gpio";
+			output-low;
+		};
+	};
+};
+
+&pm8921_mpps {
+	mpp_leds: mpp-leds {
+		pinconf {
+			pins = "mpp7", "mpp8";
+			function = "digital";
+			output-low;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
index 6f97ddc..8c18a4b 100644
--- a/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-arrow-db600c.dts
@@ -153,6 +153,53 @@
 			};
 		};
 
+		leds {
+			pinctrl-names = "default";
+			pinctrl-0 = <&user_leds>, <&mpp_leds>;
+
+			compatible = "gpio-leds";
+
+			user-led0 {
+				label = "user0-led";
+				gpios = <&tlmm_pinmux 3 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "heartbeat";
+				default-state = "off";
+			};
+
+			user-led1 {
+				label = "user1-led";
+				gpios = <&tlmm_pinmux 7 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc0";
+				default-state = "off";
+			};
+
+			user-led2 {
+				label = "user2-led";
+				gpios = <&tlmm_pinmux 10 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "mmc1";
+				default-state = "off";
+			};
+
+			user-led3 {
+				label = "user3-led";
+				gpios = <&tlmm_pinmux 11 GPIO_ACTIVE_HIGH>;
+				linux,default-trigger = "none";
+				default-state = "off";
+			};
+
+			wifi-led {
+				label = "WiFi-led";
+				gpios = <&pm8921_mpps 7 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+			};
+
+			bt-led {
+				label = "BT-led";
+				gpios = <&pm8921_mpps 8 GPIO_ACTIVE_HIGH>;
+				default-state = "off";
+			};
+		};
+
 		pci at 1b500000 {
 			status = "okay";
 			vdda-supply = <&pm8921_s3>;
-- 
2.5.0
