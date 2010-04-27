From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:43 +0530
Subject: [PATCH 05/14] ux500: move gpio macros to common header
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-6-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move GPIO macros to a common header, and allow them to use the correct
macros for the appropriate SoC, and be named accordingly.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/cpu-u8500.c         |   30 ------------------------
 arch/arm/mach-ux500/include/mach/gpio.h |   38 +++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 2c8aa93..c80beca 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -23,36 +23,6 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
-#define GPIO_RESOURCE(block)						\
-	{								\
-		.start	= U8500_GPIOBANK##block##_BASE,			\
-		.end	= U8500_GPIOBANK##block##_BASE + 127,		\
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
-		.resource	= &u8500_gpio_resources[block * 2],	\
-		.dev = {						\
-			.platform_data = &u8500_gpio_data[block],	\
-		},							\
-	}
-
-#define GPIO_DATA(_name, first)						\
-	{								\
-		.name 		= _name,				\
-		.first_gpio 	= first,				\
-		.first_irq 	= NOMADIK_GPIO_TO_IRQ(first),		\
-	}
-
 static struct nmk_gpio_platform_data u8500_gpio_data[] = {
 	GPIO_DATA("GPIO-0-31", 0),
 	GPIO_DATA("GPIO-32-63", 32), /* 37..63 not routed to pin */
diff --git a/arch/arm/mach-ux500/include/mach/gpio.h b/arch/arm/mach-ux500/include/mach/gpio.h
index 3c4cd31..d548a62 100644
--- a/arch/arm/mach-ux500/include/mach/gpio.h
+++ b/arch/arm/mach-ux500/include/mach/gpio.h
@@ -9,4 +9,42 @@
 
 #include <plat/gpio.h>
 
+#define __GPIO_RESOURCE(soc, block)					\
+	{								\
+		.start	= soc##_GPIOBANK##block##_BASE,			\
+		.end	= soc##_GPIOBANK##block##_BASE + 127,		\
+		.flags	= IORESOURCE_MEM,				\
+	},								\
+	{								\
+		.start	= IRQ_GPIO##block,				\
+		.end	= IRQ_GPIO##block,				\
+		.flags	= IORESOURCE_IRQ,				\
+	}
+
+#define __GPIO_DEVICE(soc, block)					\
+	{								\
+		.name		= "gpio",				\
+		.id		= block,				\
+		.num_resources	= 2,					\
+		.resource	= &soc##_gpio_resources[block * 2],	\
+		.dev = {						\
+			.platform_data = &soc##_gpio_data[block],	\
+		},							\
+	}
+
+#define GPIO_DATA(_name, first)						\
+	{								\
+		.name		= _name,				\
+		.first_gpio	= first,				\
+		.first_irq	= NOMADIK_GPIO_TO_IRQ(first),		\
+	}
+
+#ifdef CONFIG_UX500_SOC_DB8500
+#define GPIO_RESOURCE(block)	__GPIO_RESOURCE(U8500, block)
+#define GPIO_DEVICE(block)	__GPIO_DEVICE(u8500, block)
+#elif defined(CONFIG_UX500_SOC_DB5500)
+#define GPIO_RESOURCE(block)	__GPIO_RESOURCE(U5500, block)
+#define GPIO_DEVICE(block)	__GPIO_DEVICE(u5500, block)
+#endif
+
 #endif /* __ASM_ARCH_GPIO_H */
-- 
1.7.0
