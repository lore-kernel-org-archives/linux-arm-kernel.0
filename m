From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:34 +0100
Subject: [RFC PATCH 06/16] ARM: local timers: move Tegra to
	LOCAL_TIMER_DEVICES/ARM_SMP_TWD
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Tegra platforms to use the new arm_smp_twd driver.
Add the platform device and register it as early platform device.

Tested on a Harmony board.

Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/Kconfig      |    2 ++
 arch/arm/mach-tegra/Makefile     |    2 +-
 arch/arm/mach-tegra/localtimer.c |   27 ---------------------------
 arch/arm/mach-tegra/timer.c      |   32 +++++++++++++++++++++++++++-----
 4 files changed, 30 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/localtimer.c

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 5ec1846..4b05f02 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -9,6 +9,8 @@ config ARCH_TEGRA_2x_SOC
 	bool "Tegra 2 family"
 	select CPU_V7
 	select ARM_GIC
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD
 	select ARCH_REQUIRE_GPIOLIB
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
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
index 97cd0a9..0000000
--- a/arch/arm/mach-tegra/localtimer.c
+++ /dev/null
@@ -1,27 +0,0 @@
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
diff --git a/arch/arm/mach-tegra/timer.c b/arch/arm/mach-tegra/timer.c
index 9035042..4e1ecd0 100644
--- a/arch/arm/mach-tegra/timer.c
+++ b/arch/arm/mach-tegra/timer.c
@@ -27,9 +27,9 @@
 #include <linux/clocksource.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach/time.h>
-#include <asm/localtimer.h>
 #include <asm/sched_clock.h>
 
 #include <mach/iomap.h>
@@ -179,6 +179,30 @@ static struct irqaction tegra_timer_irq = {
 	.irq		= INT_TMR3,
 };
 
+static struct resource tegra_twd_resources[] = {
+	{
+		.start	= TEGRA_ARM_PERIF_BASE + 0x600,
+		.end	= TEGRA_ARM_PERIF_BASE + 0x600 + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tegra_twd_device = {
+	.name		= "arm_smp_twd",
+	.id		= -1,
+	.resource	= tegra_twd_resources,
+	.num_resources	= ARRAY_SIZE(tegra_twd_resources),
+};
+
+static struct platform_device *tegra_early_devices[] = {
+	&tegra_twd_device,
+};
+
 static void __init tegra_init_timer(void)
 {
 	struct clk *clk;
@@ -197,10 +221,6 @@ static void __init tegra_init_timer(void)
 	BUG_ON(IS_ERR(clk));
 	clk_enable(clk);
 
-#ifdef CONFIG_HAVE_ARM_TWD
-	twd_base = IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x600);
-#endif
-
 	switch (rate) {
 	case 12000000:
 		timer_writel(0x000b, TIMERUS_USEC_CFG);
@@ -241,6 +261,8 @@ static void __init tegra_init_timer(void)
 	tegra_clockevent.cpumask = cpu_all_mask;
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_register_device(&tegra_clockevent);
+	early_platform_add_devices(tegra_early_devices,
+				   ARRAY_SIZE(tegra_early_devices));
 }
 
 struct sys_timer tegra_timer = {
-- 
1.7.0.4
