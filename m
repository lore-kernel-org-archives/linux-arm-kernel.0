From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:49:26 +0900
Subject: [PATCH 09/14] ARM: shmobile: Rename to sh7372_init_early()
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094926.6530.46771.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename sh7372_add_early_device_dt() into sh7372_init_early()
and make it static since we have no sh7372 DT reference board
code. Also, in case of DT we do not use any early console or
early timers, so get rid of early platform stuff and early
console for the DT case.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/sh7372.h |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c        |   10 ++--------
 2 files changed, 2 insertions(+), 9 deletions(-)

--- 0007/arch/arm/mach-shmobile/include/mach/sh7372.h
+++ work/arch/arm/mach-shmobile/include/mach/sh7372.h	2013-08-08 15:46:38.000000000 +0900
@@ -63,7 +63,6 @@ extern void sh7372_map_io(void);
 extern void sh7372_earlytimer_init(void);
 extern void sh7372_add_early_devices(void);
 extern void sh7372_add_standard_devices(void);
-extern void sh7372_add_early_devices_dt(void);
 extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
 extern void sh7372_pm_init(void);
--- 0007/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2013-08-08 15:48:51.000000000 +0900
@@ -1135,15 +1135,9 @@ void __init sh7372_add_early_devices(voi
 
 #ifdef CONFIG_USE_OF
 
-void __init sh7372_add_early_devices_dt(void)
+static void __init sh7372_init_early(void)
 {
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
-
-	early_platform_add_devices(sh7372_early_devices,
-				   ARRAY_SIZE(sh7372_early_devices));
-
-	/* setup early console here as well */
-	shmobile_setup_console();
 }
 
 static const char *sh7372_boards_compat_dt[] __initdata = {
@@ -1153,7 +1147,7 @@ static const char *sh7372_boards_compat_
 
 DT_MACHINE_START(SH7372_DT, "Generic SH7372 (Flattened Device Tree)")
 	.map_io		= sh7372_map_io,
-	.init_early	= sh7372_add_early_devices_dt,
+	.init_early	= sh7372_init_early,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= sh7372_init_irq,
 	.handle_irq	= shmobile_handle_irq_intc,
