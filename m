From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue,  7 Aug 2018 12:48:39 +0530
Subject: [PATCH] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet support
Message-ID: <20180807071839.25305-1-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Ethernet support for orangepi-one-plus board,
- Ethernet port connected via RTL8211E PHY
- GMAC_EN is connected via PD6
- GMAC-3V supplied from ALDO2 regulator

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../allwinner/sun50i-h6-orangepi-one-plus.dts | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 0612c19cd994..eca5b7ea0d6d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -21,6 +21,35 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+		vin-supply = <&reg_aldo2>;
+	};
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_gmac_3v3>;
+	allwinner,rx-delay-ps = <200>;
+	allwinner,tx-delay-ps = <200>;
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
 };
 
 &mmc0 {
-- 
2.18.0.321.gffc6fa0e3
