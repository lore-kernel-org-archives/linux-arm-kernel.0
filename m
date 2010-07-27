From: augulis.darius@gmail.com (Darius Augulis)
Date: Tue, 27 Jul 2010 22:59:44 +0300
Subject: [PATCH] Support for Real6410
Message-ID: <20100727195944.910.69956.stgit@darius-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for CoreWind Real6410 board,
based on Samsung s3c6410 processor.

Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
---
 arch/arm/mach-s3c64xx/Kconfig         |    6 ++
 arch/arm/mach-s3c64xx/Makefile        |    1 
 arch/arm/mach-s3c64xx/mach-real6410.c |   88 +++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/mach-real6410.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index f5a5972..0f9f2dd 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -88,6 +88,12 @@ config MACH_ANW6410
 	help
 	  Machine support for the A&W6410
 
+config MACH_REAL6410
+	bool "REAL6410"
+	select CPU_S3C6410
+	help
+	  Machine support for the CoreWind REAL6410
+
 config MACH_SMDK6410
 	bool "SMDK6410"
 	select CPU_S3C6410
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 9d10069..6be3e5b 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_PM)		+= irq-pm.o
 obj-$(CONFIG_MACH_ANW6410)	+= mach-anw6410.o
 obj-$(CONFIG_MACH_SMDK6400)	+= mach-smdk6400.o
 obj-$(CONFIG_MACH_SMDK6410)	+= mach-smdk6410.o
+obj-$(CONFIG_MACH_REAL6410)     += mach-real6410.o
 obj-$(CONFIG_MACH_NCP)		+= mach-ncp.o
 obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
 obj-$(CONFIG_MACH_SMARTQ)	+= mach-smartq.o
diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-s3c64xx/mach-real6410.c
new file mode 100644
index 0000000..bbd9bf8
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/mach-real6410.c
@@ -0,0 +1,88 @@
+/* linux/arch/arm/mach-s3c64xx/mach-real6410.c
+ *
+ * Copyright 2010 Darius Augulis <augulis.darius@gmail.com>
+ * Copyright 2008 Openmoko, Inc.
+ * Copyright 2008 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
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
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <mach/map.h>
+#include <mach/s3c6410.h>
+#include <plat/cpu.h>
+#include <plat/regs-serial.h>
+
+#define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
+#define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
+#define UFCON S3C2410_UFCON_RXTRIG8 | S3C2410_UFCON_FIFOMODE
+
+static struct s3c2410_uartcfg real6410_uartcfgs[] __initdata = {
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
+	[2] = {
+		.hwport	     = 2,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
+	},
+	[3] = {
+		.hwport	     = 3,
+		.flags	     = 0,
+		.ucon	     = UCON,
+		.ulcon	     = ULCON,
+		.ufcon	     = UFCON,
+	},
+};
+
+static struct map_desc real6410_iodesc[] = {};
+
+static void __init real6410_map_io(void)
+{
+	s3c64xx_init_io(real6410_iodesc, ARRAY_SIZE(real6410_iodesc));
+	s3c24xx_init_clocks(12000000);
+	s3c24xx_init_uarts(real6410_uartcfgs, ARRAY_SIZE(real6410_uartcfgs));
+}
+
+static void __init real6410_machine_init(void)
+{
+}
+
+MACHINE_START(REAL6410, "REAL6410")
+	/* Maintainer: Darius Augulis <augulis.darius@gmail.com> */
+	.phys_io	= S3C_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S3C64XX_PA_SDRAM + 0x100,
+
+	.init_irq	= s3c6410_init_irq,
+	.map_io		= real6410_map_io,
+	.init_machine	= real6410_machine_init,
+	.timer		= &s3c24xx_timer,
+MACHINE_END
