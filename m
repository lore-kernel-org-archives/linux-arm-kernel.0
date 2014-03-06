From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 06 Mar 2014 12:28:33 +0900
Subject: [PATCH 02/02] ARM: shmobile: Use shmobile_init_delay() on
 r8a7791/Koelsch
In-Reply-To: <20140306032814.10814.2949.sendpatchset@w520>
References: <20140306032814.10814.2949.sendpatchset@w520>
Message-ID: <20140306032833.10814.12191.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Prototype to convert Koelsch and r8a7791 to using
shmobile_init_delay() and by that allow removing
CPU frequency information from the C code.

Needs to be reworked to fit ARM SoC board/SoC branch style.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch-reference.c |    2 +-
 arch/arm/mach-shmobile/board-koelsch.c           |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7791.h    |    1 -
 arch/arm/mach-shmobile/setup-r8a7791.c           |    9 +--------
 4 files changed, 3 insertions(+), 11 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-03-06 12:08:22.000000000 +0900
@@ -139,7 +139,7 @@ static const char * const koelsch_boards
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_add_standard_devices,
 	.init_late	= shmobile_init_late,
--- 0001/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2014-03-06 12:08:22.000000000 +0900
@@ -522,7 +522,7 @@ static const char * const koelsch_boards
 
 DT_MACHINE_START(KOELSCH_DT, "koelsch")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.init_machine	= koelsch_init,
 	.init_late	= shmobile_init_late,
--- 0001/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ work/arch/arm/mach-shmobile/include/mach/r8a7791.h	2014-03-06 12:08:22.000000000 +0900
@@ -5,7 +5,6 @@ void r8a7791_add_standard_devices(void);
 void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
 void r8a7791_pinmux_init(void);
-void r8a7791_init_early(void);
 extern struct smp_operations r8a7791_smp_ops;
 
 #endif /* __ASM_R8A7791_H__ */
--- 0003/arch/arm/mach-shmobile/setup-r8a7791.c
+++ work/arch/arm/mach-shmobile/setup-r8a7791.c	2014-03-06 12:08:22.000000000 +0900
@@ -210,13 +210,6 @@ void __init r8a7791_add_standard_devices
 	r8a7791_register_thermal();
 }
 
-void __init r8a7791_init_early(void)
-{
-#ifndef CONFIG_ARM_ARCH_TIMER
-	shmobile_setup_delay(1500, 2, 4); /* Cortex-A15 @ 1500MHz */
-#endif
-}
-
 #ifdef CONFIG_USE_OF
 static const char *r8a7791_boards_compat_dt[] __initdata = {
 	"renesas,r8a7791",
@@ -225,7 +218,7 @@ static const char *r8a7791_boards_compat
 
 DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7791_smp_ops),
-	.init_early	= r8a7791_init_early,
+	.init_early	= shmobile_init_delay,
 	.init_time	= rcar_gen2_timer_init,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
