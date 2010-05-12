From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 12 May 2010 03:35:58 +0100
Subject: [PATCH 07/15] ARM: S3C2416: Add initial support of SMDK2416
In-Reply-To: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
References: <1273631766-15693-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1273631766-15693-7-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yauhen Kharuzhy <jekhor@gmail.com>

Add support of SMDK2416 development board.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2416/Kconfig         |    6 ++
 arch/arm/mach-s3c2416/Makefile        |    1 +
 arch/arm/mach-s3c2416/mach-smdk2416.c |  144 +++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c2416/mach-smdk2416.c

diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
index cc320f6..528f273 100644
--- a/arch/arm/mach-s3c2416/Kconfig
+++ b/arch/arm/mach-s3c2416/Kconfig
@@ -21,5 +21,11 @@ config S3C2416_DMA
 
 menu "S3C2416 Machines"
 
+config MACH_SMDK2416
+	bool "SMDK2416"
+	select CPU_S3C2416
+	select S3C_DEV_HSMMC
+	help
+	  Say Y here if you are using an SMDK2416
 
 endmenu
diff --git a/arch/arm/mach-s3c2416/Makefile b/arch/arm/mach-s3c2416/Makefile
index 34bb70d..9183e81 100644
--- a/arch/arm/mach-s3c2416/Makefile
+++ b/arch/arm/mach-s3c2416/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_CPU_S3C2416)	+= irq.o
 
 # Machine support
 
+obj-$(CONFIG_MACH_SMDK2416)	+= mach-smdk2416.o
diff --git a/arch/arm/mach-s3c2416/mach-smdk2416.c b/arch/arm/mach-s3c2416/mach-smdk2416.c
new file mode 100644
index 0000000..8c9aed6
--- /dev/null
+++ b/arch/arm/mach-s3c2416/mach-smdk2416.c
@@ -0,0 +1,144 @@
+/* linux/arch/arm/mach-s3c2416/mach-hanlin_v3c.c
+ *
+ * Copyright (c) 2009 Yauhen Kharuzhy <jekhor@gmail.com>,
+ *	as part of OpenInkpot project
+ * Copyright (c) 2009 Promwad Innovation Company
+ *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
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
+#include <linux/mtd/partitions.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/hardware.h>
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+
+#include <plat/regs-serial.h>
+#include <mach/regs-gpio.h>
+#include <mach/regs-lcd.h>
+
+#include <mach/idle.h>
+#include <mach/fb.h>
+#include <mach/leds-gpio.h>
+#include <plat/iic.h>
+
+#include <plat/s3c2416.h>
+#include <plat/clock.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+#include <plat/nand.h>
+
+#include <plat/common-smdk.h>
+
+static struct map_desc smdk2416_iodesc[] __initdata = {
+	/* ISA IO Space map (memory space selected by A24) */
+
+	{
+		.virtual	= (u32)S3C24XX_VA_ISA_WORD,
+		.pfn		= __phys_to_pfn(S3C2410_CS2),
+		.length		= 0x10000,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (u32)S3C24XX_VA_ISA_WORD + 0x10000,
+		.pfn		= __phys_to_pfn(S3C2410_CS2 + (1<<24)),
+		.length		= SZ_4M,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (u32)S3C24XX_VA_ISA_BYTE,
+		.pfn		= __phys_to_pfn(S3C2410_CS2),
+		.length		= 0x10000,
+		.type		= MT_DEVICE,
+	}, {
+		.virtual	= (u32)S3C24XX_VA_ISA_BYTE + 0x10000,
+		.pfn		= __phys_to_pfn(S3C2410_CS2 + (1<<24)),
+		.length		= SZ_4M,
+		.type		= MT_DEVICE,
+	}
+};
+
+#define UCON (S3C2410_UCON_DEFAULT	| \
+		S3C2440_UCON_PCLK	| \
+		S3C2443_UCON_RXERR_IRQEN)
+
+#define ULCON (S3C2410_LCON_CS8 | S3C2410_LCON_PNONE)
+
+#define UFCON (S3C2410_UFCON_RXTRIG8	| \
+		S3C2410_UFCON_FIFOMODE	| \
+		S3C2440_UFCON_TXTRIG16)
+
+static struct s3c2410_uartcfg smdk2416_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport	     = 0,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
+	},
+	[1] = {
+		.hwport	     = 1,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
+	},
+	/* IR port */
+	[2] = {
+		.hwport	     = 2,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON | 0x50,
+		.ufcon	     = UFCON,
+	}
+};
+
+static struct platform_device *smdk2416_devices[] __initdata = {
+	&s3c_device_wdt,
+	&s3c_device_i2c0,
+	&s3c_device_hsmmc0,
+};
+
+static void __init smdk2416_map_io(void)
+{
+
+	s3c24xx_init_io(smdk2416_iodesc, ARRAY_SIZE(smdk2416_iodesc));
+	s3c24xx_init_clocks(12000000);
+	s3c24xx_init_uarts(smdk2416_uartcfgs, ARRAY_SIZE(smdk2416_uartcfgs));
+
+}
+
+static void __init smdk2416_machine_init(void)
+{
+	s3c_i2c0_set_platdata(NULL);
+
+	platform_add_devices(smdk2416_devices, ARRAY_SIZE(smdk2416_devices));
+	smdk_machine_init();
+}
+
+MACHINE_START(SMDK2416, "SMDK2416")
+	/* Maintainer: Yauhen Kharuzhy <jekhor@gmail.com> */
+	.phys_io	= S3C2410_PA_UART,
+	.io_pg_offst	= (((u32)S3C24XX_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S3C2410_SDRAM_PA + 0x100,
+
+	.init_irq	= s3c24xx_init_irq,
+	.map_io		= smdk2416_map_io,
+	.init_machine	= smdk2416_machine_init,
+	.timer		= &s3c24xx_timer,
+MACHINE_END
-- 
1.6.3.3
