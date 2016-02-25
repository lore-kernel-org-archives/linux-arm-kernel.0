From: rrichter@caviumnetworks.com (Robert Richter)
Date: Thu, 25 Feb 2016 12:02:44 +0100
Subject: [PATCH 2/2] irqchip, gicv3-its,
 cma: Use CMA for allocation of large device tables
In-Reply-To: <1456398164-16864-1-git-send-email-rrichter@caviumnetworks.com>
References: <1456398164-16864-1-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <1456398164-16864-3-git-send-email-rrichter@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

The gicv3-its device table may have a size of up to 16MB. With 4k
pagesize the maximum size of memory allocation is 4MB. Use CMA for
allocation of large tables.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 443ba8892f6f..c8914026d0e4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -19,6 +19,7 @@
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dma-contiguous.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
 #include <linux/iort.h>
@@ -860,6 +861,7 @@ static int its_alloc_tables(struct its_node *its)
 		int alloc_pages;
 		u64 tmp;
 		void *base;
+		struct page *page;
 
 		if (type == GITS_BASER_TYPE_NONE)
 			continue;
@@ -881,13 +883,8 @@ static int its_alloc_tables(struct its_node *its)
 			 */
 			order = max(get_order((1UL << ids) * entry_size),
 				    order);
-			if (order >= MAX_ORDER) {
-				order = MAX_ORDER - 1;
-				pr_warn("ITS at 0x%lx: Device Table too large, reduce its page order to %u\n",
-					its->phys_base, order);
-			}
 		}
-
+retry_alloc:
 		alloc_size = (1 << order) * PAGE_SIZE;
 		alloc_pages = (alloc_size / psz);
 		if (alloc_pages > GITS_BASER_PAGES_MAX) {
@@ -897,8 +894,22 @@ static int its_alloc_tables(struct its_node *its)
 				its->phys_base, order, alloc_pages);
 		}
 
-		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+		if (order >= MAX_ORDER) {
+			page = dma_alloc_from_contiguous(NULL, 1 << order, 0);
+			base = page ? page_address(page) : NULL;
+			if (!base) {
+				order = MAX_ORDER - 1;
+				pr_warn("ITS@0x%lx: Device table too large, reduce its page order to %u\n",
+					its->phys_base, order);
+				goto retry_alloc;
+			}
+		} else {
+			base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+		}
+
 		if (!base) {
+			pr_err("ITS at 0x%lx: Failed to allocate device table\n",
+				its->phys_base);
 			err = -ENOMEM;
 			goto out_free;
 		}
@@ -970,11 +981,12 @@ static int its_alloc_tables(struct its_node *its)
 			goto out_free;
 		}
 
-		pr_info("ITS: allocated %d %s @%lx (psz %dK, shr %d)\n",
+		pr_info("ITS: allocated %d %s @%lx (psz %dK, shr %d)%s\n",
 			(int)(alloc_size / entry_size),
 			its_base_type_string[type],
 			(unsigned long)virt_to_phys(base),
-			psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT);
+			psz / SZ_1K, (int)shr >> GITS_BASER_SHAREABILITY_SHIFT,
+			order >= MAX_ORDER ? " using CMA" : "");
 	}
 
 	return 0;
-- 
2.7.0.rc3
