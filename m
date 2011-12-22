From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Dec 2011 17:27:36 +0000
Subject: [PATCH v2 06/15] ARM: local timers: switch tegra to standalone smp_twd
In-Reply-To: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
References: <1324574865-5367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1324574865-5367-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Tegra-2 platforms to the standalone version
of smp_twd.c. Since the timer calibration code requires another
timer to be up and running, the actual initialisation is left
to the late_timer_init hook.

Tested on Harmony.

Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/Kconfig      |    1 +
 arch/arm/mach-tegra/Makefile     |    2 +-
 arch/arm/mach-tegra/localtimer.c |   26 --------------------------
 arch/arm/mach-tegra/timer.c      |   34 +++++++++++++++++++++++++++++-----
 4 files changed, 31 insertions(+), 32 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/localtimer.c

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 373652d..f93aa6aa 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -6,6 +6,7 @@ config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
 	select CPU_V7
 	select ARM_GIC
+	select ARM_SMP_TWD
 	select ARCH_REQUIRE_GPIOLIB
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index e120ff5..f7d0443 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= pinmux-tegra20-tables.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= pinmux-tegra30-tables.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= board-dt-tegra30.o
-obj-$(CONFIG_SMP)                       += platsmp.o localtimer.o headsmp.o
+obj-$(CONFIG_SMP)                       += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_SYSTEM_DMA)		+= dma.o
 obj-$(CONFIG_CPU_FREQ)                  += cpu-tegra.o
diff --git a/arch/arm/mach-tegra/localtimer.c b/arch/arm/mach-tegra/localtimer.c
deleted file mode 100644
index e91d681..0000000
--- a/arch/arm/mach-tegra/localtimer.c
+++ /dev/null
@@ -1,26 +0,0 @@
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
-#include <linux/smp.h>
-#include <linux/clockchips.h>
-#include <asm/irq.h>
-#include <asm/smp_twd.h>
-#include <asm/localtimer.h>
-
-/*
- * Setup the local clock events for a CPU.
- */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	evt->irq = IRQ_LOCALTIMER;
-	twd_timer_setup(evt);
-	return 0;
-}
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 6366654..0c537b9 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -27,9 +27,10 @@
 #include <linux/clocksource.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/ioport.h>
 
 #include <asm/mach/time.h>
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 #include <asm/sched_clock.h>
 
 #include <mach/iomap.h>
@@ -179,6 +180,31 @@ static struct irqaction tegra_timer_irq = {
 	.irq		= INT_TMR3,
 };
 
+#ifdef CONFIG_ARM_SMP_TWD
+static struct resource tegra_twd_resources[] __initdata = {
+	{
+		.start	= TEGRA_ARM_PERIF_BASE + 0x600,
+		.end	= TEGRA_ARM_PERIF_BASE + 0x610,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static void __init tegra_twd_init(void)
+{
+	int err = twd_timer_register(tegra_twd_resources,
+				     ARRAY_SIZE(tegra_twd_resources));
+	if (err)
+		pr_err("twd_timer_register failed %d\n", err);
+}
+#else
+#define tegra_twd_init	NULL
+#endif
+
 static void __init tegra_init_timer(void)
 {
 	struct clk *clk;
@@ -205,10 +231,6 @@ static void __init tegra_init_timer(void)
 	else
 		clk_enable(clk);
 
-#ifdef CONFIG_HAVE_ARM_TWD
-	twd_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x600);
-#endif
-
 	switch (rate) {
 	case 12000000:
 		timer_writel(0x000b, TIMERUS_USEC_CFG);
@@ -249,6 +271,8 @@ static void __init tegra_init_timer(void)
 	tegra_clockevent.cpumask = cpu_all_mask;
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_register_device(&tegra_clockevent);
+
+	late_time_init = tegra_twd_init;
 }
 
 struct sys_timer tegra_timer = {
-- 
1.7.7.1
