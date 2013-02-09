From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sat, 9 Feb 2013 18:12:08 +0100
Subject: [PATCH v2 01/10] ARM: S3C24XX: move s3c244x irq init to common irq
 code
In-Reply-To: <201302091811.05437.heiko@sntech.de>
References: <201302091811.05437.heiko@sntech.de>
Message-ID: <201302091812.08848.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Base for further modifications.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Makefile      |    2 +-
 arch/arm/mach-s3c24xx/irq-s3c244x.c |  142 -----------------------------------
 arch/arm/mach-s3c24xx/irq.c         |  105 ++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 143 deletions(-)
 delete mode 100644 arch/arm/mach-s3c24xx/irq-s3c244x.c

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index af53d27..051b8f9 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -33,7 +33,7 @@ obj-$(CONFIG_S3C2416_PM)	+= pm-s3c2416.o
 
 obj-$(CONFIG_CPU_S3C2440)	+= s3c2440.o irq-s3c2440.o clock-s3c2440.o
 obj-$(CONFIG_CPU_S3C2442)	+= s3c2442.o
-obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o irq-s3c244x.o clock-s3c244x.o
+obj-$(CONFIG_CPU_S3C244X)	+= s3c244x.o clock-s3c244x.o
 obj-$(CONFIG_S3C2440_CPUFREQ)	+= cpufreq-s3c2440.o
 obj-$(CONFIG_S3C2440_DMA)	+= dma-s3c2440.o
 obj-$(CONFIG_S3C2440_PLL_12000000) += pll-s3c2440-12000000.o
