From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 28 Jul 2010 19:12:17 +0900
Subject: [PATCH 5/6] S5PV310: Add Samsung Mobile Reference Board support
Message-ID: <20100728101217.GA21349@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Initial samsung mobile reference board support

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig          |    9 +++
 arch/arm/mach-s5pv310/Makefile         |    1 +
 arch/arm/mach-s5pv310/mach-universal.c |   86 ++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/mach-universal.c

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 24ef3cd..2fe8149 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -23,4 +23,13 @@ config MACH_SMDKV310
 	select ARCH_SPARSEMEM_ENABLE
 	help
 	  Machine support for Samsung SMDKV310
+
+config MACH_UNIVERSAL
+	bool "Mobile Universal Board"
+	select CPU_S5PV310
+	select ARCH_SPARSEMEM_ENABLE
+	help
+	  Machine support for Samsung Mobile Universal Reference Board.
+	  S5PC210(MCP) is one of package option of S5PV310
+
 endif
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index 56e7693..5b52132 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 # machine support
 
 obj-$(CONFIG_MACH_SMDKV310)	+= mach-smdkv310.o
+obj-$(CONFIG_MACH_UNIVERSAL)	+= mach-universal.o
diff --git a/arch/arm/mach-s5pv310/mach-universal.c b/arch/arm/mach-s5pv310/mach-universal.c
new file mode 100644
index 0000000..d22727f
--- /dev/null
+++ b/arch/arm/mach-s5pv310/mach-universal.c
@@ -0,0 +1,86 @@
+/* linux/arch/arm/mach-s5pv310/mach-universal.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co., Ltd.
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
+#define UNIVERSAL_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
+				 S3C2410_UCON_RXILEVEL |	\
+				 S3C2410_UCON_TXIRQMODE |	\
+				 S3C2410_UCON_RXIRQMODE |	\
+				 S3C2410_UCON_RXFIFO_TOI |	\
+				 S3C2443_UCON_RXERR_IRQEN)
+
+#define UNIVERSAL_ULCON_DEFAULT	S3C2410_LCON_CS8
+
+#define UNIVERSAL_UFCON_DEFAULT	(S3C2410_UFCON_FIFOMODE |	\
+				S5PV210_UFCON_TXTRIGMAX |	\
+				S5PV210_UFCON_RXTRIGMAX)
+
+static struct s3c2410_uartcfg universal_uartcfgs[] __initdata = {
+	[0] = {
+		.hwport		= 0,
+		.ucon		= UNIVERSAL_UCON_DEFAULT,
+		.ulcon		= UNIVERSAL_ULCON_DEFAULT,
+		.ufcon		= UNIVERSAL_UFCON_DEFAULT,
+	},
+	[1] = {
+		.hwport		= 1,
+		.ucon		= UNIVERSAL_UCON_DEFAULT,
+		.ulcon		= UNIVERSAL_ULCON_DEFAULT,
+		.ufcon		= UNIVERSAL_UFCON_DEFAULT,
+	},
+	[2] = {
+		.hwport		= 2,
+		.ucon		= UNIVERSAL_UCON_DEFAULT,
+		.ulcon		= UNIVERSAL_ULCON_DEFAULT,
+		.ufcon		= UNIVERSAL_UFCON_DEFAULT,
+	},
+	[3] = {
+		.hwport		= 3,
+		.ucon		= UNIVERSAL_UCON_DEFAULT,
+		.ulcon		= UNIVERSAL_ULCON_DEFAULT,
+		.ufcon		= UNIVERSAL_UFCON_DEFAULT,
+	},
+};
+
+static void __init universal_map_io(void)
+{
+	s5p_init_io(NULL, 0, S5P_VA_CHIPID);
+	s3c24xx_init_clocks(24000000);
+	s3c24xx_init_uarts(universal_uartcfgs, ARRAY_SIZE(universal_uartcfgs));
+}
+
+static void __init universal_machine_init(void)
+{
+#ifdef CONFIG_CACHE_L2X0
+	l2x0_init(S5P_VA_L2CC, 1 << 28, 0xffffffff);
+#endif
+}
+
+MACHINE_START(UNIVERSAL, "UNIVERSAL")
+	/* Maintainer: Kyungmin Park <kyungmin.park@samsung.com> */
+	.phys_io	= S3C_PA_UART & 0xfff00000,
+	.io_pg_offst	= (((u32)S3C_VA_UART) >> 18) & 0xfffc,
+	.boot_params	= S5P_PA_SDRAM + 0x100,
+	.init_irq	= s5pv310_init_irq,
+	.map_io		= universal_map_io,
+	.init_machine	= universal_machine_init,
+	.timer		= &s5pv310_timer,
+MACHINE_END
-- 
1.5.3.3
