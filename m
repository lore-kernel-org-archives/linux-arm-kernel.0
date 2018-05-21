From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 21 May 2018 19:57:50 +0800
Subject: [PATCH 13/33] clk: rockchip: use match_string() helper
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
Message-ID: <1526903890-35761-14-git-send-email-xieyisheng1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-rockchip at lists.infradead.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/clk/rockchip/clk.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 3cd8ad5..514032d 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -274,18 +274,10 @@ static struct clk *rockchip_clk_register_frac_branch(
 		struct clk_mux *frac_mux = &frac->mux;
 		struct clk_init_data init;
 		struct clk *mux_clk;
-		int i, ret;
-
-		frac->mux_frac_idx = -1;
-		for (i = 0; i < child->num_parents; i++) {
-			if (!strcmp(name, child->parent_names[i])) {
-				pr_debug("%s: found fractional parent in mux at pos %d\n",
-					 __func__, i);
-				frac->mux_frac_idx = i;
-				break;
-			}
-		}
+		int ret;
 
+		frac->mux_frac_idx = match_string(child->parent_names,
+						  child->num_parents, name);
 		frac->mux_ops = &clk_mux_ops;
 		frac->clk_nb.notifier_call = rockchip_clk_frac_notifier_cb;
 
@@ -312,6 +304,8 @@ static struct clk *rockchip_clk_register_frac_branch(
 
 		/* notifier on the fraction divider to catch rate changes */
 		if (frac->mux_frac_idx >= 0) {
+			pr_debug("%s: find fractional parent in mux at pos %d\n",
+				 __func__, frac->mux_frac_idx);
 			ret = clk_notifier_register(clk, &frac->clk_nb);
 			if (ret)
 				pr_err("%s: failed to register clock notifier for %s\n",
-- 
1.7.12.4
