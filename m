From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 20 Feb 2015 01:44:35 +0100
Subject: [PATCH v4 0/3] add support for Firefly-RK3288 and Rayeager PX2
 boards
In-Reply-To: <2137926.nqOiED5bzz@diego>
References: <1422189576-19478-1-git-send-email-naobsd@gmail.com>
 <2137926.nqOiED5bzz@diego>
Message-ID: <142441781.gJtRx3FmLT@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. Januar 2015, 02:22:55 schrieb Heiko St?bner:
> Am Sonntag, 25. Januar 2015, 21:39:33 schrieb FUKAUMI Naoki:
> > This series adds support for following Rockchip SoC based boards.
> > 
> >  - Firefly, Firefly-RK3288 (both beta and mass production version)
> >  - ChipSPARK, Rayeager PX2
> 
> I've applied this series with Andy's Tested-by for the Rayeager board and my
> Tested-by for the Firefly.
> 
> One caveat, I had to remove the gmac node from the firefly dtsi, as the
> whole gmac series goes through the network tree, so the dtb won't compile
> either in my tree or arm-soc due to the missing core node.
> 
> I'll try to see if I can get the separate gmac node in when everything is
> combined in 3.20-rc1.

I've added the missing gmac config now to my dts-branch for 3.21 (or
whatever it might get called), with the following patch:

----------- 8< ------------
From: Heiko Stuebner <heiko@sntech.de>
Date: Fri, 20 Feb 2015 01:31:57 +0100
Subject: [PATCH] ARM: dts: rockchip: enable gmac on rk3288-firefly

This was left out of the original firefly board definition due to the
ethernet support going completely through the network tree, making the
underlying nodes unavailable.

Now that everything is present enable the gmac on the firefly.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index b9dda41..b54dd78 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -179,6 +179,22 @@
 	status = "okay";
 };
 
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC>;
+	assigned-clock-parents = <&ext_gmac>;
+	clock_in_out = "input";
+	pinctrl-names = "default";
+	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
+	phy-supply = <&vcc_lan>;
+	phy-mode = "rgmii";
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 10000 1000000>;
+	snps,reset-gpio = <&gpio4 8 GPIO_ACTIVE_LOW>;
+	tx_delay = <0x30>;
+	rx_delay = <0x10>;
+	status = "ok";
+};
+
 &hdmi {
 	ddc-i2c-bus = <&i2c5>;
 	status = "okay";
-- 
2.1.4
