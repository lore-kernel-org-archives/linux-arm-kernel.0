From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 20 May 2011 09:59:23 +0200
Subject: [PATCH 7/9] ARM i.MX: use sparse irqs
In-Reply-To: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
References: <1305878365-827-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1305878365-827-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This switches the whole i.MX architecture to use sparse irqs.
It helps us getting rid of some ifdeffery in irqs.h and allows
us to be more flexible with chained interrupt handlers.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-imx/mm-imx31.c          |    8 ++++-
 arch/arm/mach-imx/mm-imx35.c          |    7 ++++
 arch/arm/plat-mxc/avic.c              |    6 +++-
 arch/arm/plat-mxc/gpio.c              |    6 +++-
 arch/arm/plat-mxc/include/mach/irqs.h |   54 +++++---------------------------
 6 files changed, 34 insertions(+), 48 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 377a7a5..cebed1e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -367,6 +367,7 @@ config ARCH_MXC
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select HAVE_SCHED_CLOCK
+	select SPARSE_IRQ
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
diff --git a/arch/arm/mach-imx/mm-imx31.c b/arch/arm/mach-imx/mm-imx31.c
index 86b9b45..e055ef0 100644
--- a/arch/arm/mach-imx/mm-imx31.c
+++ b/arch/arm/mach-imx/mm-imx31.c
@@ -19,7 +19,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/err.h>
-
+#include <linux/irq.h>
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
 
@@ -61,6 +61,12 @@ static struct mxc_gpio_port imx31_gpio_ports[] = {
 
 void __init mx31_init_irq(void)
 {
+	int ret;
+
 	mxc_init_irq(MX31_IO_ADDRESS(MX31_AVIC_BASE_ADDR));
 	mxc_gpio_init(imx31_gpio_ports,	ARRAY_SIZE(imx31_gpio_ports));
+
+	/* The ipu driver should handle this */
+	ret = irq_alloc_descs(MXC_IPU_IRQ_START, MXC_IPU_IRQ_START, 160, 0);
+	BUG_ON(ret != MXC_IPU_IRQ_START);
 }
diff --git a/arch/arm/mach-imx/mm-imx35.c b/arch/arm/mach-imx/mm-imx35.c
index c880e6d..abe908b 100644
--- a/arch/arm/mach-imx/mm-imx35.c
+++ b/arch/arm/mach-imx/mm-imx35.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/irq.h>
 
 #include <asm/pgtable.h>
 #include <asm/mach/map.h>
@@ -58,6 +59,12 @@ static struct mxc_gpio_port imx35_gpio_ports[] = {
 
 void __init mx35_init_irq(void)
 {
+	int ret;
+
 	mxc_init_irq(MX35_IO_ADDRESS(MX35_AVIC_BASE_ADDR));
 	mxc_gpio_init(imx35_gpio_ports,	ARRAY_SIZE(imx35_gpio_ports));
+
+	/* The ipu driver should handle this */
+	ret = irq_alloc_descs(MXC_IPU_IRQ_START, MXC_IPU_IRQ_START, 160, 0);
+	BUG_ON(ret != MXC_IPU_IRQ_START);
 }
diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 55d2534..1a4f00c 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -123,7 +123,7 @@ static struct mxc_irq_chip mxc_avic_chip = {
  */
 void __init mxc_init_irq(void __iomem *irqbase)
 {
-	int i;
+	int ret, i;
 
 	avic_base = irqbase;
 
@@ -140,6 +140,10 @@ void __init mxc_init_irq(void __iomem *irqbase)
 	/* all IRQ no FIQ */
 	__raw_writel(0, avic_base + AVIC_INTTYPEH);
 	__raw_writel(0, avic_base + AVIC_INTTYPEL);
+
+	ret = irq_alloc_descs(0, 0, AVIC_NUM_IRQS, 0);
+	BUG_ON(ret);
+
 	for (i = 0; i < AVIC_NUM_IRQS; i++) {
 		irq_set_chip_and_handler(i, &mxc_avic_chip.base,
 					 handle_level_irq);
diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
index 6cd6d7f..8352264 100644
--- a/arch/arm/plat-mxc/gpio.c
+++ b/arch/arm/plat-mxc/gpio.c
@@ -303,7 +303,7 @@ static struct lock_class_key gpio_lock_class;
 
 int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 {
-	int i, j;
+	int i, j, ret;
 
 	/* save for local usage */
 	mxc_gpio_ports = port;
@@ -311,6 +311,10 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
 
 	printk(KERN_INFO "MXC GPIO hardware\n");
 
+	ret = irq_alloc_descs(MXC_GPIO_IRQ_START, MXC_GPIO_IRQ_START,
+		cnt * 32, 0);
+	BUG_ON(ret != MXC_GPIO_IRQ_START);
+
 	for (i = 0; i < cnt; i++) {
 		/* disable the interrupt and clear the status */
 		__raw_writel(0, port[i].base + GPIO_IMR);
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 35c89bc..8253463 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -11,58 +11,22 @@
 #ifndef __ASM_ARCH_MXC_IRQS_H__
 #define __ASM_ARCH_MXC_IRQS_H__
 
-/*
- * SoCs with TZIC interrupt controller have 128 IRQs, those with AVIC have 64
+/* This should go away. Currently the serial driver uses this
+ * (and it shouldn't)
  */
-#ifdef CONFIG_MXC_TZIC
 #define MXC_INTERNAL_IRQS	128
-#else
-#define MXC_INTERNAL_IRQS	64
-#endif
 
+/* Right after maximum number of internal irqs */
 #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
 
-/* these are ordered by size to support multi-SoC kernels */
-#if defined CONFIG_SOC_IMX53
-#define MXC_GPIO_IRQS		(32 * 7)
-#elif defined CONFIG_ARCH_MX2
-#define MXC_GPIO_IRQS		(32 * 6)
-#elif defined CONFIG_SOC_IMX50
-#define MXC_GPIO_IRQS		(32 * 6)
-#elif defined CONFIG_ARCH_MX1
-#define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MX25
-#define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_SOC_IMX51
-#define MXC_GPIO_IRQS		(32 * 4)
-#elif defined CONFIG_ARCH_MX3
-#define MXC_GPIO_IRQS		(32 * 3)
-#endif
-
-/*
- * The next 16 interrupts are for board specific purposes.  Since
- * the kernel can only run on one machine@a time, we can re-use
- * these.  If you need more, increase MXC_BOARD_IRQS, but keep it
- * within sensible limits.
- */
-#define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + MXC_GPIO_IRQS)
-
-#ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
-#define MXC_BOARD_IRQS  80
-#else
-#define MXC_BOARD_IRQS	16
-#endif
-
-#define MXC_IPU_IRQ_START	(MXC_BOARD_IRQ_START + MXC_BOARD_IRQS)
+/* one board (mx31ads) still depends on this. Do not add new dependencies */
+#define MXC_BOARD_IRQ_START	512
 
-#ifdef CONFIG_MX3_IPU_IRQS
-#define MX3_IPU_IRQS CONFIG_MX3_IPU_IRQS
-#else
-#define MX3_IPU_IRQS 0
-#endif
-/* REVISIT: Add IPU irqs on IMX51 */
+/* should go away once the ipu uses dynamically allocated irqs */
+#define MXC_IPU_IRQ_START	1024
 
-#define NR_IRQS			(MXC_IPU_IRQ_START + MX3_IPU_IRQS)
+/* All irqs dynamically allocated */
+#define NR_IRQS			0
 
 extern int imx_irq_set_priority(unsigned char irq, unsigned char prio);
 
-- 
1.7.4.1
