From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  3 Nov 2018 20:32:38 +0800
Subject: [PATCH v2 3/3] arm64: allwinner: h6: add support for the Ethernet on
 Pine H64
In-Reply-To: <20181103123238.4665-1-icenowy@aosc.io>
References: <20181103123238.4665-1-icenowy@aosc.io>
Message-ID: <20181103123238.4665-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine H64 board has an Ethernet port, which is connected to a
RTL8211E PHY, then the PHY is connected to the MAC on H6 SoC.

Add support for the Ethernet port.

The PHY needs some time to start up, and the time is modelled as enable
ramp delay of the regulator.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Adapted the decision by Pine64 on the final version of Pine H64 (the
  current scheme on model B's).

 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 48daec7f78ba..fcf3c1de4aa2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -14,6 +14,7 @@
 	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -41,6 +42,24 @@
 	};
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_aldo2>;
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
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -85,6 +104,7 @@
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vcc-ac200";
+				regulator-enable-ramp-delay = <100000>;
 			};
 
 			reg_aldo3: aldo3 {
-- 
2.18.1
