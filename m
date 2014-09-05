From: heiko@sntech.de (Heiko Stuebner)
Date: Sat,  6 Sep 2014 01:06:06 +0200
Subject: [PATCH 03/11] clk: rockchip: reparent aclk_cpu_pre to the gpll
In-Reply-To: <1409958374-30937-1-git-send-email-heiko@sntech.de>
References: <1409958374-30937-1-git-send-email-heiko@sntech.de>
Message-ID: <1409958374-30937-4-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

aclk_cpu_pre on the rk3188 can either be sourced from the armclk or the gpll.
To reduce complexity on apll changes caused by cpufreq, reparent it always
to the gpll source.

If really necessary it could be reparented back on a per board level using
the assigned-clocks mechanism.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/clk/rockchip/clk-rk3188.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index b8c5ada..2b893da 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -651,12 +651,31 @@ CLK_OF_DECLARE(rk3066a_cru, "rockchip,rk3066a-cru", rk3066a_clk_init);
 
 static void __init rk3188a_clk_init(struct device_node *np)
 {
+	struct clk *clk1, *clk2;
+	unsigned long rate;
+	int ret;
+
 	rk3188_common_clk_init(np);
 	rockchip_clk_register_plls(rk3188_pll_clks,
 				   ARRAY_SIZE(rk3188_pll_clks),
 				   RK3188_GRF_SOC_STATUS);
 	rockchip_clk_register_branches(rk3188_clk_branches,
 				  ARRAY_SIZE(rk3188_clk_branches));
+
+	/* reparent aclk_cpu_pre from apll */
+	clk1 = __clk_lookup("aclk_cpu_pre");
+	clk2 = __clk_lookup("gpll");
+	if (clk1 && clk2) {
+		rate = clk_get_rate(clk1);
+
+		ret = clk_set_parent(clk1, clk2);
+		if (ret < 0)
+			pr_warn("%s: could not reparent aclk_cpu_pre to gpll\n", __func__);
+
+		clk_set_rate(clk1, rate);
+	} else {
+		pr_warn("%s: missing clocks to reparent aclk_cpu_pre to gpll\n", __func__);
+	}
 }
 CLK_OF_DECLARE(rk3188a_cru, "rockchip,rk3188a-cru", rk3188a_clk_init);
 
-- 
2.0.1
