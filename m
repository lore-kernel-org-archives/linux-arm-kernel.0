From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:50:21 +0900
Subject: [PATCH 14/14] ARM: shmobile: Rename to sh73a0_init_early(),
 use smp_set_ops()
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809095021.6530.8841.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename sh73a0_init_delay() into sh73a0_init_early()
to make the function name show that more than just
delay setup will happen.

Also, instead of specifying the smp ops in DT_MACHINE
convert the sh73a0 SoC code to install the smp ops
from sh73a0_init_early().

The sh73a0_add_early_devices() function also gets
updated to call sh73a0_init_early(). This way the
smp ops will be installed in both DT and C cases.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9g-reference.c |    3 +--
 arch/arm/mach-shmobile/board-kzm9g.c           |    1 -
 arch/arm/mach-shmobile/include/mach/sh73a0.h   |    2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c          |   11 +++++++----
 4 files changed, 9 insertions(+), 8 deletions(-)

--- 0011/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9g-reference.c	2013-08-09 17:44:10.000000000 +0900
@@ -54,9 +54,8 @@ static const char *kzm9g_boards_compat_d
 };
 
 DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
-	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-	.init_early	= sh73a0_init_delay,
+	.init_early	= sh73a0_init_early,
 	.init_machine	= kzm_init,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/board-kzm9g.c
+++ work/arch/arm/mach-shmobile/board-kzm9g.c	2013-08-09 17:44:01.000000000 +0900
@@ -904,7 +904,6 @@ static const char *kzm9g_boards_compat_d
 };
 
 DT_MACHINE_START(KZM9G_DT, "kzm9g")
-	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices,
 	.nr_irqs	= NR_IRQS_LEGACY,
--- 0010/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ work/arch/arm/mach-shmobile/include/mach/sh73a0.h	2013-08-09 17:42:03.000000000 +0900
@@ -71,7 +71,7 @@ enum {
 #define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
 #define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
 
-extern void sh73a0_init_delay(void);
+extern void sh73a0_init_early(void);
 extern void sh73a0_init_irq(void);
 extern void sh73a0_map_io(void);
 extern void sh73a0_earlytimer_init(void);
--- 0011/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-08-09 17:43:43.000000000 +0900
@@ -919,9 +919,12 @@ void __init sh73a0_add_standard_devices(
 			    ARRAY_SIZE(sh73a0_late_devices));
 }
 
-void __init sh73a0_init_delay(void)
+void __init sh73a0_init_early(void)
 {
 	shmobile_setup_delay(1196, 44, 46); /* Cortex-A9 @ 1196MHz */
+#ifdef CONFIG_SMP
+	smp_set_ops(&sh73a0_smp_ops);
+#endif
 }
 
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
@@ -929,7 +932,6 @@ void __init __weak sh73a0_register_twd(v
 
 void __init sh73a0_earlytimer_init(void)
 {
-	sh73a0_init_delay();
 	sh73a0_clock_init();
 	shmobile_earlytimer_init();
 	sh73a0_register_twd();
@@ -937,6 +939,8 @@ void __init sh73a0_earlytimer_init(void)
 
 void __init sh73a0_add_early_devices(void)
 {
+	sh73a0_init_early();
+
 	early_platform_add_devices(sh73a0_devices_dt,
 				   ARRAY_SIZE(sh73a0_devices_dt));
 	early_platform_add_devices(sh73a0_early_devices,
@@ -954,9 +958,8 @@ static const char *sh73a0_boards_compat_
 };
 
 DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
-	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
-	.init_early	= sh73a0_init_delay,
+	.init_early	= sh73a0_init_early,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
