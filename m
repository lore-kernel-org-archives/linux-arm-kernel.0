From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Thu, 14 Jan 2016 13:45:38 +0000
Subject: [PATCH V3 3/6] clk: bcm2835: enable fractional and mash support
In-Reply-To: <1452779142-20615-1-git-send-email-kernel@martin.sperl.org>
References: <1452779142-20615-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452779142-20615-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The clk-bcm2835 driver right now does the correct calculation
of the fractional clock divider, but it does not set the FRAC
bit.

This patch enables FRAC for all clocks with frac_bits > 0
but allows to define the selection of a higher-order MASH
support instead of just FRAC.

Right now there are no limits imposed on maximum frequencies
when using MASH/FRAC is enabled.

We also implement all the documented limitations for
MASH=2/3 with regards to Divider upper/lower limits
(switching to a lower "MASH-level" if needed).

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |  122 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 12 deletions(-)

Changelog:
	V1->V2: added this patch
	V2->V3: added checks on limits defined for mash

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 3d6490f..f5d483e 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -51,6 +51,7 @@
 #define CM_GNRICCTL		0x000
 #define CM_GNRICDIV		0x004
 # define CM_DIV_FRAC_BITS	12
+# define CM_DIV_INT_BITS	12

 #define CM_VPUCTL		0x008
 #define CM_VPUDIV		0x00c
@@ -115,6 +116,10 @@
 # define CM_GATE			BIT(CM_GATE_BIT)
 # define CM_BUSY			BIT(7)
 # define CM_BUSYD			BIT(8)
+# define CM_MASH_BITS			2
+# define CM_MASH_SHIFT			9
+# define CM_MASH_MASK			GENMASK(10, 9)
+# define CM_MASH(v)			((v << CM_MASH_SHIFT) & CM_MASH_MASK)
 # define CM_SRC_SHIFT			0
 # define CM_SRC_BITS			4
 # define CM_SRC_MASK			0xf
@@ -281,6 +286,42 @@
 #define LOCK_TIMEOUT_NS		100000000
 #define BCM2835_MAX_FB_RATE	1750000000u

+enum bcm2835_clock_mash_type {
+	MASH_NONE = 0,
+	MASH_FRAC = 1,
+	MASH_2ND_ORDER = 2,
+	MASH_3RD_ORDER = 3
+};
+
+/* Helpers for Mash support */
+#define BCM2835_MASH_MAX_FREQ	25000000u
+#define DIVMASH_OFFSET (CM_DIV_INT_BITS + CM_DIV_FRAC_BITS)
+static inline u32 divmash_calc(enum bcm2835_clock_mash_type mash, u32 div)
+{
+	return div | (mash << DIVMASH_OFFSET);
+}
+
+static inline enum bcm2835_clock_mash_type divmash_get_mash(u32 divmash)
+{
+	return (divmash >> DIVMASH_OFFSET);
+}
+
+static inline u32 divmash_get_div(u32 divmash)
+{
+	return (divmash & GENMASK(DIVMASH_OFFSET - 1, 0));
+}
+
+static inline u32 divmash_get_divi(u32 divmash)
+{
+	return (divmash >> CM_DIV_FRAC_BITS) &
+	       GENMASK(CM_DIV_INT_BITS - 1, 0);
+}
+
+static inline u32 divmash_get_divf(u32 divmash)
+{
+	return divmash & GENMASK(CM_DIV_FRAC_BITS - 1, 0);
+}
+
 struct bcm2835_cprman {
 	struct device *dev;
 	void __iomem *regs;
@@ -632,6 +673,8 @@ struct bcm2835_clock_data {
 	u32 int_bits;
 	/* Number of fractional bits in the divider */
 	u32 frac_bits;
+	/* the mash value to use - see CM_MASH */
+	enum bcm2835_clock_mash_type mash;

 	bool is_vpu_clock;
 };
@@ -1167,26 +1210,61 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 		GENMASK(CM_DIV_FRAC_BITS - data->frac_bits, 0) >> 1;
 	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
 	u64 rem;
-	u32 div;
+	u32 div, divi, divf;
+	const u32 divi_max = BIT(data->int_bits) - 1;
+	const u32 divi_min = 2;

 	rem = do_div(temp, rate);
 	div = temp;
+	divi = divmash_get_divi(div);
+	divf = divmash_get_divf(div);

 	/* Round up and mask off the unused bits */
 	if (round_up && ((div & unused_frac_mask) != 0 || rem != 0))
 		div += unused_frac_mask + 1;
 	div &= ~unused_frac_mask;

-	/* Clamp to the limits. */
+	/*
+	 * Check if we are within bounds for fractional/MASH dividers
+	 * For offset values see Table 6-32 in BCM2835-ARM-Peripherials
+	 * as well as the errata at:
+	 *   http://elinux.org/BCM2835_datasheet_errata#p105_table
+	 */
+	if (divf) {
+		switch (data->mash) {
+		case MASH_3RD_ORDER:
+			if ((divi - 3 >= divi_min) &&
+			    (divi + 4 <= divi_max) &&
+			    (parent_rate / (divi - 3) <=
+				    BCM2835_MASH_MAX_FREQ))
+				return divmash_calc(MASH_3RD_ORDER, div);
+			/* fall tru */
+		case MASH_2ND_ORDER:
+			if ((divi - 1 >= divi_min) &&
+			    (divi + 2 <= divi_max) &&
+			    (parent_rate / (divi - 1) <=
+				    BCM2835_MASH_MAX_FREQ))
+				return divmash_calc(MASH_2ND_ORDER, div);
+			/* fall tru */
+		case MASH_FRAC:
+			if ((divi >= divi_min) &&
+			    (divi + 1 <= divi_max))
+				return divmash_calc(MASH_FRAC, div);
+			/* fall tru to integer case */
+		case MASH_NONE:
+			break;
+		}
+	}
+	/* the non-frac case or frac out of bound case */

-	/* divider must be >= 2 */
-	div = max_t(u32, div, (2 << CM_DIV_FRAC_BITS));
+	/* must be <= max possible integer divider for this clock */
+	divi = min_t(u32, divi_max, divi);

-	/* clamp to max divider allowed - max is integer divider */
-	div = min_t(u32, div, GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
-				      CM_DIV_FRAC_BITS));
+	/* minimum divider is 2 */
+	divi = max_t(u32, 2, divi);

