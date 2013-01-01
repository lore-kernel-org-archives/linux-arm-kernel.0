From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Tue, 1 Jan 2013 22:53:19 +0100
Subject: [PATCH v2 02/11] ARM: S3C24XX: move irq-pm code into main irq file
In-Reply-To: <201301012251.15899.heiko@sntech.de>
References: <201301012251.15899.heiko@sntech.de>
Message-ID: <201301012253.20093.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With this change, it's possible to make more elements static
and also reduce the number of .h elements further down the road.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Makefile |    2 +-
 arch/arm/mach-s3c24xx/irq-pm.c |   95 ----------------------------------------
 arch/arm/plat-s3c24xx/irq.c    |   76 ++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 96 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/irq-pm.c

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 0ab6ab1..3e1d12c 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_CPU_S3C2443)	+= s3c2443.o irq-s3c2443.o clock-s3c2443.o
 
 # PM
 
-obj-$(CONFIG_PM)		+= pm.o irq-pm.o sleep.o
+obj-$(CONFIG_PM)		+= pm.o sleep.o
 
 # common code
 
diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
deleted file mode 100644
index 0efb2e2..0000000
--- a/arch/arm/mach-s3c24xx/irq-pm.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/irq-om.c
- *
- * Copyright (c) 2003-2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C24XX - IRQ PM code
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-
-#include <plat/cpu.h>
-#include <plat/pm.h>
-#include <plat/irq.h>
-
-#include <asm/irq.h>
-
-/* state for IRQs over sleep */
-
-/* default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
- *
- * set bit to 1 in allow bitfield to enable the wakeup settings on it
-*/
-
-unsigned long s3c_irqwake_intallow	= 1L << (IRQ_RTC - IRQ_EINT0) | 0xfL;
-unsigned long s3c_irqwake_eintallow	= 0x0000fff0L;
-
-int s3c_irq_wake(struct irq_data *data, unsigned int state)
-{
-	unsigned long irqbit = 1 << (data->irq - IRQ_EINT0);
-
-	if (!(s3c_irqwake_intallow & irqbit))
-		return -ENOENT;
-
-	printk(KERN_INFO "wake %s for irq %d\n",
-	       state ? "enabled" : "disabled", data->irq);
-
-	if (!state)
-		s3c_irqwake_intmask |= irqbit;
-	else
-		s3c_irqwake_intmask &= ~irqbit;
-
-	return 0;
-}
-
-static struct sleep_save irq_save[] = {
-	SAVE_ITEM(S3C2410_INTMSK),
-	SAVE_ITEM(S3C2410_INTSUBMSK),
-};
-
-/* the extint values move between the s3c2410/s3c2440 and the s3c2412
- * so we use an array to hold them, and to calculate the address of
- * the register at run-time
-*/
-
-static unsigned long save_extint[3];
-static unsigned long save_eintflt[4];
-static unsigned long save_eintmask;
-
-int s3c24xx_irq_suspend(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(save_extint); i++)
-		save_extint[i] = __raw_readl(S3C24XX_EXTINT0 + (i*4));
-
-	for (i = 0; i < ARRAY_SIZE(save_eintflt); i++)
-		save_eintflt[i] = __raw_readl(S3C24XX_EINFLT0 + (i*4));
-
-	s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
-	save_eintmask = __raw_readl(S3C24XX_EINTMASK);
-
-	return 0;
-}
-
-void s3c24xx_irq_resume(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < ARRAY_SIZE(save_extint); i++)
-		__raw_writel(save_extint[i], S3C24XX_EXTINT0 + (i*4));
-
-	for (i = 0; i < ARRAY_SIZE(save_eintflt); i++)
-		__raw_writel(save_eintflt[i], S3C24XX_EINFLT0 + (i*4));
-
-	s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
-	__raw_writel(save_eintmask, S3C24XX_EINTMASK);
-}
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index 19ea087..9b4404d 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -133,6 +133,36 @@ static inline void s3c_irq_maskack(struct irq_data *data)
 	s3c_irq_ack(data);
 }
 
+#ifdef CONFIG_PM
+/* state for IRQs over sleep */
+
+/* default is to allow for EINT0..EINT15, and IRQ_RTC as wakeup sources
+ *
+ * set bit to 1 in allow bitfield to enable the wakeup settings on it
+*/
+
+unsigned long s3c_irqwake_intallow	= 1L << (IRQ_RTC - IRQ_EINT0) | 0xfL;
+unsigned long s3c_irqwake_eintallow	= 0x0000fff0L;
+
+int s3c_irq_wake(struct irq_data *data, unsigned int state)
+{
+	unsigned long irqbit = 1 << (data->irq - IRQ_EINT0);
+
+	if (!(s3c_irqwake_intallow & irqbit))
+		return -ENOENT;
+
+	printk(KERN_INFO "wake %s for irq %d\n",
+	       state ? "enabled" : "disabled", data->irq);
+
+	if (!state)
+		s3c_irqwake_intmask |= irqbit;
+	else
+		s3c_irqwake_intmask &= ~irqbit;
+
+	return 0;
+}
+#endif
+
 struct irq_chip s3c_irq_level_chip = {
 	.name		= "s3c-level",
 	.irq_ack	= s3c_irq_maskack,
@@ -590,6 +620,52 @@ void __init s3c24xx_init_irq(void)
 					       &s3c24xx_irq_ops, &s3c_intc[2]);
 }
 
+#ifdef CONFIG_PM
+static struct sleep_save irq_save[] = {
+	SAVE_ITEM(S3C2410_INTMSK),
+	SAVE_ITEM(S3C2410_INTSUBMSK),
+};
+
+/* the extint values move between the s3c2410/s3c2440 and the s3c2412
+ * so we use an array to hold them, and to calculate the address of
+ * the register at run-time
+*/
+
+static unsigned long save_extint[3];
+static unsigned long save_eintflt[4];
+static unsigned long save_eintmask;
+
+int s3c24xx_irq_suspend(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(save_extint); i++)
+		save_extint[i] = __raw_readl(S3C24XX_EXTINT0 + (i*4));
+
+	for (i = 0; i < ARRAY_SIZE(save_eintflt); i++)
+		save_eintflt[i] = __raw_readl(S3C24XX_EINFLT0 + (i*4));
+
+	s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
+	save_eintmask = __raw_readl(S3C24XX_EINTMASK);
+
+	return 0;
+}
+
+void s3c24xx_irq_resume(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(save_extint); i++)
+		__raw_writel(save_extint[i], S3C24XX_EXTINT0 + (i*4));
+
+	for (i = 0; i < ARRAY_SIZE(save_eintflt); i++)
+		__raw_writel(save_eintflt[i], S3C24XX_EINFLT0 + (i*4));
+
+	s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
+	__raw_writel(save_eintmask, S3C24XX_EINTMASK);
+}
+#endif
+
 struct syscore_ops s3c24xx_irq_syscore_ops = {
 	.suspend	= s3c24xx_irq_suspend,
 	.resume		= s3c24xx_irq_resume,
-- 
1.7.2.3
