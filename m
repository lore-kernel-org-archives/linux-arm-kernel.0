From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 11 Apr 2012 18:02:41 -0700
Subject: [PATCH 03/13] clk: core: clk_calc_new_rates handles NULL parents
In-Reply-To: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
Message-ID: <1334192572-12499-4-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible to call clk_set_rate on a clock with a NULL parent.  One
such example is an adjustable-rate root clock.  Ensure that
clk_calc_new_rates does not dereference parent without checking first
and also handle the corner cases gracefully.

Reported-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Mike Turquette <mturquette@linaro.org>
Cc: Arnd Bergman <arnd.bergmann@linaro.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Richard Zhao <richard.zhao@linaro.org>
Cc: Saravana Kannan <skannan@codeaurora.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/clk/clk.c |   29 +++++++++++++++++++++--------
 1 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4daacf5..d83a9e0 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -763,25 +763,38 @@ static void clk_calc_subtree(struct clk *clk, unsigned long new_rate)
 static struct clk *clk_calc_new_rates(struct clk *clk, unsigned long rate)
 {
 	struct clk *top = clk;
-	unsigned long best_parent_rate = clk->parent->rate;
+	unsigned long best_parent_rate;
 	unsigned long new_rate;
 
-	if (!clk->ops->round_rate && !(clk->flags & CLK_SET_RATE_PARENT)) {
-		clk->new_rate = clk->rate;
+	/* sanity */
+	if (IS_ERR_OR_NULL(clk))
+		return NULL;
+
+	/* never propagate up to the parent */
+	if (!(clk->flags & CLK_SET_RATE_PARENT)) {
+		if (!clk->ops->round_rate) {
+			clk->new_rate = clk->rate;
+			return NULL;
+		} else {
+			new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
+			goto out;
+		}
+	}
+
+	/* need clk->parent from here on out */
+	if (!clk->parent) {
+		pr_debug("%s: %s has NULL parent\n", __func__, clk->name);
 		return NULL;
 	}
 
-	if (!clk->ops->round_rate && (clk->flags & CLK_SET_RATE_PARENT)) {
+	if (!clk->ops->round_rate) {
 		top = clk_calc_new_rates(clk->parent, rate);
 		new_rate = clk->new_rate = clk->parent->new_rate;
 
 		goto out;
 	}
 
-	if (clk->flags & CLK_SET_RATE_PARENT)
-		new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
-	else
-		new_rate = clk->ops->round_rate(clk->hw, rate, NULL);
+	new_rate = clk->ops->round_rate(clk->hw, rate, &best_parent_rate);
 
 	if (best_parent_rate != clk->parent->rate) {
 		top = clk_calc_new_rates(clk->parent, best_parent_rate);
-- 
1.7.5.4
