From: vinmenon@codeaurora.org (Vinayak Menon)
Date: Mon, 22 Feb 2016 19:15:44 +0530
Subject: [PATCH] of: alloc anywhere from memblock if range not specified
Message-ID: <1456148744-7583-1-git-send-email-vinmenon@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

early_init_dt_alloc_reserved_memory_arch passes end as 0 to
__memblock_alloc_base, when limits are not specified. But
__memblock_alloc_base takes end value of 0 as MEMBLOCK_ALLOC_ACCESSIBLE
and limits the end to memblock.current_limit. This results in regions
never being placed in HIGHMEM area, for e.g. CMA.
Let __memblock_alloc_base allocate from anywhere in memory if limits are
not specified.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Vinayak Menon <vinmenon@codeaurora.org>
---
 drivers/of/of_reserved_mem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1a3556a..ed01c01 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -32,11 +32,13 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	phys_addr_t align, phys_addr_t start, phys_addr_t end, bool nomap,
 	phys_addr_t *res_base)
 {
+	phys_addr_t base;
 	/*
 	 * We use __memblock_alloc_base() because memblock_alloc_base()
 	 * panic()s on allocation failure.
 	 */
-	phys_addr_t base = __memblock_alloc_base(size, align, end);
+	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
+	base = __memblock_alloc_base(size, align, end);
 	if (!base)
 		return -ENOMEM;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
