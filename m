From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Wed, 8 Dec 2010 11:07:55 +0530
Subject: [PATCH 3/9] ux500: rework gpio registration
In-Reply-To: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1291786681-8664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1291786681-8664-3-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rework gpio registration to remove build-time
changing macros.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                |    2 +-
 arch/arm/mach-ux500/cpu-db5500.c            |   33 ++++++++++++++-----
 arch/arm/mach-ux500/cpu-db8500.c            |   32 +++++++++++++-----
 arch/arm/mach-ux500/devices-common.c        |   38 ++++++++++++++++++++++
 arch/arm/mach-ux500/devices-common.h        |    5 +++
 arch/arm/mach-ux500/devices-db5500.c        |   46 ---------------------------
 arch/arm/mach-ux500/devices-db8500.c        |   36 ---------------------
 arch/arm/mach-ux500/include/mach/gpio.h     |   38 ----------------------
 arch/arm/mach-ux500/include/mach/hardware.h |    2 +
 9 files changed, 93 insertions(+), 139 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/devices-db5500.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 9720e42..93b0cf1 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y				:= clock.o cpu.o devices.o devices-common.o
-obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o devices-db5500.o dma-db5500.o
+obj-$(CONFIG_UX500_SOC_DB5500)	+= cpu-db5500.o dma-db5500.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o prcmu.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o board-mop500-sdi.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index 8816844..acc841e 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -12,6 +12,8 @@
 
 #include <asm/mach/map.h>
 
+#include <plat/gpio.h>
+
 #include <mach/hardware.h>
 #include <mach/devices.h>
 #include <mach/setup.h>
@@ -113,19 +115,32 @@ static struct platform_device mbox2_device = {
 };
 
 static struct platform_device *u5500_platform_devs[] __initdata = {
-	&u5500_gpio_devs[0],
-	&u5500_gpio_devs[1],
-	&u5500_gpio_devs[2],
-	&u5500_gpio_devs[3],
-	&u5500_gpio_devs[4],
-	&u5500_gpio_devs[5],
-	&u5500_gpio_devs[6],
-	&u5500_gpio_devs[7],
 	&mbox0_device,
 	&mbox1_device,
 	&mbox2_device,
 };
 
