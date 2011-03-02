From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  2 Mar 2011 16:53:23 +0000
Subject: [RFC PATCH 17/20] ARM: tegra: dynamically register local timer setup
	function
In-Reply-To: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
References: <1299084806-16546-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1299084806-16546-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/Makefile     |    2 +-
 arch/arm/mach-tegra/localtimer.c |   24 ------------------------
 arch/arm/mach-tegra/timer.c      |   10 ++++++++++
 3 files changed, 11 insertions(+), 25 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/localtimer.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 9bf39fa..b3b387a 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clock.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += tegra2_clocks.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-t2-tables.o
-obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
+obj-$(CONFIG_SMP)                       += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o
 obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
diff --git a/arch/arm/mach-tegra/localtimer.c b/arch/arm/mach-tegra/localtimer.c
deleted file mode 100644
index aaabad8..0000000
--- a/arch/arm/mach-tegra/localtimer.c
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *  arch/arm/mach-tegra/localtimer.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/init.h>
-#include <linux/clockchips.h>
-
-#include <asm/irq.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = IRQ_LOCALTIMER;
-	return 0;
-}
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 0fcb1eb..df7e590 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -30,6 +30,7 @@
 
 #include <asm/mach/time.h>
 #include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
 
 #include <mach/iomap.h>
@@ -192,6 +193,13 @@ static struct irqaction tegra_timer_irq = {
 	.irq		= INT_TMR3,
 };
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static void __cpuinit tegra_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = IRQ_LOCALTIMER;
+}
+#endif
+
 static void __init tegra_init_timer(void)
 {
 	struct clk *clk;
@@ -212,6 +220,8 @@ static void __init tegra_init_timer(void)
 
 #ifdef CONFIG_HAVE_ARM_TWD
 	twd_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x600);
+
+	twd_timer_register_setup(tegra_local_timer_setup);
 #endif
 
 	switch (rate) {
-- 
1.7.0.4
