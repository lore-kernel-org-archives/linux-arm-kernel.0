From: stanimir.varbanov@linaro.org (Stanimir Varbanov)
Date: Thu,  3 Dec 2015 15:35:24 +0200
Subject: [PATCH v4 5/5] ARM: dts: ifc6410: enable pcie dt node for this board
In-Reply-To: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
References: <1449149725-27607-1-git-send-email-stanimir.varbanov@linaro.org>
Message-ID: <1449149725-27607-6-git-send-email-stanimir.varbanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable pcie dt node and fill pcie dt node with regulator, pinctrl
and reset gpio, to use the pcie on the ifc6410 board.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 11ac608b6d50..f203b94ee460 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -47,6 +47,18 @@
 					bias-disable;
 				};
 			};
+
+			pcie_pins: pcie_pinmux {
+				mux {
+					pins = "gpio27";
+					function = "gpio";
+				};
+				conf {
+					pins = "gpio27";
+					drive-strength = <12>;
+					bias-disable;
+				};
+			};
 		};
 
 		rpm at 108000 {
@@ -123,6 +135,10 @@
 				pm8921_lvs1: lvs1 {
 					bias-pull-down;
 				};
+
+				pm8921_lvs6: lvs6 {
+					bias-pull-down;
+				};
 			};
 		};
 
@@ -231,6 +247,16 @@
 			status = "okay";
 		};
 
+		pci at 1b500000 {
+			status = "ok";
+			vdda-supply = <&pm8921_s3>;
+			vdda_phy-supply = <&pm8921_lvs6>;
+			vdda_refclk-supply = <&ext_3p3v>;
+			pinctrl-0 = <&pcie_pins>;
+			pinctrl-names = "default";
+			perst-gpio = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
+		};
+
 		qcom,ssbi at 500000 {
 			pmic at 0 {
 				gpio at 150 {
-- 
1.7.9.5