+static resource_size_t __initdata db5500_gpio_base[] = {
+	U5500_GPIOBANK0_BASE,
+	U5500_GPIOBANK1_BASE,
+	U5500_GPIOBANK2_BASE,
+	U5500_GPIOBANK3_BASE,
+	U5500_GPIOBANK4_BASE,
+	U5500_GPIOBANK5_BASE,
+	U5500_GPIOBANK6_BASE,
+	U5500_GPIOBANK7_BASE,
+};
+
+static void __init db5500_add_gpios(void)
+{
+	struct nmk_gpio_platform_data pdata = {
+		/* No custom data yet */
+	};
+
+	dbx500_add_gpios(ARRAY_AND_SIZE(db5500_gpio_base),
+			 IRQ_DB5500_GPIO0, &pdata);
+}
+
 void __init u5500_map_io(void)
 {
 	ux500_map_io();
@@ -135,8 +150,8 @@ void __init u5500_map_io(void)
 
 void __init u5500_init_devices(void)
 {
+	db5500_add_gpios();
 	db5500_dma_init();
-
 	db5500_add_rtc();
 
 	platform_add_devices(u5500_platform_devs,
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index b78970c..658384c 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -25,15 +25,6 @@
 #include "devices-db8500.h"
 
 static struct platform_device *platform_devs[] __initdata = {
-	&u8500_gpio_devs[0],
-	&u8500_gpio_devs[1],
-	&u8500_gpio_devs[2],
-	&u8500_gpio_devs[3],
-	&u8500_gpio_devs[4],
-	&u8500_gpio_devs[5],
-	&u8500_gpio_devs[6],
-	&u8500_gpio_devs[7],
-	&u8500_gpio_devs[8],
 	&u8500_dma40_device,
 };
 
@@ -141,6 +132,28 @@ void __init u8500_map_io(void)
 	get_db8500_asic_id();
 }
 
+static resource_size_t __initdata db8500_gpio_base[] = {
+	U8500_GPIOBANK0_BASE,
+	U8500_GPIOBANK1_BASE,
+	U8500_GPIOBANK2_BASE,
+	U8500_GPIOBANK3_BASE,
+	U8500_GPIOBANK4_BASE,
+	U8500_GPIOBANK5_BASE,
+	U8500_GPIOBANK6_BASE,
+	U8500_GPIOBANK7_BASE,
+	U8500_GPIOBANK8_BASE,
+};
+
+static void __init db8500_add_gpios(void)
+{
+	struct nmk_gpio_platform_data pdata = {
+		/* No custom data yet */
+	};
+
+	dbx500_add_gpios(ARRAY_AND_SIZE(db8500_gpio_base),
+			 IRQ_DB8500_GPIO0, &pdata);
+}
+
 /*
  * This function is called from the board init
  */
@@ -164,6 +177,7 @@ void __init u8500_init_devices(void)
 		dma40_u8500ed_fixup();
 
 	db8500_add_rtc();
+	db8500_add_gpios();
 
 	platform_add_devices(platform_devs, ARRAY_SIZE(platform_devs));
 
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 9376a24..fe69f5f 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -13,6 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/amba/bus.h>
 
+#include <plat/gpio.h>
+
 #include <mach/hardware.h>
 
 #include "devices-common.h"
@@ -105,3 +107,39 @@ dbx500_add_platform_device_4k1irq(const char *name, int id,
 	return dbx500_add_platform_device(name, id, pdata, resources,
 					  ARRAY_SIZE(resources));
 }
+
+static struct platform_device *
+dbx500_add_gpio(int id, resource_size_t addr, int irq,
+		struct nmk_gpio_platform_data *pdata)
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
+
+void dbx500_add_gpios(resource_size_t *base, int num, int irq,
+		      struct nmk_gpio_platform_data *pdata)
+{
+	int first = 0;
+	int i;
+
+	for (i = 0; i < num; i++, first += 32, irq++) {
+		pdata->first_gpio = first;
+		pdata->first_irq = NOMADIK_GPIO_TO_IRQ(first);
+
+		dbx500_add_gpio(i, base[i], irq, pdata);
+	}
+}
diff --git a/arch/arm/mach-ux500/devices-common.h b/arch/arm/mach-ux500/devices-common.h
index 2e1de0e..cbadc11 100644
--- a/arch/arm/mach-ux500/devices-common.h
+++ b/arch/arm/mach-ux500/devices-common.h
@@ -74,4 +74,9 @@ dbx500_add_rtc(resource_size_t base, int irq)
 	return dbx500_add_amba_device("rtc-pl031", base, irq, NULL, 0);
 }
 
+struct nmk_gpio_platform_data;
+
+void dbx500_add_gpios(resource_size_t *base, int num, int irq,
+		      struct nmk_gpio_platform_data *pdata);
+
 #endif
diff --git a/arch/arm/mach-ux500/devices-db5500.c b/arch/arm/mach-ux500/devices-db5500.c
deleted file mode 100644
index 33e5b56..0000000
--- a/arch/arm/mach-ux500/devices-db5500.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/gpio.h>
-
-#include <mach/hardware.h>
-#include <mach/devices.h>
-
-static struct nmk_gpio_platform_data u5500_gpio_data[] = {
-	GPIO_DATA("GPIO-0-31", 0),
-	GPIO_DATA("GPIO-32-63", 32), /* 36..63 not routed to pin */
-	GPIO_DATA("GPIO-64-95", 64), /* 83..95 not routed to pin */
-	GPIO_DATA("GPIO-96-127", 96), /* 102..127 not routed to pin */
-	GPIO_DATA("GPIO-128-159", 128), /* 149..159 not routed to pin */
-	GPIO_DATA("GPIO-160-191", 160),
-	GPIO_DATA("GPIO-192-223", 192),
-	GPIO_DATA("GPIO-224-255", 224), /* 228..255 not routed to pin */
-};
-
-static struct resource u5500_gpio_resources[] = {
-	GPIO_RESOURCE(0),
-	GPIO_RESOURCE(1),
-	GPIO_RESOURCE(2),
-	GPIO_RESOURCE(3),
-	GPIO_RESOURCE(4),
-	GPIO_RESOURCE(5),
-	GPIO_RESOURCE(6),
-	GPIO_RESOURCE(7),
-};
-
-struct platform_device u5500_gpio_devs[] = {
-	GPIO_DEVICE(0),
-	GPIO_DEVICE(1),
-	GPIO_DEVICE(2),
-	GPIO_DEVICE(3),
-	GPIO_DEVICE(4),
-	GPIO_DEVICE(5),
-	GPIO_DEVICE(6),
-	GPIO_DEVICE(7),
-};
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index 1edcf82..a7b0a18 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -19,42 +19,6 @@
 
 #include "ste-dma40-db8500.h"
 
-static struct nmk_gpio_platform_data u8500_gpio_data[] = {
-	GPIO_DATA("GPIO-0-31", 0),
-	GPIO_DATA("GPIO-32-63", 32), /* 37..63 not routed to pin */
-	GPIO_DATA("GPIO-64-95", 64),
-	GPIO_DATA("GPIO-96-127", 96), /* 98..127 not routed to pin */
-	GPIO_DATA("GPIO-128-159", 128),
-	GPIO_DATA("GPIO-160-191", 160), /* 172..191 not routed to pin */
-	GPIO_DATA("GPIO-192-223", 192),
-	GPIO_DATA("GPIO-224-255", 224), /* 231..255 not routed to pin */
-	GPIO_DATA("GPIO-256-288", 256), /* 268..288 not routed to pin */
-};
-
-static struct resource u8500_gpio_resources[] = {
-	GPIO_RESOURCE(0),
-	GPIO_RESOURCE(1),
-	GPIO_RESOURCE(2),
-	GPIO_RESOURCE(3),
-	GPIO_RESOURCE(4),
-	GPIO_RESOURCE(5),
-	GPIO_RESOURCE(6),
-	GPIO_RESOURCE(7),
-	GPIO_RESOURCE(8),
-};
-
-struct platform_device u8500_gpio_devs[] = {
-	GPIO_DEVICE(0),
-	GPIO_DEVICE(1),
-	GPIO_DEVICE(2),
-	GPIO_DEVICE(3),
-	GPIO_DEVICE(4),
-	GPIO_DEVICE(5),
-	GPIO_DEVICE(6),
-	GPIO_DEVICE(7),
-	GPIO_DEVICE(8),
-};
-
 static struct resource dma40_resources[] = {
 	[0] = {
 		.start = U8500_DMA_BASE,
diff --git a/arch/arm/mach-ux500/include/mach/gpio.h b/arch/arm/mach-ux500/include/mach/gpio.h
index d548a62..3c4cd31 100644
--- a/arch/arm/mach-ux500/include/mach/gpio.h
+++ b/arch/arm/mach-ux500/include/mach/gpio.h
@@ -9,42 +9,4 @@
 
 #include <plat/gpio.h>
 
-#define __GPIO_RESOURCE(soc, block)					\
-	{								\
-		.start	= soc##_GPIOBANK##block##_BASE,			\
-		.end	= soc##_GPIOBANK##block##_BASE + 127,		\
-		.flags	= IORESOURCE_MEM,				\
-	},								\
-	{								\
-		.start	= IRQ_GPIO##block,				\
-		.end	= IRQ_GPIO##block,				\
-		.flags	= IORESOURCE_IRQ,				\
-	}
-
-#define __GPIO_DEVICE(soc, block)					\
-	{								\
-		.name		= "gpio",				\
-		.id		= block,				\
-		.num_resources	= 2,					\
-		.resource	= &soc##_gpio_resources[block * 2],	\
-		.dev = {						\
-			.platform_data = &soc##_gpio_data[block],	\
-		},							\
-	}
-
-#define GPIO_DATA(_name, first)						\
-	{								\
-		.name		= _name,				\
-		.first_gpio	= first,				\
-		.first_irq	= NOMADIK_GPIO_TO_IRQ(first),		\
-	}
-
-#ifdef CONFIG_UX500_SOC_DB8500
-#define GPIO_RESOURCE(block)	__GPIO_RESOURCE(U8500, block)
-#define GPIO_DEVICE(block)	__GPIO_DEVICE(u8500, block)
-#elif defined(CONFIG_UX500_SOC_DB5500)
-#define GPIO_RESOURCE(block)	__GPIO_RESOURCE(U5500, block)
-#define GPIO_DEVICE(block)	__GPIO_DEVICE(u5500, block)
-#endif
-
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index 32e883a..6295cc5 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -142,6 +142,8 @@ static inline bool cpu_is_u5500(void)
 #endif
 }
 
+#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
+
 #endif
 
 #endif				/* __MACH_HARDWARE_H */
-- 
1.7.2.dirty
