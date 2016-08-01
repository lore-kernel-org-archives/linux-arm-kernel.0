From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon,  1 Aug 2016 17:33:32 +0800
Subject: [PATCH v2 3/7] clk: rockchip: rk3399: fix incorrect parent for
 rk3399's {c, g}pll_aclk_perihp_src
In-Reply-To: <1470044016-29764-1-git-send-email-zhengxing@rock-chips.com>
References: <1470044016-29764-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <1470044016-29764-4-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was a typo, swapping 'c' <--> 'g'.

And sorry to refer incorrect clock diagram, we double check it that
the bits configuration of the Xpll_aclk_perihp_src need to be fixed:
bit 1 - shows aclk_perihp_cpll_src_en
bit 0 - shows aclk_perihp_gpll_src_en

Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 drivers/clk/rockchip/clk-rk3399.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index f55f967f..8bf0d19 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -832,10 +832,10 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
 			RK3399_CLKGATE_CON(13), 1, GFLAGS),
 
 	/* perihp */
-	GATE(0, "cpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
-			RK3399_CLKGATE_CON(5), 0, GFLAGS),
-	GATE(0, "gpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
+	GATE(0, "cpll_aclk_perihp_src", "cpll", CLK_IGNORE_UNUSED,
 			RK3399_CLKGATE_CON(5), 1, GFLAGS),
+	GATE(0, "gpll_aclk_perihp_src", "gpll", CLK_IGNORE_UNUSED,
+			RK3399_CLKGATE_CON(5), 0, GFLAGS),
 	COMPOSITE(ACLK_PERIHP, "aclk_perihp", mux_aclk_perihp_p, CLK_IGNORE_UNUSED,
 			RK3399_CLKSEL_CON(14), 7, 1, MFLAGS, 0, 5, DFLAGS,
 			RK3399_CLKGATE_CON(5), 2, GFLAGS),
-- 
1.7.9.5
