From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 May 2010 08:53:10 +0200
Subject: [PATCH 2/7] ARM: S5PV210: add Aquila board
In-Reply-To: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
References: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274079195-18105-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add basic support for Samsung Aquila board. This board is based
on S5PC110 SoC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |   12 ++--
 arch/arm/mach-s5pv210/Makefile      |    1 +
 arch/arm/mach-s5pv210/mach-aquila.c |  100 +++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/mach-aquila.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index af33a1a..c42bcba 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -15,11 +15,6 @@ config CPU_S5PV210
 	help
 	  Enable S5PV210 CPU support
 
-choice
-	prompt "Select machine type"
-	depends on ARCH_S5PV210
-	default MACH_SMDKV210
-
 config MACH_SMDKV210
 	bool "SMDKV210"
 	select CPU_S5PV210
@@ -35,6 +30,11 @@ config MACH_SMDKC110
 	  Machine support for Samsung SMDKC110
 	  S5PC110(MCP) is one of package option of S5PV210
 
-endchoice
+config MACH_AQUILA
+	bool "Samsung Aquila"
+	select CPU_S5PV210
+	select ARCH_SPARSEMEM_ENABLE
+	help
+	  Machine support for the Samsung Aquila target based on S5PC110 SoC
 
 endif
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 370aac6..0bb1680 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -19,3 +19,4 @@ obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 
 obj-$(CONFIG_MACH_SMDKV210)	+= mach-smdkv210.o
 obj-$(CONFIG_MACH_SMDKC110)	+= mach-smdkc110.o
+obj-$(CONFIG_MACH_AQUILA)	+= mach-aquila.o
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
new file mode 100644
index 0000000..6a1db39
--- /dev/null
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -0,0 +1,100 @@
+/* linux/arch/arm/mach-s5pv210/mach-aquila.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+
+#include <mach/map.h>
+#include <mach/regs-clock.h>
+
+#include <plat/regs-serial.h>
+#include <plat/s5pv210.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+/* Following are default values for UCON, ULCON and UFCON UART registers */
+#define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define S5PV210_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define S5PV210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S5PV210_UFCON_TXTRIG4 |	\
+				 S5PV210_UFCON_RXTRIG4)
+
+static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport		= 0,
+		.flags		= 0,
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ulcon		= S5PV210_ULCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport		= 1,
+		.flags		= 0,
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ulcon		= S5PV210_ULCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport		= 2,
+		.flags		= 0,
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ulcon		= S5PV210_ULCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport		= 3,
+		.flags		= 0,
+		.ucon		= S5PV210_UCON_DEFAULT,
+		.ulcon		= S5PV210_ULCON_DEFAULT,
+		.ufcon		= S5PV210_UFCON_DEFAULT,
+	},
+};
+
+static struct platform_device *aquila_devices[] __initdata = {
+};
+
+static void __init aquila_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(smdkv210_uartcfgs, ARRAY_SIZE(smdkv210_uartcfgs));
+}
+
+static void __init aquila_machine_init(void)
+{
+	platform_add_devices(aquila_devices, ARRAY_SIZE(aquila_devices));
+}
+
+MACHINE_START(AQUILA, "Aquila")
+	/* Maintainers:
+	   Marek Szyprowski <m.szyprowski@samsung.com>
+	   Kyungmin Park <kyungmin.park@samsung.com> */
+	.phys_io	= S3C_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.init_irq	= s5pv210_init_irq,
+	.map_io		= aquila_map_io,
+	.init_machine	= aquila_machine_init,
+	.timer		= &s3c24xx_timer,
+MACHINE_END
-- 
1.6.4
