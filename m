From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 15 Jan 2016 14:21:05 +0000
Subject: [PATCH V4 6/7] clk: bcm2835: enable fractional and mash support
In-Reply-To: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452867667-2447-7-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The clk-bcm2835 driver right now does the correct calculation
of the fractional clock divider, but it does not set the FRAC
bit.

This patch enables FRAC for all clocks with frac_bits > 0
but allows to define the selection of a higher-order MASH
support instead of just FRAC by assigning .mash in the
clock description structure.

Right now there are no limits imposed on maximum frequencies
or additional restrictions on min/max divider when MASH/FRAC
is enabled and used.

The way that implementation is done the top 8 bits of the divider
are used to signify the mash level used for this divider.
This has been wrapped in a new type mashtype with some helper
functions that allows extraction of the divider information.
typedef is used to minimize the amount of change.
(note also that the top 8 bit are not used by the clock registers
besides requireing some magic when setting the register)

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |  111 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 104 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 1640288..545c21a 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -51,6 +51,7 @@
 #define CM_GNRICCTL		0x000
 #define CM_GNRICDIV		0x004
 # define CM_DIV_FRAC_BITS	12
+# define CM_DIV_INT_BITS	12

 #define CM_VPUCTL		0x008
 #define CM_VPUDIV		0x00c
@@ -130,6 +131,10 @@
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
@@ -296,6 +301,63 @@
 #define LOCK_TIMEOUT_NS		100000000
 #define BCM2835_MAX_FB_RATE	1750000000u

+enum bcm2835_clock_mash_type {
+	MASH_NONE = 0,
+	MASH_FRAC = 1,
+	MASH_2ND_ORDER = 2,
+	MASH_3RD_ORDER = 3
+};
+
+/*
+ * mashdiv - Helper type packed in u32 that contains
+ *   integer divider (bits 12-23)
+ *   integer divider (bits 11-0)
+ *   mash type       (bits 25-24)
+ * this also includes some helperfunctions to calc the compound u32
+ * as well as extracting the individual data from the compound u32.
+ */
+typedef u32 divmash;
+
+/* define the lowes/highest bits for a field and masks */
+#define DIVMASH_DIVF_LO_BIT 0
+#define DIVMASH_DIVF_HI_BIT (CM_DIV_FRAC_BITS - 1)
+#define DIVMASH_DIVF_MASK GENMASK(DIVMASH_DIVF_HI_BIT, DIVMASH_DIVF_LO_BIT)
+#define DIVMASH_DIVI_LO_BIT (DIVMASH_DIVF_HI_BIT + 1)
+#define DIVMASH_DIVI_HI_BIT (CM_DIV_INT_BITS + CM_DIV_FRAC_BITS - 1)
+#define DIVMASH_DIVI_MASK GENMASK(DIVMASH_DIVI_HI_BIT, DIVMASH_DIVI_LO_BIT)
+#define DIVMASH_DIV_LO_BIT DIVMASH_DIVF_LO_BIT
+#define DIVMASH_DIV_MASK (DIVMASH_DIVI_MASK | DIVMASH_DIVF_MASK)
+#define DIVMASH_MASH_LO_BIT (DIVMASH_DIVI_HI_BIT + 1)
+#define DIVMASH_MASH_HI_BIT (DIVMASH_MASH_LO_BIT + 1)
+#define DIVMASH_MASH_MASK GENMASK(DIVMASH_MASH_HI_BIT, DIVMASH_MASH_LO_BIT)
+
+static inline divmash divmash_calc(enum bcm2835_clock_mash_type mash,
+				   u32 div)
+{
+	return ((div << DIVMASH_DIV_LO_BIT)   & DIVMASH_DIV_MASK) |
+	       ((mash << DIVMASH_MASH_LO_BIT) & DIVMASH_MASH_MASK);
+}
+
+static inline enum bcm2835_clock_mash_type divmash_get_mash(divmash dm)
+{
+	return (dm & DIVMASH_MASH_MASK) >> DIVMASH_MASH_LO_BIT;
+}
+
+static inline u32 divmash_get_div(divmash dm)
+{
+	return (dm & DIVMASH_DIV_MASK) >> DIVMASH_DIV_LO_BIT;
+}
+
+static inline u32 divmash_get_divi(divmash dm)
+{
+	return (dm & DIVMASH_DIVI_MASK) >> DIVMASH_DIVI_LO_BIT;
+}
+
+static inline u32 divmash_get_divf(divmash dm)
+{
+	return (dm & DIVMASH_DIVF_MASK) >> DIVMASH_DIVF_LO_BIT;
+}
+
 struct bcm2835_cprman {
 	struct device *dev;
 	void __iomem *regs;
@@ -647,6 +709,8 @@ struct bcm2835_clock_data {
 	u32 int_bits;
 	/* Number of fractional bits in the divider */
 	u32 frac_bits;
+	/* the mash value to use - see CM_MASH */
+	enum bcm2835_clock_mash_type mash;

 	bool is_vpu_clock;
 };
@@ -1413,16 +1477,17 @@ static int bcm2835_clock_is_on(struct clk_hw *hw)
 	return (cprman_read(cprman, data->ctl_reg) & CM_ENABLE) != 0;
 }

