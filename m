From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Oct 2013 18:22:07 +0800
Subject: [PATCH] pinctrl: phandle entries will be applied sequentially
In-Reply-To: <20131010100840.GP25034@n2100.arm.linux.org.uk>
References: <1381297324-19006-1-git-send-email-shawn.guo@linaro.org>
 <CACRpkdazPK6SNg9PdWCrjB8nwho1rCueumJWAN=STXdN1zNnMA@mail.gmail.com>
 <20131010072624.GA29191@S2101-09.ap.freescale.net>
 <20131010100840.GP25034@n2100.arm.linux.org.uk>
Message-ID: <20131010102205.GD29191@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 11:08:40AM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 10, 2013 at 03:26:26PM +0800, Shawn Guo wrote:
> > However, my patch is talking about a different thing.  For example, we
> > have a device whose pinctrl-0 consists of two phandle entries that point
> > to pin configuration nodes foo and bar.
> > 
> > 	pinctrl-0 = <&foo &bar>;
> > 
> > 	foo {
> > 		...
> > 	};
> > 
> > 	bar {
> > 		...
> > 	};
> > 
> > My patch only wants to make it clear that the configuration specified by
> > node foo will be applied to pin controller first, and the configuration
> > defined in node bar will be applied after that.  When both nodes have
> > configuration for a pin, these two configs for the same pin go to two
> > different pinctrl_setting structures.  And these two pinctrl_settings
> > can not be applied accumulatedly but only sequentially.  That's what my
> > patch talks about.
> 
> I still say this is a potentially dangerous thing, and in my case of
> overriding the DAT3 pull-sense, it will cause the pin to glitch if
> nothing is connected to it.
> 
> So even if you do get this clarified, I am *not* happy to change my
> patch.

What about the solution suggested by Stephen, moving
MX6QDL_PAD_SD1_DAT3__SD1_DATA3 out from pinctrl_usdhc1_1 and having
additional nodes/phandle for DAT3 with different settings?

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 59154dc..fd52f4e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1157,7 +1157,6 @@
                                                        MX6QDL_PAD_SD1_DAT0__SD1_DATA0 0x17059
                                                        MX6QDL_PAD_SD1_DAT1__SD1_DATA1 0x17059
                                                        MX6QDL_PAD_SD1_DAT2__SD1_DATA2 0x17059
-                                                       MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
                                                        MX6QDL_PAD_NANDF_D0__SD1_DATA4 0x17059
                                                        MX6QDL_PAD_NANDF_D1__SD1_DATA5 0x17059
                                                        MX6QDL_PAD_NANDF_D2__SD1_DATA6 0x17059
@@ -1165,6 +1164,18 @@
                                                >;
                                        };

+                                       pinctrl_usdhc1_1_dat3: usdhc1dat3-1 {
+                                               fsl,pins = <
+                                                       MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x17059
+                                               >;
+                                       };
+
+                                       pinctrl_usdhc1_1_dat3cd: usdhc1dat3cd-1 {
+                                               fsl,pins = <
+                                                       MX6QDL_PAD_SD1_DAT3__SD1_DATA3 0x13059
+                                               >;
+                                       };

Then pinctrl-0 = <&pinctrl_usdhc1_1 &pinctrl_usdhc1_1_dat3> for existing
boards, and <&pinctrl_usdhc1_1 &pinctrl_usdhc1_1_dat3cd> for boards that
want to use DAT3 for card detection.

Shawn