diff --git a/arch/arm/mach-s3c24xx/irq-s3c244x.c b/arch/arm/mach-s3c24xx/irq-s3c244x.c
deleted file mode 100644
index 5fe8e58..0000000
--- a/arch/arm/mach-s3c24xx/irq-s3c244x.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/* linux/arch/arm/plat-s3c24xx/s3c244x-irq.c
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
-/* camera irq */
-
-static void s3c_irq_demux_cam(unsigned int irq,
-			      struct irq_desc *desc)
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
-	subsrc >>= 11;
-	subsrc &= 3;
-
-	if (subsrc != 0) {
-		if (subsrc & 1) {
-			generic_handle_irq(IRQ_S3C2440_CAM_C);
-		}
-		if (subsrc & 2) {
-			generic_handle_irq(IRQ_S3C2440_CAM_P);
-		}
-	}
-}
-
-#define INTMSK_CAM (1UL << (IRQ_CAM - IRQ_EINT0))
-
-static void
-s3c_irq_cam_mask(struct irq_data *data)
-{
-	s3c_irqsub_mask(data->irq, INTMSK_CAM, 3 << 11);
-}
-
-static void
-s3c_irq_cam_unmask(struct irq_data *data)
-{
-	s3c_irqsub_unmask(data->irq, INTMSK_CAM);
-}
-
-static void
-s3c_irq_cam_ack(struct irq_data *data)
-{
-	s3c_irqsub_maskack(data->irq, INTMSK_CAM, 3 << 11);
-}
-
-static struct irq_chip s3c_irq_cam = {
-	.irq_mask	= s3c_irq_cam_mask,
-	.irq_unmask	= s3c_irq_cam_unmask,
-	.irq_ack	= s3c_irq_cam_ack,
-};
-
-static int s3c244x_irq_add(struct device *dev, struct subsys_interface *sif)
-{
-	unsigned int irqno;
-
-	irq_set_chip_and_handler(IRQ_NFCON, &s3c_irq_level_chip,
-				 handle_level_irq);
-	set_irq_flags(IRQ_NFCON, IRQF_VALID);
-
-	/* add chained handler for camera */
-
-	irq_set_chip_and_handler(IRQ_CAM, &s3c_irq_level_chip,
-				 handle_level_irq);
-	irq_set_chained_handler(IRQ_CAM, s3c_irq_demux_cam);
-
-	for (irqno = IRQ_S3C2440_CAM_C; irqno <= IRQ_S3C2440_CAM_P; irqno++) {
-		irq_set_chip_and_handler(irqno, &s3c_irq_cam,
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
-	.add_dev	= s3c244x_irq_add,
-};
-
-static int s3c2440_irq_init(void)
-{
-	return subsys_interface_register(&s3c2440_irq_interface);
-}
-
-arch_initcall(s3c2440_irq_init);
-
-static struct subsys_interface s3c2442_irq_interface = {
-	.name		= "s3c2442_irq",
-	.subsys		= &s3c2442_subsys,
-	.add_dev	= s3c244x_irq_add,
-};
-
-
-static int s3c2442_irq_init(void)
-{
-	return subsys_interface_register(&s3c2442_irq_interface);
-}
-
-arch_initcall(s3c2442_irq_init);
diff --git a/arch/arm/mach-s3c24xx/irq.c b/arch/arm/mach-s3c24xx/irq.c
index cb9f5e0..95f971f 100644
--- a/arch/arm/mach-s3c24xx/irq.c
+++ b/arch/arm/mach-s3c24xx/irq.c
@@ -731,6 +731,111 @@ void __init s3c2416_init_irq(void)
 
 #endif
 
+#ifdef CONFIG_CPU_S3C244X
+/* camera irq */
+
+static void s3c_irq_demux_cam(unsigned int irq,
+			      struct irq_desc *desc)
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
+	subsrc >>= 11;
+	subsrc &= 3;
+
+	if (subsrc != 0) {
+		if (subsrc & 1) {
+			generic_handle_irq(IRQ_S3C2440_CAM_C);
+		}
+		if (subsrc & 2) {
+			generic_handle_irq(IRQ_S3C2440_CAM_P);
+		}
+	}
+}
+
+#define INTMSK_CAM (1UL << (IRQ_CAM - IRQ_EINT0))
+
+static void
+s3c_irq_cam_mask(struct irq_data *data)
+{
+	s3c_irqsub_mask(data->irq, INTMSK_CAM, 3 << 11);
+}
+
+static void
+s3c_irq_cam_unmask(struct irq_data *data)
+{
+	s3c_irqsub_unmask(data->irq, INTMSK_CAM);
+}
+
+static void
+s3c_irq_cam_ack(struct irq_data *data)
+{
+	s3c_irqsub_maskack(data->irq, INTMSK_CAM, 3 << 11);
+}
+
+static struct irq_chip s3c_irq_cam = {
+	.irq_mask	= s3c_irq_cam_mask,
+	.irq_unmask	= s3c_irq_cam_unmask,
+	.irq_ack	= s3c_irq_cam_ack,
+};
+
+static int s3c244x_irq_add(struct device *dev, struct subsys_interface *sif)
+{
+	unsigned int irqno;
+
+	irq_set_chip_and_handler(IRQ_NFCON, &s3c_irq_level_chip,
+				 handle_level_irq);
+	set_irq_flags(IRQ_NFCON, IRQF_VALID);
+
+	/* add chained handler for camera */
+
+	irq_set_chip_and_handler(IRQ_CAM, &s3c_irq_level_chip,
+				 handle_level_irq);
+	irq_set_chained_handler(IRQ_CAM, s3c_irq_demux_cam);
+
+	for (irqno = IRQ_S3C2440_CAM_C; irqno <= IRQ_S3C2440_CAM_P; irqno++) {
+		irq_set_chip_and_handler(irqno, &s3c_irq_cam,
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
+	.add_dev	= s3c244x_irq_add,
+};
+
+static int s3c2440_irq_init(void)
+{
+	return subsys_interface_register(&s3c2440_irq_interface);
+}
+
+arch_initcall(s3c2440_irq_init);
+
+static struct subsys_interface s3c2442_irq_interface = {
+	.name		= "s3c2442_irq",
+	.subsys		= &s3c2442_subsys,
+	.add_dev	= s3c244x_irq_add,
+};
+
+
+static int s3c2442_irq_init(void)
+{
+	return subsys_interface_register(&s3c2442_irq_interface);
+}
+
+arch_initcall(s3c2442_irq_init);
+#endif
+
 #ifdef CONFIG_CPU_S3C2443
 static struct s3c_irq_data init_s3c2443base[32] = {
 	{ .type = S3C_IRQTYPE_EINT, }, /* EINT0 */
-- 
1.7.2.3
