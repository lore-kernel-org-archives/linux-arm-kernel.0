From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Nov 2011 09:56:45 -0800
Subject: OMAP CRAP: The Continuing Story Of Brokenness
In-Reply-To: <20111107174645.GE15294@n2100.arm.linux.org.uk>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk>
 <20111107172600.GS31337@atomide.com>
 <20111107174645.GE15294@n2100.arm.linux.org.uk>
Message-ID: <20111107175645.GU31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111107 09:12]:
> On Mon, Nov 07, 2011 at 09:26:00AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 03:44]:
> > > Yet again I find that I'm having to email about crap on OMAP3.
> > > 
> > > I'm getting really fed up with OMAP stuff which keeps breaking in
> > > idiotic ways - and the way there's fatal build errors at EVERY merge
> > > window.  The OMAP workflow is totally broken.  Something MUST change
> > > in the way the OMAP community works to stop the continual breakage
> > > at every single bloody merge window.
> > 
> > Hmm he following fixes are queued elsewhere and now merged:
> > 
> > omap_hsmmc: fix missing parenthesis in pr_info
> > PM / OPP: Fix build when CONFIG_PM_OPP is not set 
> > net: Add back alignment for size for __alloc_skb
> > 
> > Or have you seen some other build errors?
> > 
> > FYI, now all the compile warnings are finally gone with what
> > I have in fixes branch.
> 
> It was the errors in the "ARM: OMAP: Fix build for OMAP3 only builds"
> thread.

OK, that's queued up.
 
> However, rebuilding today gives brand new breakage - for my OMAP4430SDP
> config.  This seems to be because more linux/module.h includes have been
> deleted from include/linux/*.h includes.
> 
> arch/arm/plat-omap/dmtimer.c:184: warning: data definition has no type or storage class
...

Got a fix for that one queued up too.

 
> In addition, for OMAP3430 LDP:
> 
> arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
> arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
> arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration

Looks like there's a fix for this one posted, will add that.

> arch/arm/mach-omap2/mailbox.c:417: error: expected declaration specifiers or '...' before string constant
> arch/arm/mach-omap2/mailbox.c:417: warning: data definition has no type or storage class
> arch/arm/mach-omap2/mailbox.c:417: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
...

> drivers/video/omap/dispc.c:276: warning: data definition has no type or storage class
> drivers/video/omap/dispc.c:276: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'

Yeah after pulling in the current mainline I see at least the above
two need to be patched.

 
> It might be an idea to do this:
> 
> grep -rl EXPORT_SYMBOL arch/arm/*omap* | xargs grep -L linux/export.h
> 
> and for any OMAP drivers as well.  This gives:
> 
> arch/arm/mach-omap1/id.c
> arch/arm/mach-omap1/lcd_dma.c
> arch/arm/mach-omap1/io.c
> arch/arm/mach-omap1/ams-delta-fiq.c
> arch/arm/mach-omap2/gpmc.c
> arch/arm/mach-omap2/id.c
> arch/arm/mach-omap2/io.c
> arch/arm/plat-omap/ocpi.c
> arch/arm/plat-omap/mcbsp.c
> arch/arm/plat-omap/omap_device.c
> arch/arm/plat-omap/mux.c
> arch/arm/plat-omap/devices.c
> arch/arm/plat-omap/io.c
> arch/arm/plat-omap/dma.c
> arch/arm/plat-omap/dmtimer.c
> arch/arm/plat-omap/mailbox.c
> 
> which probably should all be fixed before any more of these errors
> spring up.

Except for the ones that have module.h included as that already
includes export.h. At least the dmtimer.c will be moved to drivers,
and could be a loadable module so module.h is better there.

Anyways, will check these and post patches.

Regards,

Tony
