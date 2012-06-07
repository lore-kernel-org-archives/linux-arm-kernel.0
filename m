From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 7 Jun 2012 01:31:18 -0600 (MDT)
Subject: [PATCH 02/11] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
In-Reply-To: <20120607071900.GW12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061306.25532.59488.stgit@dusk> <20120607071900.GW12766@atomide.com>
Message-ID: <alpine.DEB.2.00.1206070121150.6684@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Jun 2012, Tony Lindgren wrote:

> It seems that most/many IP blocks need their custom reset hacks, and 
> it's not limited to just few instances?

Only four out of the fifty-seven omap_hwmod_classes defined in 
mach-omap2/omap_hwmod_44xx_data.c after this series have custom reset 
functions used:

$ fgrep 'struct omap_hwmod_class ' arch/arm/mach-omap2/omap_hwmod_44xx_data.c | wc -l
57
$ fgrep '.reset' arch/arm/mach-omap2/omap_hwmod_44xx_data.c | wc -l
4

That's 7% of the classes.  In terms of the total number of IP block 
instances that use custom reset functions viewed against the total number 
of instances on the chip, the percentage is even smaller.

> AFAIK there's no need to reset the IP blocks before the driver init, 
> it's really needed for PM. So it's not needed early on, and it's OK to 
> require running the driver init for driver modules that are not in use 
> to reset them properly. After all, the hardware is on the device, even 
> if it's not being used.

I don't think I'm following you.  It's not just PM; the problem is also 
with kexec or buggy bootloaders.  If an IP block isn't reset when the 
kernel boots, and is doing DMA or anything else that could affect the 
reset of the system, it could easily cause unpredictable behavior or 
crashes in unrelated kernel code.

It's also worth mentioning that many IP blocks, such as AESS, don't have 
Linux drivers.


- Paul
