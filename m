From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sun, 12 Feb 2012 02:34:45 +0900
Subject: [PATCH v2 11/11] ARM: EXYNOS: temporary add board file for SMDK5250
In-Reply-To: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
References: <1328981685-8602-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328981685-8602-12-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Basically, EXYNOS5 (ARCH_EXYNOS5) is supported with Device Tree.
So the non-dt board, mach-smdk5250.c file is added temporary for
testing.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Makefile        |    2 +
 arch/arm/mach-exynos/mach-smdk5250.c |   92 ++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos/mach-smdk5250.c

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 29967ef..32676af 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -44,6 +44,8 @@ obj-$(CONFIG_MACH_SMDK4412)		+= mach-smdk4x12.o
 obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 obj-$(CONFIG_MACH_EXYNOS5_DT)		+= mach-exynos5-dt.o
 
+obj-$(CONFIG_MACH_SMDK5250)		+= mach-smdk5250.o
+
 # device support
 
 obj-y					+= dev-uart.o
diff --git a/arch/arm/mach-exynos/mach-smdk5250.c b/arch/arm/mach-exynos/mach-smdk5250.c
new file mode 100644
index 0000000..b6e506d
--- /dev/null
+++ b/arch/arm/mach-exynos/mach-smdk5250.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright (c) 2012 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/platform_device.h>
+#include <linux/serial_core.h>
+
+#include <asm/mach/arch.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach-types.h>
+
+#include <plat/clock.h>
+#include <plat/cpu.h>
+#include <plat/regs-serial.h>
+
+#include <mach/map.h>
+
+#include "common.h"
+
+/* Following are default values for UCON, ULCON and UFCON UART registers */
+#define SMDK5250_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define SMDK5250_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define SMDK5250_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				 S5PV210_UFCON_TXTRIG4 |	\
+				 S5PV210_UFCON_RXTRIG4)
+
+static struct s3c2410_uartcfg smdk5250_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport		= 0,
+		.flags		= 0,
+		.ucon		= SMDK5250_UCON_DEFAULT,
+		.ulcon		= SMDK5250_ULCON_DEFAULT,
+		.ufcon		= SMDK5250_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport		= 1,
+		.flags		= 0,
+		.ucon		= SMDK5250_UCON_DEFAULT,
+		.ulcon		= SMDK5250_ULCON_DEFAULT,
+		.ufcon		= SMDK5250_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport		= 2,
+		.flags		= 0,
+		.ucon		= SMDK5250_UCON_DEFAULT,
+		.ulcon		= SMDK5250_ULCON_DEFAULT,
+		.ufcon		= SMDK5250_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport		= 3,
+		.flags		= 0,
+		.ucon		= SMDK5250_UCON_DEFAULT,
+		.ulcon		= SMDK5250_ULCON_DEFAULT,
+		.ufcon		= SMDK5250_UFCON_DEFAULT,
+	},
+};
+
+static void __init smdk5250_map_io(void)
+{
+	clk_xusbxti.rate = 24000000;
+
+	exynos_init_io(NULL, 0);
+	s3c24xx_init_clocks(clk_xusbxti.rate);
+	s3c24xx_init_uarts(smdk5250_uartcfgs, ARRAY_SIZE(smdk5250_uartcfgs));
+}
+
+static void __init smdk5250_machine_init(void)
+{
+	/* nothing here yet */
+}
+
+MACHINE_START(SMDK5250, "SMDK5250")
+	.atag_offset	= 0x100,
+	.init_irq	= exynos5_init_irq,
+	.map_io		= smdk5250_map_io,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= smdk5250_machine_init,
+	.timer		= &exynos4_timer,
+	.restart	= exynos5_restart,
+MACHINE_END
-- 
1.7.4.4
