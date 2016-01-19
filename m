From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 19 Jan 2016 14:51:38 +0000
Subject: [RFC 7/9] clk: bcm2835: allow clock choosing mechanims to be selected
 in DT
In-Reply-To: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
References: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1453215100-2382-8-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Allow the clock choosing mechanism to be selected in the
devicetree.

There are 3 options that can get selected right now:
* BCM2835_CHOOSE_CLOCK_INTEGER
  - only integer dividers are used (fails otherwise)
* BCM2835_CHOOSE_CLOCK_CLOSEST
  - choose the clock that is closest to the target rate
* BCM2835_CHOOSE_CLOCK_INTEGER_THEN_FRAC
  - integer dividers are preferred,
    otherwise uses the clock that is closest to
    the target rate
  - this is the default implementation used

If there is a need for a different policy, then that can
get implemented and selected using this mechanism.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c       |   92 ++++++++++++++++++++++++++---------
 include/dt-bindings/clock/bcm2835.h |    6 +++
 2 files changed, 74 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 7048ca5..c381cb1 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -697,6 +697,14 @@ static const struct bcm2835_pll_divider_data bcm2835_pllh_pix_data = {
 	.fixed_divider = 10,
 };
 
+struct bcm2835_rates {
+	struct clk_hw *parent;
+	unsigned long rate;
+	unsigned long prate;
+	u32 div;
+	divmash dmash;
+};
+
 struct bcm2835_clock_data {
 	const char *name;
 
@@ -718,6 +726,12 @@ struct bcm2835_clock_data {
 	bool mash_forced;
 
 	bool is_vpu_clock;
+
+	/* the determine rate function */
+	int (*choose_clock)(struct clk_hw *hw,
+			    struct clk_rate_request *req,
+			    struct bcm2835_rates *rates,
+			    size_t rate_cnt);
 };
 
 static const char *const bcm2835_clock_per_parents[] = {
@@ -1670,14 +1684,6 @@ unlock_exit:
 	return 0;
 }
 
-struct bcm2835_rates {
-	struct clk_hw *parent;
-	unsigned long rate;
-	unsigned long prate;
-	u32 div;
-	divmash dmash;
-};
-
 static int bcm2835_clock_determine_rate_set(struct clk_rate_request *req,
 					    struct bcm2835_rates *best)
 {
@@ -1688,10 +1694,10 @@ static int bcm2835_clock_determine_rate_set(struct clk_rate_request *req,
 	return 0;
 }
 
-static int bcm2835_clock_determine_integer_rate(struct clk_hw *hw,
-						struct clk_rate_request *req,
-						struct bcm2835_rates *rates,
-						size_t rate_cnt)
+static int bcm2835_clock_choose_integer_div(struct clk_hw *hw,
+					    struct clk_rate_request *req,
+					    struct bcm2835_rates *rates,
+					    size_t rate_cnt)
 {
 	size_t i;
 
@@ -1706,10 +1712,10 @@ static int bcm2835_clock_determine_integer_rate(struct clk_hw *hw,
 	return -EINVAL;
 }
 
-static int bcm2835_clock_determine_closest_rate(struct clk_hw *hw,
-						struct clk_rate_request *req,
-						struct bcm2835_rates *rates,
-						size_t rate_cnt)
+static int bcm2835_clock_choose_closest_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req,
+					     struct bcm2835_rates *rates,
+					     size_t rate_cnt)
 {
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	const struct bcm2835_clock_data *data = clock->data;
@@ -1750,14 +1756,30 @@ static int bcm2835_clock_determine_closest_rate(struct clk_hw *hw,
 	return -EINVAL;
 }
 
+static int bcm2835_clock_choose_int_then_frac(struct clk_hw *hw,
+					      struct clk_rate_request *req,
+					      struct bcm2835_rates *rates,
+					      size_t rate_cnt)
+{
+	int err;
+
+	/* find integer rates with preference */
+	err = bcm2835_clock_choose_integer_div(hw, req, rates, rate_cnt);
+	if (!err)
+		return 0;
+
+	/* find the closest rate */
+	return bcm2835_clock_choose_closest_rate(hw, req, rates, rate_cnt);
+}
+
 static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 					struct clk_rate_request *req)
 {
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	const struct bcm2835_clock_data *data = clock->data;
 	struct bcm2835_rates rates[BIT(CM_SRC_BITS)];
 	size_t i, rate_cnt = 0;
 	divmash dm;
-	int err;
 
 	/* fill in rates */
 	for (i = 0; i < clk_hw_get_num_parents(hw); ++i) {
@@ -1774,14 +1796,12 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 		rate_cnt++;
 	}
 
-	/* find integer rates with preference */
-	err = bcm2835_clock_determine_integer_rate(hw, req, rates, rate_cnt);
-	if (!err)
-		return 0;
+	/* if we have a custom rate selection , then use that one */
+	if (data->choose_clock)
+		return data->choose_clock(hw, req, rates, rate_cnt);
 
-	/* otherwise choose the "closest" one */
-	return bcm2835_clock_determine_closest_rate(hw, req, rates,
-						    rate_cnt);
+	/* otherwise choose the "int-then-frac" one */
+	return bcm2835_clock_choose_int_then_frac(hw, req, rates, rate_cnt);
 }
 
 static int _bcm2835_clk_set_parent(struct bcm2835_cprman *cprman,
@@ -2108,6 +2128,30 @@ static const struct bcm2835_clock_data *bcm2835_register_clock_of(
 	err = of_property_read_u32(nc, "brcm,min-fract-div", &value);
 	if (!err)
 		data->min_frac_div = value << CM_DIV_FRAC_BITS;
+	/* choose alternate clock selector */
+	err = of_property_read_u32(nc, "brcm,clock-selector", &value);
+	if (!err) {
+		switch (value) {
+		case BCM2835_CHOOSE_CLOCK_DEFAULT:
+		case BCM2835_CHOOSE_CLOCK_INTEGER_THEN_FRAC:
+			data->choose_clock =
+				bcm2835_clock_choose_int_then_frac;
+			break;
+		case BCM2835_CHOOSE_CLOCK_INTEGER:
+			data->choose_clock =
+				bcm2835_clock_choose_integer_div;
+			break;
+		case BCM2835_CHOOSE_CLOCK_CLOSEST:
+			data->choose_clock =
+				bcm2835_clock_choose_closest_rate;
+			break;
+		default:
+			dev_err(dev,
+				"clock %s: undefined clock-selector: %d\n",
+				data->name, value);
+			break;
+		}
+	}
 
 	/* and return the result */
 	return data;
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index eb73380..b00880e 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -76,3 +76,9 @@
 
 #define BCM2835_MASH_INTEGER		BCM2835_MASH_NONE
 #define BCM2835_MASH_FRAC		BCM2835_MASH_ORDER_1
+
+/* the possible clock selectors */
+#define BCM2835_CHOOSE_CLOCK_DEFAULT		0
+#define BCM2835_CHOOSE_CLOCK_INTEGER		1
+#define BCM2835_CHOOSE_CLOCK_INTEGER_THEN_FRAC	2
+#define BCM2835_CHOOSE_CLOCK_CLOSEST		3
-- 
1.7.10.4
