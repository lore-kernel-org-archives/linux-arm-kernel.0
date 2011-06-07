From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  7 Jun 2011 13:47:36 +0800
Subject: [PATCH] ARM: mxc: convert tzic to use generic irq chip
Message-ID: <1307425656-18040-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch converts mxc tzic interrupt controller to use generic irq
chip.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig               |    1 +
 arch/arm/plat-mxc/irq-common.c |   13 +++---
 arch/arm/plat-mxc/tzic.c       |   97 ++++++++++-----------------------------
 3 files changed, 32 insertions(+), 79 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..3002266 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -376,6 +376,7 @@ config ARCH_MXC
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
 	select HAVE_SCHED_CLOCK
 	help
 	  Support for Freescale MXC/iMX-based family of processors
diff --git a/arch/arm/plat-mxc/irq-common.c b/arch/arm/plat-mxc/irq-common.c
index e1c6eff..96953e2 100644
--- a/arch/arm/plat-mxc/irq-common.c
+++ b/arch/arm/plat-mxc/irq-common.c
@@ -42,17 +42,16 @@ EXPORT_SYMBOL(imx_irq_set_priority);
 
 int mxc_set_irq_fiq(unsigned int irq, unsigned int type)
 {
-	struct mxc_irq_chip *chip;
-	struct irq_chip *base;
+	struct irq_chip_generic *gc;
+	int (*set_irq_fiq)(unsigned int, unsigned int);
 	int ret;
 
 	ret = -ENOSYS;
 
-	base = irq_get_chip(irq);
-	if (base) {
-		chip = container_of(base, struct mxc_irq_chip, base);
-		if (chip->set_irq_fiq)
-			ret = chip->set_irq_fiq(irq, type);
+	gc = irq_get_chip_data(irq);
+	if (gc && gc->private) {
+		set_irq_fiq = gc->private;
+		ret = set_irq_fiq(irq, type);
 	}
 
 	return ret;
diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index 57f9395..d126bba 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -66,78 +66,34 @@ static int tzic_set_irq_fiq(unsigned int irq, unsigned int type)
 
 	return 0;
 }
+#else
+#define tzic_set_irq_fiq NULL
 #endif
 
-/**
- * tzic_mask_irq() - Disable interrupt source "d" in the TZIC
- *
- * @param  d            interrupt source
- */
-static void tzic_mask_irq(struct irq_data *d)
-{
-	int index, off;
-
-	index = d->irq >> 5;
-	off = d->irq & 0x1F;
-	__raw_writel(1 << off, tzic_base + TZIC_ENCLEAR0(index));
-}
-
-/**
- * tzic_unmask_irq() - Enable interrupt source "d" in the TZIC
- *
- * @param  d            interrupt source
- */
-static void tzic_unmask_irq(struct irq_data *d)
-{
-	int index, off;
-
-	index = d->irq >> 5;
-	off = d->irq & 0x1F;
-	__raw_writel(1 << off, tzic_base + TZIC_ENSET0(index));
-}
-
-static unsigned int wakeup_intr[4];
+static unsigned int *wakeup_intr[4];
 
-/**
- * tzic_set_wake_irq() - Set interrupt source "d" in the TZIC as a wake-up source.
- *
- * @param  d            interrupt source
- * @param  enable       enable as wake-up if equal to non-zero
- * 			disble as wake-up if equal to zero
- *
- * @return       This function returns 0 on success.
- */
-static int tzic_set_wake_irq(struct irq_data *d, unsigned int enable)
+static __init void tzic_init_gc(unsigned int irq_start)
 {
-	unsigned int index, off;
-
-	index = d->irq >> 5;
-	off = d->irq & 0x1F;
-
-	if (index > 3)
-		return -EINVAL;
-
-	if (enable)
-		wakeup_intr[index] |= (1 << off);
-	else
-		wakeup_intr[index] &= ~(1 << off);
-
-	return 0;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	int idx = irq_start >> 5;
+
+	gc = irq_alloc_generic_chip("tzic", 1, irq_start, tzic_base,
+				    handle_level_irq);
+	gc->private = tzic_set_irq_fiq;
+	gc->wake_enabled = IRQ_MSK(32);
+	wakeup_intr[idx] = &gc->wake_active;
+
+	ct = gc->chip_types;
+	ct->chip.irq_mask = irq_gc_mask_disable_reg;
+	ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
+	ct->chip.irq_set_wake = irq_gc_set_wake;
+	ct->regs.disable = TZIC_ENCLEAR0(idx);
+	ct->regs.enable = TZIC_ENSET0(idx);
+
+	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
 }
 
-static struct mxc_irq_chip mxc_tzic_chip = {
-	.base = {
-		.name = "MXC_TZIC",
-		.irq_ack = tzic_mask_irq,
-		.irq_mask = tzic_mask_irq,
-		.irq_unmask = tzic_unmask_irq,
-		.irq_set_wake = tzic_set_wake_irq,
-	},
-#ifdef CONFIG_FIQ
-	.set_irq_fiq = tzic_set_irq_fiq,
-#endif
-};
-
 /*
  * This function initializes the TZIC hardware and disables all the
  * interrupts. It registers the interrupt enable and disable functions
@@ -166,11 +122,8 @@ void __init tzic_init_irq(void __iomem *irqbase)
 
 	/* all IRQ no FIQ Warning :: No selection */
 
-	for (i = 0; i < MXC_INTERNAL_IRQS; i++) {
-		irq_set_chip_and_handler(i, &mxc_tzic_chip.base,
-					 handle_level_irq);
-		set_irq_flags(i, IRQF_VALID);
-	}
+	for (i = 0; i < MXC_INTERNAL_IRQS; i += 32)
+		tzic_init_gc(i);
 
 #ifdef CONFIG_FIQ
 	/* Initialize FIQ */
@@ -197,7 +150,7 @@ int tzic_enable_wake(int is_idle)
 
 	for (i = 0; i < 4; i++) {
 		v = is_idle ? __raw_readl(tzic_base + TZIC_ENSET0(i)) :
-			wakeup_intr[i];
+			*wakeup_intr[i];
 		__raw_writel(v, tzic_base + TZIC_WAKEUP0(i));
 	}
 
-- 
1.7.4.1
