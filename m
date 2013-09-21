From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 21 Sep 2013 09:11:46 -0500
Subject: [PATCH 2/2] ARM: sunxi: Simplify restart setup code
In-Reply-To: <1379772706-7028-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1379772706-7028-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1379772706-7028-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have different machine definitions for different SoCs, we
can remove the DT lookup to get the restart hook we should be using, and
hardcode it in the machine definition instead.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/sunxi.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index e0641dd..f184f6c 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -93,14 +93,13 @@ static void sun6i_restart(enum reboot_mode mode, const char *cmd)
 }
 
 static struct of_device_id sunxi_restart_ids[] = {
-	{ .compatible = "allwinner,sun4i-wdt", .data = sun4i_restart },
-	{ .compatible = "allwinner,sun6i-wdt", .data = sun6i_restart },
+	{ .compatible = "allwinner,sun4i-wdt" },
+	{ .compatible = "allwinner,sun6i-wdt" },
 	{ /*sentinel*/ }
 };
 
 static void sunxi_setup_restart(void)
 {
-	const struct of_device_id *of_id;
 	struct device_node *np;
 
 	np = of_find_matching_node(NULL, sunxi_restart_ids);
@@ -109,11 +108,6 @@ static void sunxi_setup_restart(void)
 
 	wdt_base = of_iomap(np, 0);
 	WARN(!wdt_base, "failed to map watchdog base address");
-
-	of_id = of_match_node(sunxi_restart_ids, np);
-	WARN(!of_id, "restart function not available");
-
-	arm_pm_restart = of_id->data;
 }
 
 static void __init sunxi_timer_init(void)
@@ -140,6 +134,7 @@ DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
 	.init_machine	= sunxi_dt_init,
 	.init_time	= sunxi_timer_init,
 	.dt_compat	= sunxi_board_dt_compat,
+	.restart	= sun4i_restart,
 MACHINE_END
 
 static const char * const sun6i_board_dt_compat[] = {
@@ -151,6 +146,7 @@ DT_MACHINE_START(SUN6I_DT, "Allwinner sun6i (A31) Family")
 	.init_machine	= sunxi_dt_init,
 	.init_time	= sunxi_timer_init,
 	.dt_compat	= sun6i_board_dt_compat,
+	.restart	= sun6i_restart,
 MACHINE_END
 
 static const char * const sun7i_board_dt_compat[] = {
@@ -162,4 +158,5 @@ DT_MACHINE_START(SUN7I_DT, "Allwinner sun7i (A20) Family")
 	.init_machine	= sunxi_dt_init,
 	.init_time	= sunxi_timer_init,
 	.dt_compat	= sun7i_board_dt_compat,
+	.restart	= sun4i_restart,
 MACHINE_END
-- 
1.8.4
