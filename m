From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 30 Jul 2018 13:31:35 +0100
Subject: [PATCH v3 17/19] arm64: dts: allwinner: a64: NanoPi-A64: Add Ethernet
In-Reply-To: <20180730123137.923-1-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
Message-ID: <20180730123137.923-18-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NanoPi-A64 has the usual Realtek Gbit PHY connected to the EMAC,
so add the respective nodes to the DT. The PHY is powered by the
VDD_SYS_3.3V line, which is always on.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index 5caba225b4f7..1eba1324e5b9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -51,6 +51,7 @@
 	compatible = "friendlyarm,nanopi-a64", "allwinner,sun50i-a64";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -67,6 +68,15 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_dcdc1>;
+	status = "okay";
+};
+
 /* i2c1 connected with gpio headers like pine64, bananapi */
 &i2c1 {
 	pinctrl-names = "default";
@@ -78,6 +88,13 @@
 	bias-pull-up;
 };
 
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.14.4
