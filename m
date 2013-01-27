From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 27 Jan 2013 21:40:30 +0100
Subject: [PATCH v4 4/9] ARM: S3C24XX: move s3c2416 irq init to common irq code
In-Reply-To: <201301272124.18530.heiko@sntech.de>
References: <201301272124.18530.heiko@sntech.de>
Message-ID: <201301272140.31054.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is needed to further clean up the irq init.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Makefile      |    2 +-
 arch/arm/mach-s3c24xx/irq-pm.c      |   23 +++
 arch/arm/mach-s3c24xx/irq-s3c2416.c |  348 -----------------------------------
 arch/arm/plat-s3c24xx/irq.c         |  286 ++++++++++++++++++++++++++++
 4 files changed, 310 insertions(+), 349 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2416.c

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 08b87cd..68d134f 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_S3C2412_DMA)	+= dma-s3c2412.o
 obj-$(CONFIG_S3C2412_PM)	+= pm-s3c2412.o
 obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
 
-obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o irq-s3c2416.o clock-s3c2416.o
+obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o clock-s3c2416.o
 obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
 
 obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o irq-s3c2440.o clock-s3c2440.o
diff --git a/arch/arm/mach-s3c24xx/irq-pm.c b/arch/arm/mach-s3c24xx/irq-pm.c
index 640ec91..e119959 100644
--- a/arch/arm/mach-s3c24xx/irq-pm.c
+++ b/arch/arm/mach-s3c24xx/irq-pm.c
@@ -99,3 +99,26 @@ struct syscore_ops s3c24xx_irq_syscore_ops = {
 	.suspend	= s3c24xx_irq_suspend,
 	.resume		= s3c24xx_irq_resume,
 };
