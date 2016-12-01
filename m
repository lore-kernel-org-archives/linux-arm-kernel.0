From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  1 Dec 2016 22:00:19 +0100
Subject: [PATCH 1/2] clk: bcm: Support rate change propagation on bcm2835
 clocks
In-Reply-To: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1480626020-20031-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some peripheral clocks, like the VEC (Video EnCoder) clock need to be set
to a precise rate (in our case 108MHz). With the current implementation,
where peripheral clocks are not allowed to forward rate change requests
to their parents, it is impossible to match this requirement unless the
bootloader has configured things correctly, or a specific rate has been
assigned through the DT (with the assigned-clk-rates property).

Add a new field to struct bcm2835_clock_data to specify which parent
clocks accept rate change propagation, and support set rate propagation
in bcm2835_clock_determine_rate().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Note: this approach is still fragile, since it does not prevent 2 clock
users from stepping on each other's toes.
We could use the clk rate constraints infrastructure, but it's only
applicable to leaf clocks in the clock tree (when you apply a constraint,
these constraints are not propagated to the clock tree).

Another approach would be to lock a rate on a clock, thus preventing
other users from changing it. Propagating rate locks would be easier than
propagating rate range constraints (see this patch
http://code.bulix.org/jwtzf8-107264), but it still requires that really
care about a specific clock rate explicitly lock the rate (using
clk_set_and_lock_rate()), and this means checking every drivers that have
such requirements.
---
 drivers/clk/bcm/clk-bcm2835.c | 67 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 2acaa77ad482..df96fe6dadab 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -436,6 +436,9 @@ struct bcm2835_clock_data {
 	const char *const *parents;
 	int num_mux_parents;
 
+	/* Bitmap encoding which parents accept rate change propagation. */
+	unsigned int set_rate_parent;
+
 	u32 ctl_reg;
 	u32 div_reg;
 
@@ -1017,10 +1020,60 @@ bcm2835_clk_is_pllc(struct clk_hw *hw)
 	return strncmp(clk_hw_get_name(hw), "pllc", 4) == 0;
 }
 
+static unsigned long bcm2835_clock_choose_div_and_prate(struct clk_hw *hw,
+							int parent_idx,
+							unsigned long rate,
+							u32 *div,
+							unsigned long *prate)
+{
+	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	struct bcm2835_cprman *cprman = clock->cprman;
+	const struct bcm2835_clock_data *data = clock->data;
+	unsigned long best_rate;
+	u32 curdiv, mindiv, maxdiv;
+	struct clk_hw *parent;
+
+	parent = clk_hw_get_parent_by_index(hw, parent_idx);
+
+	if (!(BIT(parent_idx) & data->set_rate_parent)) {
+		*prate = clk_hw_get_rate(parent);
+		*div = bcm2835_clock_choose_div(hw, rate, *prate, true);
+
+		return bcm2835_clock_rate_from_divisor(clock, *prate,
+						       *div);
+	}
+
+	if (data->frac_bits)
+		dev_warn(cprman->dev,
+			"frac bits are not used when propagating rate change");
+
+	/* clamp to min divider of 2 if we're dealing with a mash clock */
+	mindiv = data->is_mash_clock ? 2 : 1;
+	maxdiv = BIT(data->int_bits) - 1;
+
+	/* TODO: Be smart, and only test a subset of the available divisors. */
+	for (curdiv = mindiv; curdiv <= maxdiv; curdiv++) {
+		unsigned long tmp_rate;
+
+		tmp_rate = clk_hw_round_rate(parent, rate * curdiv);
+		tmp_rate /= curdiv;
+		if (curdiv == mindiv ||
+		    (tmp_rate > best_rate && tmp_rate <= rate))
+			best_rate = tmp_rate;
+
+		if (best_rate == rate)
+			break;
+	}
+
+	*div = curdiv << CM_DIV_FRAC_BITS;
+	*prate = curdiv * best_rate;
+
+	return best_rate;
+}
+
 static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 					struct clk_rate_request *req)
 {
-	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct clk_hw *parent, *best_parent = NULL;
 	bool current_parent_is_pllc;
 	unsigned long rate, best_rate = 0;
@@ -1048,9 +1101,8 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 		if (bcm2835_clk_is_pllc(parent) && !current_parent_is_pllc)
 			continue;
 
-		prate = clk_hw_get_rate(parent);
-		div = bcm2835_clock_choose_div(hw, req->rate, prate, true);
-		rate = bcm2835_clock_rate_from_divisor(clock, prate, div);
+		rate = bcm2835_clock_choose_div_and_prate(hw, i, req->rate,
+							  &div, &prate);
 		if (rate > best_rate && rate <= req->rate) {
 			best_parent = parent;
 			best_prate = prate;
@@ -1262,6 +1314,13 @@ static struct clk_hw *bcm2835_register_clock(struct bcm2835_cprman *cprman,
 	init.name = data->name;
 	init.flags = data->flags | CLK_IGNORE_UNUSED;
 
+	/*
+	 * Pass the CLK_SET_RATE_PARENT flag if we are allowed to propagate
+	 * rate changes on at least of the parents.
+	 */
+	if (data->set_rate_parent)
+		init.flags |= CLK_SET_RATE_PARENT;
+
 	if (data->is_vpu_clock) {
 		init.ops = &bcm2835_vpu_clock_clk_ops;
 	} else {
-- 
2.7.4
