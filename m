From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Sep 2011 00:39:25 -0400 (EDT)
Subject: [PATCH 0/19] removal of mach/vmalloc.h and generic optimizations
In-Reply-To: <1933895.GJBlYra9yP@wuerfel>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<3319383.WZQsqr8ND4@wuerfel>
	<alpine.LFD.2.00.1109172238070.20358@xanadu.home>
	<1933895.GJBlYra9yP@wuerfel>
Message-ID: <alpine.LFD.2.00.1109190034340.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 18 Sep 2011, Arnd Bergmann wrote:

> On Saturday 17 September 2011 22:46:33 Nicolas Pitre wrote:
> > On Sat, 17 Sep 2011, Arnd Bergmann wrote:
> > 
> > > On Friday 16 September 2011 03:07:11 Nicolas Pitre wrote:
> > > > This patch series removes all instances of mach/vmalloc.h in order to
> > > > have a more unified memory map across all ARM architectures.  To do so,
> > > > the static mappings are moved inside the vmalloc area.  And finally this
> > > > allows for a generic optimization to ioremap where static mappings are
> > > > reused whenever possible, using common code instead of having this
> > > > duplicated in a couple places.
> > > > 
> > > > This also provides a net reduction of more than 1200 lines of code.
> 
> > 
> > > Doing some randconfig tests, I noticed that your series is currently broken
> > > on shmobile, which triggers a 
> > > 
> > > 	BUILD_BUG_ON(VMALLOC_END > CONSISTENT_BASE);
> > > 
> > > in mem_init(), because the platform has a CONSISTENT_DMA_SIZE of 158MB.
> > > All other platforms have a CONSISTENT_DMA_SIZE of at most 14MB, which
> > > works correctly.
> > 
> > Any idea why shmobile requires such an amount of consistent memory?
> 
> No, I couldn't find anything in the code or the changelog why this was
> done. Magnus changed it in this commit:
> 
> commit 28f0721a79046056ced3b9bd79c319c5c417ec30
> Author: Magnus Damm <damm@opensource.se>
> Date:   Wed Apr 28 08:25:30 2010 +0000
> 
>     ARM: mach-shmobile: Set CONSISTENT_DMA_SIZE to 158 MB
>     
>     This patch sets CONSISTENT_DMA_SIZE to 158 MB
>     for all SH-Mobile ARM processors.
>     
>     The DMA area is mapped at 0xf6000000 - 0xffdfffff,
>     on top of the 256 MB I/O window at 0xe6000000.
>     
>     Signed-off-by: Magnus Damm <damm@opensource.se>
>     Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> Maybe he can give a better explanation and can say whether it's
> actually required. The patch series introducing it contained
> the introduction of the shdma dmaengine driver and some changes
> to video drivers, but I could not tell how they are related
> to this change.
> 
> > > My feeling is that a 158MB CONSISTENT_DMA_SIZE causes other problems
> > > anyway because we cannot map regular RAM both cached and uncached,
> > > but this is still a regression. The problem might be solved using
> > > Marek's CMA patches, which should eliminate the need for a huge
> > > CONSISTENT_DMA_SIZE.
> > 
> > Maybe.  However I don't want for this series to depend on CMA.  I'll 
> > find some temporary hack in the mean time.
> 
> Ok

I queued the patch below for the time being.  Alternatively, I could put 
the consistent DMA area into the vmalloc area too, but I don't really 
see the benefit of that.  I would prefer an explanation for the 158 MB 
instead.

----- >8

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] ARM: move VMALLOC_END down for shmobile

THIS IS	A TEMPORARY HACK.  The purpose of this is _only_ to avoid a
regression on an existing machine while a better solution is implemented.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/include/asm/pgtable.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 950dee3ce2..0d4fecf55f 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -35,6 +35,12 @@
 #define VMALLOC_START		(((unsigned long)high_memory + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 #define VMALLOC_END		0xff000000UL
 
+/* This is a temporary hack until shmobile's DMA area size is sorted out */
+#ifdef CONFIG_ARCH_SHMOBILE
+#undef VMALLOC_END
+#define VMALLOC_END		0xe6000000UL
+#endif
+
 /*
  * Hardware-wise, we have a two level page table structure, where the first
  * level has 4096 entries, and the second level has 256 entries.  Each entry
