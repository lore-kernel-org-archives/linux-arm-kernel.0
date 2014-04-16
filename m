From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 10:57:34 +0900
Subject: [PATCH v5 20/20] ARM: shmobile: marzen-reference: Remove legacy clock
 support
In-Reply-To: <1397613454-7522-1-git-send-email-horms+renesas@verge.net.au>
References: <1397613454-7522-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1397613454-7522-21-git-send-email-horms+renesas@verge.net.au>
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
v5
* Rebase

v4
* As suggested by Geert Uytterhoeven
  - Remove bogus "these" from changelog
* Rebase
---
 arch/arm/mach-shmobile/board-marzen-reference.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 529c2b4..6d34baf 100644
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
@@ -53,7 +50,6 @@ static const struct clk_name clk_names[] __initconst = {
 	{ "tmu1", NULL, "sh_tmu.1" },
 	{ "tmu2", NULL, "sh_tmu.2" },
 };
-#endif
 
 /*
  * This is a really crude hack to work around core platform clock issues
@@ -65,12 +61,8 @@ static const struct clk_name clk_enables[] __initconst = {
 
 static void __init marzen_init(void)
 {
-#ifdef CONFIG_COMMON_CLK
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
-#else
-	r8a7779_clock_init();
-#endif
 	r8a7779_add_standard_devices_dt();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
-- 
1.8.5.2
