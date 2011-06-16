From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:37 +0100
Subject: [RFC PATCH 09/16] ARM: local timers: move ux500 to
	LOCAL_TIMER_DEVICES/ARM_SMP_TWD
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-10-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the ux500 platforms to use the new arm_smp_twd driver.
Add the platform device and register it as early platform device.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-ux500/Kconfig      |    2 ++
 arch/arm/mach-ux500/Makefile     |    1 -
 arch/arm/mach-ux500/cpu-db5500.c |    1 -
 arch/arm/mach-ux500/cpu-db8500.c |    1 -
 arch/arm/mach-ux500/cpu.c        |   38 +++++++++++++++++++++++++++++++++-----
 arch/arm/mach-ux500/localtimer.c |   30 ------------------------------
 6 files changed, 35 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/localtimer.c

diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 96d546c..aa21fc0 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -5,6 +5,8 @@ config UX500_SOC_COMMON
 	default y
 	select ARM_GIC
 	select HAS_MTU
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD
 	select ARM_ERRATA_753970
 
 menu "Ux500 SoC"
diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 1694916..2e30a80 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MACH_U8500)	+= board-mop500.o board-mop500-sdi.o \
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 obj-$(CONFIG_U5500_MODEM_IRQ)	+= modem-irq-db5500.o
 obj-$(CONFIG_U5500_MBOX)	+= mbox-db5500.o
 
diff --git a/arch/arm/mach-ux500/cpu-db5500.c b/arch/arm/mach-ux500/cpu-db5500.c
index 22705d2..63eaa98 100644
--- a/arch/arm/mach-ux500/cpu-db5500.c
+++ b/arch/arm/mach-ux500/cpu-db5500.c
@@ -33,7 +33,6 @@ static struct map_desc u5500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U5500_GIC_CPU_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_L2CC_BASE, SZ_4K),
-	__IO_DEV_DESC(U5500_TWD_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_MTU0_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U5500_BACKUPRAM0_BASE, SZ_8K),
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 4598b06..dfad7c8 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -38,7 +38,6 @@ static struct map_desc u8500_io_desc[] __initdata = {
 	__IO_DEV_DESC(U8500_GIC_CPU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_GIC_DIST_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_L2CC_BASE, SZ_4K),
-	__IO_DEV_DESC(U8500_TWD_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_MTU0_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_SCU_BASE, SZ_4K),
 	__IO_DEV_DESC(U8500_BACKUPRAM0_BASE, SZ_8K),
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 1da23bb..1dac06f 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -15,7 +15,6 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/hardware/gic.h>
 #include <asm/mach/map.h>
-#include <asm/localtimer.h>
 
 #include <plat/mtu.h>
 #include <mach/hardware.h>
@@ -120,17 +119,44 @@ static int ux500_l2x0_init(void)
 early_initcall(ux500_l2x0_init);
 #endif
 
+static struct resource ux500_twd_resources[] = {
+	{
+		.start	= 0,
+		.end	= 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device ux500_twd_device = {
+	.name		= "arm_smp_twd",
+	.id		= -1,
+	.resource	= ux500_twd_resources,
+	.num_resources	= ARRAY_SIZE(ux500_twd_resources),
+};
+
+static struct platform_device *ux500_early_devices[] = {
+	&ux500_twd_device,
+};
+
 static void __init ux500_timer_init(void)
 {
-#ifdef CONFIG_LOCAL_TIMERS
+	unsigned long iobase = 0;
 	/* Setup the local timer base */
 	if (cpu_is_u5500())
-		twd_base = __io_address(U5500_TWD_BASE);
+		iobase = U5500_TWD_BASE;
 	else if (cpu_is_u8500())
-		twd_base = __io_address(U8500_TWD_BASE);
+		iobase = U8500_TWD_BASE;
 	else
 		ux500_unknown_soc();
-#endif
+
+	ux500_twd_resources[0].start += iobase;
+	ux500_twd_resources[0].end   += iobase;
+
 	if (cpu_is_u5500())
 		mtu_base = __io_address(U5500_MTU0_BASE);
 	else if (cpu_is_u8500ed())
@@ -141,6 +167,8 @@ static void __init ux500_timer_init(void)
 		ux500_unknown_soc();
 
 	nmdk_timer_init();
+	early_platform_add_devices(ux500_early_devices,
+				   ARRAY_SIZE(ux500_early_devices));
 }
 
 struct sys_timer ux500_timer = {
diff --git a/arch/arm/mach-ux500/localtimer.c b/arch/arm/mach-ux500/localtimer.c
deleted file mode 100644
index f027cef..0000000
--- a/arch/arm/mach-ux500/localtimer.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * Copyright (C) 2008-2009 ST-Ericsson
- * Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
- *
- * This file is heavily based on relaview platform, almost a copy.
- *
- * Copyright (C) 2002 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-
-#include <asm/irq.h>
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
-	twd_timer_setup(evt);
-	return 0;
-}
-- 
1.7.0.4
