From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Feb 2015 18:19:34 +0000
Subject: ask for help about swiotlb buffer is full
In-Reply-To: <54D23123.3040208@huawei.com>
References: <54CB5820.9020102@huawei.com> <54CB5AA4.7050705@huawei.com>
 <20150130115915.GB27542@e104818-lin.cambridge.arm.com>
 <54CC5346.5070402@huawei.com>
 <20150202182435.GH22661@e104818-lin.cambridge.arm.com>
 <54D209FD.40100@huawei.com>
 <20150204133205.GC26006@e104818-lin.cambridge.arm.com>
 <54D23123.3040208@huawei.com>
Message-ID: <20150205181934.GE21970@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 02:48:03PM +0000, Ding Tianhong wrote:
> On 2015/2/4 21:32, Catalin Marinas wrote:
> > On Wed, Feb 04, 2015 at 12:01:01PM +0000, Kefeng Wang wrote:
> >> On 2015-02-03 2:24, Catalin Marinas wrote:
> >>> On Sat, Jan 31, 2015 at 04:00:06AM +0000, Kefeng Wang wrote:
> >>>> 4kb page,  use Make ARCH=arm64 defconfig in v3.19 to generate config.
> >>>>
> >>>> [    0.678293] software IO TLB [mem 0x7e800000-0x7ec00000] (4MB) mapped at [ffffffc07e800000-ffffffc07ebfffff]
> >>>> [    0.686991] DMA: preallocated 256 KiB pool for atomic allocations
> >>>
> >>> Was the swiotlb buffer size the same in the 3.16 kernel? The only thing
> >>> I recall adding was the atomic pool allocations but these are only for
> >>> non-coherent DMA ops and only for dma_alloc/free. I assume, in the case
> >>> of SATA, the failure is on the dma_map_sg() path.
> >>
> >> Swiotlb buffer size is both 4M in v3.16 and v3.19-rc4, and the failure is
> >> on the dma_map_sg() -> swiotlb_map_sg_attrs.
> >>
> >>> Maybe with a 3.19 kernel you get more than 4MB swiotlb buffers used at a
> >>> time with your tests; can you try increasing this via a kernel command
> >>> like to, let's say, 8MB? If I got my calculations correctly (an IO TLB
> >>> slab is 1 << 11):
> >>>
> >>> 	swiotlb=4096
> >>>
> >>> If it still runs out with bigger buffers, we may need to look into
> >>> potential leaks.
> >>
> >> The buddy allocator can only support 4M contiguous physical memory, so it's
> >> useless to increase swiotlb buffer.
> > 
> > You could hack arch/arm64/Kconfig to set a higher
> > CONFIG_FORCE_MAX_ZONEORDER as a test. Depending on the test result, we
> > can look for an alternative solution.
> 
> I have try this before and could fix the problem, but I think it is
> not a perfect solution,.

So it's not some bug leaking memory but a genuine need for bigger
swiotlb buffer. Ideally your hardware should have an iommu as bouncing
is not cheap.

Most architectures using swiotlb seem to use the default size of 64MB
(with the risk of wasting too much memory on smaller systems). That's
what we had on arm64 before commit 3690951fc6d42f3a (arm64: Use swiotlb
late initialisation) but the problem was that the generic swiotlb_init()
function didn't bother with which zone it allocated memory from and it
wasn't always suitable for 32-bit DMA.

Below is an attempt to move back to early swiotlb initialisation but
fixing the memblock low memory allocation to make it suitable for 32-bit
only devices.

--------------8<-------------------------------

>From 41deb86ffa58fd4f505fe64bc255c0a1870a4e2d Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 5 Feb 2015 18:01:53 +0000
Subject: [PATCH] arm64: Increase the swiotlb buffer size 64MB

