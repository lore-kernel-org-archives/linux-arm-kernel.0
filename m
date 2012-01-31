From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Feb 2012 00:39:10 +0900
Subject: [PATCH 5/9] ARM: EXYNOS: add board file for SMDK5250
In-Reply-To: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1328024354-4277-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/Kconfig         |   11 ++++
 arch/arm/mach-exynos/Makefile        |    2 +
 arch/arm/mach-exynos/mach-smdk5250.c |   94 ++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-exynos/mach-smdk5250.c

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 60905d5..89b8e17 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -364,6 +364,17 @@ config MACH_SMDK4412
 	  Machine support for Samsung SMDK4412
 endif
 
+if ARCH_EXYNOS5
+
+comment "EXYNOS5250 Boards"
+
+config MACH_SMDK5250
+	bool "SMDK5250"
+	select SOC_EXYNOS5250
+	help
+	  Machine support for Samsung SMDK4412
+endif
+
 comment "Flattened Device Tree based board for Exynos4 based SoC"
 
 config MACH_EXYNOS4_DT
diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 33d27d4..1b12345 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -43,6 +43,8 @@ obj-$(CONFIG_MACH_SMDK4412)		+= mach-smdk4x12.o
 
 obj-$(CONFIG_MACH_EXYNOS4_DT)		+= mach-exynos4-dt.o
 
+obj-$(CONFIG_MACH_SMDK5250)		+= mach-smdk5250.o
+
 # device support
 
 obj-$(CONFIG_ARCH_EXYNOS4)		+= dev-audio.o
diff --git a/arch/arm/mach-exynos/mach-smdk5250.c b/arch/arm/mach-exynos/mach-smdk5250.c
new file mode 100644
index 0000000..0fe4a0b
--- /dev/null
+++ b/arch/arm/mach-exynos/mach-smdk5250.c
@@ -0,0 +1,94 @@
+/*
+ * linux/arch/arm/mach-exynos/mach-smdk5250.c
+ *
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
