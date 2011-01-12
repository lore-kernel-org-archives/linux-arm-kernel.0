From: robherring2@gmail.com (Rob Herring)
Date: Wed, 12 Jan 2011 17:31:59 -0600
Subject: [PATCH 3/7] ARM: versatile: init clocks early and add sp804 clock
In-Reply-To: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
References: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
Message-ID: <1294875123-14086-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move clock initialization to mdesc->init_early and add a clock for
sp804 timer.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-versatile/core.c         |   18 ++++++++++++++----
 arch/arm/mach-versatile/core.h         |    1 +
 arch/arm/mach-versatile/versatile_ab.c |    1 +
 arch/arm/mach-versatile/versatile_pb.c |    1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index 13a83e4..399e2ef 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -417,6 +417,10 @@ static struct clk ref24_clk = {
 	.rate	= 24000000,
 };
 
+static struct clk sp804_clk = {
+	.rate	= 1000000,
+};
+
 static struct clk dummy_apb_pclk;
 
 static struct clk_lookup lookups[] = {
@@ -453,9 +457,19 @@ static struct clk_lookup lookups[] = {
 	}, {	/* CLCD */
 		.dev_id		= "dev:20",
 		.clk		= &osc4_clk,
+	}, {	/* SP804 Timer */
+		.dev_id		= "sp804",
+		.clk		= &sp804_clk,
 	}
 };
 
+void __init versatile_init_early(void)
+{
+	osc4_clk.vcoreg = __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_OSCCLCD_OFFSET;
+
+	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
+}
+
 /*
  * CLCD support.
  */
@@ -867,10 +881,6 @@ void __init versatile_init(void)
 {
 	int i;
 
-	osc4_clk.vcoreg	= __io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_OSCCLCD_OFFSET;
-
-	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
-
 	platform_device_register(&versatile_flash_device);
 	platform_device_register(&versatile_i2c_device);
 	platform_device_register(&smc91x_device);
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
1.7.1
