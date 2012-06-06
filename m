From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  6 Jun 2012 23:34:39 +0200
Subject: [PATCH 1/7] ARM: nomadik: register GPIOs dynamically
Message-ID: <1339018479-28987-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register the NHK8815 GPIO devices dynamically like the Ux500 does
it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-nomadik/cpu-8815.c |  114 ++++++++++++++++----------------------
 1 files changed, 47 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 27f43a4..b79b384 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -35,86 +35,66 @@
 #include "clock.h"
 #include "cpu-8815.h"
 
-#define __MEM_4K_RESOURCE(x) \
-	.res = {.start = (x), .end = (x) + SZ_4K - 1, .flags = IORESOURCE_MEM}
-
-/* The 8815 has 4 GPIO blocks, let's register them immediately */
-
-#define GPIO_RESOURCE(block)						\
-	{								\
-		.start	= NOMADIK_GPIO##block##_BASE,			\
-		.end	= NOMADIK_GPIO##block##_BASE + SZ_4K - 1,	\
-		.flags	= IORESOURCE_MEM,				\
-	},								\
-	{								\
-		.start	= IRQ_GPIO##block,				\
-		.end	= IRQ_GPIO##block,				\
-		.flags	= IORESOURCE_IRQ,				\
-	}
-
-#define GPIO_DEVICE(block)						\
-	{								\
-		.name 		= "gpio",				\
-		.id		= block,				\
-		.num_resources 	= 2,					\
-		.resource	= &cpu8815_gpio_resources[block * 2],	\
-		.dev = {						\
-			.platform_data = &cpu8815_gpio[block],		\
-		},							\
-	}
+static AMBA_APB_DEVICE(cpu8815_amba_rng, "rng", 0, NOMADIK_RNG_BASE, { }, NULL);
 
-static struct nmk_gpio_platform_data cpu8815_gpio[] = {
-	{
-		.name = "GPIO-0-31",
-		.first_gpio = 0,
-		.first_irq = NOMADIK_GPIO_TO_IRQ(0),
-	}, {
-		.name = "GPIO-32-63",
-		.first_gpio = 32,
-		.first_irq = NOMADIK_GPIO_TO_IRQ(32),
-	}, {
-		.name = "GPIO-64-95",
-		.first_gpio = 64,
-		.first_irq = NOMADIK_GPIO_TO_IRQ(64),
-	}, {
-		.name = "GPIO-96-127", /* 124..127 not routed to pin */
-		.first_gpio = 96,
-		.first_irq = NOMADIK_GPIO_TO_IRQ(96),
-	}
+static struct amba_device *amba_devs[] __initdata = {
+	&cpu8815_amba_rng_device
 };
 
-static struct resource cpu8815_gpio_resources[] = {
-	GPIO_RESOURCE(0),
-	GPIO_RESOURCE(1),
-	GPIO_RESOURCE(2),
-	GPIO_RESOURCE(3),
+/* The 8815 has 4 GPIO blocks, let's register them immediately */
+static resource_size_t __initdata cpu8815_gpio_base[] = {
+	NOMADIK_GPIO0_BASE,
+	NOMADIK_GPIO1_BASE,
+	NOMADIK_GPIO2_BASE,
+	NOMADIK_GPIO3_BASE,
 };
 
-static struct platform_device cpu8815_platform_gpio[] = {
-	GPIO_DEVICE(0),
-	GPIO_DEVICE(1),
-	GPIO_DEVICE(2),
-	GPIO_DEVICE(3),
-};
+static struct platform_device *
+cpu8815_add_gpio(int id, resource_size_t addr, int irq,
+		 struct nmk_gpio_platform_data *pdata)
+{
+	struct resource resources[] = {
+		{
+			.start	= addr,
+			.end	= addr + 127,
+			.flags	= IORESOURCE_MEM,
+		},
+		{
+			.start	= irq,
+			.end	= irq,
+			.flags	= IORESOURCE_IRQ,
+		}
+	};
+
+	return platform_device_register_resndata(NULL, "gpio", id,
+				resources, ARRAY_SIZE(resources),
+				pdata, sizeof(*pdata));
+}
 
-static AMBA_APB_DEVICE(cpu8815_amba_rng, "rng", 0, NOMADIK_RNG_BASE, { }, NULL);
+void cpu8815_add_gpios(resource_size_t *base, int num, int irq,
+		       struct nmk_gpio_platform_data *pdata)
+{
+	int first = 0;
+	int i;
 
-static struct platform_device *platform_devs[] __initdata = {
-	cpu8815_platform_gpio + 0,
-	cpu8815_platform_gpio + 1,
-	cpu8815_platform_gpio + 2,
-	cpu8815_platform_gpio + 3,
-};
+	for (i = 0; i < num; i++, first += 32, irq++) {
+		pdata->first_gpio = first;
+		pdata->first_irq = NOMADIK_GPIO_TO_IRQ(first);
+		pdata->num_gpio = 32;
 
-static struct amba_device *amba_devs[] __initdata = {
-	&cpu8815_amba_rng_device
-};
+		cpu8815_add_gpio(i, base[i], irq, pdata);
+	}
+}
 
 static int __init cpu8815_init(void)
 {
 	int i;
+	struct nmk_gpio_platform_data pdata = {
+		/* No custom data yet */
+	};
 
-	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
+	cpu8815_add_gpios(cpu8815_gpio_base, ARRAY_SIZE(cpu8815_gpio_base),
+			  IRQ_GPIO0, &pdata);
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++)
 		amba_device_register(amba_devs[i], &iomem_resource);
 	return 0;
-- 
1.7.7.6
