From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:36 +0100
Subject: [RFC PATCH 08/16] ARM: local timers: move shmobile to
	LOCAL_TIMER_DEVICES/ARM_SMP_TWD
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the shmobile platforms to use the new arm_smp_twd driver.
Add the platform device and register it as early platform device.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-shmobile/Kconfig        |    2 ++
 arch/arm/mach-shmobile/Makefile       |    1 -
 arch/arm/mach-shmobile/localtimer.c   |   27 ---------------------------
 arch/arm/mach-shmobile/platsmp.c      |    1 -
 arch/arm/mach-shmobile/setup-sh73a0.c |   21 +++++++++++++++++++++
 arch/arm/mach-shmobile/smp-sh73a0.c   |    6 ------
 6 files changed, 23 insertions(+), 35 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/localtimer.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 0c8f6cf..86befbc 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -26,6 +26,8 @@ config ARCH_SH73A0
 	select SH_CLK_CPG
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD
 
 comment "SH-Mobile Board Type"
 
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 612b270..82ec6e9 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o intc-sh73a0.o
 # SMP objects
 smp-y				:= platsmp.o headsmp.o
 smp-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
-smp-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
 smp-$(CONFIG_ARCH_SH73A0)	+= smp-sh73a0.o
 
 # Pinmux setup
diff --git a/arch/arm/mach-shmobile/localtimer.c b/arch/arm/mach-shmobile/localtimer.c
deleted file mode 100644
index 8a67b1c..0000000
--- a/arch/arm/mach-shmobile/localtimer.c
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * SMP support for R-Mobile / SH-Mobile - local timer portion
- *
- * Copyright (C) 2010  Magnus Damm
- *
- * Based on vexpress, Copyright (C) 2002 ARM Ltd, All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-#include <asm/hardware/gic.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = gic_ppi_to_vppi(29);
-	twd_timer_setup(evt);
-	return 0;
-}
diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index f3888fe..5ac3b71 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -17,7 +17,6 @@
 #include <linux/smp.h>
 #include <linux/io.h>
 #include <asm/hardware/gic.h>
-#include <asm/localtimer.h>
 #include <asm/mach-types.h>
 #include <mach/common.h>
 
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index e46821c..8d26607 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -630,6 +630,26 @@ static struct platform_device dma0_device = {
 	},
 };
 
+static struct resource twd_resources[] = {
+	{
+		.start	= 0xf0000600,
+		.end	= 0xf0000600 + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= 29,
+		.end	= 29,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device twd_device = {
+	.name		= "arm_smp_twd",
+	.id		= -1,
+	.resource	= twd_resources,
+	.num_resources	= ARRAY_SIZE(twd_resources),
+};
+
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -643,6 +663,7 @@ static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&cmt10_device,
 	&tmu00_device,
 	&tmu01_device,
+	&twd_device,
 };
 
 static struct platform_device *sh73a0_late_devices[] __initdata = {
diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 3ffdbc9..d52c771 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -24,7 +24,6 @@
 #include <linux/io.h>
 #include <mach/common.h>
 #include <asm/smp_scu.h>
-#include <asm/smp_twd.h>
 #include <asm/hardware/gic.h>
 
 #define WUPCR		0xe6151010
@@ -59,11 +58,6 @@ unsigned int __init sh73a0_get_core_count(void)
 {
 	void __iomem *scu_base = scu_base_addr();
 
-#ifdef CONFIG_HAVE_ARM_TWD
-	/* twd_base needs to be initialized before percpu_timer_setup() */
-	twd_base = (void __iomem *)0xf0000600;
-#endif
-
 	return scu_get_core_count(scu_base);
 }
 
-- 
1.7.0.4
