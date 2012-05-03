From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:18:25 +0530
Subject: [PATCH V3 2/8] clk: add a fixed factor clock
In-Reply-To: <20120503063721.GD4141@pengutronix.de>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
 <20120502094807.GE20478@pengutronix.de> <4FA120E8.5030707@st.com>
 <20120502224108.GC18402@gmail.com> <4FA21879.9060508@st.com>
 <20120503063721.GD4141@pengutronix.de>
Message-ID: <4FA25469.6030701@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/3/2012 12:07 PM, Sascha Hauer wrote:
> Yes, looks good.

Thanks. Here is one more to review, found after rebasing on latest
clk-next from Mike. I will send this a complete patch for fixed factor
clock separately, following is just for review.

This happened due to Saravana's patch:

---
 drivers/clk/clk-fixed-factor.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index 8d25c2e..0e8782b 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -66,10 +66,10 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
                unsigned int mult, unsigned int div)
 {
        struct clk_fixed_factor *fix;
+       struct clk_init_data init;
        struct clk *clk;
 
        fix = kmalloc(sizeof(*fix), GFP_KERNEL);
-
        if (!fix) {
                pr_err("%s: could not allocate fixed factor clk\n", __func__);
                return ERR_PTR(-ENOMEM);
@@ -78,12 +78,15 @@ struct clk *clk_register_fixed_factor(struct device *dev, const char *name,
        /* struct clk_fixed_factor assignments */
        fix->mult = mult;
        fix->div = div;
+       fix->hw.init = &init;
+
+       init.name = name;
+       init.ops = &clk_fixed_factor_ops;
+       init.flags = flags;
+       init.parent_names = &parent_name;
+       init.num_parents = 1;
 
-       clk = clk_register(dev, name,
-                       &clk_fixed_factor_ops, &fix->hw,
-                       &parent_name,
-                       (parent_name ? 1 : 0),
-                       flags);
+       clk = clk_register(dev, &fix->hw);
 
        if (clk)
                return clk;


-- 
viresh
