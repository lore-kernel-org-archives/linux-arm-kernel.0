From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Jun 2011 20:06:31 +0100
Subject: [RFC PATCH 03/16] ARM: local timers: move realview to
	LOCAL_TIMER_DEVICES/ARM_SMP_TWD
In-Reply-To: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
References: <1308251204-16719-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1308251204-16719-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the RealView platforms to use the new arm_smp_twd driver.
Add the platform devices and register them as early platform devices.

Tested on a PB11MP.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/Kconfig           |    8 +++++++
 arch/arm/mach-realview/realview_eb.c     |   31 ++++++++++++++++++++++++++---
 arch/arm/mach-realview/realview_pb11mp.c |   30 +++++++++++++++++++++++++---
 arch/arm/mach-realview/realview_pbx.c    |   31 +++++++++++++++++++++++++----
 4 files changed, 87 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index b9a9805..7eec270 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -12,6 +12,8 @@ config REALVIEW_EB_A9MP
 	bool "Support Multicore Cortex-A9 Tile"
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD
 	help
 	  Enable support for the Cortex-A9MPCore tile fitted to the
 	  Realview(R) Emulation Baseboard platform.
@@ -21,6 +23,8 @@ config REALVIEW_EB_ARM11MP
 	depends on MACH_REALVIEW_EB
 	select CPU_V6K
 	select ARCH_HAS_BARRIERS if SMP
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD
 	help
 	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
 	  Emulation Baseboard platform.
@@ -40,6 +44,8 @@ config MACH_REALVIEW_PB11MP
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
 	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
@@ -79,6 +85,8 @@ config MACH_REALVIEW_PBX
 	select HAVE_PATA_PLATFORM
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
+	select LOCAL_TIMER_DEVICES
+	select ARM_SMP_TWD
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard
 	  Explore.
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 10e75fa..fbc941c 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -36,7 +36,6 @@
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/localtimer.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -330,6 +329,31 @@ static struct platform_device char_lcd_device = {
 	.resource	=	char_lcd_resources,
 };
 
+static struct resource eb_twd_resources[] = {
+	{
+		.start	= REALVIEW_EB11MP_TWD_BASE,
+		.end	= REALVIEW_EB11MP_TWD_BASE + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device eb_twd_device = {
+	.name		= "arm_smp_twd",
+	.id		= -1,
+	.resource	= eb_twd_resources,
+	.num_resources	= ARRAY_SIZE(eb_twd_resources),
+};
+
+static struct platform_device *eb_early_devices[] = {
+	&eb_twd_device,
+};
+
+
 static void __init gic_init_irq(void)
 {
 	if (core_tile_eb11mp() || core_tile_a9mp()) {
@@ -401,14 +425,13 @@ static void __init realview_eb_timer_init(void)
 	timer3_va_base = __io_address(REALVIEW_EB_TIMER2_3_BASE) + 0x20;
 
 	if (core_tile_eb11mp() || core_tile_a9mp()) {
-#ifdef CONFIG_LOCAL_TIMERS
-		twd_base = __io_address(REALVIEW_EB11MP_TWD_BASE);
-#endif
 		timer_irq = IRQ_EB11MP_TIMER0_1;
 	} else
 		timer_irq = IRQ_EB_TIMER0_1;
 
 	realview_timer_init(timer_irq);
+	early_platform_add_devices(eb_early_devices,
+				   ARRAY_SIZE(eb_early_devices));
 }
 
 static struct sys_timer realview_eb_timer = {
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index b2985fc..9ed17c1 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -36,7 +36,6 @@
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/localtimer.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
@@ -276,6 +275,30 @@ static struct platform_device pmu_device = {
 	.resource		= pmu_resources,
 };
 
+static struct resource realview_pb11mp_twd_resources[] = {
+	{
+		.start	= REALVIEW_TC11MP_TWD_BASE,
+		.end	= REALVIEW_TC11MP_TWD_BASE + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device realview_pb11mp_twd_device = {
+	.name		= "arm_smp_twd",
+	.id		= -1,
+	.resource	= realview_pb11mp_twd_resources,
+	.num_resources	= ARRAY_SIZE(realview_pb11mp_twd_resources),
+};
+
+static struct platform_device *realview_pb11mp_early_devices[] = {
+	&realview_pb11mp_twd_device,
+};
+
 static void __init gic_init_irq(void)
 {
 	unsigned int pldctrl;
@@ -305,10 +328,9 @@ static void __init realview_pb11mp_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE) + 0x20;
 
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = __io_address(REALVIEW_TC11MP_TWD_BASE);
-#endif
 	realview_timer_init(IRQ_TC11MP_TIMER0_1);
+	early_platform_add_devices(realview_pb11mp_early_devices,
+				   ARRAY_SIZE(realview_pb11mp_early_devices));
 }
 
 static struct sys_timer realview_pb11mp_timer = {
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 92ace2c..768faec 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -31,7 +31,6 @@
 #include <asm/leds.h>
 #include <asm/mach-types.h>
 #include <asm/pmu.h>
-#include <asm/smp_twd.h>
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -288,6 +287,30 @@ static struct platform_device pmu_device = {
 	.resource		= pmu_resources,
 };
 
+static struct resource realview_pbx_twd_resources[] = {
+	{
+		.start	= REALVIEW_PBX_TILE_TWD_BASE,
+		.end	= REALVIEW_PBX_TILE_TWD_BASE + 0x10,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device realview_pbx_twd_device = {
+	.name		= "arm_smp_twd",
+	.id		= -1,
+	.resource	= realview_pbx_twd_resources,
+	.num_resources	= ARRAY_SIZE(realview_pbx_twd_resources),
+};
+
+static struct platform_device *realview_pbx_early_devices[] = {
+	&realview_pbx_twd_device,
+};
+
 static void __init gic_init_irq(void)
 {
 	/* ARM PBX on-board GIC */
@@ -308,11 +331,9 @@ static void __init realview_pbx_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PBX_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PBX_TIMER2_3_BASE) + 0x20;
 
-#ifdef CONFIG_LOCAL_TIMERS
-	if (core_tile_pbx11mp() || core_tile_pbxa9mp())
-		twd_base = __io_address(REALVIEW_PBX_TILE_TWD_BASE);
-#endif
 	realview_timer_init(IRQ_PBX_TIMER0_1);
+	early_platform_add_devices(realview_pbx_early_devices,
+				   ARRAY_SIZE(realview_pbx_early_devices));
 }
 
 static struct sys_timer realview_pbx_timer = {
-- 
1.7.0.4
