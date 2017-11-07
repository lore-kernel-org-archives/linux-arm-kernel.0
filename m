From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue,  7 Nov 2017 21:13:26 +0100
Subject: [PATCH 2/2] ARM: sun8i: bananapi-m3: Enable dwmac-sun8i
In-Reply-To: <20171107201326.17401-1-clabbe.montjoie@gmail.com>
References: <20171107201326.17401-1-clabbe.montjoie@gmail.com>
Message-ID: <20171107201326.17401-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dwmac-sun8i hardware is present on the bananapi m3
It uses an external PHY rtl8211e via RGMII.

This patch create the needed emac and phy nodes.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index c606af3dbfed..45bdd5c17829 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -52,6 +52,7 @@
 	compatible = "sinovoip,bpi-m3", "allwinner,sun8i-a83t";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -88,6 +89,23 @@
 	/* TODO GL830 USB-to-SATA bridge downstream w/ GPIO power controls */
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+	allwinner,rx-delay-ps = <700>;
+	allwinner,tx-delay-ps = <700>;
+
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-- 
2.13.6
