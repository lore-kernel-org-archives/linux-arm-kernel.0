From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 11:46:44 +0100
Subject: [RFC PATCH 02/12] ARM: local timers: switch realview to standalone
	smp_twd
In-Reply-To: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
References: <1312886814-15627-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312886814-15627-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the SMP RealView platforms to the standalone version
of smp_twd.c. Since the timer calibration code requires another
timer to be up and running, the actual initialisation is left
to the late_timer_init hook.

Tested on EB-11MP.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-realview/Kconfig           |    3 ++
 arch/arm/mach-realview/realview_eb.c     |   33 ++++++++++++++++++++++++++---
 arch/arm/mach-realview/realview_pb11mp.c |   31 ++++++++++++++++++++++++---
 arch/arm/mach-realview/realview_pbx.c    |   30 ++++++++++++++++++++++++--
 4 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index dba6d0c..135a7ea 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -4,6 +4,7 @@ menu "RealView platform type"
 config MACH_REALVIEW_EB
 	bool "Support RealView(R) Emulation Baseboard"
 	select ARM_GIC
+	select ARM_SMP_TWD if SMP
 	help
 	  Include support for the ARM(R) RealView(R) Emulation Baseboard
 	  platform.
@@ -40,6 +41,7 @@ config MACH_REALVIEW_PB11MP
 	select ARM_GIC
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
+	select ARM_SMP_TWD if SMP
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard for
 	  the ARM11MPCore.  This platform has an on-board ARM11MPCore and has
@@ -80,6 +82,7 @@ config MACH_REALVIEW_PBX
 	select HAVE_PATA_PLATFORM
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
+	select ARM_SMP_TWD if SMP
 	help
 	  Include support for the ARM(R) RealView(R) Platform Baseboard
 	  Explore.
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index 7a4e3b1..420cc1c 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -36,7 +36,7 @@
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -391,6 +391,33 @@ static void realview_eb11mp_fixup(void)
 	realview_eb_isp1761_resources[1].end	= IRQ_EB11MP_USB;
 }
 
+#ifdef CONFIG_ARM_SMP_TWD
+static struct resource twd_resources[] __initdata = {
+	{
+		.start	= REALVIEW_EB11MP_TWD_BASE,
+		.end	= REALVIEW_EB11MP_TWD_BASE + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= IRQ_LOCALTIMER,
+		.end	= IRQ_LOCALTIMER,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static void __init realview_eb_twd_init(void)
+{
+	if (core_tile_eb11mp() || core_tile_a9mp()) {
+		int err = twd_timer_register(twd_resources,
+					     ARRAY_SIZE(twd_resources));
+		if (err)
+			pr_err("twd_timer_register failed %d\n", err);
+	}
+}
+#else
+#define realview_eb_twd_init	NULL
+#endif
+
 static void __init realview_eb_timer_init(void)
 {
 	unsigned int timer_irq;
@@ -401,9 +428,7 @@ static void __init realview_eb_timer_init(void)
 	timer3_va_base = __io_address(REALVIEW_EB_TIMER2_3_BASE) + 0x20;
 
 	if (core_tile_eb11mp() || core_tile_a9mp()) {
-#ifdef CONFIG_LOCAL_TIMERS
-		twd_base = __io_address(REALVIEW_EB11MP_TWD_BASE);
-#endif
+		late_time_init = realview_eb_twd_init;
 		timer_irq = IRQ_EB11MP_TIMER0_1;
 	} else
 		timer_irq = IRQ_EB_TIMER0_1;
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index b43644b..8185022 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -36,7 +36,7 @@
 #include <asm/pgtable.h>
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <asm/localtimer.h>
+#include <asm/smp_twd.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
@@ -298,6 +298,31 @@ static void __init gic_init_irq(void)
 	gic_cascade_irq(1, IRQ_TC11MP_PB_IRQ1);
 }
 
+#ifdef CONFIG_ARM_SMP_TWD
+static struct resource realview_pb11mp_twd_resources[] __initdata = {
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
+static void __init realview_pb11mp_twd_init(void)
+{
+	int err = twd_timer_register(realview_pb11mp_twd_resources,
+				     ARRAY_SIZE(realview_pb11mp_twd_resources));
+	if (err)
+		pr_err("twd_timer_register failed %d\n", err);
+}
+#else
+#define realview_pb11mp_twd_init	NULL
+#endif
+
 static void __init realview_pb11mp_timer_init(void)
 {
 	timer0_va_base = __io_address(REALVIEW_PB11MP_TIMER0_1_BASE);
@@ -305,10 +330,8 @@ static void __init realview_pb11mp_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PB11MP_TIMER2_3_BASE) + 0x20;
 
-#ifdef CONFIG_LOCAL_TIMERS
-	twd_base = __io_address(REALVIEW_TC11MP_TWD_BASE);
-#endif
 	realview_timer_init(IRQ_TC11MP_TIMER0_1);
+	late_time_init = realview_pb11mp_twd_init;
 }
 
 static struct sys_timer realview_pb11mp_timer = {
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 363b0ab..bbe4534 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -301,6 +301,31 @@ static void __init gic_init_irq(void)
 	}
 }
 
+#ifdef CONFIG_ARM_SMP_TWD
+static struct resource realview_pbx_twd_resources[] __initdata = {
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
+static void __init realview_pbx_twd_init(void)
+{
+	int err = twd_timer_register(realview_pbx_twd_resources,
+				     ARRAY_SIZE(realview_pbx_twd_resources));
+	if (err)
+		pr_err("twd_timer_register failed %d\n", err);
+}
+#else
+#define realview_pbx_twd_init	NULL
+#endif
+
 static void __init realview_pbx_timer_init(void)
 {
 	timer0_va_base = __io_address(REALVIEW_PBX_TIMER0_1_BASE);
@@ -308,10 +333,9 @@ static void __init realview_pbx_timer_init(void)
 	timer2_va_base = __io_address(REALVIEW_PBX_TIMER2_3_BASE);
 	timer3_va_base = __io_address(REALVIEW_PBX_TIMER2_3_BASE) + 0x20;
 
-#ifdef CONFIG_LOCAL_TIMERS
 	if (core_tile_pbx11mp() || core_tile_pbxa9mp())
-		twd_base = __io_address(REALVIEW_PBX_TILE_TWD_BASE);
-#endif
+		late_time_init = realview_pbx_twd_init;
+
 	realview_timer_init(IRQ_PBX_TIMER0_1);
 }
 
-- 
1.7.0.4
