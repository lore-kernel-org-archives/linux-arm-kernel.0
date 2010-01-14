From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:38 +0100
Subject: [PATCH 20/21] ARM: S5PC1XX: add support for SMDKC110 board
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-21-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds support for SMDKC110 evaluation board. The board can be
obtained from Meritech (http://www.meritech.co.kr).

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc110/Kconfig         |    6 ++
 arch/arm/mach-s5pc110/Makefile        |    1 +
 arch/arm/mach-s5pc110/mach-smdkc110.c |  102 +++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/mach-smdkc110.c

diff --git a/arch/arm/mach-s5pc110/Kconfig b/arch/arm/mach-s5pc110/Kconfig
index ef2f940..b2374fd 100644
--- a/arch/arm/mach-s5pc110/Kconfig
+++ b/arch/arm/mach-s5pc110/Kconfig
@@ -49,4 +49,10 @@ config S5PC110_SETUP_SDHCI_GPIO
 	help
 	  Common setup code for SDHCI gpio.
 
+config MACH_SMDKC110
+	bool "SMDKC110"
+	select CPU_S5PC110
+	help
+	  Machine support for the SMDKC110 board
+
 endif
diff --git a/arch/arm/mach-s5pc110/Makefile b/arch/arm/mach-s5pc110/Makefile
index d7e03b6..3017ddd 100644
--- a/arch/arm/mach-s5pc110/Makefile
+++ b/arch/arm/mach-s5pc110/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_S5PC110_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PC110_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
 # machine support
+obj-$(CONFIG_MACH_SMDKC110)	+= mach-smdkc110.o
diff --git a/arch/arm/mach-s5pc110/mach-smdkc110.c b/arch/arm/mach-s5pc110/mach-smdkc110.c
new file mode 100644
index 0000000..2d39dfb
--- /dev/null
+++ b/arch/arm/mach-s5pc110/mach-smdkc110.c
@@ -0,0 +1,102 @@
+/*
+ * linux/arch/arm/mach-s5pc110/mach-smdkc110.c
+ *
+ *  Copyright (C) 2009 Samsung Electronics Co.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/map.h>
+
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+
+#include <plat/regs-serial.h>
+
+#include <plat/clock.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+#include <plat/s5pc1xx.h>
+
+#define UCON	(S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK)
+#define ULCON	(S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB)
+#define UFCON	(S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE)
+
+static struct s3c2410_uartcfg universal_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport	     = 0,
+		.flags	     = 0,
+		.ucon	     = 0x3c5,
+		.ulcon	     = 0x03,
+		.ufcon	     = 0x51,
+	},
+	[1] = {
+		.hwport	     = 1,
+		.flags	     = 0,
+		.ucon	     = 0x3c5,
+		.ulcon	     = 0x03,
+		.ufcon	     = 0x51,
+	},
+	[2] = {
+		.hwport	     = 2,
+		.flags	     = 0,
+		.ucon	     = 0x3c5,
+		.ulcon	     = 0x03,
+		.ufcon	     = 0x51,
+	},
+	[3] = {
+		.hwport	     = 3,
+		.flags	     = 0,
+		.ucon	     = 0x3c5,
+		.ulcon	     = 0x03,
+		.ufcon	     = 0x51,
+	},
+};
+
+static struct platform_device *universal_devices[] __initdata = {
+};
+
+static struct map_desc universal_iodesc[] = {};
+
+static void __init universal_map_io(void)
+{
+	s5pc1xx_init_io(universal_iodesc, ARRAY_SIZE(universal_iodesc));
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
+}
+
+static void __init universal_machine_init(void)
+{
+	platform_add_devices(universal_devices, ARRAY_SIZE(universal_devices));
+}
+
+MACHINE_START(SMDKC110, "SMDKC110")
+	/* Maintainer: Samsung Electronics */
+	.phys_io	= S5PC110_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S5PC1XX_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5PC110_PA_SDRAM + 0x100,
+	.init_irq	= s5pc110_init_irq,
+	.map_io		= universal_map_io,
+	.init_machine	= universal_machine_init,
+	.timer		= &s3c24xx_timer,
+MACHINE_END
-- 
1.6.4
