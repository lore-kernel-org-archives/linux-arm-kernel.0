From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 16 Jun 2015 13:31:15 -0700
Subject: [PATCH 4/5] ARM: dts: qcom: Add ks8851 node for wired ethernet
In-Reply-To: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
References: <1434486676-21812-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1434486676-21812-5-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The micrel ks8851 device is present on MSM8960 CDP boards. It is
connected to two regulators, one controlled via a gpio and
another controlled via the RPM. Add the gsbi, spi, gpio
regulator, and micrel ks8851 nodes so that ethernet works
properly.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts | 66 ++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-msm8960.dtsi    | 25 +++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index be241f14246d..fad71d5527b0 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -262,6 +262,72 @@
 				};
 			};
 		};
+
+		gsbi at 16000000 {
+			status = "ok";
+			qcom,mode = <GSBI_PROT_SPI>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_default>;
+			spi at 16080000 {
+				status = "ok";
+				eth at 0 {
+					compatible = "micrel,ks8851";
+					reg = <0>;
+					interrupt-parent = <&msmgpio>;
+					interrupts = <90 8>;
+					spi-max-frequency = <5400000>;
+					vdd-supply = <&ext_l2>;
+					vdd-io-supply = <&pm8921_lvs6>;
+					reset-gpios = <&msmgpio 89 0>;
+				};
+			};
+		};
+
+		pinctrl at 800000 {
+			spi1_default: spi1_default {
+				mux {
+					pins = "gpio6", "gpio7", "gpio9";
+					function = "gsbi1";
+				};
+
+				mosi {
+					pins = "gpio6";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				miso {
+					pins = "gpio7";
+					drive-strength = <12>;
+					bias-disable;
+				};
+
+				cs {
+					pins = "gpio8";
+					drive-strength = <12>;
+					bias-disable;
+					output-low;
+				};
+
+				clk {
+					pins = "gpio9";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		ext_l2: gpio-regulator at 91 {
+			compatible = "regulator-fixed";
+			regulator-name = "ext_l2";
+			gpio = <&msmgpio 91 0>;
+			startup-delay-us = <10000>;
+			enable-active-high;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index fcf4bb5f9c3f..2096a94c9b52 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -271,5 +271,30 @@
 			compatible = "qcom,tcsr-msm8960", "syscon";
 			reg = <0x1a400000 0x100>;
 		};
+
+		gsbi at 16000000 {
+			compatible = "qcom,gsbi-v1.0.0";
+			cell-index = <1>;
+			reg = <0x16000000 0x100>;
+			clocks = <&gcc GSBI1_H_CLK>;
+			clock-names = "iface";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			spi at 16080000 {
+				compatible = "qcom,spi-qup-v1.1.1";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0x16080000 0x1000>;
+				interrupts = <0 147 0>;
+				spi-max-frequency = <24000000>;
+				cs-gpios = <&msmgpio 8 0>;
+
+				clocks = <&gcc GSBI1_QUP_CLK>, <&gcc GSBI1_H_CLK>;
+				clock-names = "core", "iface";
+				status = "disabled";
+			};
+		};
 	};
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
