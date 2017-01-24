From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 24 Jan 2017 10:41:18 +0100
Subject: [PATCH 1/2] clk: sunxi-ng: Call divider_round_rate if we only have a
 single parent
Message-ID: <53c56d23af099d8a41460d5ac59a2c792c8d050c.1485250845.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The divider_get_val function that is used in our determine_rate callback
doesn't try to change the parent rate at all, while clk_divider_bestdiv,
used in divider_round_rate, does.

If we have a single parent, call divider_round_rate.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/ccu_div.c | 12 ++++++++++++
 1 file changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index 8659b4cb6c20..4057e6021aa9 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -77,6 +77,18 @@ static int ccu_div_determine_rate(struct clk_hw *hw,
 {
 	struct ccu_div *cd = hw_to_ccu_div(hw);
 
+	if (clk_hw_get_num_parents(hw) == 1) {
+		req->rate = divider_round_rate(hw, req->rate,
+					       &req->best_parent_rate,
+					       cd->div.table,
+					       cd->div.width,
+					       cd->div.flags);
+
+		req->best_parent_hw = clk_hw_get_parent(hw);
+
+		return 0;
+	}
+
 	return ccu_mux_helper_determine_rate(&cd->common, &cd->mux,
 					     req, ccu_div_round_rate, cd);
 }

base-commit: 9181f40cede22bff9bc7f26830a4562373f30d73
-- 
git-series 0.8.11
