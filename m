From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:49:58 +0900
Subject: [PATCH 12/14] ARM: shmobile: Rename to r8a7740_init_early()
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094958.6530.41120.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename r8a7740_init_delay() into r8a7740_init_early()
to make the function name show that more than just
delay setup may happen in the future.

Also, make sure shmobile_setup_delay() gets executed for both
DT and C board code by updating r8a7740_add_early_devices() to
call r8a7740_init_early().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-armadillo800eva-reference.c |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h            |    2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c                   |   14 ++++++++------
 3 files changed, 10 insertions(+), 8 deletions(-)

--- 0005/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ work/arch/arm/mach-shmobile/board-armadillo800eva-reference.c	2013-08-08 16:37:19.000000000 +0900
@@ -189,7 +189,7 @@ static const char *eva_boards_compat_dt[
 
 DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva-reference")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_init_delay,
+	.init_early	= r8a7740_init_early,
 	.init_irq	= r8a7740_init_irq_of,
 	.init_machine	= eva_init,
 	.init_late	= shmobile_init_late,
--- 0005/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7740.h	2013-08-08 16:37:19.000000000 +0900
@@ -47,7 +47,7 @@ enum {
 };
 
 extern void r8a7740_meram_workaround(void);
-extern void r8a7740_init_delay(void);
+extern void r8a7740_init_early(void);
 extern void r8a7740_init_irq_of(void);
 extern void r8a7740_map_io(void);
 extern void r8a7740_add_early_devices(void);
--- 0006/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2013-08-08 16:37:19.000000000 +0900
@@ -984,8 +984,15 @@ void __init r8a7740_add_standard_devices
 	rmobile_add_device_to_domain("A3SP",	&i2c1_device);
 }
 
+void __init r8a7740_init_early(void)
+{
+	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
+};
+
 void __init r8a7740_add_early_devices(void)
 {
+	r8a7740_init_early();
+
 	early_platform_add_devices(r8a7740_early_devices,
 				   ARRAY_SIZE(r8a7740_early_devices));
 	early_platform_add_devices(r8a7740_devices_dt,
@@ -1003,11 +1010,6 @@ void __init r8a7740_add_dt_devices(void)
 
 #ifdef CONFIG_USE_OF
 
-void __init r8a7740_init_delay(void)
-{
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
-};
-
 void __init r8a7740_init_irq_of(void)
 {
 	void __iomem *intc_prio_base = ioremap_nocache(0xe6900010, 0x10);
@@ -1045,7 +1047,7 @@ static const char *r8a7740_boards_compat
 
 DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
-	.init_early	= r8a7740_init_delay,
+	.init_early	= r8a7740_init_early,
 	.init_irq	= r8a7740_init_irq_of,
 	.dt_compat	= r8a7740_boards_compat_dt,
 MACHINE_END
