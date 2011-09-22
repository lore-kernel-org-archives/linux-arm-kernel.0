From: jason77.wang@gmail.com (Hui Wang)
Date: Thu, 22 Sep 2011 17:40:08 +0800
Subject: [PATCH] ARM i.MX avic: convert to use generic irq chip
Message-ID: <1316684408-12196-1-git-send-email-jason77.wang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert i.MX avic irq handler to use generic irq chip. This not only
provides a cleanup implementation of irq chip handler, but also
implements suspend/resume interface with the help of generic irq chip
interface.

Change mxc_irq_chip to a new structure mxc_extra_irq to handle fiq
and priority functions.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---

This patch is basing on imx-features branch of linux-pengu. Have
validated this patch on 31pdk and 35pdk platforms, while have no
chance to validate it on mx2 and mx1 platforms since we don't have
those hardwares.

The purpose of changing avic to use generic irq chip is because i
added suspend/resume functions for 35pdk, and generic irq chip
naturally has suspend/resume interface. If this patch can be
accepted, i will continue to send out those 35pdk pm patches.

 arch/arm/plat-mxc/avic.c       |   79 ++++++++++++++++++++++++++++------------
 arch/arm/plat-mxc/irq-common.c |   21 ++++++-----
 arch/arm/plat-mxc/irq-common.h |    3 +-
 arch/arm/plat-mxc/tzic.c       |    8 ++++-
 4 files changed, 75 insertions(+), 36 deletions(-)

diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 55d2534..846636a 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -50,6 +50,8 @@
 
 void __iomem *avic_base;
 
+static u32 avic_saved_mask_reg[2];
+
 #ifdef CONFIG_MXC_IRQ_PRIOR
 static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
 {
@@ -90,24 +92,8 @@ static int avic_set_irq_fiq(unsigned int irq, unsigned int type)
 }
 #endif /* CONFIG_FIQ */
 
-/* Disable interrupt number "irq" in the AVIC */
-static void mxc_mask_irq(struct irq_data *d)
-{
-	__raw_writel(d->irq, avic_base + AVIC_INTDISNUM);
-}
-
-/* Enable interrupt number "irq" in the AVIC */
-static void mxc_unmask_irq(struct irq_data *d)
-{
-	__raw_writel(d->irq, avic_base + AVIC_INTENNUM);
-}
 
