From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  6 Aug 2010 20:41:48 +0900
Subject: [PATCH] ARM: S5PV310: Add SMDKC210 board support file
Message-ID: <1281094908-12684-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Samsung SMDKC210 board support file. The SoC
of SMDKC210, S5PC210(MCP) is one of package option of S5PV310.
And because composition of SMDKC210 and SMDKV310 differs, need
SMDKC210 with SMDKV310.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
NOTE:
This is for next merge window not this, because I don't want to apply
new patch which was submitted in merge window as per Russell's suggestion.
But this can help to developers and customers who want to use SMDKC210.
And this can be used base code for SMDKC210 development in 2.6.36-rcX.

 arch/arm/mach-s5pv310/Kconfig         |    8 +++
 arch/arm/mach-s5pv310/Makefile        |    1 +
 arch/arm/mach-s5pv310/mach-smdkc210.c |   91 +++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/mach-smdkc210.c

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 331b5bd..ae8e554 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -27,6 +27,14 @@ config S5PV310_SETUP_I2C2
 
 # machine support
 
+config MACH_SMDKC210
+	bool "SMDKC210"
+	select CPU_S5PV310
+	select ARCH_SPARSEMEM_ENABLE
+	help
+	  Machine support for Samsung SMDKC210
+	  S5PC210(MCP) is one of package option of S5PV310
+
 config MACH_SMDKV310
 	bool "SMDKV310"
 	select CPU_S5PV310
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index d5b51c7..aefb14f 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
 # machine support
 
+obj-$(CONFIG_MACH_SMDKC210)	+= mach-smdkc210.o
 obj-$(CONFIG_MACH_SMDKV310)	+= mach-smdkv310.o
 obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 
diff --git a/arch/arm/mach-s5pv310/mach-smdkc210.c b/arch/arm/mach-s5pv310/mach-smdkc210.c
new file mode 100644
index 0000000..71a3bec
--- /dev/null
+++ b/arch/arm/mach-s5pv310/mach-smdkc210.c
@@ -0,0 +1,91 @@
+/* linux/arch/arm/mach-s5pv310/mach-smdkc210.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/serial_core.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+#include <asm/hardware/cache-l2x0.h>
+
+#include <plat/regs-serial.h>
+#include <plat/s5pv310.h>
+#include <plat/cpu.h>
+
+#include <mach/map.h>
+
+/* Following are default values for UCON, ULCON and UFCON UART registers */
+#define SMDKC210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define SMDKC210_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define SMDKC210_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S5PV210_UFCON_TXTRIG4 |	\
+				 S5PV210_UFCON_RXTRIG4)
+
+static struct s3c2410_uartcfg smdkc210_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport		= 0,
+		.flags		= 0,
+		.ucon		= SMDKC210_UCON_DEFAULT,
+		.ulcon		= SMDKC210_ULCON_DEFAULT,
+		.ufcon		= SMDKC210_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport		= 1,
+		.flags		= 0,
+		.ucon		= SMDKC210_UCON_DEFAULT,
+		.ulcon		= SMDKC210_ULCON_DEFAULT,
+		.ufcon		= SMDKC210_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport		= 2,
+		.flags		= 0,
+		.ucon		= SMDKC210_UCON_DEFAULT,
+		.ulcon		= SMDKC210_ULCON_DEFAULT,
+		.ufcon		= SMDKC210_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport		= 3,
+		.flags		= 0,
+		.ucon		= SMDKC210_UCON_DEFAULT,
+		.ulcon		= SMDKC210_ULCON_DEFAULT,
+		.ufcon		= SMDKC210_UFCON_DEFAULT,
+	},
+};
+
+static void __init smdkc210_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(smdkc210_uartcfgs, ARRAY_SIZE(smdkc210_uartcfgs));
+}
+
+static void __init smdkc210_machine_init(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
+#endif
+}
+
+MACHINE_START(SMDKC210, "SMDKC210")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.phys_io	= S3C_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.init_irq	= s5pv310_init_irq,
+	.map_io		= smdkc210_map_io,
+	.init_machine	= smdkc210_machine_init,
+	.timer		= &s5pv310_timer,
+MACHINE_END
-- 
1.6.2.5
