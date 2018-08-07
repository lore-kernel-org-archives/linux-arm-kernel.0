From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 07 Aug 2018 15:19:33 +0800
Subject: [PATCH] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet
 support
In-Reply-To: <20180807071839.25305-1-jagan@amarulasolutions.com>
References: <20180807071839.25305-1-jagan@amarulasolutions.com>
Message-ID: <2D1B8773-0019-458A-8C7E-20077AA27AD4@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?8?7? GMT+08:00 ??3:18:39, Jagan Teki <jagan@amarulasolutions.com> ??:
>Add Ethernet support for orangepi-one-plus board,
>- Ethernet port connected via RTL8211E PHY
>- GMAC_EN is connected via PD6
>- GMAC-3V supplied from ALDO2 regulator

Is the prequisite patchset merged?

>
>Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>---
> .../allwinner/sun50i-h6-orangepi-one-plus.dts | 29 +++++++++++++++++++
> 1 file changed, 29 insertions(+)
>
>diff --git
>a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>index 0612c19cd994..eca5b7ea0d6d 100644
>--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>@@ -21,6 +21,35 @@
> 	chosen {
> 		stdout-path = "serial0:115200n8";
> 	};
>+
>+	reg_gmac_3v3: gmac-3v3 {
>+		compatible = "regulator-fixed";
>+		regulator-name = "vcc-gmac-3v3";
>+		regulator-min-microvolt = <3300000>;
>+		regulator-max-microvolt = <3300000>;
>+		startup-delay-us = <100000>;
>+		enable-active-high;
>+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
>+		vin-supply = <&reg_aldo2>;
>+	};
>+};
>+
>+&emac {
>+	pinctrl-names = "default";
>+	pinctrl-0 = <&ext_rgmii_pins>;
>+	phy-mode = "rgmii";
>+	phy-handle = <&ext_rgmii_phy>;
>+	phy-supply = <&reg_gmac_3v3>;
>+	allwinner,rx-delay-ps = <200>;
>+	allwinner,tx-delay-ps = <200>;
>+	status = "okay";
>+};
>+
>+&mdio {
>+	ext_rgmii_phy: ethernet-phy at 1 {
>+		compatible = "ethernet-phy-ieee802.3-c22";
>+		reg = <1>;
>+	};
> };
> 
> &mmc0 {
