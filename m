From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 12 May 2012 12:16:15 -0400 (EDT)
Subject: [PATCH 2/2] remove the debugging restrictions in devicemaps_init()
In-Reply-To: <20120512134916.GB10453@n2100.arm.linux.org.uk>
References: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
 <1331876668-32492-3-git-send-email-nico@fluxnic.net>
 <20120506163016.GA7412@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1205072340540.21030@xanadu.home>
 <20120508071411.GP26481@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1205081214220.21030@xanadu.home>
 <20120512134916.GB10453@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1205121147550.21030@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 12 May 2012, Russell King - ARM Linux wrote:

> On Tue, May 08, 2012 at 12:17:40PM -0400, Nicolas Pitre wrote:
> > On Tue, 8 May 2012, Russell King - ARM Linux wrote:
> > 
> > > On Tue, May 08, 2012 at 12:19:30AM -0400, Nicolas Pitre wrote:
> > > > However, the switching itself doesn't involve a full cache flush.
> > > 
> > > That's where you're wrong.  Look at the switch_mm() helpers in proc-*.S.
> > > StrongARM for example calls v4wb_flush_kern_cache_all() here, which needs
> > > the cache flushing mappings to be in place in the _current_ page table.
> > 
> > Right.  I had to be wrong somewhere.
> > 
> > What about abstracting the cache area mapping code in a function of its 
> > own, and calling it inside install_temp_mm() as well?
> 
> One of the issues is that we check that the mappings don't conflict -
> in other words, a section mapping doesn't conflict with a page table
> mapping.  We need a clean page table to start with before we start
> populating it with the IO entries, so that we know there's no mappings
> in IO space to conflict with the newly setup entries.
> 
> What we could do is allocate a new page table, use that page table to
> setup the new mappings, memcpy them to the swapper page table as a
> final step before we kick the caches and TLB.

That's exactly what my first incarnation of this patch did.

> The down side to that approach is we have people abusing the map_io
> method for other purposes (people - including you - just don't listen
> when I tell them that they shouldn't do this kind of stuff) such as
> setting up mappings which they then immediately access.  (In case
> you've forgotten, Assabet, the probing of the SCR register at map_io
> time to discover the platforms configuration.  That set the precident
> and now other platforms also do this kind of thing.)

I publicly complained about people doing that back then when I 
discovered that my first patch did break some platforms that did that -- 
s3c24xx being a prominent example.  But I certainly didn't remember that 
I might be the one who is responsible for having done it first.

Of course there is a catch22 problem, as some platforms, such as 
s3c24xx, have to probe for the hardware they're on before installing 
their final mapping.

> So, I don't think there's any easy solution to this - certainly not
> one which is going to be fragile or restricted to a small set of
> configurations.

Well, it would be StrongARM and XScale (excluding XSc3) 
based configurations that wouldn't work.  While not insignificant, this 
is not the majority of the platforms people are working on today.  And
all those reported issues of kernel not booting that would have 
benefited from this patch were neither on StrongARM nor XScale.

I therefore suggest amending my patch as follows:

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index b302a5620b..1e22e3bf71 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -988,7 +988,7 @@ void __init arm_mm_memblock_reserve(void)
 #endif
 }
 
-#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_ARM_LPAE)
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_ARM_LPAE) && !defined(FLUSH_BASE)
 
 /*
  * The debug mappings will be cleared from the initial page table by

This will benefit those platforms that can accommodate it, while the 
others will simply remain as before.  What do you think?


Nicolas
