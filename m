From: mars.cheng@mediatek.com (Mars Cheng)
Date: Thu, 9 Feb 2017 11:15:24 +0800
Subject: irqchip/gic: avoid magic irq number
Message-ID: <1486610124-28687-1-git-send-email-mars.cheng@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use defines instead of magic numbers

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
---
 drivers/irqchip/irq-gic-v3-its.c       |    7 +++---
 drivers/irqchip/irq-gic-v3.c           |   41 +++++++++++++++++---------------
 drivers/irqchip/irq-gic.c              |   38 ++++++++++++++++-------------
 include/linux/irqchip/arm-gic-common.h |   12 ++++++++++
 include/linux/irqchip/arm-gic-v3.h     |    2 ++
 5 files changed, 61 insertions(+), 39 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 69b040f..ceca96d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -588,7 +588,8 @@ static void lpi_set_config(struct irq_data *d, bool enable)
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	irq_hw_number_t hwirq = d->hwirq;
 	u32 id = its_get_event_id(d);
-	u8 *cfg = page_address(gic_rdists->prop_page) + hwirq - 8192;
+	u8 *cfg = page_address(gic_rdists->prop_page) + hwirq -
+		  GIC_FIRST_LPI_IRQ;
 
 	if (enable)
 		*cfg |= LPI_PROP_ENABLED;
@@ -691,12 +692,12 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 
 static int its_lpi_to_chunk(int lpi)
 {
-	return (lpi - 8192) >> IRQS_PER_CHUNK_SHIFT;
+	return (lpi - GIC_FIRST_LPI_IRQ) >> IRQS_PER_CHUNK_SHIFT;
 }
 
 static int its_chunk_to_lpi(int chunk)
 {
-	return (chunk << IRQS_PER_CHUNK_SHIFT) + 8192;
+	return (chunk << IRQS_PER_CHUNK_SHIFT) + GIC_FIRST_LPI_IRQ;
 }
 
 static int __init its_lpi_init(u32 id_bits)
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index c132f29..577ab0b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -56,7 +56,7 @@ struct gic_chip_data {
 	u64			redist_stride;
 	u32			nr_redist_regions;
 	unsigned int		irq_nr;
-	struct partition_desc	*ppi_descs[16];
+	struct partition_desc	*ppi_descs[GIC_NR_PPI];
 };
 
 static struct gic_chip_data gic_data __read_mostly;
@@ -78,7 +78,7 @@ static inline unsigned int gic_irq(struct irq_data *d)
 
 static inline int gic_irq_in_rdist(struct irq_data *d)
 {
-	return gic_irq(d) < 32;
+	return gic_irq(d) < GIC_FIRST_SPI_IRQ;
 }
 
 static inline void __iomem *gic_dist_base(struct irq_data *d)
@@ -86,7 +86,7 @@ static inline void __iomem *gic_dist_base(struct irq_data *d)
 	if (gic_irq_in_rdist(d))	/* SGI+PPI -> SGI_base for this CPU */
 		return gic_data_rdist_sgi_base();
 
-	if (d->hwirq <= 1023)		/* SPI -> dist_base */
+	if (d->hwirq <= GIC_SPURIOUS_IRQ)	/* SPI -> dist_base */
 		return gic_data.dist_base;
 
 	return NULL;
@@ -289,7 +289,8 @@ static void gic_eoimode1_eoi_irq(struct irq_data *d)
 	 * No need to deactivate an LPI, or an interrupt that
 	 * is is getting forwarded to a vcpu.
 	 */
-	if (gic_irq(d) >= 8192 || irqd_is_forwarded_to_vcpu(d))
+	if (gic_irq(d) >= GIC_FIRST_LPI_IRQ ||
+	    irqd_is_forwarded_to_vcpu(d))
 		return;
 	gic_write_dir(gic_irq(d));
 }
@@ -301,12 +302,13 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	void __iomem *base;
 
 	/* Interrupt configuration for SGIs can't be changed */
-	if (irq < 16)
+	if (irq <= GIC_LAST_SGI_IRQ)
 		return -EINVAL;
 
 	/* SPIs have restrictions on the supported types */
