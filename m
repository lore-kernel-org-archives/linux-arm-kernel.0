From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Apr 2012 20:50:19 +0800
Subject: [PATCH 3/3] clk: propagate round_rate for CLK_SET_RATE_PARENT case
In-Reply-To: <1334235019-15553-1-git-send-email-shawn.guo@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334235019-15553-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1334235019-15553-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Need to propagate round_rate call for the clk that has no .round_rate
operation but with flag CLK_SET_RATE_PARENT set.

For example, clk_mux is a clk with no .round_rate operation.  However,
it could likely be in a clk_set_rate propagation path, saying it has
parent clk who has .round_rate and .set_rate operations.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/clk.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d04e1e4..1f1fff1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -587,8 +587,12 @@ unsigned long __clk_round_rate(struct clk *clk, unsigned long rate)
 	if (!clk)
 		return -EINVAL;
 
-	if (!clk->ops->round_rate)
-		return clk->rate;
+	if (!clk->ops->round_rate) {
+		if (clk->flags & CLK_SET_RATE_PARENT)
+			return __clk_round_rate(clk->parent, rate);
+		else
+			return clk->rate;
+	}
 
 	if (clk->parent)
 		parent_rate = clk->parent->rate;
-- 
1.7.5.4
