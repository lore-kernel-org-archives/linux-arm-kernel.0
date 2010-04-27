From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 27 Apr 2010 09:46:42 +0530
Subject: [PATCH 04/14] ux500: move irq and common maps to cpu.c
In-Reply-To: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
References: <1272341812-4622-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1272341812-4622-5-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move IRQ initialization and common io mapping setup code to cpu.c,
renaming U8500* to UX500* along the way.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 arch/arm/mach-ux500/Makefile             |    2 +-
 arch/arm/mach-ux500/board-mop500.c       |    2 +-
 arch/arm/mach-ux500/cpu-u8500.c          |   44 +------------------
 arch/arm/mach-ux500/cpu.c                |   68 ++++++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/setup.h |   13 +++++-
 5 files changed, 83 insertions(+), 46 deletions(-)
 create mode 100644 arch/arm/mach-ux500/cpu.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 95e6e24..6deee85 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel, U8500 machine.
 #
 
-obj-y				:= clock.o
+obj-y				:= clock.o cpu.o
 obj-$(CONFIG_ARCH_U8500)	+= cpu-u8500.o
 obj-$(CONFIG_MACH_U8500_MOP)	+= board-mop500.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o localtimer.o
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4335186..9ca4709 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -221,7 +221,7 @@ MACHINE_START(U8500, "ST-Ericsson MOP500 platform")
 	.io_pg_offst	= (IO_ADDRESS(U8500_UART2_BASE) >> 18) & 0xfffc,
 	.boot_params	= 0x100,
 	.map_io		= u8500_map_io,
-	.init_irq	= u8500_init_irq,
+	.init_irq	= ux500_init_irq,
 	/* we re-use nomadik timer here */
 	.timer		= &u8500_timer,
 	.init_machine	= u8500_init_machine,
diff --git a/arch/arm/mach-ux500/cpu-u8500.c b/arch/arm/mach-ux500/cpu-u8500.c
index 8919af4..2c8aa93 100644
--- a/arch/arm/mach-ux500/cpu-u8500.c
+++ b/arch/arm/mach-ux500/cpu-u8500.c
@@ -18,9 +18,7 @@
 #include <linux/io.h>
 
 #include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
-#include <asm/hardware/cache-l2x0.h>
 #include <plat/mtu.h>
 #include <mach/hardware.h>
 #include <mach/setup.h>
@@ -103,32 +101,13 @@ static struct platform_device *platform_devs[] __initdata = {
 	&u8500_gpio_devs[8],
 };
 
