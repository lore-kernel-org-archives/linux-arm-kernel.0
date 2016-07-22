From: hl@rock-chips.com (Lin Huang)
Date: Fri, 22 Jul 2016 14:37:45 +0800
Subject: [PATCH] clk: rockchip: add clock flag parameter when register pll
Message-ID: <1469169465-5892-1-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko St??bner <heiko@sntech.de>

add clock flag parameter so we can pass specific clock flag
(like CLK_GET_RATE_NOCACHE etc..)to pll driver.

Change-Id: I1e076b3efa6b5da082b6e68e2e2a4c9dfd93e3d4
Signed-off-by: Heiko St??bner <heiko@sntech.de>
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 drivers/clk/rockchip/clk-pll.c | 4 ++--
 drivers/clk/rockchip/clk.c     | 2 +-
 drivers/clk/rockchip/clk.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index db81e45..9c1373e 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -837,7 +837,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		u8 num_parents, int con_offset, int grf_lock_offset,
 		int lock_shift, int mode_offset, int mode_shift,
 		struct rockchip_pll_rate_table *rate_table,
-		u8 clk_pll_flags)
+		unsigned long flags, u8 clk_pll_flags)
 {
 	const char *pll_parents[3];
 	struct clk_init_data init;
@@ -892,7 +892,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	init.name = pll_name;
 
 	/* keep all plls untouched for now */
-	init.flags = CLK_IGNORE_UNUSED;
+	init.flags = flags | CLK_IGNORE_UNUSED;
 
 	init.parent_names = &parent_names[0];
 	init.num_parents = 1;
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 7ffd134..1f1c74f 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -385,7 +385,7 @@ void __init rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
 				list->con_offset, grf_lock_offset,
 				list->lock_shift, list->mode_offset,
 				list->mode_shift, list->rate_table,
-				list->pll_flags);
+				list->flags, list->pll_flags);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 2194ffa..3747de5 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -238,7 +238,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		u8 num_parents, int con_offset, int grf_lock_offset,
 		int lock_shift, int mode_offset, int mode_shift,
 		struct rockchip_pll_rate_table *rate_table,
-		u8 clk_pll_flags);
+		unsigned long flags, u8 clk_pll_flags);
 
 struct rockchip_cpuclk_clksel {
 	int reg;
-- 
2.6.6
