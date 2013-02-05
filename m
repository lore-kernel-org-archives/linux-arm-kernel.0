From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Wed, 6 Feb 2013 00:13:12 +0100
Subject: [PATCH 3/6] ARM: S3C24XX: move s3c2440 irqs to common irq code
In-Reply-To: <201302060010.53929.heiko@sntech.de>
References: <201302060010.53929.heiko@sntech.de>
Message-ID: <201302060013.12890.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will be integrated in the following patch.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Makefile      |    2 +-
 arch/arm/mach-s3c24xx/irq-s3c2440.c |  128 -----------------------------------
 arch/arm/mach-s3c24xx/irq.c         |   88 ++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 129 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c2440.c

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index 051b8f9..9041260 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -31,7 +31,7 @@ obj-$(CONFIG_S3C2412_PM_SLEEP)	+= sleep-s3c2412.o
 obj-$(CONFIG_CPU_S3C2416)	+= s3c2416.o clock-s3c2416.o
 obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
 
-obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o irq-s3c2440.o clock-s3c2440.o
+obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o clock-s3c2440.o
 obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
 obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o clock-s3c244x.o
 obj-$(CONFIG_S3C2440_CPUFREQ)	+= cpufreq-s3c2440.o
diff --git a/arch/arm/mach-s3c24xx/irq-s3c2440.c b/arch/arm/mach-s3c24xx/irq-s3c2440.c
deleted file mode 100644
index 4a18cde..0000000
--- a/arch/arm/mach-s3c24xx/irq-s3c2440.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/* linux/arch/arm/mach-s3c2440/irq.c
- *
- * Copyright (c) 2003-2004 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
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
-/* WDT/AC97 */
-
-static void s3c_irq_demux_wdtac97(unsigned int irq,
-				  struct irq_desc *desc)
-{
-	unsigned int subsrc, submsk;
-
-	/* read the current pending interrupts, and the mask
-	 * for what it is available */
-
-	subsrc = __raw_readl(S3C2410_SUBSRCPND);
-	submsk = __raw_readl(S3C2410_INTSUBMSK);
-
-	subsrc &= ~submsk;
-	subsrc >>= 13;
-	subsrc &= 3;
-
-	if (subsrc != 0) {
-		if (subsrc & 1) {
-			generic_handle_irq(IRQ_S3C2440_WDT);
-		}
-		if (subsrc & 2) {
-			generic_handle_irq(IRQ_S3C2440_AC97);
-		}
-	}
-}
-
-
-#define INTMSK_WDT	 (1UL << (IRQ_WDT - IRQ_EINT0))
-
-static void
-s3c_irq_wdtac97_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_WDT, 3 << 13);
-}
-
-static void
-s3c_irq_wdtac97_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_WDT);
-}
-
-static void
-s3c_irq_wdtac97_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_WDT, 3 << 13);
-}
-
-static struct irq_chip s3c_irq_wdtac97 = {
-	.irq_mask	= s3c_irq_wdtac97_mask,
-	.irq_unmask	= s3c_irq_wdtac97_unmask,
-	.irq_ack	= s3c_irq_wdtac97_ack,
-};
-
-static int s3c2440_irq_add(struct device *dev, struct subsys_interface *sif)
-{
-	unsigned int irqno;
-
-	printk("S3C2440: IRQ Support\n");
-
-	/* add new chained handler for wdt, ac7 */
-
-	irq_set_chip_and_handler(IRQ_WDT, &s3c_irq_level_chip,
-				 handle_level_irq);
-	irq_set_chained_handler(IRQ_WDT, s3c_irq_demux_wdtac97);
-
-	for (irqno = IRQ_S3C2440_WDT; irqno <= IRQ_S3C2440_AC97; irqno++) {
-		irq_set_chip_and_handler(irqno, &s3c_irq_wdtac97,
-					 handle_level_irq);
-		set_irq_flags(irqno, IRQF_VALID);
-	}
-
-	return 0;
-}
-
-static struct subsys_interface s3c2440_irq_interface = {
-	.name		= "s3c2440_irq",
-	.subsys		= &s3c2440_subsys,
-	.add_dev	= s3c2440_irq_add,
-};
-
-static int s3c2440_irq_init(void)
-{
-	return subsys_interface_register(&s3c2440_irq_interface);
-}
-
-arch_initcall(s3c2440_irq_init);
-
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index c544e00..592072b 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -786,6 +786,94 @@ static struct irq_chip s3c_irq_cam = {
 };
 
 #ifdef CONFIG_CPU_S3C2440
+/* WDT/AC97 */
+
+static void s3c_irq_demux_wdtac97(unsigned int irq,
+				  struct irq_desc *desc)
+{
+	unsigned int subsrc, submsk;
+
+	/* read the current pending interrupts, and the mask
+	 * for what it is available */
+
+	subsrc = __raw_readl(S3C2410_SUBSRCPND);
+	submsk = __raw_readl(S3C2410_INTSUBMSK);
+
+	subsrc &= ~submsk;
+	subsrc >>= 13;
+	subsrc &= 3;
+
+	if (subsrc != 0) {
+		if (subsrc & 1) {
+			generic_handle_irq(IRQ_S3C2440_WDT);
+		}
+		if (subsrc & 2) {
+			generic_handle_irq(IRQ_S3C2440_AC97);
+		}
+	}
+}
+
+
+#define INTMSK_WDT	 (1UL << (IRQ_WDT - IRQ_EINT0))
+
+static void
+s3c_irq_wdtac97_mask(struct irq_data *data)
+{
+	s3c_irqsub_mask(data->irq, INTMSK_WDT, 3 << 13);
+}
+
+static void
+s3c_irq_wdtac97_unmask(struct irq_data *data)
+{
+	s3c_irqsub_unmask(data->irq, INTMSK_WDT);
+}
+
+static void
+s3c_irq_wdtac97_ack(struct irq_data *data)
+{
+	s3c_irqsub_maskack(data->irq, INTMSK_WDT, 3 << 13);
+}
+
+static struct irq_chip s3c_irq_wdtac97 = {
+	.irq_mask	= s3c_irq_wdtac97_mask,
+	.irq_unmask	= s3c_irq_wdtac97_unmask,
+	.irq_ack	= s3c_irq_wdtac97_ack,
+};
+
+static int s3c2440_irq_add(struct device *dev, struct subsys_interface *sif)
+{
+	unsigned int irqno;
+
+	printk("S3C2440: IRQ Support\n");
+
+	/* add new chained handler for wdt, ac7 */
+
+	irq_set_chip_and_handler(IRQ_WDT, &s3c_irq_level_chip,
+				 handle_level_irq);
+	irq_set_chained_handler(IRQ_WDT, s3c_irq_demux_wdtac97);
+
+	for (irqno = IRQ_S3C2440_WDT; irqno <= IRQ_S3C2440_AC97; irqno++) {
+		irq_set_chip_and_handler(irqno, &s3c_irq_wdtac97,
+					 handle_level_irq);
+		set_irq_flags(irqno, IRQF_VALID);
+	}
+
+	return 0;
+}
+
+static struct subsys_interface s3c2440_irq_interface = {
+	.name		= "s3c2440_irq",
+	.subsys		= &s3c2440_subsys,
+	.add_dev	= s3c2440_irq_add,
+};
+
+static int s3c2440_irq_init(void)
+{
+	return subsys_interface_register(&s3c2440_irq_interface);
+}
+
+arch_initcall(s3c2440_irq_init);
+
 void __init s3c2440_init_irq(void)
 {
 	unsigned int irqno;
-- 
1.7.2.3
