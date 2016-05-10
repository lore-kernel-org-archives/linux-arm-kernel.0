From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 May 2016 15:45:59 -0700
Subject: [PATCH 2/2] ARM: dts: qcom: Enable sdcard and emmc on apq8074
 dragonboard
In-Reply-To: <20160510224559.17568-1-sboyd@codeaurora.org>
References: <20160510224559.17568-1-sboyd@codeaurora.org>
Message-ID: <20160510224559.17568-2-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the sdcard slot and wire up the regulators for the two
storage controllers found on the apq8074 dragonboard.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index 8d1011d289bc..ad51df27dfb7 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -25,11 +25,23 @@
 			bus-width = <8>;
 			non-removable;
 			status = "ok";
+
+			vmmc-supply = <&pm8941_l20>;
+			vqmmc-supply = <&pm8941_s3>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdhc1_pin_a>;
 		};
 
 		sdhci at f98a4900 {
 			cd-gpios = <&msmgpio 62 0x1>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&sdhc2_pin_a>, <&sdhc2_cd_pin_a>;
 			bus-width = <4>;
+			status = "ok";
+
+			vmmc-supply = <&pm8941_l21>;
+			vqmmc-supply = <&pm8941_l13>;
 		};
 
 
@@ -59,6 +71,42 @@
 					function = "blsp_spi8";
 				};
 			};
+
+			sdhc1_pin_a: sdhc1-pin-active {
+				clk {
+					pins = "sdc1_clk";
+					drive-strength = <16>;
+					bias-disable;
+				};
+
+				cmd-data {
+					pins = "sdc1_cmd", "sdc1_data";
+					drive-strength = <10>;
+					bias-pull-up;
+				};
+			};
+
+			sdhc2_cd_pin_a: sdhc2-cd-pin-active {
+				pins = "gpio62";
+				function = "gpio";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			sdhc2_pin_a: sdhc2-pin-active {
+				clk {
+					pins = "sdc2_clk";
+					drive-strength = <10>;
+					bias-disable;
+				};
+
+				cmd-data {
+					pins = "sdc2_cmd", "sdc2_data";
+					drive-strength = <6>;
+					bias-pull-up;
+				};
+			};
 		};
 
 		i2c at f9967000 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
