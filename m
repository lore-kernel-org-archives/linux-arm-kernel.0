From: hl@rock-chips.com (Lin Huang)
Date: Fri, 29 Jul 2016 15:56:55 +0800
Subject: [PATCH v4 1/7] clk: rockchip: add clock flag parameter when register
 pll
In-Reply-To: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
References: <1469779021-10426-1-git-send-email-hl@rock-chips.com>
Message-ID: <1469779021-10426-2-git-send-email-hl@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Heiko St?bner <heiko@sntech.de>

add clock flag parameter so we can pass specific clock flag
(like CLK_GET_RATE_NOCACHE etc..)to pll driver.

Signed-off-by: Heiko St?bner <heiko@sntech.de>
Signed-off-by: Lin Huang <hl@rock-chips.com>
---
Changes in v4:
- None

Changes in v3:
- None

Changes in v2:
- None

Changes in v1:
- None

 drivers/clk/rockchip/clk-pll.c | 4 ++--
 drivers/clk/rockchip/clk.c     | 2 +-
 drivers/clk/rockchip/clk.h     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 8ac73bc..d824c36 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -864,7 +864,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		u8 num_parents, int con_offset, int grf_lock_offset,
 		int lock_shift, int mode_offset, int mode_shift,
 		struct rockchip_pll_rate_table *rate_table,
-		u8 clk_pll_flags)
+		unsigned long flags, u8 clk_pll_flags)
 {
 	const char *pll_parents[3];
 	struct clk_init_data init;
@@ -919,7 +919,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	init.name = pll_name;
 
 	/* keep all plls untouched for now */
-	init.flags = CLK_IGNORE_UNUSED;
+	init.flags = flags | CLK_IGNORE_UNUSED;
 
 	init.parent_names = &parent_names[0];
 	init.num_parents = 1;
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index f0a8be1..9a046f1 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -390,7 +390,7 @@ void __init rockchip_clk_register_plls(struct rockchip_clk_provider *ctx,
 				list->con_offset, grf_lock_offset,
 				list->lock_shift, list->mode_offset,
 				list->mode_shift, list->rate_table,
-				list->pll_flags);
+				list->flags, list->pll_flags);
 		if (IS_ERR(clk)) {
 			pr_err("%s: failed to register clock %s\n", __func__,
 				list->name);
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index 1abb7d0..bac775d 100644
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
1.9.1
