From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 23 May 2016 16:58:59 +0200
Subject: [PATCH 3/3] ARM: rockchip: drop rk3288 jtag/mmc switch handling
In-Reply-To: <1464015539-19521-1-git-send-email-heiko@sntech.de>
References: <1464015539-19521-1-git-send-email-heiko@sntech.de>
Message-ID: <1464015539-19521-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We moved that functionality to a more generic place where it can also
be used for other socs, so drop it from architecture code.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/rockchip.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index beb71da..e7b2aa7 100644
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
2.6.4
