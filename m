From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 12:47:48 -0700
Subject: [PULL] clk: at91: sama5d2 materials
In-Reply-To: <20150825191033.31346.67237@quantum>
References: <20150818102401.17de779b@bbrezillon>
 <20150825191033.31346.67237@quantum>
Message-ID: <20151001194747.GK19319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/25, Michael Turquette wrote:
> Quoting Boris Brezillon (2015-08-18 01:24:01)
> > Stephen, Mike,
> > 
> > Here is a PR for the sama5d2 materials.
> > I know we're already late in the release cycle and I'm not sure you can
> > take this PR into account for 4.3, so if you can't could you please
> > queue it for 4.4?
> 
> Queued for 4.4.
> 
> Thanks,
> Mike
> 
> > 
> > Thanks,
> > 
> > Boris
> > 
> > The following changes since commit c42743f11f58646a50bc4b96da363429dca0c5e6:
> > 

This commit was in clk-next and then got rebased. clk-next isn't
stable, please don't base pull requests on it. If you have some
dependency on the patches in there then we need to know so that
we can provide some branch.

I cherry-picked the 4 patches to clk-next. I had to squash in this fix
to get it to compile. Please check.

---8<----
diff --git a/drivers/clk/at91/clk-generated.c b/drivers/clk/at91/clk-generated.c
index 631123ca6f85..abc80949e1dd 100644
--- a/drivers/clk/at91/clk-generated.c
+++ b/drivers/clk/at91/clk-generated.c
@@ -99,22 +99,22 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 					struct clk_rate_request *req)
 {
 	struct clk_generated *gck = to_clk_generated(hw);
-	struct clk *parent = NULL;
+	struct clk_hw *parent = NULL;
 	long best_rate = -EINVAL;
 	unsigned long tmp_rate, min_rate;
 	int best_diff = -1;
 	int tmp_diff;
 	int i;
 
-	for (i = 0; i < __clk_get_num_parents(hw->clk); i++) {
+	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
 		u32 div;
 		unsigned long parent_rate;
 
-		parent = clk_get_parent_by_index(hw->clk, i);
+		parent = clk_hw_get_parent_by_index(hw, i);
 		if (!parent)
 			continue;
 
-		parent_rate = __clk_get_rate(parent);
+		parent_rate = clk_hw_get_rate(parent);
 		min_rate = DIV_ROUND_CLOSEST(parent_rate, GENERATED_MAX_DIV + 1);
 		if (!parent_rate ||
 		    (gck->range.max && min_rate > gck->range.max))
@@ -128,7 +128,7 @@ static int clk_generated_determine_rate(struct clk_hw *hw,
 				best_rate = tmp_rate;
 				best_diff = tmp_diff;
 				req->best_parent_rate = parent_rate;
-				req->best_parent_hw = __clk_get_hw(parent);
+				req->best_parent_hw = parent;
 			}
 
 			if (!best_diff || tmp_rate < req->rate)
@@ -156,7 +156,7 @@ static int clk_generated_set_parent(struct clk_hw *hw, u8 index)
 {
 	struct clk_generated *gck = to_clk_generated(hw);
 
-	if (index >= __clk_get_num_parents(hw->clk))
+	if (index >= clk_hw_get_num_parents(hw))
 		return -EINVAL;
 
 	gck->parent_id = index;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
