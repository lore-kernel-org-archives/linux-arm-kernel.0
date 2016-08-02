From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue,  2 Aug 2016 21:13:19 +0800
Subject: [PATCH] clk: rockchip: rk3399: add pll up and down when change pll
 freq
Message-ID: <1470143599-8851-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Elaine Zhang <zhangqing@rock-chips.com>

The suggestion that is from IC designer, the correct pll sequence setting
should be like these:
----
  set pll to slow mode or other plls
  set pll down
  set pll params
  set pll up
  wait pll lock status
  set pll to normal mode
----

Hence, there are potential risks that we need to fix:
rockchip_rk3399_wait_pll_lock - timeout waiting for pll to lock
rockchip_rk3399_pll_set_params - pll update unsucessful, trying to restore old params

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
---

 drivers/clk/rockchip/clk-pll.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index db81e45..35994e8 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -681,6 +681,11 @@ static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
 		rate_change_remuxed = 1;
 	}
 
+	/* set pll power down */
+	writel(HIWORD_UPDATE(RK3399_PLLCON3_PWRDOWN,
+			     RK3399_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(3));
+
 	/* update pll values */
 	writel_relaxed(HIWORD_UPDATE(rate->fbdiv, RK3399_PLLCON0_FBDIV_MASK,
 						  RK3399_PLLCON0_FBDIV_SHIFT),
@@ -704,6 +709,11 @@ static int rockchip_rk3399_pll_set_params(struct rockchip_clk_pll *pll,
 					    RK3399_PLLCON3_DSMPD_SHIFT),
 		       pll->reg_base + RK3399_PLLCON(3));
 
+	/* set pll power up */
+	writel(HIWORD_UPDATE(0,
+			     RK3399_PLLCON3_PWRDOWN, 0),
+	       pll->reg_base + RK3399_PLLCON(3));
+
 	/* wait for the pll to lock */
 	ret = rockchip_rk3399_pll_wait_lock(pll);
 	if (ret) {
-- 
1.7.9.5
