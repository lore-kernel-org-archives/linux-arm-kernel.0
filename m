From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 May 2016 11:46:09 -0700
Subject: [PATCH] ARM: dts: omap5-igep0050: Correct hdmi regulator
In-Reply-To: <572A38FD.9050801@ti.com>
References: <1461925297-9734-1-git-send-email-peter.ujfalusi@ti.com>
 <6ee9d67a-e907-715a-f3f5-d90a470314c3@ti.com>
 <20160504172634.GS5995@atomide.com> <572A38FD.9050801@ti.com>
Message-ID: <20160505184609.GB5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [160504 11:03]:
> On 05/04/2016 12:26 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > Adding Nishanth to Cc.
> > 
> > * Peter Ujfalusi <peter.ujfalusi@ti.com> [160429 05:15]:
> >> ldo7_reg, obviously ;)
> >>
> >>> 	status = "okay";
> >>> 	regulator-min-microvolt = <1800000>;
> >>> 	regulator-max-microvolt = <1800000>;
> >>> };
> > 
> > It really seems to be ldo7, otherwise there's no HDMI output. I don't
> > have the schematics either.
> > 
> > But it seems we have at least two other regressions in Linux next that
> > prevent me from testing this properly:
> > 
> > 1. On igepv5, I get this for the MMC regulator
> > 
> > ldo9: bypassed regulator has no supply!
> > ldo9: failed to get the current voltage(-517)
> > palmas-pmic 48070000.i2c:palmas at 48:palmas_pmic: failed to register 48070000.i2c:palmar

The patch I posted fixes this. Then for the HDMI see below.
I've kept it at 2V like we have in omap5-board-common.dtsi,
I wonder if it really should be 1.8V though for ldo7 in this
case?

Regards,

Tony
8< -----------------
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 5 May 2016 11:29:23 -0700
Subject: [PATCH] ARM: dts: Fix ldo7 source for HDMI on igepv5

Fix ldo7 source for HDMI on igepv5.

Suggested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/omap5-igep0050.dts b/arch/arm/boot/dts/omap5-igep0050.dts
index 46ecb1d..72ff6a4 100644
--- a/arch/arm/boot/dts/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/omap5-igep0050.dts
@@ -35,6 +35,12 @@
 	};
 };
 
+&ldo7_reg {
+	status = "okay";
+	regulator-min-microvolt = <2000000>;
+	regulator-max-microvolt = <2000000>;
+};
+
 &omap5_pmx_core {
 	i2c4_pins: pinmux_i2c4_pins {
 		pinctrl-single,pins = <
