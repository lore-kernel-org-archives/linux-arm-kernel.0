From: rric@kernel.org (Robert Richter)
Date: Mon, 21 Sep 2015 22:58:34 +0200
Subject: [PATCH v5 1/6] irqchip,
 gicv3-its: Add range check for number of allocated pages
In-Reply-To: <1442869119-1814-1-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
Message-ID: <1442869119-1814-2-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

The number of pages for the its table may exceed the maximum of 256.
Adding a range check and limitting the number to its maximum.

Based on a patch from Tirumalesh Chalamarla <tchalamarla@cavium.com>.

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@cavium.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 11 ++++++++++-
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 26b55c53755f..0636cb33aeea 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -822,6 +822,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		u64 entry_size = GITS_BASER_ENTRY_SIZE(val);
 		int order = get_order(psz);
 		int alloc_size;
+		int alloc_pages;
 		u64 tmp;
 		void *base;
 
@@ -856,6 +857,14 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 		}
 
 		alloc_size = (1 << order) * PAGE_SIZE;
+		alloc_pages = (alloc_size / psz);
+		if (alloc_pages > GITS_BASER_PAGES_MAX) {
+			alloc_pages = GITS_BASER_PAGES_MAX;
+			order = get_order(GITS_BASER_PAGES_MAX * psz);
+			pr_warn("%s: Device Table too large, reduce its page order to %u (%u pages)\n",
+				node_name, order, alloc_pages);
+		}
+
 		base = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
 		if (!base) {
 			err = -ENOMEM;
@@ -884,7 +893,7 @@ static int its_alloc_tables(const char *node_name, struct its_node *its)
 			break;
 		}
 
-		val |= (alloc_size / psz) - 1;
+		val |= alloc_pages - 1;
 
 		writeq_relaxed(val, its->base + GITS_BASER + i * 8);
 		tmp = readq_relaxed(its->base + GITS_BASER + i * 8);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9eeeb9589acf..c0c8a2ef9d90 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -231,6 +231,7 @@
 #define GITS_BASER_PAGE_SIZE_16K	(1UL << GITS_BASER_PAGE_SIZE_SHIFT)
 #define GITS_BASER_PAGE_SIZE_64K	(2UL << GITS_BASER_PAGE_SIZE_SHIFT)
 #define GITS_BASER_PAGE_SIZE_MASK	(3UL << GITS_BASER_PAGE_SIZE_SHIFT)
+#define GITS_BASER_PAGES_MAX		256
 
 #define GITS_BASER_TYPE_NONE		0
 #define GITS_BASER_TYPE_DEVICE		1
-- 
2.1.1
