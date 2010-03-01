From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Mon, 1 Mar 2010 15:04:30 +0530
Subject: [PATCH 5/5] ux500: add gpio support
In-Reply-To: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
References: <1267436070-10631-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1267436070-10631-6-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the GPIOs on the U8500, using the plat-nomadik GPIO
driver.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/Kconfig                            |    1 +
 arch/arm/mach-ux500/Kconfig                 |    1 +
 arch/arm/mach-ux500/cpu-u8500.c             |   82 ++++++++++++++++++++++++++-
 arch/arm/mach-ux500/include/mach/gpio.h     |   12 ++++
 arch/arm/mach-ux500/include/mach/hardware.h |   12 ++++
 arch/arm/mach-ux500/include/mach/irqs.h     |    8 ++-
 6 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/gpio.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5c9ab5f..68666ec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -776,6 +776,7 @@ config ARCH_U8500
 	select GENERIC_TIME
 	select GENERIC_CLOCKEVENTS
 	select COMMON_CLKDEV
+	select ARCH_REQUIRE_GPIOLIB
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 03625d7..cd412a3 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -8,6 +8,7 @@ config MACH_U8500_MOP
 	default y
 	select ARM_GIC
 	select HAS_MTU
+	select NOMADIK_GPIO
 	help
 	  Include support for mop500 development platform
 	  based on U8500 architecture. The platform is based
diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 09bcba1..5fb4466 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/amba/bus.h>
 #include <linux/irq.h>
+#include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
@@ -23,9 +24,82 @@
 #include <mach/hardware.h>
 #include <mach/setup.h>
 
-/* add any platform devices here - TODO */
+#define GPIO_RESOURCE(block)						\
+	{								\
+		.start	= U8500_GPIOBANK##block##_BASE,			\
+		.end	= U8500_GPIOBANK##block##_BASE + 127,		\
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
+		.resource	= &u8500_gpio_resources[block * 2],	\
+		.dev = {						\
+			.platform_data = &u8500_gpio_data[block],	\
+		},							\
+	}
+
+#define GPIO_DATA(_name, first)						\
+	{								\
+		.name 		= _name,				\
+		.first_gpio 	= first,				\
+		.first_irq 	= NOMADIK_GPIO_TO_IRQ(first),		\
+	}
+
+static struct nmk_gpio_platform_data u8500_gpio_data[] = {
+	GPIO_DATA("GPIO-0-31", 0),
+	GPIO_DATA("GPIO-32-63", 32), /* 37..63 not routed to pin */
+	GPIO_DATA("GPIO-64-95", 64),
+	GPIO_DATA("GPIO-96-127", 96), /* 97..127 not routed to pin */
+	GPIO_DATA("GPIO-128-159", 128),
+	GPIO_DATA("GPIO-160-191", 160), /* 172..191 not routed to pin */
+	GPIO_DATA("GPIO-192-223", 192),
+	GPIO_DATA("GPIO-224-255", 224), /* 231..255 not routed to pin */
+	GPIO_DATA("GPIO-256-288", 256), /* 258..288 not routed to pin */
+};
+
+static struct resource u8500_gpio_resources[] = {
+	GPIO_RESOURCE(0),
+	GPIO_RESOURCE(1),
+	GPIO_RESOURCE(2),
+	GPIO_RESOURCE(3),
+	GPIO_RESOURCE(4),
+	GPIO_RESOURCE(5),
+	GPIO_RESOURCE(6),
+	GPIO_RESOURCE(7),
+	GPIO_RESOURCE(8),
+};
+
+static struct platform_device u8500_gpio_devs[] = {
+	GPIO_DEVICE(0),
+	GPIO_DEVICE(1),
+	GPIO_DEVICE(2),
+	GPIO_DEVICE(3),
+	GPIO_DEVICE(4),
+	GPIO_DEVICE(5),
+	GPIO_DEVICE(6),
+	GPIO_DEVICE(7),
+	GPIO_DEVICE(8),
+};
+
 static struct platform_device *platform_devs[] __initdata = {
-	/* yet to be added, add i2c0, gpio.. */
+	&u8500_gpio_devs[0],
+	&u8500_gpio_devs[1],
+	&u8500_gpio_devs[2],
+	&u8500_gpio_devs[3],
+	&u8500_gpio_devs[4],
+	&u8500_gpio_devs[5],
+	&u8500_gpio_devs[6],
+	&u8500_gpio_devs[7],
+	&u8500_gpio_devs[8],
 };
 
 #define __IO_DEV_DESC(x, sz)	{		\
