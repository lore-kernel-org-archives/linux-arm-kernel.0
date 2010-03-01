From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 1 Mar 2010 15:04:29 +0530
Subject: [PATCH 4/5] nomadik-gpio: convert to platform driver
In-Reply-To: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
References: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1267436070-10631-5-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On the U8500 platform there are four GPIO blocks, each with a 4K address
space, including the peripheral identification.  However, each of these
blocks have a varying number of banks, each of which have 32 GPIOs and
an interrupt line.

The current nomadik-gpio driver implementation can handle each of these
sub-banks easily with one instance each, but cannot as-is be hooked up
to them because it is an AMBA driver and it expects to see a peripheral
with the appropriate peripheral ids but having only one bank and only
one interrupt.

Solve this by converting the driver to a platform driver.

Acked-by: Alessandro Rubini <rubini@unipv.it>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-nomadik/cpu-8815.c          |   83 ++++++++++++++++------------
 arch/arm/plat-nomadik/gpio.c              |   74 +++++++++++++++-----------
 arch/arm/plat-nomadik/include/plat/gpio.h |    1 -
 3 files changed, 90 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 9bf33b3..91c3c90 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/amba/bus.h>
+#include <linux/platform_device.h>
 #include <linux/gpio.h>
 
 #include <mach/hardware.h>
@@ -30,60 +31,66 @@
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
 
+#define __MEM_4K_RESOURCE(x) \
+	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
+
 /* The 8815 has 4 GPIO blocks, let's register them immediately */
+
+#define GPIO_RESOURCE(block)						\
+	{								\
+		.start	= NOMADIK_GPIO##block##_BASE,			\
+		.end	= NOMADIK_GPIO##block##_BASE + SZ_4K - 1,	\
+		.flags	= IORESOURCE_MEM,				\
+	},								\
+	{								\
+		.start	= IRQ_GPIO##block,				\
+		.end	= IRQ_GPIO##block,				\
+		.flags	= IORESOURCE_IRQ,				\
+	}
+
+#define GPIO_DEVICE(block)						\
+	{								\
+		.name 		= "gpio",				\
+		.id		= block,				\
+		.num_resources 	= 2,					\
+		.resource	= &cpu8815_gpio_resources[block * 2],	\
+		.dev = {						\
+			.platform_data = &cpu8815_gpio[block],		\
+		},							\
+	}
+
 static struct nmk_gpio_platform_data cpu8815_gpio[] = {
 	{
 		.name = "GPIO-0-31",
 		.first_gpio = 0,
 		.first_irq = NOMADIK_GPIO_TO_IRQ(0),
-		.parent_irq = IRQ_GPIO0,
 	}, {
 		.name = "GPIO-32-63",
 		.first_gpio = 32,
 		.first_irq = NOMADIK_GPIO_TO_IRQ(32),
-		.parent_irq = IRQ_GPIO1,
 	}, {
 		.name = "GPIO-64-95",
 		.first_gpio = 64,
 		.first_irq = NOMADIK_GPIO_TO_IRQ(64),
-		.parent_irq = IRQ_GPIO2,
 	}, {
 		.name = "GPIO-96-127", /* 124..127 not routed to pin */
 		.first_gpio = 96,
 		.first_irq = NOMADIK_GPIO_TO_IRQ(96),
-		.parent_irq = IRQ_GPIO3,
 	}
 };
 
-#define __MEM_4K_RESOURCE(x) \
-	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
+static struct resource cpu8815_gpio_resources[] = {
+	GPIO_RESOURCE(0),
+	GPIO_RESOURCE(1),
+	GPIO_RESOURCE(2),
+	GPIO_RESOURCE(3),
+};
 
