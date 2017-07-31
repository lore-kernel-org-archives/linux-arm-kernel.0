From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:25:46 +0100
Subject: [PATCH v3 08/59] irqchip/gic-v3-its: Split out property table
 allocation
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-9-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the LPI property table allocation into its own function, as
this is going to be required for those associated with VMs in
the future.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3e4ac8c13e21..039626d21a73 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -899,13 +899,32 @@ static void its_lpi_free(struct event_lpi_map *map)
 	kfree(map->col_map);
 }
 
+static struct page *its_allocate_prop_table(gfp_t gfp_flags)
+{
+	struct page *prop_page;
+
+	prop_page = alloc_pages(gfp_flags, get_order(LPI_PROPBASE_SZ));
+	if (!prop_page)
+		return NULL;
+
+	/* Priority 0xa0, Group-1, disabled */
+	memset(page_address(prop_page),
+	       LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1,
+	       LPI_PROPBASE_SZ);
+
+	/* Make sure the GIC will observe the written configuration */
+	gic_flush_dcache_to_poc(page_address(prop_page), LPI_PROPBASE_SZ);
+
+	return prop_page;
+}
+
+
 static int __init its_alloc_lpi_tables(void)
 {
 	phys_addr_t paddr;
 
 	lpi_id_bits = min_t(u32, gic_rdists->id_bits, ITS_MAX_LPI_NRBITS);
-	gic_rdists->prop_page = alloc_pages(GFP_NOWAIT,
-					   get_order(LPI_PROPBASE_SZ));
+	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
 	if (!gic_rdists->prop_page) {
 		pr_err("Failed to allocate PROPBASE\n");
 		return -ENOMEM;
@@ -914,14 +933,6 @@ static int __init its_alloc_lpi_tables(void)
 	paddr = page_to_phys(gic_rdists->prop_page);
 	pr_info("GIC: using LPI property table @%pa\n", &paddr);
 
-	/* Priority 0xa0, Group-1, disabled */
-	memset(page_address(gic_rdists->prop_page),
-	       LPI_PROP_DEFAULT_PRIO | LPI_PROP_GROUP1,
-	       LPI_PROPBASE_SZ);
-
-	/* Make sure the GIC will observe the written configuration */
-	gic_flush_dcache_to_poc(page_address(gic_rdists->prop_page), LPI_PROPBASE_SZ);
-
 	return its_lpi_init(lpi_id_bits);
 }
 
-- 
2.11.0
