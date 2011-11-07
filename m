From: balbi@ti.com (Felipe Balbi)
Date: Mon, 7 Nov 2011 19:51:09 +0200
Subject: OMAP CRAP: The Continuing Story Of Brokenness
In-Reply-To: <20111107172600.GS31337@atomide.com>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk>
 <20111107172600.GS31337@atomide.com>
Message-ID: <20111107175108.GA3999@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 07, 2011 at 09:26:00AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 03:44]:
> > Yet again I find that I'm having to email about crap on OMAP3.
> > 
> > I'm getting really fed up with OMAP stuff which keeps breaking in
> > idiotic ways - and the way there's fatal build errors at EVERY merge
> > window.  The OMAP workflow is totally broken.  Something MUST change
> > in the way the OMAP community works to stop the continual breakage
> > at every single bloody merge window.
> 
> Hmm he following fixes are queued elsewhere and now merged:
> 
> omap_hsmmc: fix missing parenthesis in pr_info
> PM / OPP: Fix build when CONFIG_PM_OPP is not set 
> net: Add back alignment for size for __alloc_skb
> 
> Or have you seen some other build errors?
> 
> FYI, now all the compile warnings are finally gone with what
> I have in fixes branch.
>  
> > One is new:
> > 
> > WARNING: at arch/arm/mach-omap2/usb-musb.c:141 usb_musb_init+0xc0/0x174()
> > usb_musb_init: could not find omap_hwmod for usb_otg_hs
> > Modules linked in:
> > Backtrace:
> > [<c0017920>] (dump_backtrace+0x0/0x10c) from [<c02d9368>] (dump_stack+0x18/0x1c) r7:c181ff20 r6:c03ceb54 r5:c037545b r4:0000008d
> > [<c02d9350>] (dump_stack+0x0/0x1c) from [<c003adfc>] (warn_slowpath_common+0x58/0x70)
> > [<c003ada4>] (warn_slowpath_common+0x0/0x70) from [<c003aeb8>] (warn_slowpath_fmt+0x38/0x40)
> >  r8:00000000 r7:00000013 r6:c0374b05 r5:c03f06e4 r4:c0374190
> > [<c003ae80>] (warn_slowpath_fmt+0x0/0x40) from [<c03ceb54>] (usb_musb_init+0xc0/0x174)
> >  r3:c02df894 r2:c03707d9
> > [<c03cea94>] (usb_musb_init+0x0/0x174) from [<c03ce02c>] (omap_ldp_init+0xb0/0x100)
> >  r6:c003e7d8 r5:c03f06e4 r4:c04053e4
> > [<c03cdf7c>] (omap_ldp_init+0x0/0x100) from [<c03c6788>] (customize_machine+0x24/0x30)
> >  r4:c03f03a8
> > [<c03c6764>] (customize_machine+0x0/0x30) from [<c0008710>] (do_one_initcall+0x9c/0x164)
> > [<c0008674>] (do_one_initcall+0x0/0x164) from [<c03c3284>] (kernel_init+0x7c/0x120)
> > [<c03c3208>] (kernel_init+0x0/0x120) from [<c003e7d8>] (do_exit+0x0/0x62c)
> >  r5:c03c3208 r4:00000000
> 
> Felipe, care to check what the status of the musb hwmod issue
> above is?

doesn't seem to be a bug on usb-musb.c, looking at
omap_hwmod_3xxx_data.c:

$ git grep -A 1 -e "static struct omap_hwmod \w\+usbhsotg_hwmod = {"\
	arch/arm/mach-omap2/omap_hwmod*data.c
arch/arm/mach-omap2/omap_hwmod_2430_data.c:static struct omap_hwmod omap2430_usbhsotg_hwmod = {
arch/arm/mach-omap2/omap_hwmod_2430_data.c-     .name           = "usb_otg_hs",
--
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:static struct omap_hwmod omap3xxx_usbhsotg_hwmod = {
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c-     .name           = "usb_otg_hs",
--
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c:static struct omap_hwmod am35xx_usbhsotg_hwmod = {
arch/arm/mach-omap2/omap_hwmod_3xxx_data.c-     .name           = "am35x_otg_hs",

in fact, that part of the code hasn't changed during this merge window:

$ git log v3.1..linus/master -- arch/arm/mach-omap2/usb-musb.c

commit f718e2c034bf6ff872106344935006230764cb12
Author: Benoit Cousson <b-cousson@ti.com>
Date:   Wed Aug 10 15:30:09 2011 +0200

    ARM: OMAP2+: devices: Remove all omap_device_pm_latency structures
    
    Remove all these duplicated structures since a default one is now
    available.
    
    Signed-off-by: Benoit Cousson <b-cousson@ti.com>
    Signed-off-by: Kevin Hilman <khilman@ti.com>

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index d86af3c..47fb5d6 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -60,14 +60,6 @@ static struct musb_hdrc_platform_data musb_plat = {
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
-static struct omap_device_pm_latency omap_musb_latency[] = {
-	{
-		.deactivate_func	= omap_device_idle_hwmods,
-		.activate_func		= omap_device_enable_hwmods,
-		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
-	},
-};
-
 static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
 {
 	switch (board_data->interface_type) {
@@ -150,8 +142,7 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
                 return;
 
 	pdev = omap_device_build(name, bus_id, oh, &musb_plat,
-			       sizeof(musb_plat), omap_musb_latency,
-			       ARRAY_SIZE(omap_musb_latency), false);
+			       sizeof(musb_plat), NULL, 0, false);
 	if (IS_ERR(pdev)) {
 		pr_err("Could not build omap_device for %s %s\n",
 						name, oh_name);

commit c541c15fb5ab48c47bc9b90121538fd30d152f23
Merge: 5c30cdf be73246 7d33910 ab4eb8b dc9ca24
Author: Tony Lindgren <tony@atomide.com>
Date:   Tue Oct 4 09:47:06 2011 -0700

    Merge branches 'cleanup-part3', 'voltage', 'dmtimer' and 'l3' into dt-base

could the below be the bug ?

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3008e16..74f1454 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3232,7 +3232,6 @@ static __initdata struct omap_hwmod *omap3430es1_hwmods[] = {
 /* 3430ES2+-only hwmods */
 static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
 	&omap3xxx_dss_core_hwmod,
-	&omap3xxx_usbhsotg_hwmod,
 	NULL
 };
 
@@ -3240,6 +3239,7 @@ static __initdata struct omap_hwmod *omap3430es2plus_hwmods[] = {
 static __initdata struct omap_hwmod *omap34xx_hwmods[] = {
 	&omap34xx_sr1_hwmod,
 	&omap34xx_sr2_hwmod,
+	&omap3xxx_usbhsotg_hwmod,
 	NULL
 };
 

clearly commit d6504acd (OMAP2+: hwmod: remove OMAP_CHIP*) is wrong at
thinking MUSB is only available on ES2+ revisions of OMAP3430.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111107/945e23bf/attachment.sig>