-static struct mxc_irq_chip mxc_avic_chip = {
-	.base = {
-		.irq_ack = mxc_mask_irq,
-		.irq_mask = mxc_mask_irq,
-		.irq_unmask = mxc_unmask_irq,
-	},
+static struct mxc_extra_irq avic_extra_irq = {
 #ifdef CONFIG_MXC_IRQ_PRIOR
 	.set_priority = avic_irq_set_priority,
 #endif
@@ -116,6 +102,56 @@ static struct mxc_irq_chip mxc_avic_chip = {
 #endif
 };
 
+
+#ifdef CONFIG_PM
+static void avic_irq_suspend(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = gc->chip_types;
+	int idx = gc->irq_base >> 5;
+
+	avic_saved_mask_reg[idx] = __raw_readl(avic_base + ct->regs.mask);
+	__raw_writel(gc->wake_active, avic_base + ct->regs.mask);
+}
+
+static void avic_irq_resume(struct irq_data *d)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+	struct irq_chip_type *ct = gc->chip_types;
+	int idx = gc->irq_base >> 5;
+
+	__raw_writel(avic_saved_mask_reg[idx], avic_base + ct->regs.mask);
+}
+
+#else
+#define avic_irq_suspend NULL
+#define avic_irq_resume NULL
+#endif
+
+static __init void avic_init_gc(unsigned int irq_start)
+{
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	int idx = irq_start >> 5;
+
+	gc = irq_alloc_generic_chip("mxc-avic", 1, irq_start, avic_base,
+				    handle_level_irq);
+	gc->private = &avic_extra_irq;
+	gc->wake_enabled = IRQ_MSK(32);
+
+	ct = gc->chip_types;
+	ct->chip.irq_mask = irq_gc_mask_clr_bit;
+	ct->chip.irq_unmask = irq_gc_mask_set_bit;
+	ct->chip.irq_ack = irq_gc_mask_clr_bit;
+	ct->chip.irq_set_wake = irq_gc_set_wake;
+	ct->chip.irq_suspend = avic_irq_suspend;
+	ct->chip.irq_resume = avic_irq_resume;
+	ct->regs.mask = !idx ? AVIC_INTENABLEL : AVIC_INTENABLEH;
+	ct->regs.ack = ct->regs.mask;
+
+	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
+}
+
 /*
  * This function initializes the AVIC hardware and disables all the
  * interrupts. It registers the interrupt enable and disable functions
@@ -140,11 +176,9 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	/* all IRQ no FIQ */
 	__raw_writel(0, avic_base + AVIC_INTTYPEH);
 	__raw_writel(0, avic_base + AVIC_INTTYPEL);
-	for (i = 0; i < AVIC_NUM_IRQS; i++) {
-		irq_set_chip_and_handler(i, &mxc_avic_chip.base,
-					 handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-	}
+
+	for (i = 0; i < AVIC_NUM_IRQS; i += 32)
+		avic_init_gc(i);
 
 	/* Set default priority value (0) for all IRQ's */
 	for (i = 0; i < 8; i++)
@@ -157,4 +191,3 @@ void __init mxc_init_irq(void __iomem *irqbase)
 
 	printk(KERN_INFO "MXC IRQ initialized\n");
 }
-
diff --git a/arch/arm/plat-mxc/irq-common.c b/arch/arm/plat-mxc/irq-common.c
index 96953e2..b6e1145 100644
--- a/arch/arm/plat-mxc/irq-common.c
+++ b/arch/arm/plat-mxc/irq-common.c
@@ -23,17 +23,17 @@
 
 int imx_irq_set_priority(unsigned char irq, unsigned char prio)
 {
-	struct mxc_irq_chip *chip;
-	struct irq_chip *base;
+	struct irq_chip_generic *gc;
+	struct mxc_extra_irq *exirq;
 	int ret;
 
 	ret = -ENOSYS;
 
-	base = irq_get_chip(irq);
-	if (base) {
-		chip = container_of(base, struct mxc_irq_chip, base);
-		if (chip->set_priority)
-			ret = chip->set_priority(irq, prio);
+	gc = irq_get_chip_data(irq);
+	if (gc && gc->private) {
+		exirq = gc->private;
+		if (exirq->set_priority)
+			ret = exirq->set_priority(irq, prio);
 	}
 
 	return ret;
@@ -43,15 +43,16 @@ EXPORT_SYMBOL(imx_irq_set_priority);
 int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
 {
 	struct irq_chip_generic *gc;
-	int (*set_irq_fiq)(unsigned int, unsigned int);
+	struct mxc_extra_irq *exirq;
 	int ret;
 
 	ret = -ENOSYS;
 
 	gc = irq_get_chip_data(irq);
 	if (gc && gc->private) {
-		set_irq_fiq = gc->private;
-		ret = set_irq_fiq(irq, type);
+		exirq = gc->private;
+		if (exirq->set_irq_fiq)
+			ret = exirq->set_irq_fiq(irq, type);
 	}
 
 	return ret;
diff --git a/arch/arm/plat-mxc/irq-common.h b/arch/arm/plat-mxc/irq-common.h
index 7203543..6ccb3a1 100644
--- a/arch/arm/plat-mxc/irq-common.h
+++ b/arch/arm/plat-mxc/irq-common.h
@@ -19,9 +19,8 @@
 #ifndef __PLAT_MXC_IRQ_COMMON_H__
 #define __PLAT_MXC_IRQ_COMMON_H__
 
-struct mxc_irq_chip
+struct mxc_extra_irq
 {
-	struct irq_chip	base;
 	int (*set_priority)(unsigned char irq, unsigned char prio);
 	int (*set_irq_fiq)(unsigned int irq, unsigned int type);
 };
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index f257fcc..a580750 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -74,6 +74,12 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 
 static unsigned int *wakeup_intr[4];
 
+static struct mxc_extra_irq tzic_extra_irq = {
+#ifdef CONFIG_FIQ
+	.set_irq_fiq = tzic_set_irq_fiq,
+#endif
+};
+
 static __init void tzic_init_gc(unsigned int irq_start)
 {
 	struct irq_chip_generic *gc;
@@ -82,7 +88,7 @@ static __init void tzic_init_gc(unsigned int irq_start)
 
 	gc = irq_alloc_generic_chip("tzic", 1, irq_start, tzic_base,
 				    handle_level_irq);
-	gc->private = tzic_set_irq_fiq;
+	gc->private = &tzic_extra_irq;
 	gc->wake_enabled = IRQ_MSK(32);
 	wakeup_intr[idx] = &gc->wake_active;
 
-- 
1.7.6
