From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:52 +0200
Subject: [PATCH 3/9] ARM: S5PV210: convert uart to device-table
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert UART device initialization to the device-table approach. Based
on the initial work by Ben Dooks. This patch performs the conversion
only for S5PV210 SoC, the final will update all other SoCs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Makefile            |    2 +-
 arch/arm/mach-s5pv210/init.c              |   44 ---------
 arch/arm/plat-s5p/Kconfig                 |    1 +
 arch/arm/plat-s5p/Makefile                |    1 -
 arch/arm/plat-s5p/cpu.c                   |    5 -
 arch/arm/plat-s5p/dev-uart.c              |  139 -----------------------------
 arch/arm/plat-s5p/include/plat/s5p6440.h  |    6 +-
 arch/arm/plat-s5p/include/plat/s5p6442.h  |    4 -
 arch/arm/plat-s5p/include/plat/s5pc100.h  |    3 -
 arch/arm/plat-s5p/include/plat/s5pv210.h  |    4 -
 arch/arm/plat-samsung/Kconfig             |   10 ++
 arch/arm/plat-samsung/Makefile            |    2 +
 arch/arm/plat-samsung/dev-uart-s3c24xx.c  |   37 ++++++++
 arch/arm/plat-samsung/dev-uart-s3c64xx.c  |   42 +++++++++
 arch/arm/plat-samsung/dev-uart.c          |   23 -----
 arch/arm/plat-samsung/dev_templates.c     |    4 +
 arch/arm/plat-samsung/include/plat/cpu.h  |    1 -
 arch/arm/plat-samsung/include/plat/devs.h |   10 --
 arch/arm/plat-samsung/include/plat/uart.h |   30 ++++++
 arch/arm/plat-samsung/init.c              |   28 +-----
 20 files changed, 133 insertions(+), 263 deletions(-)
 delete mode 100644 arch/arm/mach-s5pv210/init.c
 delete mode 100644 arch/arm/plat-s5p/dev-uart.c
 create mode 100644 arch/arm/plat-samsung/dev-uart-s3c24xx.c
 create mode 100644 arch/arm/plat-samsung/dev-uart-s3c64xx.c
 create mode 100644 arch/arm/plat-samsung/include/plat/uart.h

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 6f7c13b..a854577 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -12,7 +12,7 @@ obj-				:=
 
 # Core support for S5PV210 system
 
-obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o dma.o gpiolib.o
+obj-$(CONFIG_CPU_S5PV210)	+= cpu.o clock.o dma.o gpiolib.o
 obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 obj-$(CONFIG_CPU_S5PV210)	+= dev-table.o
 
diff --git a/arch/arm/mach-s5pv210/init.c b/arch/arm/mach-s5pv210/init.c
deleted file mode 100644
index 4865ae2..0000000
--- a/arch/arm/mach-s5pv210/init.c
+++ /dev/null
@@ -1,44 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/init.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/serial_core.h>
-
-#include <plat/cpu.h>
-#include <plat/devs.h>
-#include <plat/s5pv210.h>
-#include <plat/regs-serial.h>
-
-static struct s3c24xx_uart_clksrc s5pv210_serial_clocks[] = {
-	[0] = {
-		.name		= "pclk",
-		.divisor	= 1,
-		.min_baud	= 0,
-		.max_baud	= 0,
-	},
-};
-
-/* uart registration process */
-void __init s5pv210_common_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	struct s3c2410_uartcfg *tcfg = cfg;
-	u32 ucnt;
-
-	for (ucnt = 0; ucnt < no; ucnt++, tcfg++) {
-		if (!tcfg->clocks) {
-			tcfg->clocks = s5pv210_serial_clocks;
-			tcfg->clocks_size = ARRAY_SIZE(s5pv210_serial_clocks);
-		}
-	}
-
-	s3c24xx_init_uartdevs("s5pv210-uart", s5p_uart_resources, cfg, no);
-}
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index c6a855d..f0dd7fd 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -23,6 +23,7 @@ config PLAT_S5P
 	select SAMSUNG_CLKSRC
 	select SAMSUNG_IRQ_VIC_TIMER
 	select SAMSUNG_IRQ_UART
