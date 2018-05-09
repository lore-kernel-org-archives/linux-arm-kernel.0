From: nicoleotsuka@gmail.com (Nicolin Chen)
Date: Wed,  9 May 2018 15:58:23 -0700
Subject: [RFC][PATCH] arm64: update iomem_resource.end
Message-ID: <1525906703-28481-1-git-send-email-nicoleotsuka@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iomem_resource.end is -1 by default and should be updated in
arch-level code.

ARM64 so far hasn't updated it while core kernel code (mm/hmm.c)
started to use iomem_resource.end for boundary check. So it'd be
better to assign iomem_resource.end using a valid value, the end
of physical address space for example because iomem_resource.end
in theory should reflect that.

However, VA_BITS might be smaller than PA_BITS in ARM64. So using
the end of physical address space doesn't make a lot of sense in
this case, or could be even harmful since virtual address cannot
reach that memory region. Furthermore, the linear region size of
ARM64 only has the half of Virtual Memory size -- "VA_BITS - 1".

So this patch updates the iomem_resource.end by using the end of
physical address space or the end of linear mapping region when
(VA_BITS - 1) is smaller than PA_BITS.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 arch/arm64/mm/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f48b194..22015af 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -377,6 +377,12 @@ void __init arm64_memblock_init(void)
 	BUILD_BUG_ON(linear_region_size != BIT(VA_BITS - 1));
 
 	/*
+	 * Update iomem_resource.end based on size of physical address space,
+	 * or linear region size when (VA_BITS - 1) is smaller than PA_BITS.
+	 */
+	iomem_resource.end = BIT(min(PHYS_MASK_SHIFT, VA_BITS - 1)) - 1;
+
+	/*
 	 * Select a suitable value for the base of physical memory.
 	 */
 	memstart_addr = round_down(memblock_start_of_DRAM(),
-- 
2.1.4
