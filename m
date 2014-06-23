From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:27 +0900
Subject: [PATCH 14/24] ARM: shmobile: marzen-reference: Remove legacy clock
 support
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <f0b78f8b63fe92242232b7a3e4aa951983ee1f45.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marzen DT reference is now only built for multiplatform
which means that CCF comes with the package. Remove unused legacy
code ifdefs to clean up the code.

Based on similar work for the Koelsch board by Magnus Damm.

Cc: Magnus Damm <damm@opensource.se>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 46936ff..1b63686 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -31,13 +31,10 @@
 
 static void __init marzen_init_timer(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	r8a7779_clocks_init(r8a7779_read_mode_pins());
-#endif
 	clocksource_of_init();
 }
 
-#ifdef CONFIG_COMMON_CLK
 /*
  * This is a really crude hack to provide clkdev support to platform
  * devices until they get moved to DT.
@@ -51,15 +48,10 @@ static const struct clk_name clk_names[] __initconst = {
 	{ "scif5", NULL, "sh-sci.5" },
 	{ "tmu0", "fck", "sh-tmu.0" },
 };
-#endif
 
 static void __init marzen_init(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
-#else
-	r8a7779_clock_init();
-#endif
 	r8a7779_add_standard_devices_dt();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
-- 
2.0.0.rc2