+	select S3C64XX_DEV_UART
 	help
 	  Base platform code for Samsung's S5P series SoC.
 
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index b2e0296..ec5a519 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -13,7 +13,6 @@ obj-				:=
 # Core files
 
 obj-y				+= dev-pmu.o
-obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o
diff --git a/arch/arm/plat-s5p/cpu.c b/arch/arm/plat-s5p/cpu.c
index b07a078..745aaf6 100644
--- a/arch/arm/plat-s5p/cpu.c
+++ b/arch/arm/plat-s5p/cpu.c
@@ -37,7 +37,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idmask		= 0xffffff00,
 		.map_io		= s5p6440_map_io,
 		.init_clocks	= s5p6440_init_clocks,
-		.init_uarts	= s5p6440_init_uarts,
 		.init		= s5p6440_init,
 		.name		= name_s5p6440,
 	}, {
@@ -45,7 +44,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idmask		= 0xffffff00,
 		.map_io		= s5p6442_map_io,
 		.init_clocks	= s5p6442_init_clocks,
-		.init_uarts	= s5p6442_init_uarts,
 		.init		= s5p6442_init,
 		.name		= name_s5p6442,
 	}, {
@@ -53,7 +51,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idmask		= 0xfffff000,
 		.map_io		= s5pc100_map_io,
 		.init_clocks	= s5pc100_init_clocks,
-		.init_uarts	= s5pc100_init_uarts,
 		.init		= s5pc100_init,
 		.name		= name_s5pc100,
 	}, {
@@ -61,7 +58,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idmask		= 0xfffff000,
 		.map_io		= s5pv210_map_io,
 		.init_clocks	= s5pv210_init_clocks,
-		.init_uarts	= s5pv210_init_uarts,
 		.init		= s5pv210_init,
 		.name		= name_s5pv210,
 	}, {
@@ -69,7 +65,6 @@ static struct cpu_table cpu_ids[] __initdata = {
 		.idmask		= 0xfffff000,
 		.map_io		= s5pv310_map_io,
 		.init_clocks	= s5pv310_init_clocks,
-		.init_uarts	= s5pv310_init_uarts,
 		.init		= s5pv310_init,
 		.name		= name_s5pv310,
 	},
diff --git a/arch/arm/plat-s5p/dev-uart.c b/arch/arm/plat-s5p/dev-uart.c
deleted file mode 100644
index a89331e..0000000
--- a/arch/arm/plat-s5p/dev-uart.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/* linux/arch/arm/plat-s5p/dev-uart.c
- *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * Base S5P UART resource and device definitions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/interrupt.h>
-#include <linux/list.h>
-#include <linux/platform_device.h>
-
-#include <asm/mach/arch.h>
-#include <asm/mach/irq.h>
-#include <mach/hardware.h>
-#include <mach/map.h>
-
-#include <plat/devs.h>
-
- /* Serial port registrations */
-
-static struct resource s5p_uart0_resource[] = {
-	[0] = {
-		.start	= S5P_PA_UART0,
-		.end	= S5P_PA_UART0 + S5P_SZ_UART,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_S5P_UART_RX0,
-		.end	= IRQ_S5P_UART_RX0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX0,
-		.end	= IRQ_S5P_UART_TX0,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR0,
-		.end	= IRQ_S5P_UART_ERR0,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct resource s5p_uart1_resource[] = {
-	[0] = {
-		.start	= S5P_PA_UART1,
-		.end	= S5P_PA_UART1 + S5P_SZ_UART,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_S5P_UART_RX1,
-		.end	= IRQ_S5P_UART_RX1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX1,
-		.end	= IRQ_S5P_UART_TX1,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR1,
-		.end	= IRQ_S5P_UART_ERR1,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource s5p_uart2_resource[] = {
-	[0] = {
-		.start	= S5P_PA_UART2,
-		.end	= S5P_PA_UART2 + S5P_SZ_UART,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_S5P_UART_RX2,
-		.end	= IRQ_S5P_UART_RX2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX2,
-		.end	= IRQ_S5P_UART_TX2,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR2,
-		.end	= IRQ_S5P_UART_ERR2,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct resource s5p_uart3_resource[] = {
-#if CONFIG_SERIAL_SAMSUNG_UARTS > 3
-	[0] = {
-		.start	= S5P_PA_UART3,
-		.end	= S5P_PA_UART3 + S5P_SZ_UART,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= IRQ_S5P_UART_RX3,
-		.end	= IRQ_S5P_UART_RX3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= IRQ_S5P_UART_TX3,
-		.end	= IRQ_S5P_UART_TX3,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
-		.start	= IRQ_S5P_UART_ERR3,
-		.end	= IRQ_S5P_UART_ERR3,
-		.flags	= IORESOURCE_IRQ,
-	},
-#endif
-};
-
-struct s3c24xx_uart_resources s5p_uart_resources[] __initdata = {
-	[0] = {
-		.resources	= s5p_uart0_resource,
-		.nr_resources	= ARRAY_SIZE(s5p_uart0_resource),
-	},
-	[1] = {
-		.resources	= s5p_uart1_resource,
-		.nr_resources	= ARRAY_SIZE(s5p_uart1_resource),
-	},
-	[2] = {
-		.resources	= s5p_uart2_resource,
-		.nr_resources	= ARRAY_SIZE(s5p_uart2_resource),
-	},
-	[3] = {
-		.resources	= s5p_uart3_resource,
-		.nr_resources	= ARRAY_SIZE(s5p_uart3_resource),
-	},
-};
diff --git a/arch/arm/plat-s5p/include/plat/s5p6440.h b/arch/arm/plat-s5p/include/plat/s5p6440.h
index a4cd75a..a690fa7 100644
--- a/arch/arm/plat-s5p/include/plat/s5p6440.h
+++ b/arch/arm/plat-s5p/include/plat/s5p6440.h
@@ -12,7 +12,8 @@
 
  /* Common init code for S5P6440 related SoCs */
 
-extern void s5p6440_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+extern void s5p6440_init_uarts(struct s3c2410_uartcfg *cfg, int no);
+
 extern void s5p6440_register_clocks(void);
 extern void s5p6440_setup_clocks(void);
 
@@ -23,11 +24,8 @@ extern void s5p6440_init_irq(void);
 extern void s5p6440_map_io(void);
 extern void s5p6440_init_clocks(int xtal);
 
-#define s5p6440_init_uarts s5p6440_common_init_uarts
-
 #else
 #define s5p6440_init_clocks NULL
-#define s5p6440_init_uarts NULL
 #define s5p6440_map_io NULL
 #define s5p6440_init NULL
 #endif
diff --git a/arch/arm/plat-s5p/include/plat/s5p6442.h b/arch/arm/plat-s5p/include/plat/s5p6442.h
index 7b88013..1da2bb3 100644
--- a/arch/arm/plat-s5p/include/plat/s5p6442.h
+++ b/arch/arm/plat-s5p/include/plat/s5p6442.h
@@ -12,7 +12,6 @@
 
 /* Common init code for S5P6442 related SoCs */
 
-extern void s5p6442_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s5p6442_register_clocks(void);
 extern void s5p6442_setup_clocks(void);
 
@@ -23,11 +22,8 @@ extern void s5p6442_init_irq(void);
 extern void s5p6442_map_io(void);
 extern void s5p6442_init_clocks(int xtal);
 
-#define s5p6442_init_uarts s5p6442_common_init_uarts
-
 #else
 #define s5p6442_init_clocks NULL
-#define s5p6442_init_uarts NULL
 #define s5p6442_map_io NULL
 #define s5p6442_init NULL
 #endif
diff --git a/arch/arm/plat-s5p/include/plat/s5pc100.h b/arch/arm/plat-s5p/include/plat/s5pc100.h
index 5f6099d..9fed677 100644
--- a/arch/arm/plat-s5p/include/plat/s5pc100.h
+++ b/arch/arm/plat-s5p/include/plat/s5pc100.h
@@ -12,7 +12,6 @@
 
 /* Common init code for S5PC100 related SoCs */
 
-extern void s5pc100_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s5pc100_register_clocks(void);
 extern void s5pc100_setup_clocks(void);
 
@@ -23,11 +22,9 @@ extern void s5pc100_init_irq(void);
 extern void s5pc100_map_io(void);
 extern void s5pc100_init_clocks(int xtal);
 
-#define s5pc100_init_uarts s5pc100_common_init_uarts
 
 #else
 #define s5pc100_init_clocks NULL
-#define s5pc100_init_uarts NULL
 #define s5pc100_map_io NULL
 #define s5pc100_init NULL
 #endif
diff --git a/arch/arm/plat-s5p/include/plat/s5pv210.h b/arch/arm/plat-s5p/include/plat/s5pv210.h
index 49dac0b..2305fb5 100644
--- a/arch/arm/plat-s5p/include/plat/s5pv210.h
+++ b/arch/arm/plat-s5p/include/plat/s5pv210.h
@@ -12,7 +12,6 @@
 
 /* Common init code for S5PV210 related SoCs */
 
-extern void s5pv210_common_init_uarts(struct s3c2410_uartcfg *cfg, int no);
 extern void s5pv210_register_clocks(void);
 extern void s5pv210_setup_clocks(void);
 extern void s5pv210_register_devtable(void);
@@ -24,11 +23,8 @@ extern void s5pv210_init_irq(void);
 extern void s5pv210_map_io(void);
 extern void s5pv210_init_clocks(int xtal);
 
-#define s5pv210_init_uarts s5pv210_common_init_uarts
-
 #else
 #define s5pv210_init_clocks NULL
-#define s5pv210_init_uarts NULL
 #define s5pv210_map_io NULL
 #define s5pv210_init NULL
 #endif
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 4529dd6..8f3be02 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -145,6 +145,16 @@ config S3C_ADC
 
 # device definitions to compile in
 
+config S3C24XX_DEV_UART
+	bool
+	help
+	  Compile in platform device definitions for s3c24xx style UART
+
+config S3C64XX_DEV_UART
+	bool
+	help
+	  Compile in platform device definitions for s3c64xx style UART
+
 config S3C_DEV_HSMMC
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index a14f443..edaa083 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -33,6 +33,8 @@ obj-$(CONFIG_S3C_ADC)	+= adc.o
 
 obj-y				+= platformdata.o
 
+obj-$(CONFIG_S3C24XX_DEV_UART)	+= dev-uart-s3c24xx.o
+obj-$(CONFIG_S3C64XX_DEV_UART)	+= dev-uart-s3c64xx.o
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
 obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
 obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
diff --git a/arch/arm/plat-samsung/dev-uart-s3c24xx.c b/arch/arm/plat-samsung/dev-uart-s3c24xx.c
new file mode 100644
index 0000000..5c3fbc0
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-uart-s3c24xx.c
@@ -0,0 +1,37 @@
+/* linux/arch/arm/plat-s3c/dev-fb.c
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * S3C series device definition for framebuffer device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/gfp.h>
+
+#include <plat/devs.h>
+#include <plat/dev-core.h>
+
+static struct resource template_uart[] __initdata = {
+	[0] = {
+		.end = SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.end = 3,  /* UARTS have three IRQs */
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct s3c_pdev_template s3c24xx_aurt_template __initdata = {
+	.type = SAMSUNG_DEVICE_UART,
+	.resources = resources_uart,
+	.nr_res = ARRAY_SIZE(resources_uart),
+};
diff --git a/arch/arm/plat-samsung/dev-uart-s3c64xx.c b/arch/arm/plat-samsung/dev-uart-s3c64xx.c
new file mode 100644
index 0000000..9bb2807
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-uart-s3c64xx.c
@@ -0,0 +1,42 @@
+/* linux/arch/arm/plat-s3c/dev-fb.c
+ *
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * S3C series device definition for framebuffer device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/gfp.h>
+
+#include <plat/devs.h>
+#include <plat/dev-core.h>
+
+static struct resource resources_uart_s3c64xx[4] __initdata = {
+	[0] = {
+		.end = SZ_1K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.flags = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.flags = IORESOURCE_IRQ,
+	},
+	[3] = {
+		.flags = IORESOURCE_IRQ,
+	}
+};
+
+struct s3c_pdev_template s3c64xx_uart_template __initdata = {
+	.type = SAMSUNG_DEVICE_UART,
+	.resources = resources_uart_s3c64xx,
+	.nr_res = ARRAY_SIZE(resources_uart_s3c64xx),
+};
diff --git a/arch/arm/plat-samsung/dev-uart.c b/arch/arm/plat-samsung/dev-uart.c
index 3776cd9..3d69a7b 100644
--- a/arch/arm/plat-samsung/dev-uart.c
+++ b/arch/arm/plat-samsung/dev-uart.c
@@ -17,28 +17,5 @@
 
 /* uart devices */
 
-static struct platform_device s3c24xx_uart_device0 = {
-	.id		= 0,
-};
-
-static struct platform_device s3c24xx_uart_device1 = {
-	.id		= 1,
-};
-
-static struct platform_device s3c24xx_uart_device2 = {
-	.id		= 2,
-};
-
-static struct platform_device s3c24xx_uart_device3 = {
-	.id		= 3,
-};
-
-struct platform_device *s3c24xx_uart_src[4] = {
-	&s3c24xx_uart_device0,
-	&s3c24xx_uart_device1,
-	&s3c24xx_uart_device2,
-	&s3c24xx_uart_device3,
-};
-
 struct platform_device *s3c24xx_uart_devs[4] = {
 };
diff --git a/arch/arm/plat-samsung/dev_templates.c b/arch/arm/plat-samsung/dev_templates.c
index 6783bec..dcf8c0e 100644
--- a/arch/arm/plat-samsung/dev_templates.c
+++ b/arch/arm/plat-samsung/dev_templates.c
@@ -21,6 +21,8 @@
 #include <plat/dev-core.h>
 #include <plat/cpu.h>
 
+#include <plat/uart.h>
+
 #define TEMPLATE_ENTRY(_type, _res) \
 {	.type = (_type), \
 	.resources = (_res), \
@@ -39,6 +41,8 @@ struct resource s3c_std_resources_4k[] __initdata = {
 };
 
 static struct s3c_pdev_template *templates[] __initdata = {
+	s3c24xx_uart_template_p,
+	s3c64xx_uart_template_p,
 };
 
 u64 samsung_std_dma_mask = 0xffffffffUL;
diff --git a/arch/arm/plat-samsung/include/plat/cpu.h b/arch/arm/plat-samsung/include/plat/cpu.h
index 6412933..a6679c4 100644
--- a/arch/arm/plat-samsung/include/plat/cpu.h
+++ b/arch/arm/plat-samsung/include/plat/cpu.h
@@ -35,7 +35,6 @@ struct cpu_table {
 	unsigned long	idcode;
 	unsigned long	idmask;
 	void		(*map_io)(void);
-	void		(*init_uarts)(struct s3c2410_uartcfg *cfg, int no);
 	void		(*init_clocks)(int xtal);
 	int		(*init)(void);
 	const char	*name;
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 79e7564..aa6a248 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -129,17 +129,7 @@ extern int samsung_add_devices(struct s3c_devtable *devs, int nr_devs);
 extern void samsung_device_setparent(struct device *dev,
 				     enum s3c_dev_type type, int index);
 
-struct s3c24xx_uart_resources {
-	struct resource		*resources;
-	unsigned long		 nr_resources;
-};
-
-extern struct s3c24xx_uart_resources s3c2410_uart_resources[];
-extern struct s3c24xx_uart_resources s3c64xx_uart_resources[];
-extern struct s3c24xx_uart_resources s5p_uart_resources[];
-
 extern struct platform_device *s3c24xx_uart_devs[];
-extern struct platform_device *s3c24xx_uart_src[];
 
 extern struct platform_device s3c_device_timer[];
 
diff --git a/arch/arm/plat-samsung/include/plat/uart.h b/arch/arm/plat-samsung/include/plat/uart.h
new file mode 100644
index 0000000..2a149e7
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/uart.h
@@ -0,0 +1,30 @@
+/* arch/arm/plat-s3c/include/plat/iic.h
+ *
+ * Copyright 2004-2009 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * S3C - I2C Controller platform_device info
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_UART_H
+#define __ASM_ARCH_UART_H __FILE__
+
+#ifdef CONFIG_S3C64XX_DEV_UART
+extern struct s3c_pdev_template s3c64xx_uart_template;
+#define s3c64xx_uart_template_p (&s3c64xx_uart_template)
+#else
+#define s3c64xx_uart_template_p NULL
+#endif
+
+#ifdef CONFIG_S3C24XX_DEV_UART
+extern struct s3c_pdev_template s3c24xx_uart_template;
+#define s3c24xx_uart_template_p (&s3c24xx_uart_template)
+#else
+#define s3c24xx_uart_template_p NULL
+#endif
+
+#endif /* __ASM_ARCH_UART_H */
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 6790edf..42b1c33 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -26,6 +26,7 @@
 #include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/clock.h>
+#include <plat/dev-core.h>
 
 #include <plat/regs-serial.h>
 
@@ -100,46 +101,25 @@ static struct s3c2410_uartcfg uart_cfgs[CONFIG_SERIAL_SAMSUNG_UARTS];
  * This also fills in the array passed to the serial driver for the
  * early initialisation of the console.
 */
-
-void __init s3c24xx_init_uartdevs(char *name,
-				  struct s3c24xx_uart_resources *res,
-				  struct s3c2410_uartcfg *cfg, int no)
+void __init s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
 {
 	struct platform_device *platdev;
 	struct s3c2410_uartcfg *cfgptr = uart_cfgs;
-	struct s3c24xx_uart_resources *resp;
 	int uart;
 
 	memcpy(cfgptr, cfg, sizeof(struct s3c2410_uartcfg) * no);
 
 	for (uart = 0; uart < no; uart++, cfg++, cfgptr++) {
-		platdev = s3c24xx_uart_src[cfgptr->hwport];
-
-		resp = res + cfgptr->hwport;
+		platdev = s3c_device_create(SAMSUNG_DEVICE_UART,
+					    cfgptr->hwport, NULL);
 
 		s3c24xx_uart_devs[uart] = platdev;
-
-		platdev->name = name;
-		platdev->resource = resp->resources;
-		platdev->num_resources = resp->nr_resources;
-
 		platdev->dev.platform_data = cfgptr;
 	}
 
 	nr_uarts = no;
 }
 
-void __init s3c24xx_init_uarts(struct s3c2410_uartcfg *cfg, int no)
-{
-	if (cpu == NULL)
-		return;
-
-	if (cpu->init_uarts == NULL) {
-		printk(KERN_ERR "s3c24xx_init_uarts: cpu has no uart init\n");
-	} else
-		(cpu->init_uarts)(cfg, no);
-}
-
 static int __init s3c_arch_init(void)
 {
 	int ret;
-- 
1.7.1.569.g6f426
