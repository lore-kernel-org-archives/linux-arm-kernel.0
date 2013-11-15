From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 15 Nov 2013 12:47:55 +0400
Subject: [PATCH 4/9] ARM: sa1100: convert gpio driver to be a proper platform
 driver
In-Reply-To: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384505280-25389-5-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Start cleaning up/refreshing SA1100 GPIO driver.
* Changed to bind through device model.
* Replaced direct register access with readl/writel.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/generic.c              |  13 +++-
 arch/arm/mach-sa1100/generic.h              |   1 -
 arch/arm/mach-sa1100/include/mach/SA-1100.h |   2 +
 arch/arm/mach-sa1100/irq.c                  |   2 -
 drivers/gpio/Kconfig                        |   6 ++
 drivers/gpio/Makefile                       |   2 +-
 drivers/gpio/gpio-sa1100.c                  | 110 ++++++++++++++++++++++------
 7 files changed, 110 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-sa1100/generic.c b/arch/arm/mach-sa1100/generic.c
index d4ea142..c2718f0 100644
--- a/arch/arm/mach-sa1100/generic.c
+++ b/arch/arm/mach-sa1100/generic.c
@@ -9,7 +9,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -299,6 +298,17 @@ static struct platform_device sa11x0dma_device = {
 	.resource	= sa11x0dma_resources,
 };
 
+static struct resource sa11x0_gpio_resources[] = {
+	DEFINE_RES_MEM(GPIO_PHYS, GPIO_SIZE),
+};
+
+static struct platform_device sa11x0gpio_device = {
+	.name		= "sa1100-gpio",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(sa11x0_gpio_resources),
+	.resource	= sa11x0_gpio_resources,
+};
+
 static struct platform_device *sa11x0_devices[] __initdata = {
 	&sa11x0udc_device,
 	&sa11x0uart1_device,
@@ -307,6 +317,7 @@ static struct platform_device *sa11x0_devices[] __initdata = {
 	&sa11x0pcmcia_device,
 	&sa11x0rtc_device,
 	&sa11x0dma_device,
+	&sa11x0gpio_device,
 };
 
 static int __init sa1100_init(void)
diff --git a/arch/arm/mach-sa1100/generic.h b/arch/arm/mach-sa1100/generic.h
index 0d92e11..0b68b95 100644
--- a/arch/arm/mach-sa1100/generic.h
+++ b/arch/arm/mach-sa1100/generic.h
@@ -9,7 +9,6 @@
 extern void sa1100_timer_init(void);
 extern void __init sa1100_map_io(void);
 extern void __init sa1100_init_irq(void);
-extern void __init sa1100_init_gpio(void);
 extern void sa11x0_restart(enum reboot_mode, const char *);
 extern void sa11x0_init_late(void);
 
diff --git a/arch/arm/mach-sa1100/include/mach/SA-1100.h b/arch/arm/mach-sa1100/include/mach/SA-1100.h
index 0ac6cc0..70d01a2 100644
--- a/arch/arm/mach-sa1100/include/mach/SA-1100.h
+++ b/arch/arm/mach-sa1100/include/mach/SA-1100.h
@@ -1134,6 +1134,8 @@
  * Clock
  *    fcpu, Tcpu	Frequency, period of the CPU core clock (CCLK).
  */
+#define GPIO_PHYS	0x90040000
+#define GPIO_SIZE	0x20
 
 #define GPLR		__REG(0x90040000)  /* GPIO Pin Level Reg.             */
 #define GPDR		__REG(0x90040004)  /* GPIO Pin Direction Reg.         */
diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 68e8f9d..f055a6b 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -357,6 +357,4 @@ void __init sa1100_init_irq(void)
 	irq_set_chained_handler(IRQ_GPIO11_27, sa1100_high_gpio_handler);
 
 	set_handle_irq(sa1100_handle_irq);
-
-	sa1100_init_gpio();
 }
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a0471e6..1abea36 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -224,6 +224,12 @@ config GPIO_PXA
 	help
 	  Say yes here to support the PXA GPIO device
 
+config GPIO_SA1100
+	bool "SA1100 GPIO support"
+	depends on ARCH_SA1100
+	help
+	  Say yes here to support the StrongARM 11x0 GPIO device.
+
 config GPIO_RCAR
 	tristate "Renesas R-Car GPIO"
 	depends on ARM
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 7971e36..57755e6 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_GPIO_RC5T583)	+= gpio-rc5t583.o
 obj-$(CONFIG_GPIO_RDC321X)	+= gpio-rdc321x.o
 obj-$(CONFIG_GPIO_RCAR)		+= gpio-rcar.o
 obj-$(CONFIG_GPIO_SAMSUNG)	+= gpio-samsung.o
-obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
+obj-$(CONFIG_GPIO_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SODAVILLE)	+= gpio-sodaville.o
 obj-$(CONFIG_GPIO_SPEAR_SPICS)	+= gpio-spear-spics.o
diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
index a90be34..f4e881a 100644
--- a/drivers/gpio/gpio-sa1100.c
+++ b/drivers/gpio/gpio-sa1100.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-sa1100/gpio.c
+ * drivers/gpio/gpio-sa1100.c
  *
  * Generic SA-1100 GPIO handling
  *
