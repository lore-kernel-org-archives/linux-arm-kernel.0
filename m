From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 23 Feb 2015 07:55:17 +0000
Subject: [PATCH 04/12] ARM: dts: apq8064: Add SATA controller support.
In-Reply-To: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <424678035-12862-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1424678117-13094-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds AHCI based SATA controller support to APQ8064.
Tested on IFC6410 board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 15 +++++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 35 ++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 1723cdf..3164197 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -56,6 +56,12 @@
 				qcom,switch-mode-frequency	= <4800000>;
 			};
 
+			pm8921_s4: pm8921-s4 {
+				regulator-min-microvolt		= <1800000>;
+				regulator-max-microvolt		= <1800000>;
+				qcom,switch-mode-frequency	= <3200000>;
+			};
+
 			pm8921_l3: pm8921-l3 {
 				regulator-min-microvolt = <3050000>;
 				regulator-max-microvolt = <3300000>;
@@ -72,6 +78,15 @@
 			};
 		};
 
+		sata_phy0: sata-phy at 1b400000{
+			status = "okay";
+		};
+
+		sata0: sata at 29000000 {
+			status		= "okay";
+			target-supply	= <&pm8921_s4>;
+		};
+
 		/* OTG */
 		usb1_phy: phy at 12500000 {
 			status		= "okay";
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index c251c72..e65aff0 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -566,6 +566,41 @@
 			usb-phy		= <&usb4_phy>;
 		};
 
+		sata_phy0: sata-phy at 1b400000{
+			compatible	= "qcom,apq8064-sata-phy";
+			status		= "disabled";
+			reg		= <0x1b400000 0x200>;
+			reg-names	= "phy_mem";
+			clocks		= <&gcc SATA_PHY_CFG_CLK>;
+			clock-names	= "cfg";
+			#phy-cells	= <0>;
+		};
+
+		sata0: sata at 29000000 {
+			compatible		= "generic-ahci";
+			status			= "disabled";
+			reg			= <0x29000000 0x180>;
+			interrupts		= <0 209 0>;
+
+			clocks			= <&gcc SFAB_SATA_S_H_CLK>,
+						<&gcc SATA_H_CLK>,
+						<&gcc SATA_A_CLK>,
+						<&gcc SATA_RXOOB_CLK>,
+						<&gcc SATA_PMALIVE_CLK>;
+			clock-names		= "slave_iface",
+						"iface",
+						"bus",
+						"rxoob",
+						"core_pmalive";
+
+			assigned-clocks		= <&gcc SATA_RXOOB_CLK>,
+						<&gcc SATA_PMALIVE_CLK>;
+			assigned-clock-rates	= <100000000>, <100000000>;
+
+			phys			= <&sata_phy0>;
+			phy-names		= "sata-phy";
+		};
+
 		/* Temporary fixed regulator */
 		vsdcc_fixed: vsdcc-regulator {
 			compatible = "regulator-fixed";
-- 
1.9.1
