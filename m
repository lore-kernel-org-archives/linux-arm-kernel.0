From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  7 Jun 2017 08:23:05 +0800
Subject: [PATCH 3/3] arm64: allwinner: h5: enable dwmac-sun8i for Nano Pi NEO2
In-Reply-To: <20170607002305.15897-1-icenowy@aosc.io>
References: <20170607002305.15897-1-icenowy@aosc.io>
Message-ID: <20170607002305.15897-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the required DT parts to enable Ethernet (dwmac-sun8i driver) on
the Nano Pi NEO2 board. It uses an external Realtek RTL8211E PHY
connected via RGMII to provide GbE network. Specially unlike other
Allwinner boards, the phy is connected to MDIO address 7, not 1.

This includes the regulator (which is controlled by a GPIO pin) and
the actual Ethernet MAC node, referring the RGMII pins of the device.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts   | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
index f2767b99c28a..968908761194 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo2.dts
@@ -50,6 +50,7 @@
 	compatible = "friendlyarm,nanopi-neo2", "allwinner,sun50i-h5";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -72,6 +73,16 @@
 		};
 	};
 
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
+	};
+
 	reg_vcc3v3: vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
@@ -98,6 +109,22 @@
 	status = "okay";
 };
 
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.12.2
