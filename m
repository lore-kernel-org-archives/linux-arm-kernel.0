From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Sep 2018 20:59:47 +0100
Subject: [PATCH 03/10] irqchip/gic-v3-its: Split property table clearing from
 allocation
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <20180921195954.21574-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're going to reuse some pre-allocated memory for the property
table, split out the zeroing of that table into a separate function
for later use.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ed6aab11e019..7ef6baea2d78 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1597,6 +1597,15 @@ static void its_lpi_free(unsigned long *bitmap, u32 base, u32 nr_ids)
 	kfree(bitmap);
 }
 
+static void gic_reset_prop_table(void *va)
+{
+	/* Priority 0xa0, Group-1, disabled */
+	memset(va, LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1, LPI_PROPBASE_SZ);
+
+	/* Make sure the GIC will observe the written configuration */
+	gic_flush_dcache_to_poc(va, LPI_PROPBASE_SZ);
+}
+
 static struct page *its_allocate_prop_table(gfp_t gfp_flags)
 {
 	struct page *prop_page;
@@ -1605,13 +1614,7 @@ static struct page *its_allocate_prop_table(gfp_t gfp_flags)
 	if (!prop_page)
 		return NULL;
 
-	/* Priority 0xa0, Group-1, disabled */
-	memset(page_address(prop_page),
-	       LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1,
-	       LPI_PROPBASE_SZ);
-
-	/* Make sure the GIC will observe the written configuration */
-	gic_flush_dcache_to_poc(page_address(prop_page), LPI_PROPBASE_SZ);
+	gic_reset_prop_table(page_address(prop_page));
 
 	return prop_page;
 }
-- 
2.18.0