-#define __IO_DEV_DESC(x, sz)	{		\
-	.virtual	= IO_ADDRESS(x),	\
-	.pfn		= __phys_to_pfn(x),	\
-	.length		= sz,			\
-	.type		= MT_DEVICE,		\
-}
-
 /* minimum static i/o mapping required to boot U8500 platforms */
 static struct map_desc u8500_io_desc[] __initdata = {
-	__IO_DEV_DESC(U8500_UART2_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_GIC_CPU_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_TWD_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
 	__IO_DEV_DESC(U8500_PRCMU_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST1_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST2_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST3_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST5_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_CLKRST6_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO1_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO2_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GPIO3_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
 };
 
 static struct map_desc u8500ed_io_desc[] __initdata = {
@@ -142,6 +121,8 @@ static struct map_desc u8500v1_io_desc[] __initdata = {
 
 void __init u8500_map_io(void)
 {
+	ux500_map_io();
+
 	iotable_init(u8500_io_desc, ARRAY_SIZE(u8500_io_desc));
 
 	if (cpu_is_u8500ed())
@@ -150,12 +131,6 @@ void __init u8500_map_io(void)
 		iotable_init(u8500v1_io_desc, ARRAY_SIZE(u8500v1_io_desc));
 }
 
-void __init u8500_init_irq(void)
-{
-	gic_dist_init(0, __io_address(U8500_GIC_DIST_BASE), 29);
-	gic_cpu_init(0, __io_address(U8500_GIC_CPU_BASE));
-}
-
 /*
  * This function is called from the board init
  */
@@ -185,18 +160,3 @@ static void __init u8500_timer_init(void)
 struct sys_timer u8500_timer = {
 	.init	= u8500_timer_init,
 };
-
-#ifdef CONFIG_CACHE_L2X0
-static int u8500_l2x0_init(void)
-{
-	void __iomem *l2x0_base;
-
-	l2x0_base = __io_address(U8500_L2CC_BASE);
-
-	/* 64KB way size, 8 way associativity, force WA */
-	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
-
-	return 0;
-}
-early_initcall(u8500_l2x0_init);
-#endif
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
new file mode 100644
index 0000000..e6a8058
--- /dev/null
+++ b/arch/arm/mach-ux500/cpu.c
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/platform_device.h>
+#include <linux/amba/bus.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach/map.h>
+
+#include <mach/hardware.h>
+#include <mach/setup.h>
+
+#include "clock.h"
+
+static struct map_desc ux500_io_desc[] __initdata = {
+	__IO_DEV_DESC(UX500_UART0_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_UART2_BASE, SZ_4K),
+
+	__IO_DEV_DESC(UX500_GIC_CPU_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_GIC_DIST_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_L2CC_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_TWD_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_SCU_BASE, SZ_4K),
+
+	__IO_DEV_DESC(UX500_CLKRST1_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_CLKRST2_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_CLKRST3_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_CLKRST5_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_CLKRST6_BASE, SZ_4K),
+
+	__IO_DEV_DESC(UX500_MTU0_BASE, SZ_4K),
+	__IO_DEV_DESC(UX500_MTU1_BASE, SZ_4K),
+
+	__IO_DEV_DESC(UX500_BACKUPRAM0_BASE, SZ_8K),
+};
+
+void __init ux500_map_io(void)
+{
+	iotable_init(ux500_io_desc, ARRAY_SIZE(ux500_io_desc));
+}
+
+void __init ux500_init_irq(void)
+{
+	gic_dist_init(0, __io_address(UX500_GIC_DIST_BASE), 29);
+	gic_cpu_init(0, __io_address(UX500_GIC_CPU_BASE));
+}
+
+#ifdef CONFIG_CACHE_L2X0
+static int ux500_l2x0_init(void)
+{
+	void __iomem *l2x0_base;
+
+	l2x0_base = __io_address(UX500_L2CC_BASE);
+
+	/* 64KB way size, 8 way associativity, force WA */
+	l2x0_init(l2x0_base, 0x3e060000, 0xc0000fff);
+
+	return 0;
+}
+early_initcall(ux500_l2x0_init);
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/setup.h b/arch/arm/mach-ux500/include/mach/setup.h
index 65112bf..6c4c348 100644
--- a/arch/arm/mach-ux500/include/mach/setup.h
+++ b/arch/arm/mach-ux500/include/mach/setup.h
@@ -14,13 +14,22 @@
 #include <asm/mach/time.h>
 #include <linux/init.h>
 
-extern void u8500_map_io(void);
+extern void __init ux500_map_io(void);
+extern void __init u8500_map_io(void);
+
 extern void u8500_init_devices(void);
-extern void u8500_init_irq(void);
+extern void __init ux500_init_irq(void);
 /* We re-use nomadik_timer for this platform */
 extern void nmdk_timer_init(void);
 
 struct sys_timer;
 extern struct sys_timer u8500_timer;
 
+#define __IO_DEV_DESC(x, sz)	{		\
+	.virtual	= IO_ADDRESS(x),	\
+	.pfn		= __phys_to_pfn(x),	\
+	.length		= sz,			\
+	.type		= MT_DEVICE,		\
+}
+
 #endif /*  __ASM_ARCH_SETUP_H */
-- 
1.7.0
