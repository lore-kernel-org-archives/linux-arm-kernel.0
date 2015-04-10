From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Apr 2015 13:34:23 +0100
Subject: [PATCH v2 05/12] ARM: dts: apq8064: Add SATA controller support.
In-Reply-To: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1428669187-10775-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1428669263-10990-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds AHCI based SATA controller support to APQ8064.
Tested on IFC6410 board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts |  9 ++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi        | 35 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
index 122bf34..c9c9c5e 100644
--- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
@@ -116,6 +116,15 @@
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
index 5aac9a5..56cc65e 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -379,6 +379,41 @@
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
+			interrupts		= <GIC_SPI 209 IRQ_TYPE_NONE>;
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