With commit 3690951fc6d4 (arm64: Use swiotlb late initialisation), the
swiotlb buffer size is limited to MAX_ORDER_NR_PAGES. However, there are
platforms with 32-bit only devices that require bounce buffering via
swiotlb. This patch changes the swiotlb initialisation to an early 64MB
memblock allocation. In order to get the swiotlb buffer correctly
allocated (via memblock_virt_alloc_low_nopanic), this patch also defines
ARCH_LOW_ADDRESS_LIMIT to the maximum physical address capable of 32-bit
DMA.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/processor.h |  3 ++-
 arch/arm64/mm/dma-mapping.c        | 16 +++-------------
 arch/arm64/mm/init.c               | 10 +++++++---
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f9be30ea1cbd..7701b07a21a3 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -45,7 +45,8 @@
 #define STACK_TOP		STACK_TOP_MAX
 #endif /* CONFIG_COMPAT */
 
-#define ARCH_LOW_ADDRESS_LIMIT	PHYS_MASK
+extern phys_addr_t dma_phys_limit;
+#define ARCH_LOW_ADDRESS_LIMIT	(dma_phys_limit - 1)
 #endif /* __KERNEL__ */
 
 struct debug_info {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index d92094203913..18f15095deec 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -360,8 +360,6 @@ struct dma_map_ops coherent_swiotlb_dma_ops = {
 };
 EXPORT_SYMBOL(coherent_swiotlb_dma_ops);
 
-extern int swiotlb_late_init_with_default_size(size_t default_size);
-
 static int __init atomic_pool_init(void)
 {
 	pgprot_t prot = __pgprot(PROT_NORMAL_NC);
@@ -423,21 +421,13 @@ out:
 	return -ENOMEM;
 }
 
-static int __init swiotlb_late_init(void)
+static int __init arm64_dma_init(void)
 {
-	size_t swiotlb_size = min(SZ_64M, MAX_ORDER_NR_PAGES << PAGE_SHIFT);
+	int ret;
 
 	dma_ops = &noncoherent_swiotlb_dma_ops;
 
-	return swiotlb_late_init_with_default_size(swiotlb_size);
-}
-
-static int __init arm64_dma_init(void)
-{
-	int ret = 0;
-
-	ret |= swiotlb_late_init();
-	ret |= atomic_pool_init();
+	ret = atomic_pool_init();
 
 	return ret;
 }
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index c95464a33f36..f6123a965396 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -33,6 +33,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dma-contiguous.h>
 #include <linux/efi.h>
+#include <linux/swiotlb.h>
 
 #include <asm/fixmap.h>
 #include <asm/sections.h>
@@ -44,6 +45,7 @@
 #include "mm.h"
 
 phys_addr_t memstart_addr __read_mostly = 0;
+phys_addr_t dma_phys_limit __read_mostly;
 
 #ifdef CONFIG_BLK_DEV_INITRD
 static int __init early_initrd(char *p)
@@ -84,7 +86,7 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
 
 	/* 4GB maximum for 32-bit only capable devices */
 	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
-		max_dma = PFN_DOWN(max_zone_dma_phys());
+		max_dma = PFN_DOWN(dma_phys_limit);
 		zone_size[ZONE_DMA] = max_dma - min;
 	}
 	zone_size[ZONE_NORMAL] = max - max_dma;
@@ -138,8 +140,6 @@ static void arm64_memory_present(void)
 
 void __init arm64_memblock_init(void)
 {
-	phys_addr_t dma_phys_limit = 0;
-
 	/*
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
@@ -155,6 +155,8 @@ void __init arm64_memblock_init(void)
 	/* 4GB maximum for 32-bit only capable devices */
 	if (IS_ENABLED(CONFIG_ZONE_DMA))
 		dma_phys_limit = max_zone_dma_phys();
+	else
+		dma_phys_limit = PHYS_MASK + 1;
 	dma_contiguous_reserve(dma_phys_limit);
 
 	memblock_allow_resize();
@@ -256,6 +258,8 @@ static void __init free_unused_memmap(void)
  */
 void __init mem_init(void)
 {
+	swiotlb_init(1);
+
 	set_max_mapnr(pfn_to_page(max_pfn) - mem_map);
 
 #ifndef CONFIG_SPARSEMEM_VMEMMAP
