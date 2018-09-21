From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Sep 2018 20:59:49 +0100
Subject: [PATCH 05/10] irqchip/gic-v3-its: Keep track of property table's PA
 and VA
In-Reply-To: <20180921195954.21574-1-marc.zyngier@arm.com>
References: <20180921195954.21574-1-marc.zyngier@arm.com>
Message-ID: <20180921195954.21574-6-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're currently only tracking the page allocated to contain the
property table by its struct page. In the future, it is going to
be convenient to track both PA and VA for that page instead. Let's
do that.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 23 +++++++++++++----------
 include/linux/irqchip/arm-gic-v3.h |  3 ++-
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 462bba422189..c2f1138034fd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1029,7 +1029,7 @@ static inline u32 its_get_event_id(struct irq_data *d)
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
 	irq_hw_number_t hwirq;
-	struct page *prop_page;
+	void *va;
 	u8 *cfg;
 
 	if (irqd_is_forwarded_to_vcpu(d)) {
@@ -1037,7 +1037,7 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		u32 event = its_get_event_id(d);
 		struct its_vlpi_map *map;
 
-		prop_page = its_dev->event_map.vm->vprop_page;
+		va = page_address(its_dev->event_map.vm->vprop_page);
 		map = &its_dev->event_map.vlpi_maps[event];
 		hwirq = map->vintid;
 
@@ -1045,11 +1045,11 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 		map->properties &= ~clr;
 		map->properties |= set | LPI_PROP_GROUP1;
 	} else {
-		prop_page = gic_rdists->prop_page;
+		va = gic_rdists->prop_table_va;
 		hwirq = d->hwirq;
 	}
 
-	cfg = page_address(prop_page) + hwirq - 8192;
+	cfg = va + hwirq - 8192;
 	*cfg &= ~clr;
 	*cfg |= set | LPI_PROP_GROUP1;
 
@@ -1628,18 +1628,21 @@ static void its_free_prop_table(struct page *prop_page)
 
 static int __init its_alloc_lpi_prop_table(void)
 {
-	phys_addr_t paddr;
+	struct page *page;
 
 	lpi_id_bits = min_t(u32, GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
 				ITS_MAX_LPI_NRBITS);
-	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
-	if (!gic_rdists->prop_page) {
+	page = its_allocate_prop_table(GFP_NOWAIT);
+	if (!page) {
 		pr_err("Failed to allocate PROPBASE\n");
 		return -ENOMEM;
 	}
 
-	paddr = page_to_phys(gic_rdists->prop_page);
-	pr_info("GIC: using LPI property table @%pa\n", &paddr);
+	gic_rdists->prop_table_pa = page_to_phys(page);
+	gic_rdists->prop_table_va = page_address(page);
+
+	pr_info("GICv3: using LPI property table @%pa\n",
+		&gic_rdists->prop_table_pa);
 
 	return its_lpi_init(lpi_id_bits);
 }
@@ -1987,7 +1990,7 @@ static void its_cpu_init_lpis(void)
 	paddr = page_to_phys(pend_page);
 
 	/* set PROPBASE */
-	val = (page_to_phys(gic_rdists->prop_page) |
+	val = (gic_rdists->prop_table_pa |
 	       GICR_PROPBASER_InnerShareable |
 	       GICR_PROPBASER_RaWaWb |
 	       ((LPI_NRBITS - 1) & GICR_PROPBASER_IDBITS_MASK));
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 266093e845bb..c2a7b863fc2e 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -587,7 +587,8 @@ struct rdists {
 		phys_addr_t	phys_base;
 		bool		lpi_enabled;
 	} __percpu		*rdist;
-	struct page		*prop_page;
+	phys_addr_t		prop_table_pa;
+	void			*prop_table_va;
 	u64			flags;
 	u32			gicd_typer;
 	bool			has_vlpis;
-- 
2.18.0
