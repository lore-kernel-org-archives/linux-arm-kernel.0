From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sat, 24 Jan 2015 13:00:00 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <20150115142536.GC512@earth.universe>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150113204219.GJ2419@atomide.com> <20150115142536.GC512@earth.universe>
Message-ID: <201501241300.00723@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 January 2015 15:25:36 Sebastian Reichel wrote:
> On Tue, Jan 13, 2015 at 12:42:20PM -0800, Tony Lindgren wrote:
> > * Arnd Bergmann <arnd@arndb.de> [150113 12:27]:
> > > On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> > > > It seems we can now drop omap3517 legacy booting support
> > > > to get a bit closer to making all of omap3 boot in
> > > > device tree only mode.
> > > > 
> > > > All these boards have at least minimal support for
> > > > booting with device tree, and pretty much anything
> > > > supported with the legacy board files can be configured
> > > > also for device tree based booting if not done already.
> > > 
> > > Ah, very nice.
> > > 
> > > Just out of curiosity, what are the remaining showstoppers
> > > for the 3430 and 3530 based boards?
> > 
> > Not much really. We're now printing a warning to get a
> > people to upgrade their systems. So with some boards we
> > need to wait a while.
> > 
> > Then here are the remaining items that I'm aware of:
> > 
> > - A regression at least on some n900 with appended DTB not
> > booting
> > 
> >   properly any longer reported by Pali
> > 
> > - A regression where the legacy ATAGs don't seem to get
> > properly
> > 
> >   translated by the uncompress code for atag_rev at least
> >   reported by Pali
> > 
> > - A few missing .dts files for devkit8000, omap3logic,
> > omap3stalker,
> > 
> >   omap3pandora and omap3touchbook
> > 
> > Pali and Sebastian probably know best of any other remaining
> > issues to drop n900 legacy booting.
> 
> Apart from the bugs there is only one feature-wise regression
> when the system is booted via DT, which is the accelerometer.
> I will (re)send patches for that in the next days.
> 
> -- Sebastian

Another regression for DT setup (which does not occur for board code):

omap_hsmmc driver does not export slot_name sysfs entry because
it not supported by DT yet. Entry slot_name is used by userspace
application to determinate if mmc block device is internal eMMC
memory or external uSD card. So support for this property also in
DT is needed.

Here is simple patch which fix this problem:

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 8571027..31ca609 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -665,6 +665,7 @@
 };
 
 &mmc1 {
+	slot-name = "external";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&vmmc1>;
@@ -674,6 +675,7 @@
 
 /* most boards use vaux3, only some old versions use vmmc2 instead */
 &mmc2 {
+	slot-name = "internal";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
 	vmmc-supply = <&vaux3>;
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7c71dcd..cd189eb 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2021,6 +2021,8 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 
+	of_property_read_string(np, "slot-name", &pdata->name);
+
 	return pdata;
 }
 #else


With this patch identification works fine:

/ # cat /sys/block/mmcblk0/device/../slot_name 
external
/ # cat /sys/block/mmcblk1/device/../slot_name 
internal

Without patch omap_hsmmc driver does not create slot_name.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150124/e7a5459a/attachment.sig>
