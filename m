From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 30 Sep 2014 15:10:27 +0100
Subject: [PATCH v2 4/4] ARM: dts: apq8064: Add SATA controller support.
In-Reply-To: <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1412086159-20894-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1412086227-21071-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds AHCI based SATA controller support to APQ8064.
Tested on IFC6410 board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |  8 +++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 36 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index f221e9e..446dab9 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -40,6 +40,14 @@
 			};
 		};
 
+		sata_phy0: sata-phy at 1b400000{
+			status = "okay";
+		};
+
+		sata0: sata at 29000000 {
+			status = "okay";
+		};
+
 		/* OTG */
 		usb1_phy: phy at 12500000 {
 			status = "okay";
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index 28643fb..44b6a0a 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -634,6 +634,42 @@
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
+				 	  	<&gcc SATA_A_CLK>,
+						<&gcc SATA_RXOOB_CLK>,
+						<&gcc SATA_PMALIVE_CLK>;
+			clock-names 		= "slave_iface",
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
+			target-supply		= <&pm8921_s4>;
+		};
+
 		/* Temporary fixed regulator */
 		vsdcc_fixed: vsdcc-regulator {
 			compatible = "regulator-fixed";
-- 
1.9.1
