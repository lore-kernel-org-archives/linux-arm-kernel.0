From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:36 +0100
Subject: [PATCH 03/54] ARM: gic: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132536.GD15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/common/gic.c |   62 ++++++++++++++++++++++++------------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 772f95f..1118f40 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -47,57 +47,56 @@ struct gic_chip_data {
 
 static struct gic_chip_data gic_data[MAX_GIC_NR];
 
-static inline void __iomem *gic_dist_base(unsigned int irq)
+static inline void __iomem *gic_dist_base(struct irq_data *d)
 {
-	struct gic_chip_data *gic_data = get_irq_chip_data(irq);
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
 	return gic_data->dist_base;
 }
 
-static inline void __iomem *gic_cpu_base(unsigned int irq)
+static inline void __iomem *gic_cpu_base(struct irq_data *d)
 {
-	struct gic_chip_data *gic_data = get_irq_chip_data(irq);
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
 	return gic_data->cpu_base;
 }
 
-static inline unsigned int gic_irq(unsigned int irq)
+static inline unsigned int gic_irq(struct irq_data *d)
 {
-	struct gic_chip_data *gic_data = get_irq_chip_data(irq);
-	return irq - gic_data->irq_offset;
+	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
+	return d->irq - gic_data->irq_offset;
 }
 
 /*
  * Routines to acknowledge, disable and enable interrupts
  */
-static void gic_ack_irq(unsigned int irq)
+static void gic_ack_irq(struct irq_data *d)
 {
-
 	spin_lock(&irq_controller_lock);
-	writel(gic_irq(irq), gic_cpu_base(irq) + GIC_CPU_EOI);
+	writel(gic_irq(d), gic_cpu_base(d) + GIC_CPU_EOI);
 	spin_unlock(&irq_controller_lock);
 }
 
-static void gic_mask_irq(unsigned int irq)
+static void gic_mask_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (irq % 32);
+	u32 mask = 1 << (d->irq % 32);
 
 	spin_lock(&irq_controller_lock);
-	writel(mask, gic_dist_base(irq) + GIC_DIST_ENABLE_CLEAR + (gic_irq(irq) / 32) * 4);
+	writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
 	spin_unlock(&irq_controller_lock);
 }
 
-static void gic_unmask_irq(unsigned int irq)
+static void gic_unmask_irq(struct irq_data *d)
 {
-	u32 mask = 1 << (irq % 32);
+	u32 mask = 1 << (d->irq % 32);
 
 	spin_lock(&irq_controller_lock);
-	writel(mask, gic_dist_base(irq) + GIC_DIST_ENABLE_SET + (gic_irq(irq) / 32) * 4);
+	writel(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
 	spin_unlock(&irq_controller_lock);
 }
 
-static int gic_set_type(unsigned int irq, unsigned int type)
+static int gic_set_type(struct irq_data *d, unsigned int type)
 {
-	void __iomem *base = gic_dist_base(irq);
-	unsigned int gicirq = gic_irq(irq);
+	void __iomem *base = gic_dist_base(d);
+	unsigned int gicirq = gic_irq(d);
 	u32 enablemask = 1 << (gicirq % 32);
 	u32 enableoff = (gicirq / 32) * 4;
 	u32 confmask = 0x2 << ((gicirq % 16) * 2);
@@ -140,15 +139,16 @@ static int gic_set_type(unsigned int irq, unsigned int type)
 }
 
 #ifdef CONFIG_SMP
-static int gic_set_cpu(unsigned int irq, const struct cpumask *mask_val)
+static int
+gic_set_cpu(struct irq_data *d, const struct cpumask *mask_val, bool force)
 {
-	void __iomem *reg = gic_dist_base(irq) + GIC_DIST_TARGET + (gic_irq(irq) & ~3);
-	unsigned int shift = (irq % 4) * 8;
+	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
+	unsigned int shift = (d->irq % 4) * 8;
 	unsigned int cpu = cpumask_first(mask_val);
 	u32 val;
 
 	spin_lock(&irq_controller_lock);
-	irq_desc[irq].node = cpu;
+	d->node = cpu;
 	val = readl(reg) & ~(0xff << shift);
 	val |= 1 << (cpu + shift);
 	writel(val, reg);
@@ -166,7 +166,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 	unsigned long status;
 
 	/* primary controller ack'ing */
-	chip->ack(irq);
+	chip->irq_ack(&desc->irq_data);
 
 	spin_lock(&irq_controller_lock);
 	status = readl(chip_data->cpu_base + GIC_CPU_INTACK);
@@ -184,17 +184,17 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
 
  out:
 	/* primary controller unmasking */
-	chip->unmask(irq);
+	chip->irq_unmask(&desc->irq_data);
 }
 
 static struct irq_chip gic_chip = {
-	.name		= "GIC",
-	.ack		= gic_ack_irq,
-	.mask		= gic_mask_irq,
-	.unmask		= gic_unmask_irq,
-	.set_type	= gic_set_type,
+	.name			= "GIC",
+	.irq_ack		= gic_ack_irq,
+	.irq_mask		= gic_mask_irq,
+	.irq_unmask		= gic_unmask_irq,
+	.irq_set_type		= gic_set_type,
 #ifdef CONFIG_SMP
-	.set_affinity	= gic_set_cpu,
+	.irq_set_affinity	= gic_set_cpu,
 #endif
 };
 
-- 
1.7.1
