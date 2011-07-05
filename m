From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Jul 2011 23:19:24 +0800
Subject: [PATCH v2 1/3] gpio/mxc: get gpio range/base from gpio core
In-Reply-To: <1309879166-25788-1-git-send-email-shawn.guo@linaro.org>
References: <1309879166-25788-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1309879166-25788-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of assigning the gpio range based on pdev->id, the patch
makes changes to get the range from gpio core that is dynamically
allocated.

As a result, the uses of pdev->id can be removed from the driver.
This will make dt migration of the driver easier.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/gpio.h |   13 +++++++++----
 arch/arm/plat-mxc/include/mach/irqs.h |   21 +++------------------
 drivers/gpio/gpio-mxc.c               |   18 ++++++++++--------
 3 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
index 31c820c..abdf5d7 100644
--- a/arch/arm/plat-mxc/include/mach/gpio.h
+++ b/arch/arm/plat-mxc/include/mach/gpio.h
@@ -23,10 +23,15 @@
 #include <mach/hardware.h>
 #include <asm-generic/gpio.h>
 
-
-/* There's a off-by-one betweem the gpio bank number and the gpiochip */
-/* range e.g. GPIO_1_5 is gpio 5 under linux */
-#define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
+/*
+ * There's a off-by-one betweem the gpio bank number and the gpiochip
+ * range e.g. GPIO_1_5 is gpio 5 under linux.
+ *
+ * When gpio core allocates gpio range for a bank, it starts from the
+ * end of the total range.  That is to say, bank 0 will get a higher
+ * gpio range than bank 1.
+ */
+#define IMX_GPIO_NR(bank, nr)	(ARCH_NR_GPIOS - (bank) * 32 + (nr))
 
 /* use gpiolib dispatchers */
 #define gpio_get_value		__gpio_get_value
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 35c89bc..00e812b 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -11,6 +11,8 @@
 #ifndef __ASM_ARCH_MXC_IRQS_H__
 #define __ASM_ARCH_MXC_IRQS_H__
 
+#include <asm-generic/gpio.h>
+
 /*
  * SoCs with TZIC interrupt controller have 128 IRQs, those with AVIC have 64
  */
@@ -22,30 +24,13 @@
 
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
 /*
  * The next 16 interrupts are for board specific purposes.  Since
  * the kernel can only run on one machine at a time, we can re-use
  * these.  If you need more, increase MXC_BOARD_IRQS, but keep it
  * within sensible limits.
  */
-#define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + MXC_GPIO_IRQS)
+#define MXC_BOARD_IRQ_START	(MXC_INTERNAL_IRQS + ARCH_NR_GPIOS)
 
 #ifdef CONFIG_MACH_MX31ADS_WM1133_EV1
 #define MXC_BOARD_IRQS  80
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 2f6a81b..8241680 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -240,14 +240,13 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 {
 	struct mxc_gpio_port *port;
 	struct resource *iores;
+	static int once = 0;
 	int err;
 
 	port = kzalloc(sizeof(struct mxc_gpio_port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
 
-	port->virtual_irq_start = MXC_GPIO_IRQ_START + pdev->id * 32;
-
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iores) {
 		err = -ENODEV;
@@ -277,14 +276,13 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 	writel(0, port->base + GPIO_IMR);
 	writel(~0, port->base + GPIO_ISR);
 
-	/* gpio-mxc can be a generic irq chip */
-	mxc_gpio_init_gc(port);
-
 	if (cpu_is_mx2()) {
 		/* setup one handler for all GPIO interrupts */
-		if (pdev->id == 0)
+		if (!once) {
 			irq_set_chained_handler(port->irq,
 						mx2_gpio_irq_handler);
+			once = 1;
+		}
 	} else {
 		/* setup one handler for each entry */
 		irq_set_chained_handler(port->irq, mx3_gpio_irq_handler);
@@ -304,12 +302,16 @@ static int __devinit mxc_gpio_probe(struct platform_device *pdev)
 	if (err)
 		goto out_iounmap;
 
-	port->bgc.gc.base = pdev->id * 32;
-
 	err = gpiochip_add(&port->bgc.gc);
 	if (err)
 		goto out_bgpio_remove;
 
+	/* Here, we get a gpio number range/base assigned by gpio core */
+	port->virtual_irq_start = MXC_GPIO_IRQ_START + port->bgc.gc.base;
+
+	/* gpio-mxc can be a generic irq chip */
+	mxc_gpio_init_gc(port);
+
 	list_add_tail(&port->node, &mxc_gpio_ports);
 
 	return 0;
-- 
1.7.4.1
