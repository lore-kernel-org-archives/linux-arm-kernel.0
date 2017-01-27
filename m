From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 16:47:26 -0800
Subject: [PATCH 3/5] ARM: dts: qcom-msm8974: Add HS usb node and OTG detection
 mechanisms
In-Reply-To: <20170127004728.22490-1-stephen.boyd@linaro.org>
References: <20170127004728.22490-1-stephen.boyd@linaro.org>
Message-ID: <20170127004728.22490-4-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This USB controller has two phys, so add them both underneath the
ULPI bus, but only enable one of them based on the board
configuration. To get OTG to work, we need to add the id and vbus
detection info and also populate the regulators for the vbus
supply.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts | 20 +++++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi            | 49 ++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi             | 32 ++++++++++++++++-
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
index e9ee6dbf81fb..42a95a086c0f 100644
--- a/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8074-dragonboard.dts
@@ -57,6 +57,26 @@
 			};
 		};
 
+		usb at f9a55000 {
+			status = "ok";
+			phys = <&usb_hs2_phy>;
+			phy-select = <&tcsr 0xb000 1>;
+			extcon = <&smbb>, <&usb_id>;
+			vbus-supply = <&chg_otg>;
+			hnp-disable;
+			srp-disable;
+			adp-disable;
+			ulpi {
+				phy at b {
+					status = "ok";
+					v3p3-supply = <&pm8941_l24>;
+					v1p8-supply = <&pm8941_l6>;
+					extcon = <&smbb>;
+					qcom,init-seq = /bits/ 8 <0x1 0x63>;
+				};
+			};
+		};
+
 		pinctrl at fd510000 {
 			i2c11_pins: i2c11 {
 				mux {
diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 6c167c031368..c714c673ea0c 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -511,6 +511,11 @@
 			reg = <0xfc400000 0x4000>;
 		};
 
+		tcsr: syscon at fd4a0000 {
+			compatible = "syscon";
+			reg = <0xfd4a0000 0x10000>;
+		};
+
 		tcsr_mutex_block: syscon at fd484000 {
 			compatible = "syscon";
 			reg = <0xfd484000 0x2000>;
@@ -618,6 +623,50 @@
 			};
 		};
 
+		otg: usb at f9a55000 {
+			compatible = "qcom,ci-hdrc";
+			reg = <0xf9a55000 0x200>,
+			      <0xf9a55200 0x200>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
+				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
+			clock-names = "iface", "core";
+			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
+			assigned-clock-rates = <75000000>;
+			resets = <&gcc GCC_USB_HS_BCR>;
+			reset-names = "core";
+			phy_type = "ulpi";
+			dr_mode = "otg";
+			ahb-burst-config = <0>;
+			phy-names = "usb-phy";
+			status = "disabled";
+			#reset-cells = <1>;
+
+			ulpi {
+				usb_hs1_phy: phy at a {
+					compatible = "qcom,usb-hs-phy-msm8974",
+						     "qcom,usb-hs-phy";
+					#phy-cells = <0>;
+					clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+					clock-names = "ref", "sleep";
+					resets = <&gcc GCC_USB2A_PHY_BCR>, <&otg 0>;
+					reset-names = "phy", "por";
+					status = "disabled";
+				};
+
+				usb_hs2_phy: phy at b {
+					compatible = "qcom,usb-hs-phy-msm8974",
+						     "qcom,usb-hs-phy";
+					#phy-cells = <0>;
+					clocks = <&xo_board>, <&gcc GCC_USB2B_PHY_SLEEP_CLK>;
+					clock-names = "ref", "sleep";
+					resets = <&gcc GCC_USB2B_PHY_BCR>, <&otg 1>;
+					reset-names = "phy", "por";
+					status = "disabled";
+				};
+			};
+		};
+
 		rng at f9bff000 {
 			compatible = "qcom,prng";
 			reg = <0xf9bff000 0x200>;
diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi b/arch/arm/boot/dts/qcom-pm8941.dtsi
index 6b16b296f0fa..3fc9f34f45bb 100644
--- a/arch/arm/boot/dts/qcom-pm8941.dtsi
+++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
@@ -26,7 +26,14 @@
 			bias-pull-up;
 		};
 
-		charger at 1000 {
+		usb_id: misc at 900 {
+			compatible = "qcom,pm8941-misc";
+			reg = <0x900>;
+			interrupts = <0x0 0x9 0 IRQ_TYPE_EDGE_BOTH>;
+			interrupt-names = "usb_id";
+		};
+
+		smbb: charger at 1000 {
 			compatible = "qcom,pm8941-charger";
 			reg = <0x1000>;
 			interrupts = <0x0 0x10 7 IRQ_TYPE_EDGE_BOTH>,
@@ -175,5 +182,28 @@
 
 			status = "disabled";
 		};
+
+		regulators {
+			compatible = "qcom,pm8941-regulators";
+			interrupts = <0x1 0x83 0x2 0>, <0x1 0x84 0x2 0>;
+			interrupt-names = "ocp-5vs1", "ocp-5vs2";
+			vin_5vs-supply = <&pm8941_5v>;
+
+			pm8941_5v: s4 {
+				regulator-min-microvolt = <5000000>;
+				regulator-max-microvolt = <5000000>;
+				regulator-enable-ramp-delay = <500>;
+			};
+
+			pm8941_5vs1: 5vs1 {
+				regulator-enable-ramp-delay = <1000>;
+				regulator-pull-down;
+				regulator-over-current-protection;
+				qcom,ocp-max-retries = <10>;
+				qcom,ocp-retry-delay = <30>;
+				qcom,vs-soft-start-strength = <0>;
+				regulator-initial-mode = <1>;
+			};
+		};
 	};
 };
-- 
2.10.0.297.gf6727b0
