From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:30 +0100
Subject: [PATCH v1 15/18] ARM: tegra: dynamically register local timer setup
	function
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-16-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/Makefile     |    2 +-
 arch/arm/mach-tegra/localtimer.c |   25 -------------------------
 arch/arm/mach-tegra/timer.c      |   12 ++++++++++++
 3 files changed, 13 insertions(+), 26 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/localtimer.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 823c703..efbddfc 100644
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
index 590f1cc..0000000
--- a/arch/arm/mach-tegra/localtimer.c
+++ /dev/null
@@ -1,25 +0,0 @@
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
-#include <asm/hardware/gic.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
-	return 0;
-}
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 9035042..da30fdd 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -30,7 +30,9 @@
 
 #include <asm/mach/time.h>
 #include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
+#include <asm/hardware/gic.h>
 
 #include <mach/iomap.h>
 #include <mach/irqs.h>
@@ -179,6 +181,14 @@ static struct irqaction tegra_timer_irq = {
 	.irq		= INT_TMR3,
 };
 
+#ifdef CONFIG_HAVE_ARM_TWD
+static int __cpuinit tegra_local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = gic_ppi_to_vppi(IRQ_LOCALTIMER);
+	return 0;
+}
+#endif
+
 static void __init tegra_init_timer(void)
 {
 	struct clk *clk;
@@ -199,6 +209,8 @@ static void __init tegra_init_timer(void)
 
 #ifdef CONFIG_HAVE_ARM_TWD
 	twd_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x600);
+
+	twd_timer_register_setup(tegra_local_timer_setup);
 #endif
 
 	switch (rate) {
-- 
1.7.0.4
