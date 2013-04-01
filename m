From: robherring2@gmail.com (Rob Herring)
Date: Mon,  1 Apr 2013 17:21:20 -0500
Subject: [PATCH v2 10/13] ARM: versatile: use OF init for sp804 timer
In-Reply-To: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
References: <1364854883-5961-1-git-send-email-robherring2@gmail.com>
Message-ID: <1364854883-5961-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Enable DT based init for the sp804 timers on versatile DT platform.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/boot/dts/versatile-ab.dts     |   12 ++++++++++++
 arch/arm/mach-versatile/core.c         |   26 +++++++++++++-------------
 arch/arm/mach-versatile/versatile_dt.c |    1 -
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index e2fe319..dde75ae 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -121,6 +121,18 @@
 			interrupts = <0>;
 		};
 
+		timer at 101e2000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x101e2000 0x1000>;
+			interrupts = <4>;
+		};
+
+		timer at 101e3000 {
+			compatible = "arm,sp804", "arm,primecell";
+			reg = <0x101e3000 0x1000>;
+			interrupts = <5>;
+		};
+
 		gpio0: gpio at 101e4000 {
 			compatible = "arm,pl061", "arm,primecell";
 			reg = <0x101e4000 0x1000>;
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 25160ae..54bb80b 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -749,12 +749,25 @@ void versatile_restart(char mode, const char *cmd)
 /* Early initializations */
 void __init versatile_init_early(void)
 {
+	u32 val;
 	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
 
 	osc4_clk.vcoreg	= sys + VERSATILE_SYS_OSCCLCD_OFFSET;
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
 	versatile_sched_clock_init(sys + VERSATILE_SYS_24MHz_OFFSET, 24000000);
+
+	/*
+	 * set clock frequency:
+	 *	VERSATILE_REFCLK is 32KHz
+	 *	VERSATILE_TIMCLK is 1MHz
+	 */
+	val = readl(__io_address(VERSATILE_SCTL_BASE));
+	writel((VERSATILE_TIMCLK << VERSATILE_TIMER1_EnSel) |
+	       (VERSATILE_TIMCLK << VERSATILE_TIMER2_EnSel) |
+	       (VERSATILE_TIMCLK << VERSATILE_TIMER3_EnSel) |
+	       (VERSATILE_TIMCLK << VERSATILE_TIMER4_EnSel) | val,
+	       __io_address(VERSATILE_SCTL_BASE));
 }
 
 void __init versatile_init(void)
@@ -785,19 +798,6 @@ void __init versatile_init(void)
  */
 void __init versatile_timer_init(void)
 {
-	u32 val;
-
-	/* 
-	 * set clock frequency: 
-	 *	VERSATILE_REFCLK is 32KHz
-	 *	VERSATILE_TIMCLK is 1MHz
-	 */
-	val = readl(__io_address(VERSATILE_SCTL_BASE));
-	writel((VERSATILE_TIMCLK << VERSATILE_TIMER1_EnSel) |
-	       (VERSATILE_TIMCLK << VERSATILE_TIMER2_EnSel) | 
-	       (VERSATILE_TIMCLK << VERSATILE_TIMER3_EnSel) |
-	       (VERSATILE_TIMCLK << VERSATILE_TIMER4_EnSel) | val,
-	       __io_address(VERSATILE_SCTL_BASE));
 
 	/*
 	 * Initialise to a known state (all timers off)
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 2558f2e..3621b00 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -45,7 +45,6 @@ DT_MACHINE_START(VERSATILE_PB, "ARM-Versatile (Device Tree Support)")
 	.map_io		= versatile_map_io,
 	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
-	.init_time	= versatile_timer_init,
 	.init_machine	= versatile_dt_init,
 	.dt_compat	= versatile_dt_match,
 	.restart	= versatile_restart,
-- 
1.7.10.4
