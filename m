From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 01 Jul 2014 13:46:50 -0700
Subject: [PATCH v4 02/13] clk: composite: allow read-only clocks
In-Reply-To: <3089033.Y3HT2Lq8qX@diego>
References: <1808429.dNxms7FR7U@diego> <3089033.Y3HT2Lq8qX@diego>
Message-ID: <20140701204650.32686.12713@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Heiko St?bner (2014-06-22 13:43:35)
> This allows readl-only composite clocks by making mux_ops->set_parent and
> divider_ops->round_rate/set_rate optional.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/clk/clk-composite.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
> index 0a4cd21..046d3f6 100644
> --- a/drivers/clk/clk-composite.c
> +++ b/drivers/clk/clk-composite.c
> @@ -210,7 +210,7 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
>         clk_composite_ops = &composite->ops;
>  
>         if (mux_hw && mux_ops) {
> -               if (!mux_ops->get_parent || !mux_ops->set_parent) {
> +               if (!mux_ops->get_parent) {
>                         clk = ERR_PTR(-EINVAL);
>                         goto err;
>                 }
> @@ -218,7 +218,8 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
>                 composite->mux_hw = mux_hw;
>                 composite->mux_ops = mux_ops;
>                 clk_composite_ops->get_parent = clk_composite_get_parent;
> -               clk_composite_ops->set_parent = clk_composite_set_parent;
> +               if (mux_ops->set_parent)
> +                       clk_composite_ops->set_parent = clk_composite_set_parent;
>                 if (mux_ops->determine_rate)
>                         clk_composite_ops->determine_rate = clk_composite_determine_rate;
>         }
> @@ -235,10 +236,6 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
>                         if (rate_ops->set_rate) {
>                                 clk_composite_ops->set_rate = clk_composite_set_rate;
>                         }
> -               } else {
> -                       WARN(rate_ops->set_rate,
> -                               "%s: missing round_rate op is required\n",
> -                               __func__);

Getting rid of this WARN isn't such a great solution. How about rolling
in the following cleanup?



>From 03a08d7e746aedc6ce99228d629752f241383e7f Mon Sep 17 00:00:00 2001
From: Mike Turquette <mturquette@linaro.org>
Date: Tue, 1 Jul 2014 12:11:38 -0700
Subject: [PATCH] clk: composite: improve rate_hw sanity check logic

The function pointer population and sanity checking logic got a bit ugly
with the advent of the .determine_rate callback. Clean it up.

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/clk-composite.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index faf7c32..bdf4f2b 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -226,21 +226,27 @@ struct clk *clk_register_composite(struct device *dev, const char *name,
 			clk = ERR_PTR(-EINVAL);
 			goto err;
 		}
+		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
 
-		/* .round_rate is a prerequisite for .set_rate */
-		if (rate_ops->round_rate) {
-			clk_composite_ops->round_rate = clk_composite_round_rate;
-			if (rate_ops->set_rate) {
-				clk_composite_ops->set_rate = clk_composite_set_rate;
-			}
+		if (rate_ops->determine_rate)
+			clk_composite_ops->determine_rate =
+				clk_composite_determine_rate;
+		else if (rate_ops->round_rate)
+			clk_composite_ops->round_rate =
+				clk_composite_round_rate;
+
+		/* .set_rate requires either .round_rate or .determine_rate */
+		if (rate_ops->set_rate) {
+			if (rate_ops->determine_rate || rate_ops->round_rate)
+				clk_composite_ops->set_rate =
+					clk_composite_set_rate;
+			else
+				WARN(1, "%s: missing round_rate op is required\n",
+						__func__);
 		}
 
 		composite->rate_hw = rate_hw;
 		composite->rate_ops = rate_ops;
-		clk_composite_ops->recalc_rate = clk_composite_recalc_rate;
-		if (rate_ops->determine_rate ||
-		    (rate_ops->round_rate && clk_composite_ops->set_parent))
-			clk_composite_ops->determine_rate = clk_composite_determine_rate;
 	}
 
 	if (gate_hw && gate_ops) {
-- 
1.8.3.2
