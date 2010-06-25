From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 25 Jun 2010 23:27:16 +0900
Subject: [PATCH 7/8] ARM: S5PV310: Add Board support file
In-Reply-To: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
References: <1277476037-8806-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1277476037-8806-8-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Changhwan Youn <chaos.youn@samsung.com>

This patch adds Samsung SMDKV310 board support file.

Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv310/Makefile        |    4 ++
 arch/arm/mach-s5pv310/mach-smdkv310.c |   94 +++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/mach-smdkv310.c

diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index 1b263a5..56e7693 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -18,3 +18,7 @@ obj-$(CONFIG_CPU_S5PV310)	+= setup-i2c0.o time.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
+
+# machine support
+
+obj-$(CONFIG_MACH_SMDKV310)	+= mach-smdkv310.o
diff --git a/arch/arm/mach-s5pv310/mach-smdkv310.c b/arch/arm/mach-s5pv310/mach-smdkv310.c
new file mode 100644
index 0000000..6ce9ebd
--- /dev/null
+++ b/arch/arm/mach-s5pv310/mach-smdkv310.c
@@ -0,0 +1,94 @@
+/* linux/arch/arm/mach-s5pv310/mach-smdkv310.c
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
+extern struct sys_timer s5pv310_timer;
+
+/* Following are default values for UCON, ULCON and UFCON UART registers */
+#define SMDKV310_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define SMDKV310_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define SMDKV310_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S5PV210_UFCON_TXTRIG4 |	\
+				 S5PV210_UFCON_RXTRIG4)
+
+static struct s3c2410_uartcfg smdkv310_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport		= 0,
+		.flags		= 0,
+		.ucon		= SMDKV310_UCON_DEFAULT,
+		.ulcon		= SMDKV310_ULCON_DEFAULT,
+		.ufcon		= SMDKV310_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport		= 1,
+		.flags		= 0,
+		.ucon		= SMDKV310_UCON_DEFAULT,
+		.ulcon		= SMDKV310_ULCON_DEFAULT,
+		.ufcon		= SMDKV310_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport		= 2,
+		.flags		= 0,
+		.ucon		= SMDKV310_UCON_DEFAULT,
+		.ulcon		= SMDKV310_ULCON_DEFAULT,
+		.ufcon		= SMDKV310_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport		= 3,
+		.flags		= 0,
+		.ucon		= SMDKV310_UCON_DEFAULT,
+		.ulcon		= SMDKV310_ULCON_DEFAULT,
+		.ufcon		= SMDKV310_UFCON_DEFAULT,
+	},
+};
+
+static void __init smdkv310_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(smdkv310_uartcfgs, ARRAY_SIZE(smdkv310_uartcfgs));
+}
+
+static void __init smdkv310_machine_init(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
+#endif
+}
+
+MACHINE_START(SMDKV310, "SMDKV310")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	/* Maintainer: Changhwan Youn <chaos.youn@samsung.com> */
+	.phys_io	= S3C_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.init_irq	= s5pv310_init_irq,
+	.map_io		= smdkv310_map_io,
+	.init_machine	= smdkv310_machine_init,
+	.timer		= &s5pv310_timer,
+MACHINE_END
-- 
1.6.2.5
