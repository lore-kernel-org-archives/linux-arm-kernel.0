From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 29 Sep 2014 10:15:34 +0100
Subject: [PATCH 4/4] ARM: DT: apq8064: Add SATA controller support.
In-Reply-To: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1411982134-8090-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds AHCI based SATA controller support to APQ8064.
Tested on IFC6410 board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 38d3efa..fa057b7 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -274,6 +274,17 @@
 				regulator-always-on;
 			};
 
+			pm8921_s4: pm8921-s4 {
+				compatible	= "qcom,rpm-pm8921-smps";
+				reg		= <QCOM_RPM_PM8921_SMPS4>;
+
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				qcom,boot-load 		= <200000>;
+				qcom,switch-mode-frequency = <3200000>;
+				regulator-always-on;
+			};
+
 			pm8921_l3: pm8921-l3 {
 				compatible	= "qcom,rpm-pm8921-pldo";
 				reg		= <QCOM_RPM_PM8921_LDO3>;
@@ -396,6 +407,35 @@
 			usb-phy		= <&usb4_phy>;
 		};
 
+		sata_phy0:sata-phy at 1b400000{
+			compatible	= "qcom,apq8064-sata-phy";
+			reg		= <0x1b400000 0x200>;
+			reg-names	= "phy_mem";
+			clocks		= <&gcc SATA_PHY_CFG_CLK>;
+			clock-names = "cfg";
+			#phy-cells = <0>;
+		};
+
+		sata0: sata at 29000000 {
+			compatible	= "generic-ahci";
+			reg		= <0x29000000 0x180>;
+			interrupts	= <0 209 0>;
+			clocks = <&gcc SFAB_SATA_S_H_CLK>, <&gcc SATA_H_CLK>,
+				 <&gcc SATA_A_CLK>, <&gcc SATA_RXOOB_CLK>,
+				 <&gcc SATA_PMALIVE_CLK>;
+
+			clock-names = "slave_iface", "iface",
+				      "bus", "rxoob",
+				      "core_pmalive";
+			assigned-clocks = <&gcc SATA_RXOOB_CLK>,
+						<&gcc SATA_PMALIVE_CLK>;
+			assigned-clock-rates = <100000000>, <100000000>;
+
+			phys  = <&sata_phy0>;
+			phy-names = "sata-phy";
+			target-supply = <&pm8921_s4>;
+		};
+
 		/* Temporary fixed regulator */
 		vsdcc_fixed: vsdcc-regulator {
 			compatible = "regulator-fixed";
-- 
1.9.1
