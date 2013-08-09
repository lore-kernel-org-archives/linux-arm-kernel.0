From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:49:36 +0900
Subject: [PATCH 10/14] ARM: shmobile: Rename to emev2_init_early(),
 use smp_set_ops()
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094936.6530.31840.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Rename emev2_init_delay() into emev2_init_early()
to make the function name show that more than just
delay setup will happen.

Also, instead of specifying the smp ops in DT_MACHINE
convert the EMEV2 SoC code to install the smp ops
from emev2_init_early().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9d-reference.c |    3 +--
 arch/arm/mach-shmobile/board-kzm9d.c           |    3 +--
 arch/arm/mach-shmobile/include/mach/emev2.h    |    2 +-
 arch/arm/mach-shmobile/setup-emev2.c           |    8 +++++---
 4 files changed, 8 insertions(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-kzm9d-reference.c
+++ work/arch/arm/mach-shmobile/board-kzm9d-reference.c	2013-08-08 16:18:34.000000000 +0900
@@ -38,9 +38,8 @@ static const char *kzm9d_boards_compat_d
 };
 
 DT_MACHINE_START(KZM9D_DT, "kzm9d")
-	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
-	.init_early	= emev2_init_delay,
+	.init_early	= emev2_init_early,
 	.init_machine	= kzm9d_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= kzm9d_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/board-kzm9d.c
+++ work/arch/arm/mach-shmobile/board-kzm9d.c	2013-08-08 16:18:17.000000000 +0900
@@ -83,9 +83,8 @@ static const char *kzm9d_boards_compat_d
 };
 
 DT_MACHINE_START(KZM9D_DT, "kzm9d")
-	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
-	.init_early	= emev2_init_delay,
+	.init_early	= emev2_init_early,
 	.init_machine	= kzm9d_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= kzm9d_boards_compat_dt,
--- 0001/arch/arm/mach-shmobile/include/mach/emev2.h
+++ work/arch/arm/mach-shmobile/include/mach/emev2.h	2013-08-08 16:17:57.000000000 +0900
@@ -2,7 +2,7 @@
 #define __ASM_EMEV2_H__
 
 extern void emev2_map_io(void);
-extern void emev2_init_delay(void);
+extern void emev2_init_early(void);
 extern void emev2_add_standard_devices(void);
 extern void emev2_clock_init(void);
 
--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-08-08 16:17:47.000000000 +0900
@@ -190,9 +190,12 @@ void __init emev2_add_standard_devices(v
 	emev2_register_pmu();
 }
 
-void __init emev2_init_delay(void)
+void __init emev2_init_early(void)
 {
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
+#ifdef CONFIG_SMP
+	smp_set_ops(&emev2_smp_ops);
+#endif
 }
 
 #ifdef CONFIG_USE_OF
@@ -203,9 +206,8 @@ static const char *emev2_boards_compat_d
 };
 
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
-	.smp		= smp_ops(emev2_smp_ops),
 	.map_io		= emev2_map_io,
-	.init_early	= emev2_init_delay,
+	.init_early	= emev2_init_early,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
 