+
+#ifdef CONFIG_CPU_S3C2416
+static struct sleep_save s3c2416_irq_save[] = {
+	SAVE_ITEM(S3C2416_INTMSK2),
+};
+
+static int s3c2416_irq_suspend(void)
+{
+	s3c_pm_do_save(s3c2416_irq_save, ARRAY_SIZE(s3c2416_irq_save));
+
+	return 0;
+}
+
+static void s3c2416_irq_resume(void)
+{
+	s3c_pm_do_restore(s3c2416_irq_save, ARRAY_SIZE(s3c2416_irq_save));
+}
+
+struct syscore_ops s3c2416_irq_syscore_ops = {
+	.suspend	= s3c2416_irq_suspend,
+	.resume		= s3c2416_irq_resume,
+};
+#endif
diff --git a/arch/arm/mach-s3c24xx/irq-s3c2416.c b/arch/arm/mach-s3c24xx/irq-s3c2416.c
deleted file mode 100644
index ff141b0..0000000
--- a/arch/arm/mach-s3c24xx/irq-s3c2416.c
+++ /dev/null
@@ -1,348 +0,0 @@
-/* linux/arch/arm/mach-s3c2416/irq.c
- *
- * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
- *	as part of OpenInkpot project
- * Copyright (c) 2009 Promwad Innovation Company
- *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
-*/
-
-#include <linux/init.h>
-#include <linux/module.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/syscore_ops.h>
-
-#include <mach/hardware.h>
-#include <asm/irq.h>
-
-#include <asm/mach/irq.h>
-
-#include <mach/regs-irq.h>
-#include <mach/regs-gpio.h>
-
-#include <plat/cpu.h>
-#include <plat/pm.h>
-#include <plat/irq.h>
-
-#define INTMSK(start, end) ((1 << ((end) + 1 - (start))) - 1)
-
-static inline void s3c2416_irq_demux(unsigned int irq, unsigned int len)
-{
-	unsigned int subsrc, submsk;
-	unsigned int end;
-
-	/* read the current pending interrupts, and the mask
-	 * for what it is available */
-
-	subsrc = __raw_readl(S3C2410_SUBSRCPND);
-	submsk = __raw_readl(S3C2410_INTSUBMSK);
-
-	subsrc  &= ~submsk;
-	subsrc >>= (irq - S3C2410_IRQSUB(0));
-	subsrc  &= (1 << len)-1;
-
-	end = len + irq;
-
-	for (; irq < end && subsrc; irq++) {
-		if (subsrc & 1)
-			generic_handle_irq(irq);
-
-		subsrc >>= 1;
-	}
-}
-
-/* WDT/AC97 sub interrupts */
-
-static void s3c2416_irq_demux_wdtac97(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2416_irq_demux(IRQ_S3C2443_WDT, 4);
-}
-
-#define INTMSK_WDTAC97	(1UL << (IRQ_WDT - IRQ_EINT0))
-#define SUBMSK_WDTAC97	INTMSK(IRQ_S3C2443_WDT, IRQ_S3C2443_AC97)
-
-static void s3c2416_irq_wdtac97_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
-}
-
-static void s3c2416_irq_wdtac97_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_WDTAC97);
-}
-
-static void s3c2416_irq_wdtac97_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
-}
-
-static struct irq_chip s3c2416_irq_wdtac97 = {
-	.irq_mask	= s3c2416_irq_wdtac97_mask,
-	.irq_unmask	= s3c2416_irq_wdtac97_unmask,
-	.irq_ack	= s3c2416_irq_wdtac97_ack,
-};
-
-/* LCD sub interrupts */
-
-static void s3c2416_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2416_irq_demux(IRQ_S3C2443_LCD1, 4);
-}
-
-#define INTMSK_LCD	(1UL << (IRQ_LCD - IRQ_EINT0))
-#define SUBMSK_LCD	INTMSK(IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4)
-
-static void s3c2416_irq_lcd_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_LCD, SUBMSK_LCD);
-}
-
-static void s3c2416_irq_lcd_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_LCD);
-}
-
-static void s3c2416_irq_lcd_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_LCD, SUBMSK_LCD);
-}
-
-static struct irq_chip s3c2416_irq_lcd = {
-	.irq_mask	= s3c2416_irq_lcd_mask,
-	.irq_unmask	= s3c2416_irq_lcd_unmask,
-	.irq_ack	= s3c2416_irq_lcd_ack,
-};
-
-/* DMA sub interrupts */
-
-static void s3c2416_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2416_irq_demux(IRQ_S3C2443_DMA0, 6);
-}
-
-#define INTMSK_DMA	(1UL << (IRQ_S3C2443_DMA - IRQ_EINT0))
-#define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
-
-
-static void s3c2416_irq_dma_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_DMA, SUBMSK_DMA);
-}
-
-static void s3c2416_irq_dma_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_DMA);
-}
-
-static void s3c2416_irq_dma_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_DMA, SUBMSK_DMA);
-}
-
-static struct irq_chip s3c2416_irq_dma = {
-	.irq_mask	= s3c2416_irq_dma_mask,
-	.irq_unmask	= s3c2416_irq_dma_unmask,
-	.irq_ack	= s3c2416_irq_dma_ack,
-};
-
-/* UART3 sub interrupts */
-
-static void s3c2416_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
-{
-	s3c2416_irq_demux(IRQ_S3C2443_RX3, 3);
-}
-
-#define INTMSK_UART3	(1UL << (IRQ_S3C2443_UART3 - IRQ_EINT0))
-#define SUBMSK_UART3	(0x7 << (IRQ_S3C2443_RX3 - S3C2410_IRQSUB(0)))
-
-static void s3c2416_irq_uart3_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_UART3, SUBMSK_UART3);
-}
-
-static void s3c2416_irq_uart3_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_UART3);
-}
-
-static void s3c2416_irq_uart3_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_UART3, SUBMSK_UART3);
-}
-
-static struct irq_chip s3c2416_irq_uart3 = {
-	.irq_mask	= s3c2416_irq_uart3_mask,
-	.irq_unmask	= s3c2416_irq_uart3_unmask,
-	.irq_ack	= s3c2416_irq_uart3_ack,
-};
-
-/* second interrupt register */
-
-static inline void s3c2416_irq_ack_second(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
-
-	__raw_writel(bitval, S3C2416_SRCPND2);
-	__raw_writel(bitval, S3C2416_INTPND2);
-}
-
-static void s3c2416_irq_mask_second(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
-	unsigned long mask;
-
-	mask = __raw_readl(S3C2416_INTMSK2);
-	mask |= bitval;
-	__raw_writel(mask, S3C2416_INTMSK2);
-}
-
-static void s3c2416_irq_unmask_second(struct irq_data *data)
-{
-	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
-	unsigned long mask;
-
-	mask = __raw_readl(S3C2416_INTMSK2);
-	mask &= ~bitval;
-	__raw_writel(mask, S3C2416_INTMSK2);
-}
-
-struct irq_chip s3c2416_irq_second = {
-	.irq_ack	= s3c2416_irq_ack_second,
-	.irq_mask	= s3c2416_irq_mask_second,
-	.irq_unmask	= s3c2416_irq_unmask_second,
-};
-
-
-/* IRQ initialisation code */
-
-static int s3c2416_add_sub(unsigned int base,
-				   void (*demux)(unsigned int,
-						 struct irq_desc *),
-				   struct irq_chip *chip,
-				   unsigned int start, unsigned int end)
-{
-	unsigned int irqno;
-
-	irq_set_chip_and_handler(base, &s3c_irq_level_chip, handle_level_irq);
-	irq_set_chained_handler(base, demux);
-
-	for (irqno = start; irqno <= end; irqno++) {
-		irq_set_chip_and_handler(irqno, chip, handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
-
-	return 0;
-}
-
-static void s3c2416_irq_add_second(void)
-{
-	unsigned long pend;
-	unsigned long last;
-	int irqno;
-	int i;
-
-	/* first, clear all interrupts pending... */
-	last = 0;
-	for (i = 0; i < 4; i++) {
-		pend = __raw_readl(S3C2416_INTPND2);
-
-		if (pend == 0 || pend == last)
-			break;
-
-		__raw_writel(pend, S3C2416_SRCPND2);
-		__raw_writel(pend, S3C2416_INTPND2);
-		printk(KERN_INFO "irq: clearing pending status %08x\n",
-		       (int)pend);
-		last = pend;
-	}
-
-	for (irqno = IRQ_S3C2416_2D; irqno <= IRQ_S3C2416_I2S1; irqno++) {
-		switch (irqno) {
-		case IRQ_S3C2416_RESERVED2:
-		case IRQ_S3C2416_RESERVED3:
-			/* no IRQ here */
-			break;
-		default:
-			irq_set_chip_and_handler(irqno, &s3c2416_irq_second,
-						 handle_edge_irq);
-			set_irq_flags(irqno, IRQF_VALID);
-		}
-	}
-}
-
-static int s3c2416_irq_add(struct device *dev,
-				  struct subsys_interface *sif)
-{
-	printk(KERN_INFO "S3C2416: IRQ Support\n");
-
-	s3c2416_add_sub(IRQ_LCD, s3c2416_irq_demux_lcd, &s3c2416_irq_lcd,
-			IRQ_S3C2443_LCD2, IRQ_S3C2443_LCD4);
-
-	s3c2416_add_sub(IRQ_S3C2443_DMA, s3c2416_irq_demux_dma,
-			&s3c2416_irq_dma, IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5);
-
-	s3c2416_add_sub(IRQ_S3C2443_UART3, s3c2416_irq_demux_uart3,
-			&s3c2416_irq_uart3,
-			IRQ_S3C2443_RX3, IRQ_S3C2443_ERR3);
-
-	s3c2416_add_sub(IRQ_WDT, s3c2416_irq_demux_wdtac97,
-			&s3c2416_irq_wdtac97,
-			IRQ_S3C2443_WDT, IRQ_S3C2443_AC97);
-
-	s3c2416_irq_add_second();
-
-	return 0;
-}
-
-static struct subsys_interface s3c2416_irq_interface = {
-	.name		= "s3c2416_irq",
-	.subsys		= &s3c2416_subsys,
-	.add_dev	= s3c2416_irq_add,
-};
-
-static int __init s3c2416_irq_init(void)
-{
-	return subsys_interface_register(&s3c2416_irq_interface);
-}
-
-arch_initcall(s3c2416_irq_init);
-
-#ifdef CONFIG_PM
-static struct sleep_save irq_save[] = {
-	SAVE_ITEM(S3C2416_INTMSK2),
-};
-
-int s3c2416_irq_suspend(void)
-{
-	s3c_pm_do_save(irq_save, ARRAY_SIZE(irq_save));
-
-	return 0;
-}
-
-void s3c2416_irq_resume(void)
-{
-	s3c_pm_do_restore(irq_save, ARRAY_SIZE(irq_save));
-}
-
-struct syscore_ops s3c2416_irq_syscore_ops = {
-	.suspend	= s3c2416_irq_suspend,
-	.resume		= s3c2416_irq_resume,
-};
-#endif
diff --git a/arch/arm/plat-s3c24xx/irq.c b/arch/arm/plat-s3c24xx/irq.c
index adb4358..131f747 100644
--- a/arch/arm/plat-s3c24xx/irq.c
+++ b/arch/arm/plat-s3c24xx/irq.c
@@ -626,3 +626,289 @@ void __init s3c24xx_init_irq(void)
 	s3c24xx_init_intc(NULL, &init_subint[0], main_intc, 0x4a000018);
 	s3c24xx_init_intc(NULL, &init_eint[0], main_intc, 0x560000a4);
 }
+
+#ifdef CONFIG_CPU_S3C2416
+#define INTMSK(start, end) ((1 << ((end) + 1 - (start))) - 1)
+
+static inline void s3c2416_irq_demux(unsigned int irq, unsigned int len)
+{
+	unsigned int subsrc, submsk;
+	unsigned int end;
+
+	/* read the current pending interrupts, and the mask
+	 * for what it is available */
+
+	subsrc = __raw_readl(S3C2410_SUBSRCPND);
+	submsk = __raw_readl(S3C2410_INTSUBMSK);
+
+	subsrc  &= ~submsk;
+	subsrc >>= (irq - S3C2410_IRQSUB(0));
+	subsrc  &= (1 << len)-1;
+
+	end = len + irq;
+
+	for (; irq < end && subsrc; irq++) {
+		if (subsrc & 1)
+			generic_handle_irq(irq);
+
+		subsrc >>= 1;
+	}
+}
+
+/* WDT/AC97 sub interrupts */
+
+static void s3c2416_irq_demux_wdtac97(unsigned int irq, struct irq_desc *desc)
+{
+	s3c2416_irq_demux(IRQ_S3C2443_WDT, 4);
+}
+
+#define INTMSK_WDTAC97	(1UL << (IRQ_WDT - IRQ_EINT0))
+#define SUBMSK_WDTAC97	INTMSK(IRQ_S3C2443_WDT, IRQ_S3C2443_AC97)
+
+static void s3c2416_irq_wdtac97_mask(struct irq_data *data)
+{
+	s3c_irqsub_mask(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+}
+
+static void s3c2416_irq_wdtac97_unmask(struct irq_data *data)
+{
+	s3c_irqsub_unmask(data->irq, INTMSK_WDTAC97);
+}
+
+static void s3c2416_irq_wdtac97_ack(struct irq_data *data)
+{
+	s3c_irqsub_maskack(data->irq, INTMSK_WDTAC97, SUBMSK_WDTAC97);
+}
+
+static struct irq_chip s3c2416_irq_wdtac97 = {
+	.irq_mask	= s3c2416_irq_wdtac97_mask,
+	.irq_unmask	= s3c2416_irq_wdtac97_unmask,
+	.irq_ack	= s3c2416_irq_wdtac97_ack,
+};
+
+/* LCD sub interrupts */
+
+static void s3c2416_irq_demux_lcd(unsigned int irq, struct irq_desc *desc)
+{
+	s3c2416_irq_demux(IRQ_S3C2443_LCD1, 4);
+}
+
+#define INTMSK_LCD	(1UL << (IRQ_LCD - IRQ_EINT0))
+#define SUBMSK_LCD	INTMSK(IRQ_S3C2443_LCD1, IRQ_S3C2443_LCD4)
+
+static void s3c2416_irq_lcd_mask(struct irq_data *data)
+{
+	s3c_irqsub_mask(data->irq, INTMSK_LCD, SUBMSK_LCD);
+}
+
+static void s3c2416_irq_lcd_unmask(struct irq_data *data)
+{
+	s3c_irqsub_unmask(data->irq, INTMSK_LCD);
+}
+
+static void s3c2416_irq_lcd_ack(struct irq_data *data)
+{
+	s3c_irqsub_maskack(data->irq, INTMSK_LCD, SUBMSK_LCD);
+}
+
+static struct irq_chip s3c2416_irq_lcd = {
+	.irq_mask	= s3c2416_irq_lcd_mask,
+	.irq_unmask	= s3c2416_irq_lcd_unmask,
+	.irq_ack	= s3c2416_irq_lcd_ack,
+};
+
+/* DMA sub interrupts */
+
+static void s3c2416_irq_demux_dma(unsigned int irq, struct irq_desc *desc)
+{
+	s3c2416_irq_demux(IRQ_S3C2443_DMA0, 6);
+}
+
+#define INTMSK_DMA	(1UL << (IRQ_S3C2443_DMA - IRQ_EINT0))
+#define SUBMSK_DMA	INTMSK(IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5)
+
+
+static void s3c2416_irq_dma_mask(struct irq_data *data)
+{
+	s3c_irqsub_mask(data->irq, INTMSK_DMA, SUBMSK_DMA);
+}
+
+static void s3c2416_irq_dma_unmask(struct irq_data *data)
+{
+	s3c_irqsub_unmask(data->irq, INTMSK_DMA);
+}
+
+static void s3c2416_irq_dma_ack(struct irq_data *data)
+{
+	s3c_irqsub_maskack(data->irq, INTMSK_DMA, SUBMSK_DMA);
+}
+
+static struct irq_chip s3c2416_irq_dma = {
+	.irq_mask	= s3c2416_irq_dma_mask,
+	.irq_unmask	= s3c2416_irq_dma_unmask,
+	.irq_ack	= s3c2416_irq_dma_ack,
+};
+
+/* UART3 sub interrupts */
+
+static void s3c2416_irq_demux_uart3(unsigned int irq, struct irq_desc *desc)
+{
+	s3c2416_irq_demux(IRQ_S3C2443_RX3, 3);
+}
+
+#define INTMSK_UART3	(1UL << (IRQ_S3C2443_UART3 - IRQ_EINT0))
+#define SUBMSK_UART3	(0x7 << (IRQ_S3C2443_RX3 - S3C2410_IRQSUB(0)))
+
+static void s3c2416_irq_uart3_mask(struct irq_data *data)
+{
+	s3c_irqsub_mask(data->irq, INTMSK_UART3, SUBMSK_UART3);
+}
+
+static void s3c2416_irq_uart3_unmask(struct irq_data *data)
+{
+	s3c_irqsub_unmask(data->irq, INTMSK_UART3);
+}
+
+static void s3c2416_irq_uart3_ack(struct irq_data *data)
+{
+	s3c_irqsub_maskack(data->irq, INTMSK_UART3, SUBMSK_UART3);
+}
+
+static struct irq_chip s3c2416_irq_uart3 = {
+	.irq_mask	= s3c2416_irq_uart3_mask,
+	.irq_unmask	= s3c2416_irq_uart3_unmask,
+	.irq_ack	= s3c2416_irq_uart3_ack,
+};
+
+/* second interrupt register */
+
+static inline void s3c2416_irq_ack_second(struct irq_data *data)
+{
+	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
+
+	__raw_writel(bitval, S3C2416_SRCPND2);
+	__raw_writel(bitval, S3C2416_INTPND2);
+}
+
+static void s3c2416_irq_mask_second(struct irq_data *data)
+{
+	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
+	unsigned long mask;
+
+	mask = __raw_readl(S3C2416_INTMSK2);
+	mask |= bitval;
+	__raw_writel(mask, S3C2416_INTMSK2);
+}
+
+static void s3c2416_irq_unmask_second(struct irq_data *data)
+{
+	unsigned long bitval = 1UL << (data->irq - IRQ_S3C2416_2D);
+	unsigned long mask;
+
+	mask = __raw_readl(S3C2416_INTMSK2);
+	mask &= ~bitval;
+	__raw_writel(mask, S3C2416_INTMSK2);
+}
+
+static struct irq_chip s3c2416_irq_second = {
+	.irq_ack	= s3c2416_irq_ack_second,
+	.irq_mask	= s3c2416_irq_mask_second,
+	.irq_unmask	= s3c2416_irq_unmask_second,
+};
+
+
+/* IRQ initialisation code */
+
+static int s3c2416_add_sub(unsigned int base,
+				   void (*demux)(unsigned int,
+						 struct irq_desc *),
+				   struct irq_chip *chip,
+				   unsigned int start, unsigned int end)
+{
+	unsigned int irqno;
+
+	irq_set_chip_and_handler(base, &s3c_irq_level_chip, handle_level_irq);
+	irq_set_chained_handler(base, demux);
+
+	for (irqno = start; irqno <= end; irqno++) {
+		irq_set_chip_and_handler(irqno, chip, handle_level_irq);
+		set_irq_flags(irqno, IRQF_VALID);
+	}
+
+	return 0;
+}
+
+static void s3c2416_irq_add_second(void)
+{
+	unsigned long pend;
+	unsigned long last;
+	int irqno;
+	int i;
+
+	/* first, clear all interrupts pending... */
+	last = 0;
+	for (i = 0; i < 4; i++) {
+		pend = __raw_readl(S3C2416_INTPND2);
+
+		if (pend == 0 || pend == last)
+			break;
+
+		__raw_writel(pend, S3C2416_SRCPND2);
+		__raw_writel(pend, S3C2416_INTPND2);
+		printk(KERN_INFO "irq: clearing pending status %08x\n",
+		       (int)pend);
+		last = pend;
+	}
+
+	for (irqno = IRQ_S3C2416_2D; irqno <= IRQ_S3C2416_I2S1; irqno++) {
+		switch (irqno) {
+		case IRQ_S3C2416_RESERVED2:
+		case IRQ_S3C2416_RESERVED3:
+			/* no IRQ here */
+			break;
+		default:
+			irq_set_chip_and_handler(irqno, &s3c2416_irq_second,
+						 handle_edge_irq);
+			set_irq_flags(irqno, IRQF_VALID);
+		}
+	}
+}
+
+static int s3c2416_irq_add(struct device *dev,
+				  struct subsys_interface *sif)
+{
+	printk(KERN_INFO "S3C2416: IRQ Support\n");
+
+	s3c2416_add_sub(IRQ_LCD, s3c2416_irq_demux_lcd, &s3c2416_irq_lcd,
+			IRQ_S3C2443_LCD2, IRQ_S3C2443_LCD4);
+
+	s3c2416_add_sub(IRQ_S3C2443_DMA, s3c2416_irq_demux_dma,
+			&s3c2416_irq_dma, IRQ_S3C2443_DMA0, IRQ_S3C2443_DMA5);
+
+	s3c2416_add_sub(IRQ_S3C2443_UART3, s3c2416_irq_demux_uart3,
+			&s3c2416_irq_uart3,
+			IRQ_S3C2443_RX3, IRQ_S3C2443_ERR3);
+
+	s3c2416_add_sub(IRQ_WDT, s3c2416_irq_demux_wdtac97,
+			&s3c2416_irq_wdtac97,
+			IRQ_S3C2443_WDT, IRQ_S3C2443_AC97);
+
+	s3c2416_irq_add_second();
+
+	return 0;
+}
+
+static struct subsys_interface s3c2416_irq_interface = {
+	.name		= "s3c2416_irq",
+	.subsys		= &s3c2416_subsys,
+	.add_dev	= s3c2416_irq_add,
+};
+
+static int __init s3c2416_irq_init(void)
+{
+	return subsys_interface_register(&s3c2416_irq_interface);
+}
+
+arch_initcall(s3c2416_irq_init);
+
+#endif
-- 
1.7.10.4