-static struct amba_device cpu8815_amba_gpio[] = {
-	{
-		.dev = {
-			.init_name = "gpio0",
-			.platform_data = cpu8815_gpio + 0,
-		},
-		__MEM_4K_RESOURCE(NOMADIK_GPIO0_BASE),
-	}, {
-		.dev = {
-			.init_name = "gpio1",
-			.platform_data = cpu8815_gpio + 1,
-		},
-		__MEM_4K_RESOURCE(NOMADIK_GPIO1_BASE),
-	}, {
-		.dev = {
-			.init_name = "gpio2",
-			.platform_data = cpu8815_gpio + 2,
-		},
-		__MEM_4K_RESOURCE(NOMADIK_GPIO2_BASE),
-	}, {
-		.dev = {
-			.init_name = "gpio3",
-			.platform_data = cpu8815_gpio + 3,
-		},
-		__MEM_4K_RESOURCE(NOMADIK_GPIO3_BASE),
-	},
+static struct platform_device cpu8815_platform_gpio[] = {
+	GPIO_DEVICE(0),
+	GPIO_DEVICE(1),
+	GPIO_DEVICE(2),
+	GPIO_DEVICE(3),
 };
 
 static struct amba_device cpu8815_amba_rng = {
@@ -93,11 +100,14 @@ static struct amba_device cpu8815_amba_rng = {
 	__MEM_4K_RESOURCE(NOMADIK_RNG_BASE),
 };
 
+static struct platform_device *platform_devs[] __initdata = {
+	cpu8815_platform_gpio + 0,
+	cpu8815_platform_gpio + 1,
+	cpu8815_platform_gpio + 2,
+	cpu8815_platform_gpio + 3,
+};
+
 static struct amba_device *amba_devs[] __initdata = {
-	cpu8815_amba_gpio + 0,
-	cpu8815_amba_gpio + 1,
-	cpu8815_amba_gpio + 2,
-	cpu8815_amba_gpio + 3,
 	&cpu8815_amba_rng
 };
 
@@ -105,6 +115,7 @@ static int __init cpu8815_init(void)
 {
 	int i;
 
+	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
 	return 0;
diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
index 4c3ea1a..092f380 100644
--- a/arch/arm/plat-nomadik/gpio.c
+++ b/arch/arm/plat-nomadik/gpio.c
@@ -13,7 +13,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
-#include <linux/amba/bus.h>
+#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/spinlock.h>
@@ -303,30 +303,48 @@ static struct gpio_chip nmk_gpio_template = {
 	.can_sleep		= 0,
 };
 
-static int __init nmk_gpio_probe(struct amba_device *dev, struct amba_id *id)
+static int __init nmk_gpio_probe(struct platform_device *dev)
 {
-	struct nmk_gpio_platform_data *pdata;
+	struct nmk_gpio_platform_data *pdata = dev->dev.platform_data;
 	struct nmk_gpio_chip *nmk_chip;
 	struct gpio_chip *chip;
+	struct resource *res;
+	int irq;
 	int ret;
 
-	pdata = dev->dev.platform_data;
-	ret = amba_request_regions(dev, pdata->name);
-	if (ret)
-		return ret;
+	if (!pdata)
+		return -ENODEV;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0) {
+		ret = irq;
+		goto out;
+	}
+
+	if (request_mem_region(res->start, resource_size(res),
+			       dev_name(&dev->dev)) == NULL) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	nmk_chip = kzalloc(sizeof(*nmk_chip), GFP_KERNEL);
 	if (!nmk_chip) {
 		ret = -ENOMEM;
-		goto out_amba;
+		goto out_release;
 	}
 	/*
 	 * The virt address in nmk_chip->addr is in the nomadik register space,
 	 * so we can simply convert the resource address, without remapping
 	 */
-	nmk_chip->addr = io_p2v(dev->res.start);
+	nmk_chip->addr = io_p2v(res->start);
 	nmk_chip->chip = nmk_gpio_template;
-	nmk_chip->parent_irq = pdata->parent_irq;
+	nmk_chip->parent_irq = irq;
 	spin_lock_init(&nmk_chip->lock);
 
 	chip = &nmk_chip->chip;
@@ -339,7 +357,7 @@ static int __init nmk_gpio_probe(struct amba_device *dev, struct amba_id *id)
 	if (ret)
 		goto out_free;
 
-	amba_set_drvdata(dev, nmk_chip);
+	platform_set_drvdata(dev, nmk_chip);
 
 	nmk_gpio_init_irq(nmk_chip);
 
@@ -347,51 +365,45 @@ static int __init nmk_gpio_probe(struct amba_device *dev, struct amba_id *id)
 		 nmk_chip->chip.base, nmk_chip->chip.base+31, nmk_chip->addr);
 	return 0;
 
- out_free:
+out_free:
 	kfree(nmk_chip);
- out_amba:
-	amba_release_regions(dev);
+out_release:
+	release_mem_region(res->start, resource_size(res));
+out:
 	dev_err(&dev->dev, "Failure %i for GPIO %i-%i\n", ret,
 		  pdata->first_gpio, pdata->first_gpio+31);
 	return ret;
 }
 
-static int nmk_gpio_remove(struct amba_device *dev)
+static int __exit nmk_gpio_remove(struct platform_device *dev)
 {
 	struct nmk_gpio_chip *nmk_chip;
+	struct resource *res;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
 
-	nmk_chip = amba_get_drvdata(dev);
+	nmk_chip = platform_get_drvdata(dev);
 	gpiochip_remove(&nmk_chip->chip);
 	kfree(nmk_chip);
-	amba_release_regions(dev);
+	release_mem_region(res->start, resource_size(res));
 	return 0;
 }
 
 
-/* We have 0x1f080060 and 0x1f180060, accept both using the mask */
-static struct amba_id nmk_gpio_ids[] = {
-	{
-		.id	= 0x1f080060,
-		.mask	= 0xffefffff,
-	},
-	{0, 0},
-};
-
-static struct amba_driver nmk_gpio_driver = {
-	.drv = {
+static struct platform_driver nmk_gpio_driver = {
+	.driver = {
 		.owner = THIS_MODULE,
 		.name = "gpio",
 		},
 	.probe = nmk_gpio_probe,
-	.remove = nmk_gpio_remove,
+	.remove = __exit_p(nmk_gpio_remove),
 	.suspend = NULL, /* to be done */
 	.resume = NULL,
-	.id_table = nmk_gpio_ids,
 };
 
 static int __init nmk_gpio_init(void)
 {
-	return amba_driver_register(&nmk_gpio_driver);
+	return platform_driver_register(&nmk_gpio_driver);
 }
 
 arch_initcall(nmk_gpio_init);
diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h b/arch/arm/plat-nomadik/include/plat/gpio.h
index 1d665a0..4200811 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -65,7 +65,6 @@ struct nmk_gpio_platform_data {
 	char *name;
 	int first_gpio;
 	int first_irq;
-	int parent_irq;
 };
 
 #endif /* __ASM_PLAT_GPIO_H */
-- 
1.7.0
