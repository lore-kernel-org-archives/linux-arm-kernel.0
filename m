From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:32:12 +0900
Subject: [PATCH v6 17/17] ARM: shmobile: marzen-reference: Remove legacy clock
 support
In-Reply-To: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153532-23675-18-git-send-email-horms+renesas@verge.net.au>
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
v5, v6
* Rebase

v4
* As suggested by Geert Uytterhoeven
  - Remove bogus "these" from changelog
* Rebase
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 21c8cee..c6c133d 100644
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
1.8.5.2