@@ -11,60 +11,128 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/io.h>
-#include <mach/hardware.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
 #include <mach/irqs.h>
 
+#define SA1100_NGPIO 28
+
+struct sa1100_gpio_chip {
+	struct gpio_chip gc;
+	void __iomem *regbase;
+};
+
+#define to_sgc(chip)	container_of(chip, struct sa1100_gpio_chip, gc)
+
+#define GPLR_OFFSET	0x00  /* GPIO Pin Level Reg.             */
+#define GPDR_OFFSET	0x04  /* GPIO Pin Direction Reg.         */
+#define GPSR_OFFSET	0x08  /* GPIO Pin output Set Reg.        */
+#define GPCR_OFFSET	0x0C  /* GPIO Pin output Clear Reg.      */
+#define GRER_OFFSET	0x10  /* GPIO Rising-Edge detect Reg.    */
+#define GFER_OFFSET	0x14  /* GPIO Falling-Edge detect Reg.   */
+#define GEDR_OFFSET	0x18  /* GPIO Edge Detect status Reg.    */
+#define GAFR_OFFSET	0x1C  /* GPIO Alternate Function Reg.    */
+
 static int sa1100_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return GPLR & GPIO_GPIO(offset);
+	struct sa1100_gpio_chip *sgc = to_sgc(chip);
+	return readl_relaxed(sgc->regbase + GPLR_OFFSET) & BIT(offset);
 }
 
 static void sa1100_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
-	if (value)
-		GPSR = GPIO_GPIO(offset);
-	else
-		GPCR = GPIO_GPIO(offset);
+	struct sa1100_gpio_chip *sgc = to_sgc(chip);
+	writel_relaxed(BIT(offset), sgc->regbase +
+				(value ? GPSR_OFFSET : GPCR_OFFSET));
 }
 
 static int sa1100_direction_input(struct gpio_chip *chip, unsigned offset)
 {
+	struct sa1100_gpio_chip *sgc = to_sgc(chip);
 	unsigned long flags;
+	uint32_t tmp;
 
 	local_irq_save(flags);
-	GPDR &= ~GPIO_GPIO(offset);
+
+	tmp = readl_relaxed(sgc->regbase + GPDR_OFFSET);
+	tmp &= ~BIT(offset);
+	writel_relaxed(tmp, sgc->regbase + GPDR_OFFSET);
+
 	local_irq_restore(flags);
 	return 0;
 }
 
 static int sa1100_direction_output(struct gpio_chip *chip, unsigned offset, int value)
 {
+	struct sa1100_gpio_chip *sgc = to_sgc(chip);
 	unsigned long flags;
+	uint32_t tmp;
 
 	local_irq_save(flags);
 	sa1100_gpio_set(chip, offset, value);
-	GPDR |= GPIO_GPIO(offset);
+
+	tmp = readl_relaxed(sgc->regbase + GPDR_OFFSET);
+	tmp |= BIT(offset);
+	writel_relaxed(tmp, sgc->regbase + GPDR_OFFSET);
+
 	local_irq_restore(flags);
 	return 0;
 }
 
-static int sa1100_to_irq(struct gpio_chip *chip, unsigned offset)
+static int sa1100_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
 {
 	return offset < 11 ? (IRQ_GPIO0 + offset) : (IRQ_GPIO11 - 11 + offset);
 }
 
-static struct gpio_chip sa1100_gpio_chip = {
-	.label			= "gpio",
-	.direction_input	= sa1100_direction_input,
-	.direction_output	= sa1100_direction_output,
-	.set			= sa1100_gpio_set,
-	.get			= sa1100_gpio_get,
-	.to_irq			= sa1100_to_irq,
-	.base			= 0,
-	.ngpio			= GPIO_MAX + 1,
+static int sa1100_gpio_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret;
+	struct sa1100_gpio_chip *sgc;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	sgc = kzalloc(sizeof(*sgc), GFP_KERNEL);
+	if  (!sgc)
+		return -ENOMEM;
+
+	sgc->regbase = ioremap(res->start, resource_size(res));
+	if (!sgc->regbase) {
+		kfree(sgc);
+		return -EINVAL;
+	}
+
+	sgc->gc.label = "gpio";
+	sgc->gc.direction_input = sa1100_direction_input;
+	sgc->gc.direction_output = sa1100_direction_output;
+	sgc->gc.set = sa1100_gpio_set;
+	sgc->gc.get = sa1100_gpio_get;
+	sgc->gc.to_irq = sa1100_gpio_to_irq;
+
+	sgc->gc.base = 0;
+	sgc->gc.ngpio = SA1100_NGPIO;
+
+	/* Initialize GPIO chips */
+	ret = gpiochip_add(&sgc->gc);
+	if (ret) {
+		iounmap(sgc->regbase);
+		kfree(sgc);
+	}
+
+	return ret;
+}
+
+static struct platform_driver sa1100_gpio_driver = {
+	.probe		= sa1100_gpio_probe,
+	.driver		= {
+		.name	= "sa1100-gpio",
+	},
 };
 
-void __init sa1100_init_gpio(void)
+static int __init sa1100_gpio_init(void)
 {
-	gpiochip_add(&sa1100_gpio_chip);
+	return platform_driver_register(&sa1100_gpio_driver);
 }
+postcore_initcall(sa1100_gpio_init);
-- 
1.8.4.2
