From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Mar 2015 14:15:05 +0000
Subject: [PATCH 4/4] irqchip: gicv3-its: Use non-cacheable accesses when no
 shareability
In-Reply-To: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
References: <1427465705-17126-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1427465705-17126-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the ITS or the redistributors report their shareability as zero,
then it is important to make sure they will no generate any cacheable
traffic, as this is unlikely to produce the expected result.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 47 ++++++++++++++++++++++++++++++++++----
 include/linux/irqchip/arm-gic-v3.h |  4 ++++
 2 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 56353f6..9687f8a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -802,6 +802,7 @@ static int its_alloc_tables(struct its_node *its)
 	int i;
 	int psz = SZ_64K;
 	u64 shr = GITS_BASER_InnerShareable;
+	u64 cache = GITS_BASER_WaWb;
 
 	for (i = 0; i < GITS_BASER_NR_REGS; i++) {
 		u64 val = readq_relaxed(its->base + GITS_BASER + i * 8);
@@ -848,7 +849,7 @@ retry_baser:
 		val = (virt_to_phys(base) 				 |
 		       (type << GITS_BASER_TYPE_SHIFT)			 |
 		       ((entry_size - 1) << GITS_BASER_ENTRY_SIZE_SHIFT) |
-		       GITS_BASER_WaWb					 |
+		       cache						 |
 		       shr						 |
 		       GITS_BASER_VALID);
 
@@ -874,9 +875,12 @@ retry_baser:
 			 * Shareability didn't stick. Just use
 			 * whatever the read reported, which is likely
 			 * to be the only thing this redistributor
-			 * supports.
+			 * supports. If that's zero, make it
+			 * non-cacheable as well.
 			 */
 			shr = tmp & GITS_BASER_SHAREABILITY_MASK;
+			if (!shr)
+				cache = GITS_BASER_nC;
 			goto retry_baser;
 		}
 
@@ -980,6 +984,17 @@ static void its_cpu_init_lpis(void)
 	tmp = readq_relaxed(rbase + GICR_PROPBASER);
 
 	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
+		if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
+			/*
+			 * The HW reports non-shareable, we must
+			 * remove the cacheability attributes as
+			 * well.
+			 */
+			val &= ~(GICR_PROPBASER_SHAREABILITY_MASK |
+				 GICR_PROPBASER_CACHEABILITY_MASK);
+			val |= GICR_PROPBASER_nC;
+			writeq_relaxed(val, rbase + GICR_PROPBASER);
+		}
 		pr_info_once("GIC: using cache flushing for LPI property table\n");
 		gic_rdists->flags |= RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING;
 	}
@@ -990,6 +1005,18 @@ static void its_cpu_init_lpis(void)
 	       GICR_PENDBASER_WaWb);
 
 	writeq_relaxed(val, rbase + GICR_PENDBASER);
+	tmp = readq_relaxed(rbase + GICR_PENDBASER);
+
+	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
+		/*
+		 * The HW reports non-shareable, we must remove the
+		 * cacheability attributes as well.
+		 */
+		val &= ~(GICR_PENDBASER_SHAREABILITY_MASK |
+			 GICR_PENDBASER_CACHEABILITY_MASK);
+		val |= GICR_PENDBASER_nC;
+		writeq_relaxed(val, rbase + GICR_PENDBASER);
+	}
 
 	/* Enable LPIs */
 	val = readl_relaxed(rbase + GICR_CTLR);
@@ -1422,14 +1449,26 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 
 	writeq_relaxed(baser, its->base + GITS_CBASER);
 	tmp = readq_relaxed(its->base + GITS_CBASER);
-	writeq_relaxed(0, its->base + GITS_CWRITER);
-	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
 
 	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
+		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
+			/*
+			 * The HW reports non-shareable, we must
+			 * remove the cacheability attributes as
+			 * well.
+			 */
+			baser &= ~(GITS_CBASER_SHAREABILITY_MASK |
+				   GITS_CBASER_CACHEABILITY_MASK);
+			baser |= GITS_CBASER_nC;
+			writeq_relaxed(baser, its->base + GITS_CBASER);
+		}
 		pr_info("ITS: using cache flushing for cmd queue\n");
 		its->flags |= ITS_FLAGS_CMDQ_NEEDS_FLUSHING;
 	}
 
+	writeq_relaxed(0, its->base + GITS_CWRITER);
+	writel_relaxed(GITS_CTLR_ENABLE, its->base + GITS_CTLR);
+
 	if (of_property_read_bool(its->msi_chip.of_node, "msi-controller")) {
 		its->domain = irq_domain_add_tree(NULL, &its_domain_ops, its);
 		if (!its->domain) {
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 826a4bd..ffbc034 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -126,6 +126,7 @@
 #define GICR_PROPBASER_WaWb		(5U << 7)
 #define GICR_PROPBASER_RaWaWt		(6U << 7)
 #define GICR_PROPBASER_RaWaWb		(7U << 7)
+#define GICR_PROPBASER_CACHEABILITY_MASK (7U << 7)
 #define GICR_PROPBASER_IDBITS_MASK	(0x1f)
 
 #define GICR_PENDBASER_NonShareable	(0U << 10)
@@ -140,6 +141,7 @@
 #define GICR_PENDBASER_WaWb		(5U << 7)
 #define GICR_PENDBASER_RaWaWt		(6U << 7)
 #define GICR_PENDBASER_RaWaWb		(7U << 7)
+#define GICR_PENDBASER_CACHEABILITY_MASK (7U << 7)
 
 /*
  * Re-Distributor registers, offsets from SGI_base
@@ -195,6 +197,7 @@
 #define GITS_CBASER_WaWb		(5UL << 59)
 #define GITS_CBASER_RaWaWt		(6UL << 59)
 #define GITS_CBASER_RaWaWb		(7UL << 59)
+#define GITS_CBASER_CACHEABILITY_MASK	(7UL << 59)
 #define GITS_CBASER_NonShareable	(0UL << 10)
 #define GITS_CBASER_InnerShareable	(1UL << 10)
 #define GITS_CBASER_OuterShareable	(2UL << 10)
@@ -211,6 +214,7 @@
 #define GITS_BASER_WaWb			(5UL << 59)
 #define GITS_BASER_RaWaWt		(6UL << 59)
 #define GITS_BASER_RaWaWb		(7UL << 59)
+#define GITS_BASER_CACHEABILITY_MASK	(7UL << 59)
 #define GITS_BASER_TYPE_SHIFT		(56)
 #define GITS_BASER_TYPE(r)		(((r) >> GITS_BASER_TYPE_SHIFT) & 7)
 #define GITS_BASER_ENTRY_SIZE_SHIFT	(48)
-- 
2.1.4
