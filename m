From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:31:07 +0100
Subject: [RFC PATCH 12/15] irqchip/s3c24xx: fixup IO accessors for big endian
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <20160608183110.13851-13-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben.dooks@codethink.co.uk>

Instead of using the __raw accesors, use the _relaxed versions
to deal with any issues due to endian-ness of the CPU.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

---
CC: Thomas Gleixner <tglx@linutronix.de> (maintainer:IRQCHIP DRIVERS)
CC: Jason Cooper <jason@lakedaemon.net> (maintainer:IRQCHIP DRIVERS)
CC: Marc Zyngier <marc.zyngier@arm.com> (maintainer:IRQCHIP DRIVERS)
CC: linux-kernel at vger.kernel.org (open list:IRQCHIP DRIVERS)
CC: linux-arm-kernel at lists.infradead.org
---
 drivers/irqchip/irq-s3c24xx.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index 5dc5a76..c25ce5a 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -92,9 +92,9 @@ static void s3c_irq_mask(struct irq_data *data)
 	unsigned long mask;
 	unsigned int irqno;
 
-	mask = __raw_readl(intc->reg_mask);
+	mask = readl_relaxed(intc->reg_mask);
 	mask |= (1UL << irq_data->offset);
-	__raw_writel(mask, intc->reg_mask);
+	writel_relaxed(mask, intc->reg_mask);
 
 	if (parent_intc) {
 		parent_data = &parent_intc->irqs[irq_data->parent_irq];
@@ -119,9 +119,9 @@ static void s3c_irq_unmask(struct irq_data *data)
 	unsigned long mask;
 	unsigned int irqno;
 
-	mask = __raw_readl(intc->reg_mask);
+	mask = readl_relaxed(intc->reg_mask);
 	mask &= ~(1UL << irq_data->offset);
-	__raw_writel(mask, intc->reg_mask);
+	writel_relaxed(mask, intc->reg_mask);
 
 	if (parent_intc) {
 		irqno = irq_find_mapping(parent_intc->domain,
@@ -136,9 +136,9 @@ static inline void s3c_irq_ack(struct irq_data *data)
 	struct s3c_irq_intc *intc = irq_data->intc;
 	unsigned long bitval = 1UL << irq_data->offset;
 
-	__raw_writel(bitval, intc->reg_pending);
+	writel_relaxed(bitval, intc->reg_pending);
 	if (intc->reg_intpnd)
-		__raw_writel(bitval, intc->reg_intpnd);
+		writel_relaxed(bitval, intc->reg_intpnd);
 }
 
 static int s3c_irq_type(struct irq_data *data, unsigned int type)
@@ -172,9 +172,9 @@ static int s3c_irqext_type_set(void __iomem *gpcon_reg,
 	unsigned long newvalue = 0, value;
 
 	/* Set the GPIO to external interrupt mode */
-	value = __raw_readl(gpcon_reg);
+	value = readl_relaxed(gpcon_reg);
 	value = (value & ~(3 << gpcon_offset)) | (0x02 << gpcon_offset);
-	__raw_writel(value, gpcon_reg);
+	writel_relaxed(value, gpcon_reg);
 
 	/* Set the external interrupt to pointed trigger type */
 	switch (type)
@@ -208,9 +208,9 @@ static int s3c_irqext_type_set(void __iomem *gpcon_reg,
 			return -EINVAL;
 	}
 
-	value = __raw_readl(extint_reg);
+	value = readl_relaxed(extint_reg);
 	value = (value & ~(7 << extint_offset)) | (newvalue << extint_offset);
-	__raw_writel(value, extint_reg);
+	writel_relaxed(value, extint_reg);
 
 	return 0;
 }
@@ -315,8 +315,8 @@ static void s3c_irq_demux(struct irq_desc *desc)
 
 	chained_irq_enter(chip, desc);
 
-	src = __raw_readl(sub_intc->reg_pending);
-	msk = __raw_readl(sub_intc->reg_mask);
+	src = readl_relaxed(sub_intc->reg_pending);
+	msk = readl_relaxed(sub_intc->reg_mask);
 
 	src &= ~msk;
 	src &= irq_data->sub_bits;
@@ -337,7 +337,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 	int pnd;
 	int offset;
 
-	pnd = __raw_readl(intc->reg_intpnd);
+	pnd = readl_relaxed(intc->reg_intpnd);
 	if (!pnd)
 		return false;
 
@@ -352,7 +352,7 @@ static inline int s3c24xx_handle_intc(struct s3c_irq_intc *intc,
 	 *
 	 * Thanks to Klaus, Shannon, et al for helping to debug this problem
 	 */
-	offset = __raw_readl(intc->reg_intpnd + 4);
+	offset = readl_relaxed(intc->reg_intpnd + 4);
 
 	/* Find the bit manually, when the offset is wrong.
 	 * The pending register only ever contains the one bit of the next
@@ -406,7 +406,7 @@ int s3c24xx_set_fiq(unsigned int irq, bool on)
 		intmod = 0;
 	}
 
-	__raw_writel(intmod, S3C2410_INTMOD);
+	writel_relaxed(intmod, S3C2410_INTMOD);
 	return 0;
 }
 
@@ -508,14 +508,14 @@ static void s3c24xx_clear_intc(struct s3c_irq_intc *intc)
 
 	last = 0;
 	for (i = 0; i < 4; i++) {
-		pend = __raw_readl(reg_source);
+		pend = readl_relaxed(reg_source);
 
 		if (pend == 0 || pend == last)
 			break;
 
-		__raw_writel(pend, intc->reg_pending);
+		writel_relaxed(pend, intc->reg_pending);
 		if (intc->reg_intpnd)
-			__raw_writel(pend, intc->reg_intpnd);
+			writel_relaxed(pend, intc->reg_intpnd);
 
 		pr_info("irq: clearing pending status %08x\n", (int)pend);
 		last = pend;
-- 
2.8.3
