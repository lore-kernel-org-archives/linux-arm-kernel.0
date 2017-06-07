From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  7 Jun 2017 08:23:04 +0800
Subject: [PATCH 2/3] arm64: allwinner: h5: enable dwmac-sun8i for Orange Pi
 Prime
In-Reply-To: <20170607002305.15897-1-icenowy@aosc.io>
References: <20170607002305.15897-1-icenowy@aosc.io>
Message-ID: <20170607002305.15897-2-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the required DT parts to enable Ethernet (dwmac-sun8i driver) on
the Orange Pi Prime board. It uses an external Realtek RTL8211E PHY
connected via RGMII to provide GbE network.

This includes the regulator (which is controlled by a GPIO pin) and
the actual Ethernet MAC node, referring the RGMII pins of the device.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../dts/allwinner/sun50i-h5-orangepi-prime.dts     | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
index 097c33386190..d906b302cbcd 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-prime.dts
@@ -54,6 +54,7 @@
 	compatible = "xunlong,orangepi-prime", "allwinner,sun50i-h5";
 
 	aliases {
+		ethernet0 = &emac;
 		serial0 = &uart0;
 	};
 
@@ -86,6 +87,16 @@
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
@@ -133,12 +144,28 @@
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
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
 	status = "okay";
 };
 
+&mdio {
+	ext_rgmii_phy: ethernet-phy at 1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.12.2
