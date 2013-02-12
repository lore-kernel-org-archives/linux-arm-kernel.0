From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 12 Feb 2013 20:42:32 +0100
Subject: [PATCH] ARM: S3C24XX: remove plat-samsung/irq.h
Message-ID: <201302122042.32471.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

plat-samsung/irq.h did only contain functions for handling the spread out
subirqs on s3c24xx arches, which are not needed anymore.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
Sorry for bringing this separate submission, but I just remembered
it this evening.

This applies on top of all the other s3c24xx irq changes and
I think this patch will mark the end of the irq-cleanup for now.

 arch/arm/mach-s3c24xx/irq-pm.c           |    7 ++-
 arch/arm/mach-s3c24xx/irq.c              |    8 +--
 arch/arm/plat-samsung/include/plat/irq.h |  116 ------------------------------
 3 files changed, 9 insertions(+), 122 deletions(-)
 delete mode 100644 arch/arm/plat-samsung/include/plat/irq.h

diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
index e119959..b91341e 100644
--- a/arch/arm/mach-s3c24xx/irq-pm.c
+++ b/arch/arm/mach-s3c24xx/irq-pm.c
@@ -16,10 +16,15 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/syscore_ops.h>
+#include <linux/io.h>
 
 #include <plat/cpu.h>
 #include <plat/pm.h>
-#include <plat/irq.h>
+#include <plat/map-base.h>
+#include <plat/map-s3c.h>
+
+#include <mach/regs-irq.h>
+#include <mach/regs-gpio.h>
 
 #include <asm/irq.h>
 
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index debf606..3f3de74 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -34,7 +34,6 @@
 #include <plat/cpu.h>
 #include <plat/regs-irqtype.h>
 #include <plat/pm.h>
-#include <plat/irq.h>
 
 #define S3C_IRQTYPE_NONE	0
 #define S3C_IRQTYPE_EINT	1
@@ -175,8 +174,7 @@ static int s3c_irqext_type_set(void __iomem *gpcon_reg,
 	return 0;
 }
 
-/* FIXME: make static when it's out of plat-samsung/irq.h */
-int s3c_irqext_type(struct irq_data *data, unsigned int type)
+static int s3c_irqext_type(struct irq_data *data, unsigned int type)
 {
 	void __iomem *extint_reg;
 	void __iomem *gpcon_reg;
@@ -224,7 +222,7 @@ static int s3c_irqext0_type(struct irq_data *data, unsigned int type)
 				   extint_offset, type);
 }
 
-struct irq_chip s3c_irq_chip = {
+static struct irq_chip s3c_irq_chip = {
 	.name		= "s3c",
 	.irq_ack	= s3c_irq_ack,
 	.irq_mask	= s3c_irq_mask,
@@ -232,7 +230,7 @@ struct irq_chip s3c_irq_chip = {
 	.irq_set_wake	= s3c_irq_wake
 };
 
-struct irq_chip s3c_irq_level_chip = {
+static struct irq_chip s3c_irq_level_chip = {
 	.name		= "s3c-level",
 	.irq_mask	= s3c_irq_mask,
 	.irq_unmask	= s3c_irq_unmask,
diff --git a/arch/arm/plat-samsung/include/plat/irq.h b/arch/arm/plat-samsung/include/plat/irq.h
deleted file mode 100644
index e21a89b..0000000
--- a/arch/arm/plat-samsung/include/plat/irq.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/* linux/arch/arm/plat-samsung/include/plat/irq.h
- *
- * Copyright (c) 2004-2005 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Header file for S3C24XX CPU IRQ support
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/regs-irq.h>
-#include <mach/regs-gpio.h>
-
-#define irqdbf(x...)
-#define irqdbf2(x...)
-
-#define EXTINT_OFF (IRQ_EINT4 - 4)
-
-/* these are exported for arch/arm/mach-* usage */
-extern struct irq_chip s3c_irq_level_chip;
-extern struct irq_chip s3c_irq_chip;
-
-static inline void s3c_irqsub_mask(unsigned int irqno,
-				   unsigned int parentbit,
-				   int subcheck)
-{
-	unsigned long mask;
-	unsigned long submask;
-
-	submask = __raw_readl(S3C2410_INTSUBMSK);
-	mask = __raw_readl(S3C2410_INTMSK);
-
-	submask |= (1UL << (irqno - IRQ_S3CUART_RX0));
-
-	/* check to see if we need to mask the parent IRQ */
-
-	if ((submask  & subcheck) == subcheck)
-		__raw_writel(mask | parentbit, S3C2410_INTMSK);
-
-	/* write back masks */
-	__raw_writel(submask, S3C2410_INTSUBMSK);
-
-}
-
-static inline void s3c_irqsub_unmask(unsigned int irqno,
-				     unsigned int parentbit)
-{
-	unsigned long mask;
-	unsigned long submask;
-
-	submask = __raw_readl(S3C2410_INTSUBMSK);
-	mask = __raw_readl(S3C2410_INTMSK);
-
-	submask &= ~(1UL << (irqno - IRQ_S3CUART_RX0));
-	mask &= ~parentbit;
-
-	/* write back masks */
-	__raw_writel(submask, S3C2410_INTSUBMSK);
-	__raw_writel(mask, S3C2410_INTMSK);
-}
-
-
-static inline void s3c_irqsub_maskack(unsigned int irqno,
-				      unsigned int parentmask,
-				      unsigned int group)
-{
-	unsigned int bit = 1UL << (irqno - IRQ_S3CUART_RX0);
-
-	s3c_irqsub_mask(irqno, parentmask, group);
-
-	__raw_writel(bit, S3C2410_SUBSRCPND);
-
-	/* only ack parent if we've got all the irqs (seems we must
-	 * ack, all and hope that the irq system retriggers ok when
-	 * the interrupt goes off again)
-	 */
-
-	if (1) {
-		__raw_writel(parentmask, S3C2410_SRCPND);
-		__raw_writel(parentmask, S3C2410_INTPND);
-	}
-}
-
-static inline void s3c_irqsub_ack(unsigned int irqno,
-				  unsigned int parentmask,
-				  unsigned int group)
-{
-	unsigned int bit = 1UL << (irqno - IRQ_S3CUART_RX0);
-
-	__raw_writel(bit, S3C2410_SUBSRCPND);
-
-	/* only ack parent if we've got all the irqs (seems we must
-	 * ack, all and hope that the irq system retriggers ok when
-	 * the interrupt goes off again)
-	 */
-
-	if (1) {
-		__raw_writel(parentmask, S3C2410_SRCPND);
-		__raw_writel(parentmask, S3C2410_INTPND);
-	}
-}
-
-/* exported for use in arch/arm/mach-s3c2410 */
-
-#ifdef CONFIG_PM
-extern int s3c_irq_wake(struct irq_data *data, unsigned int state);
-#else
-#define s3c_irq_wake NULL
-#endif
-
-extern int s3c_irqext_type(struct irq_data *d, unsigned int type);
-- 
1.7.2.3
