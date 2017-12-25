From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Mon, 25 Dec 2017 12:38:10 +0300
Subject: [PATCH 1/2] clk: rename clk_core_get_boundaries() to
 clk_hw_get_boundaries() and expose
In-Reply-To: <20171221200743.GM7997@codeaurora.org>
References: <1513872282-5370-1-git-send-email-al.kochet@gmail.com>
 <1513872282-5370-2-git-send-email-al.kochet@gmail.com>
 <20171221200743.GM7997@codeaurora.org>
Message-ID: <8EC4D15B-4A89-43FA-953E-95AF81417067@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> 21 ???. 2017 ?., ? 23:07, Stephen Boyd <sboyd@codeaurora.org> ???????(?):
> 
> Can you convert to the determine_rate op instead of round_rate?
> That function should tell you the min/max limits so that you
> don't need to query that information from the core.

I converted rockchip_fractional_approximation() to rockchip_determine_rate() (see the patch attached).
If it increase parent?s clock for out of limits value, than clock request will fail with -EINVAL, like
with round_rate() approach.

The problem is that min/max limits provided to determine_rate() is for clock for which the determine_rate()
was called. While rockchip_determine_rate() (rockchip_fractional_approximation()) requires information
about parent clock limits.

How can I know parents clock limits for current clock? Implement determine_rate() for each parent clocks
the same way I did for this one clock?

Regards,
Alexander.

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 3c1fb0d..1e0c701 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -174,23 +174,9 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
 		unsigned long *m, unsigned long *n)
 {
 	struct clk_fractional_divider *fd = to_clk_fd(hw);
-	unsigned long p_rate, p_parent_rate;
-	unsigned long min_rate = 0, max_rate = 0;
-	struct clk_hw *p_parent;
 	unsigned long scale;
-
-	p_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
-	if ((rate * 20 > p_rate) && (p_rate % rate != 0)) {
-		p_parent = clk_hw_get_parent(clk_hw_get_parent(hw));
-		p_parent_rate = clk_hw_get_rate(p_parent);
-		clk_hw_get_boundaries(clk_hw_get_parent(hw),
-			&min_rate, &max_rate);
-		if (p_parent_rate < min_rate)
-			p_parent_rate = min_rate;
-		if (p_parent_rate > max_rate)
-			p_parent_rate = max_rate;
-		*parent_rate = p_parent_rate;
-	}
+	unsigned long rate_orig = rate;
+	unsigned long parent_rate_orig = *parent_rate;
 
 	/*
 	 * Get rate closer to *parent_rate to guarantee there is no overflow
@@ -204,8 +190,36 @@ static void rockchip_fractional_approximation(struct clk_hw *hw,
 	rational_best_approximation(rate, *parent_rate,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
 			m, n);
+
+	pr_info("%s: %s: rate:%lu -> %lu parent_rate:%lu -> %lu m:%lu n:%lu\n",
+		__func__, clk_hw_get_name(hw), rate_orig,  rate,
+		parent_rate_orig, *parent_rate,
+		*m, *n);
 }
 
+static int rockchip_determine_rate(struct clk_hw *hw,
+				   struct clk_rate_request *req)
+{
+	unsigned long p_rate, p_parent_rate;
+	struct clk_hw *p_parent;
+	unsigned long best_parent_rate = req->best_parent_rate;
+
+	p_rate = clk_hw_get_rate(clk_hw_get_parent(hw));
+	if ((req->rate * 20 > p_rate) && (p_rate % req->rate != 0)) {
+		p_parent = clk_hw_get_parent(clk_hw_get_parent(hw));
+		p_parent_rate = clk_hw_get_rate(p_parent);
+		req->best_parent_rate = p_parent_rate;
+	}
+
+	pr_info("%s: %s: rate:%lu min_rate:%lu max_rate:%lu best_parent_rate:%lu -> %lu best_parent_hw:%s\n",
+		__func__, clk_hw_get_name(hw), req->rate, req->min_rate, req->max_rate, best_parent_rate, req->best_parent_rate,
+		req->best_parent_hw ? clk_hw_get_name(req->best_parent_hw) : "<null>");
+
+	return 0;
+}
+
+static struct clk_ops rockchip_clk_fractional_divider_ops;
+
 static struct clk *rockchip_clk_register_frac_branch(
 		struct rockchip_clk_provider *ctx, const char *name,
 		const char *const *parent_names, u8 num_parents,
@@ -253,7 +267,8 @@ static struct clk *rockchip_clk_register_frac_branch(
 	div->nmask = GENMASK(div->nwidth - 1, 0) << div->nshift;
 	div->lock = lock;
 	div->approximation = rockchip_fractional_approximation;
-	div_ops = &clk_fractional_divider_ops;
+	div_ops = &rockchip_clk_fractional_divider_ops;
+
 
 	clk = clk_register_composite(NULL, name, parent_names, num_parents,
 				     NULL, NULL,
@@ -392,6 +407,9 @@ struct rockchip_clk_provider * __init rockchip_clk_init(struct device_node *np,
 	ctx->grf = syscon_regmap_lookup_by_phandle(ctx->cru_node,
 						   "rockchip,grf");
 
+	rockchip_clk_fractional_divider_ops = clk_fractional_divider_ops;
+	rockchip_clk_fractional_divider_ops.determine_rate = rockchip_determine_rate;
+
 	return ctx;
 
 err_free:
