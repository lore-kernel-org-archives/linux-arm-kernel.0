From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Aug 2014 09:24:15 +0900
Subject: [PATCH 6/8] ARM: shmobile: marzen-reference: Enable TMU0 in device
 tree
In-Reply-To: <cover.1408492048.git.horms+renesas@verge.net.au>
References: <cover.1408492048.git.horms+renesas@verge.net.au>
Message-ID: <5ecd7a5185008723056a4b70815aa017272ca751.1408492048.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

No more device needs to be added from platform code when booting the
reference platform, remove the now empty
r8a7779_add_standard_devices_dt() function completely.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts            |  4 ++++
 arch/arm/mach-shmobile/board-marzen-reference.c | 10 ----------
 arch/arm/mach-shmobile/r8a7779.h                |  1 -
 arch/arm/mach-shmobile/setup-r8a7779.c          | 17 +++++------------
 4 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 5745555..c160404 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -78,6 +78,10 @@
 	clock-frequency = <31250000>;
 };
 
+&tmu0 {
+	status = "okay";
+};
+
 &pfc {
 	lan0_pins: lan0 {
 		intc {
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 21b3e1c..f671003 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -37,18 +37,8 @@ static void __init marzen_init_timer(void)
 	clocksource_of_init();
 }
 
-/*
- * This is a really crude hack to provide clkdev support to platform
- * devices until they get moved to DT.
- */
-static const struct clk_name clk_names[] __initconst = {
-	{ "tmu0", "fck", "sh-tmu.0" },
-};
-
 static void __init marzen_init(void)
 {
-	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-	r8a7779_add_standard_devices_dt();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
 }
diff --git a/arch/arm/mach-shmobile/r8a7779.h b/arch/arm/mach-shmobile/r8a7779.h
index 5415c71..19f9704 100644
--- a/arch/arm/mach-shmobile/r8a7779.h
+++ b/arch/arm/mach-shmobile/r8a7779.h
@@ -17,7 +17,6 @@ extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
-extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_init_late(void);
 extern u32 r8a7779_read_mode_pins(void);
 extern void r8a7779_clock_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 236c1be..11ceee6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -641,7 +641,7 @@ static void __init r8a7779_register_hpb_dmae(void)
 					  sizeof(dma_platform_data));
 }
 
-static struct platform_device *r8a7779_devices_dt[] __initdata = {
+static struct platform_device *r8a7779_early_devices[] __initdata = {
 	&tmu0_device,
 };
 
@@ -669,8 +669,8 @@ void __init r8a7779_add_standard_devices(void)
 
 	r8a7779_init_pm_domains();
 
-	platform_add_devices(r8a7779_devices_dt,
-			    ARRAY_SIZE(r8a7779_devices_dt));
+	platform_add_devices(r8a7779_early_devices,
+			    ARRAY_SIZE(r8a7779_early_devices));
 	platform_add_devices(r8a7779_standard_devices,
 			    ARRAY_SIZE(r8a7779_standard_devices));
 	r8a7779_register_hpb_dmae();
@@ -678,8 +678,8 @@ void __init r8a7779_add_standard_devices(void)
 
 void __init r8a7779_add_early_devices(void)
 {
-	early_platform_add_devices(r8a7779_devices_dt,
-				   ARRAY_SIZE(r8a7779_devices_dt));
+	early_platform_add_devices(r8a7779_early_devices,
+				   ARRAY_SIZE(r8a7779_early_devices));
 
 	/* Early serial console setup is not included here due to
 	 * memory map collisions. The SCIF serial ports in r8a7779
@@ -739,12 +739,6 @@ void __init r8a7779_init_irq_dt(void)
 	__raw_writel(0x003fee3f, INT2SMSKCR4);
 }
 
-void __init r8a7779_add_standard_devices_dt(void)
-{
-	platform_add_devices(r8a7779_devices_dt,
-			     ARRAY_SIZE(r8a7779_devices_dt));
-}
-
 #define MODEMR		0xffcc0020
 
 u32 __init r8a7779_read_mode_pins(void)
@@ -773,7 +767,6 @@ DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
-	.init_machine	= r8a7779_add_standard_devices_dt,
 	.init_late	= r8a7779_init_late,
 	.dt_compat	= r8a7779_compat_dt,
 MACHINE_END
-- 
2.0.1