-static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
-				    unsigned long rate,
-				    unsigned long parent_rate,
-				    bool round_up)
+static divmash bcm2835_clock_choose_div(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate,
+					bool round_up)
 {
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	const struct bcm2835_clock_data *data = clock->data;
 	u32 unused_frac_mask =
 		GENMASK(CM_DIV_FRAC_BITS - data->frac_bits, 0) >> 1;
 	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
+	enum bcm2835_clock_mash_type mash = MASH_NONE;
 	u64 rem;
 	u32 div;

@@ -1443,7 +1508,11 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 	div = min_t(u32, div, GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
 				      CM_DIV_FRAC_BITS));

-	return div;
+	/* set mash if necessary */
+	if (data->frac_bits && (div & GENMASK(CM_DIV_FRAC_BITS - 1, 0)))
+		mash = data->mash ? data->mash : MASH_FRAC;
+
+	return divmash_calc(mash, div);
 }

 static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
@@ -1534,10 +1603,36 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
-	u32 div = bcm2835_clock_choose_div(hw, rate, parent_rate, false);
+	divmash dm = bcm2835_clock_choose_div(hw, rate, parent_rate, false);
+	u32 div = divmash_get_div(dm);
+	enum bcm2835_clock_mash_type mash = divmash_get_mash(dm);
+	u32 ctl;
+
+	spin_lock(&cprman->regs_lock);

+	/* if div and mash are identical, then there is nothing to do */
+	ctl = cprman_read(cprman, data->ctl_reg);
+	if ((div == cprman_read(cprman, data->div_reg)) &&
+	    (CM_MASH(mash) == (ctl & CM_MASH_MASK)))
+		goto unlock_exit;
+
+	/*
+	 * Setting up mash type
+	 *
+	 * In principle it is recommended to stop/start the clock first,
+	 * but as we set CLK_SET_RATE_GATE during registration of the
+	 * clock this requirement should be take care of by the
+	 * clk-framework.
+	 */
+	cprman_write(cprman, data->ctl_reg,
+		     (ctl & ~CM_MASH_MASK) | CM_MASH(mash));
+
+	/* and set div */
 	cprman_write(cprman, data->div_reg, div);

+unlock_exit:
+	spin_unlock(&cprman->regs_lock);
+
 	return 0;
 }

@@ -1549,6 +1644,7 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 	unsigned long rate, best_rate = 0;
 	unsigned long prate, best_prate = 0;
 	size_t i;
+	divmash dm;
 	u32 div;

 	/*
@@ -1559,7 +1655,8 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 		if (!parent)
 			continue;
 		prate = clk_hw_get_rate(parent);
-		div = bcm2835_clock_choose_div(hw, req->rate, prate, true);
+		dm = bcm2835_clock_choose_div(hw, req->rate, prate, true);
+		div = divmash_get_div(dm);
 		rate = bcm2835_clock_rate_from_divisor(clock, prate, div);
 		if (rate > best_rate && rate <= req->rate) {
 			best_parent = parent;
--
1.7.10.4
