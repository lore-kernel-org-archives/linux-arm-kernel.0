From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 21 Aug 2014 10:45:13 +0200
Subject: [PATCH 1/2] mm: cma: adjust address limit to avoid hitting low/high
 memory boundary
In-Reply-To: <1408610714-16204-1-git-send-email-m.szyprowski@samsung.com>
References: <1408610714-16204-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1408610714-16204-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Automatically allocated regions should not cross low/high memory boundary,
because such regions cannot be later correctly initialized due to spanning
across two memory zones. This patch adds a check for this case and a simple
code for moving region to low memory if automatically selected address might
not fit completely into high memory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 mm/cma.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/cma.c b/mm/cma.c
index c17751c0dcaf..4acc6aa4a086 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/log2.h>
 #include <linux/cma.h>
+#include <linux/highmem.h>
 
 struct cma {
 	unsigned long	base_pfn;
@@ -163,6 +164,8 @@ int __init cma_declare_contiguous(phys_addr_t base,
 			bool fixed, struct cma **res_cma)
 {
 	struct cma *cma;
+	phys_addr_t memblock_end = memblock_end_of_DRAM();
+	phys_addr_t highmem_start = __pa(high_memory);
 	int ret = 0;
 
 	pr_debug("%s(size %lx, base %08lx, limit %08lx alignment %08lx)\n",
@@ -196,6 +199,24 @@ int __init cma_declare_contiguous(phys_addr_t base,
 	if (!IS_ALIGNED(size >> PAGE_SHIFT, 1 << order_per_bit))
 		return -EINVAL;
 
+	/*
+	 * adjust limit to avoid crossing low/high memory boundary for
+	 * automatically allocated regions
+	 */
+	if (((limit == 0 || limit > memblock_end) &&
+	     (memblock_end - size < highmem_start &&
+	      memblock_end > highmem_start)) ||
+	    (!fixed && limit > highmem_start && limit - size < highmem_start)) {
+		limit = highmem_start;
+	}
+
+	if (fixed && base < highmem_start && base+size > highmem_start) {
+		ret = -EINVAL;
+		pr_err("Region at %08lx defined on low/high memory boundary (%08lx)\n",
+			(unsigned long)base, (unsigned long)highmem_start);
+		goto err;
+	}
+
 	/* Reserve memory */
 	if (base && fixed) {
 		if (memblock_is_region_reserved(base, size) ||
-- 
1.9.2