@@ -49,6 +123,10 @@ static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_CLKRST3_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_CLKRST5_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_CLKRST6_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_GPIO3_BASE, SZ_4K),
+	__IO_DEV_DESC(U8500_GPIO5_BASE, SZ_4K),
 };
 
 static struct map_desc u8500ed_io_desc[] __initdata = {
diff --git a/arch/arm/mach-ux500/include/mach/gpio.h b/arch/arm/mach-ux500/include/mach/gpio.h
new file mode 100644
index 0000000..3c4cd31
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/gpio.h
@@ -0,0 +1,12 @@
+#ifndef __ASM_ARCH_GPIO_H
+#define __ASM_ARCH_GPIO_H
+
+/*
+ * 288 (#267 is the highest one actually hooked up) onchip GPIOs, plus enough
+ * room for a couple of GPIO expanders.
+ */
+#define ARCH_NR_GPIOS	350
+
+#include <plat/gpio.h>
+
+#endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
index f29a43d..99ca89f 100644
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -23,6 +23,8 @@
 
 /* typesafe io address */
 #define __io_address(n)		__io(IO_ADDRESS(n))
+/* used by some plat-nomadik code */
+#define io_p2v(n)		__io_address(n)
 
 /*
  * Base address definitions for U8500 Onchip IPs. All the
@@ -128,6 +130,16 @@
 #define U8500_GPIO1_BASE	(U8500_PER1_BASE + 0xe000)
 #define U8500_CLKRST1_BASE	(U8500_PER1_BASE + 0xf000)
 
+#define U8500_GPIOBANK0_BASE	U8500_GPIO1_BASE
+#define U8500_GPIOBANK1_BASE	(U8500_GPIO1_BASE + 0x80)
+#define U8500_GPIOBANK2_BASE	U8500_GPIO3_BASE
+#define U8500_GPIOBANK3_BASE	(U8500_GPIO3_BASE + 0x80)
+#define U8500_GPIOBANK4_BASE	(U8500_GPIO3_BASE + 0x100)
+#define U8500_GPIOBANK5_BASE	(U8500_GPIO3_BASE + 0x180)
+#define U8500_GPIOBANK6_BASE	U8500_GPIO2_BASE
+#define U8500_GPIOBANK7_BASE	(U8500_GPIO2_BASE + 0x80)
+#define U8500_GPIOBANK8_BASE	U8500_GPIO5_BASE
+
 /* ST-Ericsson modified pl022 id */
 #define SSP_PER_ID		0x01080022
 
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index 394b5dd..8a1f697 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -66,6 +66,12 @@
 /* There are 128 shared peripheral interrupts assigned to
  * INTID[160:32]. The first 32 interrupts are reserved.
  */
-#define NR_IRQS			161
+#define U8500_SOC_NR_IRQS		161
+
+/* After chip-specific IRQ numbers we have the GPIO ones */
+#define NOMADIK_NR_GPIO			288
+#define NOMADIK_GPIO_TO_IRQ(gpio)	((gpio) + U8500_SOC_NR_IRQS)
+#define NOMADIK_IRQ_TO_GPIO(irq)	((irq) - U8500_SOC_NR_IRQS)
+#define NR_IRQS				NOMADIK_GPIO_TO_IRQ(NOMADIK_NR_GPIO)
 
 #endif /*ASM_ARCH_IRQS_H*/
-- 
1.7.0
