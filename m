From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 24 Oct 2014 11:16:25 -0700
Subject: ARM: issue with memory reservation from DT
In-Reply-To: <20141021171658.GA27405@n2100.arm.linux.org.uk>
References: <543EAC5A.6050209@ti.com>
 <20141015175025.GJ27405@n2100.arm.linux.org.uk> <54400123.7040806@ti.com>
 <5440FF54.5080905@gmail.com> <544691A3.9060901@ti.com>
 <20141021171658.GA27405@n2100.arm.linux.org.uk>
Message-ID: <544A9779.90102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/21/2014 10:16 AM, Russell King - ARM Linux wrote:
> On Tue, Oct 21, 2014 at 08:02:27PM +0300, Grygorii Strashko wrote:
>> Oh. Yes you are right in general - I've just not expected from kernel
>> to crash silently, so my intention was to report issue first of all.
>
> The problem here is that each time someone finds a new way to break it,
> the code gets more complicated, which means there's yet more ways to
> break it.
>
> As an example, try reading through sanity_check_meminfo() and working
> out exactly what each variable in there does - it'll take some
> considerable time to work it out.  It /used/ to be pretty obvious.
>
> It's pretty scary too that it's walking a list of memblock regions,
> while modifying that list, potentially removing the entry that it's
> currently at.  I suspect that would cause it to skip a region given
> how the for() loop works.
>
> Either way, I think we need to get some of this stuff back to being
> coded in a simple and obvious-to-understand manner.
>

The removal while iterating is pretty ugly. I was trying to match
the behavior of meminfo, perhaps a little bit too closely.
Here's one attempt to simplify (net 20 lines removal)

-----8<-----

 From bfb57bb087537432acef0a109fa93f6360e6615a Mon Sep 17 00:00:00 2001
From: Laura Abbott <lauraa@codeaurora.org>
Date: Thu, 23 Oct 2014 18:00:23 -0700
Subject: [PATCH 1/2] arm: Clean up sanity_check_meminfo

The logic for sanity_check_meminfo has become difficult to
follow. Clean up the code so it's more obvious what the code
is actually trying to do. Additionally, meminfo is now removed
so rename the function to better describe it's purpose.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
  arch/arm/kernel/setup.c |  4 ++--
  arch/arm/mm/mmu.c       | 50 +++++++++++++++----------------------------------
  arch/arm/mm/nommu.c     |  2 +-
  3 files changed, 18 insertions(+), 38 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 84db893d..155c69d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -76,7 +76,7 @@ extern void init_default_cache_policy(unsigned long);
  extern void paging_init(const struct machine_desc *desc);
  extern void early_paging_init(const struct machine_desc *,
  			      struct proc_info_list *);
-extern void sanity_check_meminfo(void);
+extern void adjust_lowmem_bounds(void);
  extern enum reboot_mode reboot_mode;
  extern void setup_dma_zone(const struct machine_desc *desc);
  
@@ -911,7 +911,7 @@ void __init setup_arch(char **cmdline_p)
  
  	early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
  	setup_dma_zone(mdesc);
-	sanity_check_meminfo();
+	adjust_lowmem_bounds();
  	arm_memblock_init(mdesc);
  
  	paging_init(mdesc);
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8348ed6..f6dfcde 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1072,50 +1072,20 @@ early_param("vmalloc", early_vmalloc);
  
  phys_addr_t arm_lowmem_limit __initdata = 0;
  
-void __init sanity_check_meminfo(void)
+void __init adjust_lowmem_bounds(void)
  {
  	phys_addr_t memblock_limit = 0;
-	int highmem = 0;
  	phys_addr_t vmalloc_limit = __pa(vmalloc_min - 1) + 1;
  	struct memblock_region *reg;
  
  	for_each_memblock(memory, reg) {
  		phys_addr_t block_start = reg->base;
  		phys_addr_t block_end = reg->base + reg->size;
-		phys_addr_t size_limit = reg->size;
  
-		if (reg->base >= vmalloc_limit)
-			highmem = 1;
-		else
-			size_limit = vmalloc_limit - reg->base;
-
-
-		if (!IS_ENABLED(CONFIG_HIGHMEM) || cache_is_vipt_aliasing()) {
-
-			if (highmem) {
-				pr_notice("Ignoring RAM at %pa-%pa (!CONFIG_HIGHMEM)\n",
-					&block_start, &block_end);
-				memblock_remove(reg->base, reg->size);
-				continue;
-			}
-
-			if (reg->size > size_limit) {
-				phys_addr_t overlap_size = reg->size - size_limit;
-
-				pr_notice("Truncating RAM at %pa-%pa to -%pa",
-				      &block_start, &block_end, &vmalloc_limit);
-				memblock_remove(vmalloc_limit, overlap_size);
-				block_end = vmalloc_limit;
-			}
-		}
-
-		if (!highmem) {
-			if (block_end > arm_lowmem_limit) {
-				if (reg->size > size_limit)
-					arm_lowmem_limit = vmalloc_limit;
-				else
-					arm_lowmem_limit = block_end;
-			}
+		if (reg->base < vmalloc_limit) {
+			if (block_end > arm_lowmem_limit)
+				arm_lowmem_limit = min(vmalloc_limit,
+							block_end);
  
  			/*
  			 * Find the first non-section-aligned page, and point
@@ -1152,6 +1122,16 @@ void __init sanity_check_meminfo(void)
  	if (!memblock_limit)
  		memblock_limit = arm_lowmem_limit;
  
+	if (!IS_ENABLED(CONFIG_HIGHMEM) || cache_is_vipt_aliasing()) {
+		if (memblock_end_of_DRAM() > arm_lowmem_limit) {
+			phys_addr_t end = memblock_end_of_DRAM();
+
+			pr_notice("Ignoring RAM at %pa-%pa (!CONFIG_HIGHMEM)\n",
+				&memblock_limit, &end);
+			memblock_remove(memblock_limit, end);
+		}
+	}
+
  	memblock_set_current_limit(memblock_limit);
  }
  
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index a014dfa..f94443b 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -294,7 +294,7 @@ void __init arm_mm_memblock_reserve(void)
  #endif
  }
  
-void __init sanity_check_meminfo(void)
+void __init adjust_lowmem_bounds(void)
  {
  	phys_addr_t end;
  	sanity_check_meminfo_mpu();
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
