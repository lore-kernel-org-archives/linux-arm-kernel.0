From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 Nov 2016 23:39:00 +0100
Subject: [PATCH v2 3/3] ARM: rockchip: drop rk3288 jtag/mmc switch handling
In-Reply-To: <20161115223900.30728-1-heiko@sntech.de>
References: <20161115223900.30728-1-heiko@sntech.de>
Message-ID: <20161115223900.30728-4-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We moved that functionality to a more generic place where it can also
be used for other socs, so drop it from architecture code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 arch/arm/mach-rockchip/rockchip.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index e7fdf06..0008783 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -29,13 +29,11 @@
 #include "core.h"
 #include "pm.h"
 
-#define RK3288_GRF_SOC_CON0 0x244
 #define RK3288_TIMER6_7_PHYS 0xff810000
 
 static void __init rockchip_timer_init(void)
 {
 	if (of_machine_is_compatible("rockchip,rk3288")) {
-		struct regmap *grf;
 		void __iomem *reg_base;
 
 		/*
@@ -54,16 +52,6 @@ static void __init rockchip_timer_init(void)
 		} else {
 			pr_err("rockchip: could not map timer7 registers\n");
 		}
-
-		/*
-		 * Disable auto jtag/sdmmc switching that causes issues
-		 * with the mmc controllers making them unreliable
-		 */
-		grf = syscon_regmap_lookup_by_compatible("rockchip,rk3288-grf");
-		if (!IS_ERR(grf))
-			regmap_write(grf, RK3288_GRF_SOC_CON0, 0x10000000);
-		else
-			pr_err("rockchip: could not get grf syscon\n");
 	}
 
 	of_clk_init(NULL);
-- 
2.10.2
