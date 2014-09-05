From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  6 Sep 2014 01:06:04 +0200
Subject: [PATCH 01/11] clk: rockchip: fix rk3066 pll status register location
In-Reply-To: <1409958374-30937-1-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
Message-ID: <1409958374-30937-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The register providing the pll lock status is at a different address on the
rk3066. The error became apparent while working on cpufreq support for
the rockchip SoCs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 732118e..b8c5ada 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -19,6 +19,7 @@
 #include <dt-bindings/clock/rk3188-cru-common.h>
 #include "clk.h"
 
+#define RK3066_GRF_SOC_STATUS	0x15c
 #define RK3188_GRF_SOC_STATUS	0xac
 
 enum rk3188_plls {
@@ -628,9 +629,6 @@ static void __init rk3188_common_clk_init(struct device_node *np)
 		pr_warn("%s: could not register clock usb480m: %ld\n",
 			__func__, PTR_ERR(clk));
 
-	rockchip_clk_register_plls(rk3188_pll_clks,
-				   ARRAY_SIZE(rk3188_pll_clks),
-				   RK3188_GRF_SOC_STATUS);
 	rockchip_clk_register_branches(common_clk_branches,
 				  ARRAY_SIZE(common_clk_branches));
 	rockchip_clk_protect_critical(rk3188_critical_clocks,
@@ -643,6 +641,9 @@ static void __init rk3188_common_clk_init(struct device_node *np)
 static void __init rk3066a_clk_init(struct device_node *np)
 {
 	rk3188_common_clk_init(np);
+	rockchip_clk_register_plls(rk3188_pll_clks,
+				   ARRAY_SIZE(rk3188_pll_clks),
+				   RK3066_GRF_SOC_STATUS);
 	rockchip_clk_register_branches(rk3066a_clk_branches,
 				  ARRAY_SIZE(rk3066a_clk_branches));
 }
@@ -651,6 +652,9 @@ CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
 static void __init rk3188a_clk_init(struct device_node *np)
 {
 	rk3188_common_clk_init(np);
+	rockchip_clk_register_plls(rk3188_pll_clks,
+				   ARRAY_SIZE(rk3188_pll_clks),
+				   RK3188_GRF_SOC_STATUS);
 	rockchip_clk_register_branches(rk3188_clk_branches,
 				  ARRAY_SIZE(rk3188_clk_branches));
 }
-- 
2.0.1
