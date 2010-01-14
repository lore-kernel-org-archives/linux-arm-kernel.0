From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Jan 2010 16:19:04 +0900
Subject: [PATCH v5 6/8 RE-SEND] ARM: S5P6440: Add Board support file
Message-ID: <1263453544-3915-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds Samsung's SMDK6440 board support file.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p6440/mach-smdk6440.c |  115 +++++++++++++++++++++++++++++++++
 1 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5p6440/mach-smdk6440.c

diff --git a/arch/arm/mach-s5p6440/mach-smdk6440.c b/arch/arm/mach-s5p6440/mach-smdk6440.c
new file mode 100644
index 0000000..e3a49af
--- /dev/null
+++ b/arch/arm/mach-s5p6440/mach-smdk6440.c
@@ -0,0 +1,111 @@
+/* linux/arch/arm/mach-s5p6440/mach-smdk6440.c
+ *
+ * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/timer.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/serial_core.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/map.h>
+
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+
+#include <plat/regs-serial.h>
+
+#include <plat/s5p6440.h>
+#include <plat/clock.h>
+#include <mach/regs-clock.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+#include <plat/pll.h>
+
+#define S5P6440_UCON_DEFAULT    (S3C2410_UCON_TXILEVEL |	\
+				S3C2410_UCON_RXILEVEL |		\
+				S3C2410_UCON_TXIRQMODE |	\
+				S3C2410_UCON_RXIRQMODE |	\
+				S3C2410_UCON_RXFIFO_TOI |	\
+				S3C2443_UCON_RXERR_IRQEN)
+
+#define S5P6440_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define S5P6440_UFCON_DEFAULT   (S3C2410_UFCON_FIFOMODE |	\
+				S3C2440_UFCON_TXTRIG16 |	\
+				S3C2410_UFCON_RXTRIG8)
+
+static struct s3c2410_uartcfg smdk6440_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport	     = 0,
+		.flags	     = 0,
+		.ucon	     = S5P6440_UCON_DEFAULT,
+		.ulcon	     = S5P6440_ULCON_DEFAULT,
+		.ufcon	     = S5P6440_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport	     = 1,
+		.flags	     = 0,
+		.ucon	     = S5P6440_UCON_DEFAULT,
+		.ulcon	     = S5P6440_ULCON_DEFAULT,
+		.ufcon	     = S5P6440_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport	     = 2,
+		.flags	     = 0,
+		.ucon	     = S5P6440_UCON_DEFAULT,
+		.ulcon	     = S5P6440_ULCON_DEFAULT,
+		.ufcon	     = S5P6440_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport	     = 3,
+		.flags	     = 0,
+		.ucon	     = S5P6440_UCON_DEFAULT,
+		.ulcon	     = S5P6440_ULCON_DEFAULT,
+		.ufcon	     = S5P6440_UFCON_DEFAULT,
+	},
+};
+
+static struct platform_device *smdk6440_devices[] __initdata = {
+};
+
+static void __init smdk6440_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_SYS_ID);
+	s3c24xx_init_clocks(12000000);
+	s3c24xx_init_uarts(smdk6440_uartcfgs, ARRAY_SIZE(smdk6440_uartcfgs));
+}
+
+static void __init smdk6440_machine_init(void)
+{
+	platform_add_devices(smdk6440_devices, ARRAY_SIZE(smdk6440_devices));
+}
+
+MACHINE_START(SMDK6440, "SMDK6440")
+	/* Maintainer: Kukjin Kim <kgene.kim@samsung.com> */
+	.phys_io	= S5P_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S5P_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+
+	.init_irq	= s5p6440_init_irq,
+	.map_io		= smdk6440_map_io,
+	.init_machine	= smdk6440_machine_init,
+	.timer		= &s3c24xx_timer,
+MACHINE_END
-- 
1.6.2.5
