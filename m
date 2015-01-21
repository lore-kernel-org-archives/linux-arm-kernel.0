From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 21 Jan 2015 20:56:06 +0100
Subject: [PATCH 2/3] clk: rockchip: add a dummy clock for the watchdog pclk on
 rk3288
In-Reply-To: <1736604.toH3biuFW2@phil>
References: <1736604.toH3biuFW2@phil>
Message-ID: <40627478.oB4De9HGiG@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pclk supplying the watchdog is controlled via the SGRF register area.
Currently we don't have any clock-type handling external clock bits like
this one. Additionally the SGRF isn't even writable in every boot mode.

But still the clock control is available and in the future someone might
want to use it. Therefore define a simple clock for the time being so
that the watchdog driver can read its rate.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3288.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index cbcddcc..6cc3e0d 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -866,6 +866,14 @@ static void __init rk3288_clk_init(struct device_node *np)
 		pr_warn("%s: could not register clock hclk_vcodec_pre: %ld\n",
 			__func__, PTR_ERR(clk));
 
+	/* Watchdog pclk is controlled by RK3288_SGRF_SOC_CON0[1]. */
+	clk = clk_register_fixed_factor(NULL, "pclk_wdt", "pclk_pd_alive", 0, 1, 1);
+	if (IS_ERR(clk))
+		pr_warn("%s: could not register clock pclk_wdt: %ld\n",
+			__func__, PTR_ERR(clk));
+	else
+		rockchip_clk_add_lookup(clk, PCLK_WDT);
+
 	rockchip_clk_register_plls(rk3288_pll_clks,
 				   ARRAY_SIZE(rk3288_pll_clks),
 				   RK3288_GRF_SOC_STATUS1);
-- 
2.1.1
