From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 19 Sep 2011 00:13:02 -0400 (EDT)
Subject: [PATCH 16/19] ARM: move iotable mappings within the vmalloc region
In-Reply-To: <20110917162046.GK16381@n2100.arm.linux.org.uk>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-17-git-send-email-nico@fluxnic.net>
	<20110917151953.GJ16381@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1109171150320.20358@xanadu.home>
	<20110917162046.GK16381@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1109190008140.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 17 Sep 2011, Russell King - ARM Linux wrote:

> On Sat, Sep 17, 2011 at 12:05:02PM -0400, Nicolas Pitre wrote:
> > On Sat, 17 Sep 2011, Russell King - ARM Linux wrote:
> > 
> > > > @@ -853,6 +866,7 @@ void __init sanity_check_meminfo(void)
> > > >  #endif
> > > >  	meminfo.nr_banks = j;
> > > >  	memblock_set_current_limit(lowmem_limit);
> > > > +	high_memory = __va(lowmem_limit - 1) + 1;
> > > 
> > > NAK.  This ends up initializing this setting twice during the boot,
> > > potentially leading to bugs because they're both done in different ways.
> > 
> > In that case I should remove the other one.
> 
> If you do that, don't forget to fix nommu as well.

OK, so I moved this into a patch of its own not to confuse things.  Here 
it is:

----- >8

From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: [PATCH] ARM: move initialization of the high_memory variable earlier

Some upcoming changes must know the VMALLOC_START value, which is based
on high_memory, before bootmem_init() is called.

The best location to set it is in sanity_check_meminfo() where the needed
computation is already done, and in the non MMU case it is trivial to do
now that the meminfo array is already sorted at that point.

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mm/init.c  |    2 --
 arch/arm/mm/mmu.c   |    1 +
 arch/arm/mm/nommu.c |    2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index c82a817689..b5e953ea58 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -380,8 +380,6 @@ void __init bootmem_init(void)
 	 */
 	arm_bootmem_free(min, max_low, max_high);
 
-	high_memory = __va(((phys_addr_t)max_low << PAGE_SHIFT) - 1) + 1;
-
 	/*
 	 * This doesn't seem to be used by the Linux memory manager any
 	 * more, but is used by ll_rw_block.  If we can get rid of it, we
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 594d677b92..eefb8ed5de 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -852,6 +852,7 @@ void __init sanity_check_meminfo(void)
 	}
 #endif
 	meminfo.nr_banks = j;
+	high_memory = __va(lowmem_limit - 1) + 1;
 	memblock_set_current_limit(lowmem_limit);
 }
 
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 941a98c9e8..9348730a6b 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -29,6 +29,8 @@ void __init arm_mm_memblock_reserve(void)
 
 void __init sanity_check_meminfo(void)
 {
+	phys_addr_t end = bank_phys_end(&meminfo.bank[meminfo.nr_banks - 1]);
+	high_memory = __va(end - 1) + 1;
 }
 
 /*