-	if (irq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
-			 type != IRQ_TYPE_EDGE_RISING)
+	if (irq >= GIC_FIRST_SPI_IRQ &&
+	    type != IRQ_TYPE_LEVEL_HIGH &&
+	    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
 	if (gic_irq_in_rdist(d)) {
@@ -348,7 +350,8 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 	do {
 		irqnr = gic_read_iar();
 
-		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+		if (likely(irqnr > GIC_LAST_SGI_IRQ && irqnr < GIC_MAX_IRQ) ||
+		    irqnr >= GIC_FIRST_LPI_IRQ) {
 			int err;
 
 			if (static_key_true(&supports_deactivate))
@@ -358,7 +361,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 			if (err) {
 				WARN_ONCE(true, "Unexpected interrupt received!\n");
 				if (static_key_true(&supports_deactivate)) {
-					if (irqnr < 8192)
+					if (irqnr < GIC_FIRST_LPI_IRQ)
 						gic_write_dir(irqnr);
 				} else {
 					gic_write_eoir(irqnr);
@@ -366,7 +369,7 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 			}
 			continue;
 		}
-		if (irqnr < 16) {
+		if (irqnr <= GIC_LAST_SGI_IRQ) {
 			gic_write_eoir(irqnr);
 			if (static_key_true(&supports_deactivate))
 				gic_write_dir(irqnr);
@@ -744,30 +747,30 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		chip = &gic_eoimode1_chip;
 
 	/* SGIs are private to the core kernel */
-	if (hw < 16)
+	if (hw < GIC_NR_SGI)
 		return -EPERM;
 	/* Nothing here */
-	if (hw >= gic_data.irq_nr && hw < 8192)
+	if (hw >= gic_data.irq_nr && hw < GIC_FIRST_LPI_IRQ)
 		return -EPERM;
 	/* Off limits */
 	if (hw >= GIC_ID_NR)
 		return -EPERM;
 
 	/* PPIs */
-	if (hw < 32) {
+	if (hw < GIC_FIRST_SPI_IRQ) {
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	}
 	/* SPIs */
-	if (hw >= 32 && hw < gic_data.irq_nr) {
+	if (hw >= GIC_FIRST_SPI_IRQ && hw < gic_data.irq_nr) {
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
 	}
 	/* LPIs */
-	if (hw >= 8192 && hw < GIC_ID_NR) {
+	if (hw >= GIC_FIRST_LPI_IRQ && hw < GIC_ID_NR) {
 		if (!gic_dist_supports_lpis())
 			return -EPERM;
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
@@ -788,10 +791,10 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		switch (fwspec->param[0]) {
 		case 0:			/* SPI */
-			*hwirq = fwspec->param[1] + 32;
+			*hwirq = fwspec->param[1] + GIC_FIRST_SPI_IRQ;
 			break;
 		case 1:			/* PPI */
-			*hwirq = fwspec->param[1] + 16;
+			*hwirq = fwspec->param[1] + GIC_FIRST_PPI_IRQ;
 			break;
 		case GIC_IRQ_TYPE_LPI:	/* LPI */
 			*hwirq = fwspec->param[1];
@@ -933,8 +936,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	typer = readl_relaxed(gic_data.dist_base + GICD_TYPER);
 	gic_data.rdists.id_bits = GICD_TYPER_ID_BITS(typer);
 	gic_irqs = GICD_TYPER_IRQS(typer);
-	if (gic_irqs > 1020)
-		gic_irqs = 1020;
+	if (gic_irqs > GIC_MAX_IRQ)
+		gic_irqs = GIC_MAX_IRQ;
 	gic_data.irq_nr = gic_irqs;
 
 	gic_data.domain = irq_domain_create_tree(handle, &gic_irq_domain_ops,
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1b1df4f..70f6392 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -76,10 +76,10 @@ struct gic_chip_data {
 	void __iomem *raw_cpu_base;
 	u32 percpu_offset;
 #if defined(CONFIG_CPU_PM) || defined(CONFIG_ARM_GIC_PM)
-	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
-	u32 saved_spi_active[DIV_ROUND_UP(1020, 32)];
-	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
-	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
+	u32 saved_spi_enable[DIV_ROUND_UP(GIC_LAST_SPI_IRQ, 32)];
+	u32 saved_spi_active[DIV_ROUND_UP(GIC_LAST_SPI_IRQ, 32)];
+	u32 saved_spi_conf[DIV_ROUND_UP(GIC_LAST_SPI_IRQ, 16)];
+	u32 saved_spi_target[DIV_ROUND_UP(GIC_LAST_SPI_IRQ, 4)];
 	u32 __percpu *saved_ppi_enable;
 	u32 __percpu *saved_ppi_active;
 	u32 __percpu *saved_ppi_conf;
@@ -296,12 +296,13 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	unsigned int gicirq = gic_irq(d);
 
 	/* Interrupt configuration for SGIs can't be changed */
-	if (gicirq < 16)
+	if (gicirq < GIC_FIRST_PPI_IRQ)
 		return -EINVAL;
 
 	/* SPIs have restrictions on the supported types */
-	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
-			    type != IRQ_TYPE_EDGE_RISING)
+	if (gicirq >= GIC_FIRST_SPI_IRQ &&
+	    type != IRQ_TYPE_LEVEL_HIGH &&
+	    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
 	return gic_configure_irq(gicirq, type, base, NULL);
@@ -358,13 +359,14 @@ static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 		irqstat = readl_relaxed(cpu_base + GIC_CPU_INTACK);
 		irqnr = irqstat & GICC_IAR_INT_ID_MASK;
 
-		if (likely(irqnr > 15 && irqnr < 1020)) {
+		if (likely((irqnr >  GIC_LAST_SGI_IRQ) &&
+			   (irqnr < GIC_FIRST_SPECIAL_IRQ))) {
 			if (static_key_true(&supports_deactivate))
 				writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
 			handle_domain_irq(gic->domain, irqnr, regs);
 			continue;
 		}
-		if (irqnr < 16) {
+		if (irqnr < GIC_FIRST_PPI_IRQ) {
 			writel_relaxed(irqstat, cpu_base + GIC_CPU_EOI);
 			if (static_key_true(&supports_deactivate))
 				writel_relaxed(irqstat, cpu_base + GIC_CPU_DEACTIVATE);
@@ -401,7 +403,8 @@ static void gic_handle_cascade_irq(struct irq_desc *desc)
 		goto out;
 
 	cascade_irq = irq_find_mapping(chip_data->domain, gic_irq);
-	if (unlikely(gic_irq < 32 || gic_irq > 1020))
+	if (unlikely(gic_irq < GIC_FIRST_SPI_IRQ ||
+		     gic_irq > GIC_LAST_SPI_IRQ))
 		handle_bad_irq(desc);
 	else
 		generic_handle_irq(cascade_irq);
@@ -1109,8 +1112,8 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 	 */
 	gic_irqs = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0x1f;
 	gic_irqs = (gic_irqs + 1) * 32;
-	if (gic_irqs > 1020)
-		gic_irqs = 1020;
+	if (gic_irqs > GIC_MAX_IRQ)
+		gic_irqs = GIC_MAX_IRQ;
 	gic->gic_irqs = gic_irqs;
 
 	if (handle) {		/* DT/ACPI */
@@ -1123,17 +1126,18 @@ static int gic_init_bases(struct gic_chip_data *gic, int irq_start,
 		 * For secondary GICs, skip over PPIs, too.
 		 */
 		if (gic == &gic_data[0] && (irq_start & 31) > 0) {
-			hwirq_base = 16;
+			hwirq_base = GIC_FIRST_PPI_IRQ;
 			if (irq_start != -1)
-				irq_start = (irq_start & ~31) + 16;
+				irq_start = (irq_start & ~31) +
+					    GIC_FIRST_PPI_IRQ;
 		} else {
-			hwirq_base = 32;
+			hwirq_base = GIC_FIRST_SPI_IRQ;
 		}
 
 		gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
 
-		irq_base = irq_alloc_descs(irq_start, 16, gic_irqs,
-					   numa_node_id());
+		irq_base = irq_alloc_descs(irq_start, GIC_FIRST_PPI_IRQ,
+					   gic_irqs, numa_node_id());
 		if (irq_base < 0) {
 			WARN(1, "Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
 			     irq_start);
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index c647b05..1d37cce 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -13,6 +13,18 @@
 #include <linux/types.h>
 #include <linux/ioport.h>
 
+#define GIC_FIRST_SGI_IRQ	0
+#define GIC_LAST_SGI_IRQ	15
+#define GIC_NR_SGI		(GIC_LAST_SGI_IRQ - GIC_FIRST_SGI_IRQ + 1)
+#define GIC_FIRST_PPI_IRQ	16
+#define GIC_LAST_PPI_IRQ	31
+#define GIC_NR_PPI		(GIC_LAST_PPI_IRQ - GIC_FIRST_PPI_IRQ + 1)
+#define GIC_FIRST_SPI_IRQ	32
+#define GIC_LAST_SPI_IRQ	1019
+#define GIC_MAX_IRQ		1020
+#define GIC_FIRST_SPECIAL_IRQ	1020
+#define GIC_SPURIOUS_IRQ	1023
+
 enum gic_type {
 	GIC_V2,
 	GIC_V3,
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index e808f8a..894aebf 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -408,6 +408,8 @@
 #define ICC_SGI1R_AFFINITY_3_SHIFT	48
 #define ICC_SGI1R_AFFINITY_3_MASK	(0xffULL << ICC_SGI1R_AFFINITY_3_SHIFT)
 
+#define GIC_FIRST_LPI_IRQ		8192
+
 #include <asm/arch_gicv3.h>
 
 #ifndef __ASSEMBLY__
-- 
1.7.9.5
