From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 27 Jan 2010 19:04:19 +0900
Subject: [PATCH v4 6/8] ARM: S5PV210: Add SMDKC110 board support file
Message-ID: <1264586659-23030-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SMDKC110 board support file.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Makefile        |    1 +
 arch/arm/mach-s5pv210/mach-smdkc110.c |   98 +++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/mach-smdkc110.c

diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 3ecb607..8ebf51c 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o
 # machine support
 
 obj-$(CONFIG_MACH_SMDKV210)	+= mach-smdkv210.o
+obj-$(CONFIG_MACH_SMDKC110)	+= mach-smdkc110.o
diff --git a/arch/arm/mach-s5pv210/mach-smdkc110.c b/arch/arm/mach-s5pv210/mach-smdkc110.c
new file mode 100644
index 0000000..ab4869d
--- /dev/null
+++ b/arch/arm/mach-s5pv210/mach-smdkc110.c
@@ -0,0 +1,98 @@
+/* linux/arch/arm/mach-s5pv210/mach-smdkc110.c
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
+static struct platform_device *smdkc110_devices[] __initdata = {
+};
+
+static void __init smdkc110_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(smdkv210_uartcfgs, ARRAY_SIZE(smdkv210_uartcfgs));
+}
+
+static void __init smdkc110_machine_init(void)
+{
+	platform_add_devices(smdkc110_devices, ARRAY_SIZE(smdkc110_devices));
+}
+
+MACHINE_START(SMDKC110, "SMDKC110")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.phys_io	= S3C_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.init_irq	= s5pv210_init_irq,
+	.map_io		= smdkc110_map_io,
+	.init_machine	= smdkc110_machine_init,
+	.timer		= &s3c24xx_timer,
+MACHINE_END
-- 
1.6.2.5
