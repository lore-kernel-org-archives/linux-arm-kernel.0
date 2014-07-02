From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Jul 2014 17:18:44 +0100
Subject: [PATCH 2/3] ARM: remove remaining definitions of
 PLAT_PHYS_OFFSET from <mach/memory.h>
In-Reply-To: <20140702161523.GR14781@pengutronix.de>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1404295043-6661-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140702103819.GH32514@n2100.arm.linux.org.uk>
 <20140702161523.GR14781@pengutronix.de>
Message-ID: <20140702161844.GO32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 06:15:23PM +0200, Uwe Kleine-K?nig wrote:
> On Wed, Jul 02, 2014 at 11:38:19AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Jul 02, 2014 at 11:57:22AM +0200, Uwe Kleine-K?nig wrote:
> > >  config PHYS_OFFSET
> > >  	hex "Physical address of main memory" if MMU
> > > -	depends on !ARM_PATCH_PHYS_VIRT && !NEED_MACH_MEMORY_H
> > > +	depends on !ARM_PATCH_PHYS_VIRT
> > >  	default DRAM_BASE if !MMU
> > > +	default 0x00000000 if ARCH_EBSA110 || EP93XX_SDCE3_SYNC_PHYS_OFFSET || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_IOP13XX || ARCH_KS8695 || (ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET)
> > 
> > It would be nice to see a few \ characters in that long line.
> Yeah, right.
> 
> Also note that there is an ARCH_FOOTBRIDGE while mach-footbridge is
> selected by FOOTBRIDGE. Following up your comments to the footbridge
> series one of them should be changed. (But I wonder which one.)

Yes, I spotted that.  It's was actually harmless, because CO285
also built mach-footbridge:

+ machine-$(CONFIG_FOOTBRIDGE)     := footbridge
+  incdir-$(CONFIG_FOOTBRIDGE)     := ebsa285
+textaddr-$(CONFIG_ARCH_CO285)     := 0x60008000
+ machine-$(CONFIG_ARCH_CO285)     := footbridge
+  incdir-$(CONFIG_ARCH_CO285)     := ebsa285

which makes the machine- and incdir- for CO285 redundant...  I'd
recommend changing that CONFIG_FOOTBRIDGE to CONFIG_ARCH_FOOTBRIDGE
because that's more conformant to the pattern which people expect.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
