From: dianders@chromium.org (Douglas Anderson)
Date: Fri, 18 Dec 2015 14:27:02 -0800
Subject: [PATCH v2 2/2] ARM: dma-mapping: sort the pages after allocation
In-Reply-To: <1450477622-30948-1-git-send-email-dianders@chromium.org>
References: <1450477622-30948-1-git-send-email-dianders@chromium.org>
Message-ID: <1450477622-30948-2-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After doing allocation, make one last-ditch effort to get contiguous
regions of pages to optimize TLB usage.  This is a rather simplistic
approach that could be later optimized, but it doesn't hurt and should
only have the opportunity to help.

>From my testing the sort took less than 400us for a 4MB allocation.
That's much faster than the actual allocation which was more than a
millisecond even in the fastest case (and was often several hundred ms).

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- Sort patch new for v2 (and optional if people hate it).

 arch/arm/mm/dma-mapping.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 9887d432cf1f..d1b3d3e6fe47 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -23,6 +23,7 @@
 #include <linux/highmem.h>
 #include <linux/memblock.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/iommu.h>
 #include <linux/io.h>
 #include <linux/vmalloc.h>
@@ -1122,6 +1123,21 @@ static inline void __free_iova(struct dma_iommu_mapping *mapping,
 	spin_unlock_irqrestore(&mapping->lock, flags);
 }
 
+static int cmp_pfns(const void *a, const void *b)
+{
+	unsigned long a_pfn;
+	unsigned long b_pfn;
+
+	a_pfn = page_to_pfn(*(struct page **)a);
+	b_pfn = page_to_pfn(*(struct page **)b);
+
+	if (a_pfn < b_pfn)
+		return -1;
+	else if (a_pfn > b_pfn)
+		return 1;
+	return 0;
+}
+
 /* We'll try 2M, 1M, 64K, and finally 4K; array must end with 0! */
 static const int iommu_order_array[] = { 9, 8, 4, 0 };
 
@@ -1133,6 +1149,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	int array_size = count * sizeof(struct page *);
 	int i = 0;
 	int order_idx = 0;
+	int first_order_zero = -1;
 
 	if (array_size <= PAGE_SIZE)
 		pages = kzalloc(array_size, GFP_KERNEL);
@@ -1171,6 +1188,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		/* Drop down when we get small */
 		if (__fls(count) < order) {
 			order_idx++;
+			/* Don't update first_order_zero; no need to sort end */
 			continue;
 		}
 
@@ -1181,6 +1199,8 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 			/* Go down a notch@first sign of pressure */
 			if (!pages[i]) {
 				order_idx++;
+				if (iommu_order_array[order_idx] == 0)
+					first_order_zero = i;
 				continue;
 			}
 		} else {
@@ -1201,6 +1221,26 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 		count -= 1 << order;
 	}
 
+	/*
+	 * If we folded under memory pressure, try one last ditch event to get
+	 * contiguous pages via sorting.  Under testing this sometimes helped
+	 * get a few more contiguous pages and didn't cost much compared to
+	 * the above allocations.
+	 *
+	 * Note that we only sort the order zero pages so that we don't mess
+	 * up the higher order allocations by sticking small pages in between
+	 * them.
+	 *
+	 * If someone wanted to optimize this more, they could insert extra
+	 * (out of order) single pages in places to help keep virtual and
+	 * physical pages aligned with each other.  As it is we often get
+	 * lucky and get the needed alignment but we're not guaranteed.
+	 */
+	if (first_order_zero >= 0)
+		sort(pages + first_order_zero,
+		     (size >> PAGE_SHIFT) - first_order_zero, sizeof(*pages),
+		     cmp_pfns, NULL);
+
 	return pages;
 error:
 	while (i--)
-- 
2.6.0.rc2.230.g3dd15c0
