From: linux@arm.linux.org.uk (Russell King)
Date: Thu, 04 Mar 2010 19:11:56 +0000
Subject: [PATCH] ARM: Integrator: pass 'khz' to integrator_time_init
References: <git-1267729916-d89d90e05d3d7392921e61fd9a65a20f3dc6a180@rmk-PC>
Message-ID: <git-1267729916-e504d2d965ff812d89c7c484276e35e001195fae@rmk-PC>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This is now what the clocksource/clockevent initialization functions
want, so give them the timer tick rate directly.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-integrator/common.h        |    2 +-
 arch/arm/mach-integrator/core.c          |    6 +++---
 arch/arm/mach-integrator/integrator_ap.c |    2 +-
 arch/arm/mach-integrator/integrator_cp.c |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-integrator/common.h b/arch/arm/mach-integrator/common.h
index 7dc24bb..cdbe710 100644
--- a/arch/arm/mach-integrator/common.h
+++ b/arch/arm/mach-integrator/common.h
@@ -1 +1 @@
-extern void integrator_time_init(unsigned long, unsigned int);
+extern void integrator_time_init(u32, unsigned int);
diff --git a/arch/arm/mach-integrator/core.c b/arch/arm/mach-integrator/core.c
index b1ccbe3..d02f0e3 100644
--- a/arch/arm/mach-integrator/core.c
+++ b/arch/arm/mach-integrator/core.c
@@ -363,12 +363,12 @@ static void integrator_clockevent_init(u32 khz, unsigned int ctrl)
 /*
  * Set up timer(s).
  */
-void __init integrator_time_init(unsigned long reload, unsigned int ctrl)
+void __init integrator_time_init(u32 khz, unsigned int ctrl)
 {
 	writel(0, TIMER0_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER1_VA_BASE + TIMER_CTRL);
 	writel(0, TIMER2_VA_BASE + TIMER_CTRL);
 
-	integrator_clocksource_init(reload * HZ / 1000);
-	integrator_clockevent_init(reload * HZ / 1000, ctrl);
+	integrator_clocksource_init(khz);
+	integrator_clockevent_init(khz, ctrl);
 }
diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index cfb718f..93da7d4 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -337,7 +337,7 @@ static void __init ap_init(void)
 
 static void __init ap_init_timer(void)
 {
-	integrator_time_init(1000000 * TICKS_PER_uSEC / HZ, 0);
+	integrator_time_init(TICKS_PER_uSEC * 1000, 0);
 }
 
 static struct sys_timer ap_timer = {
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 3e84732..108bc48 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -572,7 +572,7 @@ static void __init intcp_init(void)
 
 static void __init intcp_timer_init(void)
 {
-	integrator_time_init(1000000 / HZ, TIMER_CTRL_IE);
+	integrator_time_init(1000, TIMER_CTRL_IE);
 }
 
 static struct sys_timer cp_timer = {