-	return div;
+	/* return the divmash value based only on divi */
+	return divmash_calc(MASH_NONE, divi << CM_DIV_FRAC_BITS);
 }

 static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
@@ -1277,10 +1355,28 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
-	u32 div = bcm2835_clock_choose_div(hw, rate, parent_rate, false);
+	u32 divmash = bcm2835_clock_choose_div(hw, rate, parent_rate, false);
+	enum bcm2835_clock_mash_type mash = divmash_get_mash(divmash);
+	u32 div = divmash_get_div(divmash);
+	u32 ctl;
+
+	spin_lock(&cprman->regs_lock);
+	/* check if divider is identical, then return */
+	if (div == cprman_read(cprman, data->div_reg))
+		goto unlock;

+	/* set the divider */
 	cprman_write(cprman, data->div_reg, div);

+	/* set mash to the selected value */
+	ctl = cprman_read(cprman, data->ctl_reg);
+	ctl &= ~CM_MASH_MASK;
+	ctl |= CM_MASH(mash) & CM_MASH_MASK;
+	cprman_write(cprman, data->ctl_reg, ctl);
+
+unlock:
+	spin_unlock(&cprman->regs_lock);
+
 	return 0;
 }

@@ -1292,7 +1388,7 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 	unsigned long rate, best_rate = 0;
 	unsigned long prate, best_prate = 0;
 	size_t i;
-	u32 div;
+	u32 divmash, div;

 	/*
 	 * Select parent clock that results in the closest but lower rate
@@ -1302,8 +1398,10 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 		if (!parent)
 			continue;
 		prate = clk_hw_get_rate(parent);
-		div = bcm2835_clock_choose_div(hw, req->rate, prate, true);
-		rate = bcm2835_clock_rate_from_divisor(clock, prate, div);
+		divmash = bcm2835_clock_choose_div(hw, req->rate, prate,
+						   true);
+		div = divmash_get_div(divmash);
+		rate = bcm2835_clock_rate_from_divisor(clock, prate, divmash);
 		if (rate > best_rate && rate <= req->rate) {
 			best_parent = parent;
 			best_prate = prate;
--
1.7.10.4
