From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 11 Jan 2015 23:09:23 +0100
Subject: [PATCH] ARM: rockchip: disable jtag/sdmmc autoswitching on rk3288
Message-ID: <27329915.EKTrifTJzR@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

rk3288 SoCs have a function to automatically switch between jtag/sdmmc pinmux
settings depending on the card state. This collides with a lot of assumptions.

It only works when using the internal card-detect mechanism and breaks
horribly when using either the normal card-detect via the slot-gpio function
or via any other pin. Also there is of course no link between the mmc and jtag
on the software-side, so the jtag clocks may very well be disabled when the
card is ejected and the soc switches back to the jtag pinmux.

Leaving the switching function enabled did result in mmc timeouts and rcu
stalls thus hanging the system on 3.19-rc1. Therefore disable it in all cases,
as we expect the devicetree to explicitly select either mmc or jtag pinmuxes
anyway.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/rockchip.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index d226b71..a611f48 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -19,11 +19,37 @@
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <linux/irqchip.h>
+#include <linux/clk-provider.h>
+#include <linux/clocksource.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/hardware/cache-l2x0.h>
 #include "core.h"
 
+#define RK3288_GRF_SOC_CON0 0x244
+
+static void __init rockchip_timer_init(void)
+{
+	if (of_machine_is_compatible("rockchip,rk3288")) {
+		struct regmap *grf;
+
+		/*
+		 * Disable auto jtag/sdmmc switching that causes issues
+		 * with the mmc controllers making them unreliable
+		 */
+		grf = syscon_regmap_lookup_by_compatible("rockchip,rk3288-grf");
+		if (!IS_ERR(grf))
+			regmap_write(grf, RK3288_GRF_SOC_CON0, 0x10000000);
+		else
+			pr_err("rockchip: could not get grf syscon\n");
+	}
+
+	of_clk_init(NULL);
+	clocksource_of_init();
+}
+
 static void __init rockchip_dt_init(void)
 {
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
@@ -42,6 +68,7 @@ static const char * const rockchip_board_dt_compat[] = {
 DT_MACHINE_START(ROCKCHIP_DT, "Rockchip Cortex-A9 (Device Tree)")
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
+	.init_time	= rockchip_timer_init,
 	.dt_compat	= rockchip_board_dt_compat,
 	.init_machine	= rockchip_dt_init,
 MACHINE_END
-- 
2.1.1
