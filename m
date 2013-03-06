From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Mar 2013 09:22:33 +0900
Subject: [PATCH 02/04] ARM: shmobile: Add EMEV2 specific timer_init
In-Reply-To: <20130306002214.5430.43766.sendpatchset@w520>
References: <20130306002214.5430.43766.sendpatchset@w520>
Message-ID: <20130306002233.5430.86.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add a emev2_timer_init() function to the EMEV2 setup
code. This is preparation work for EMEV2 TWD support.

To allow registration of the TWD driver from
the ->timer_init() callback the init code for EMEV2
clocks is from ->init_machine() to ->init_time().

This affects EMEV2 clock init order on the KZM9D board
but leaves the generic EMEV2 DT case as-is due to
no setup code for clocks in the DT case.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kzm9d.c        |    2 +-
 arch/arm/mach-shmobile/include/mach/emev2.h |    1 +
 arch/arm/mach-shmobile/setup-emev2.c        |    8 ++++++--
 3 files changed, 8 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-kzm9d.c
+++ work/arch/arm/mach-shmobile/board-kzm9d.c	2013-03-05 18:31:45.000000000 +0900
@@ -90,6 +90,6 @@ DT_MACHINE_START(KZM9D_DT, "kzm9d")
 	.init_irq	= emev2_init_irq,
 	.init_machine	= kzm9d_add_standard_devices,
 	.init_late	= shmobile_init_late,
-	.init_time	= shmobile_timer_init,
+	.init_time	= emev2_timer_init,
 	.dt_compat	= kzm9d_boards_compat_dt,
 MACHINE_END
--- 0001/arch/arm/mach-shmobile/include/mach/emev2.h
+++ work/arch/arm/mach-shmobile/include/mach/emev2.h	2013-03-05 18:31:45.000000000 +0900
@@ -5,6 +5,7 @@ extern void emev2_map_io(void);
 extern void emev2_init_irq(void);
 extern void emev2_add_early_devices(void);
 extern void emev2_add_standard_devices(void);
+extern void emev2_timer_init(void);
 extern void emev2_clock_init(void);
 extern void emev2_set_boot_vector(unsigned long value);
 
--- 0004/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-03-05 18:34:09.000000000 +0900
@@ -395,8 +395,6 @@ static struct platform_device *emev2_lat
 
 void __init emev2_add_standard_devices(void)
 {
-	emev2_clock_init();
-
 	platform_add_devices(emev2_early_devices,
 			     ARRAY_SIZE(emev2_early_devices));
 
@@ -404,6 +402,12 @@ void __init emev2_add_standard_devices(v
 			     ARRAY_SIZE(emev2_late_devices));
 }
 
+void __init emev2_timer_init(void)
+{
+	emev2_clock_init();
+	shmobile_timer_init();
+}
+
 static void __init emev2_init_delay(void)
 {
 	shmobile_setup_delay(533, 1, 3); /* Cortex-A9 @ 533MHz */
