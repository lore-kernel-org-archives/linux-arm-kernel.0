From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 13:46:26 +0000
Subject: [PATCH 02/11] ARM: versatile: use new init_early for clock tree and
	sched_clock init
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <E1PiSB8-0003ox-Cm@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the clock tree and our sched_clock() early.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-versatile/core.c         |   23 +++++++++++------------
 arch/arm/mach-versatile/core.h         |    1 +
 arch/arm/mach-versatile/versatile_ab.c |    1 +
 arch/arm/mach-versatile/versatile_pb.c |    1 +
 4 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index b4f1f17..606e046 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -762,14 +762,21 @@ static void versatile_leds_event(led_event_t ledevt)
 }
 #endif	/* CONFIG_LEDS */
 
-void __init versatile_init(void)
+/* Early initializations */
+void __init versatile_init_early(void)
 {
-	int i;
-
-	osc4_clk.vcoreg	= __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_OSCCLCD_OFFSET;
+	void __iomem *sys = __io_address(VERSATILE_SYS_BASE);
 
+	osc4_clk.vcoreg	= sys + VERSATILE_SYS_OSCCLCD_OFFSET;
 	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
 
+	versatile_sched_clock_init(sys + VERSATILE_SYS_24MHz_OFFSET, 24000000);
+}
+
+void __init versatile_init(void)
+{
+	int i;
+
 	platform_device_register(&versatile_flash_device);
 	platform_device_register(&versatile_i2c_device);
 	platform_device_register(&smc91x_device);
@@ -786,12 +793,6 @@ void __init versatile_init(void)
 }
 
 /*
- * The sched_clock counter
- */
-#define REFCOUNTER		(__io_address(VERSATILE_SYS_BASE) + \
-				 VERSATILE_SYS_24MHz_OFFSET)
-
-/*
  * Where is the timer (VA)?
  */
 #define TIMER0_VA_BASE		 __io_address(VERSATILE_TIMER0_1_BASE)
@@ -806,8 +807,6 @@ static void __init versatile_timer_init(void)
 {
 	u32 val;
 
-	versatile_sched_clock_init(REFCOUNTER, 24000000);
-
 	/* 
 	 * set clock frequency: 
 	 *	VERSATILE_REFCLK is 32KHz
diff --git a/arch/arm/mach-versatile/core.h b/arch/arm/mach-versatile/core.h
index 9d39886..e04768a 100644
--- a/arch/arm/mach-versatile/core.h
+++ b/arch/arm/mach-versatile/core.h
@@ -25,6 +25,7 @@
 #include <linux/amba/bus.h>
 
 extern void __init versatile_init(void);
+extern void __init versatile_init_early(void);
 extern void __init versatile_init_irq(void);
 extern void __init versatile_map_io(void);
 extern struct sys_timer versatile_timer;
diff --git a/arch/arm/mach-versatile/versatile_ab.c b/arch/arm/mach-versatile/versatile_ab.c
index aa9730f..f8ae64b 100644
--- a/arch/arm/mach-versatile/versatile_ab.c
+++ b/arch/arm/mach-versatile/versatile_ab.c
@@ -37,6 +37,7 @@ MACHINE_START(VERSATILE_AB, "ARM-Versatile AB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.boot_params	= 0x00000100,
 	.map_io		= versatile_map_io,
+	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_init,
diff --git a/arch/arm/mach-versatile/versatile_pb.c b/arch/arm/mach-versatile/versatile_pb.c
index bf46964..97fb306 100644
--- a/arch/arm/mach-versatile/versatile_pb.c
+++ b/arch/arm/mach-versatile/versatile_pb.c
@@ -110,6 +110,7 @@ MACHINE_START(VERSATILE_PB, "ARM-Versatile PB")
 	/* Maintainer: ARM Ltd/Deep Blue Solutions Ltd */
 	.boot_params	= 0x00000100,
 	.map_io		= versatile_map_io,
+	.init_early	= versatile_init_early,
 	.init_irq	= versatile_init_irq,
 	.timer		= &versatile_timer,
 	.init_machine	= versatile_pb_init,
-- 
1.6.2.5
