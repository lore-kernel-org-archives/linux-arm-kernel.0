From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 11:39:21 +0000
Subject: [PATCH 5/6] clk: bcm2835: correctly enable fractional clock support
In-Reply-To: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456745963-2403-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The current driver calculates the clock divider with
fractional support enabled.

But it does not enable fractional support in the
control register itself resulting in an integer only divider,
but in clk_set_rate responds back the fractionally divided
clock frequency.

This patch enables fractional support in the control register
whenever there is a fractional bit set in the requested clock divider.

Mash clock limits are are also handled for the PWM clock
applying the correct divider limits (2 and max_int) applicable to
basic fractional divider support (mash order of 1).

It also adds locking to protect the read/modify/write cycle of
the register modification.

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the
audio domain clocks")

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   45 +++++++++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index edb1f74..da77069 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -52,6 +52,7 @@
 #define CM_GNRICCTL		0x000
 #define CM_GNRICDIV		0x004
 # define CM_DIV_FRAC_BITS	12
+# define CM_DIV_FRAC_MASK	GENMASK(CM_DIV_FRAC_BITS - 1, 0)

 #define CM_VPUCTL		0x008
 #define CM_VPUDIV		0x00c
@@ -129,6 +130,7 @@
 # define CM_GATE			BIT(CM_GATE_BIT)
 # define CM_BUSY			BIT(7)
 # define CM_BUSYD			BIT(8)
+# define CM_FRAC			BIT(9)
 # define CM_SRC_SHIFT			0
 # define CM_SRC_BITS			4
 # define CM_SRC_MASK			0xf
@@ -648,6 +650,7 @@ struct bcm2835_clock_data {
 	u32 frac_bits;

 	bool is_vpu_clock;
+	bool is_mash_clock;
 };

 static const char *const bcm2835_clock_per_parents[] = {
@@ -829,6 +832,7 @@ static const struct bcm2835_clock_data bcm2835_clock_pwm_data = {
 	.div_reg = CM_PWMDIV,
 	.int_bits = 12,
 	.frac_bits = 12,
+	.is_mash_clock = true,
 };

 struct bcm2835_pll {
@@ -1184,7 +1188,7 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 		GENMASK(CM_DIV_FRAC_BITS - data->frac_bits, 0) >> 1;
 	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
 	u64 rem;
-	u32 div;
+	u32 div, mindiv, maxdiv;

 	rem = do_div(temp, rate);
 	div = temp;
@@ -1194,11 +1198,23 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 		div += unused_frac_mask + 1;
 	div &= ~unused_frac_mask;

-	/* clamp to min divider of 1 */
-	div = max_t(u32, div, 1 << CM_DIV_FRAC_BITS);
-	/* clamp to the highest possible fractional divider */
-	div = min_t(u32, div, GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
-				      CM_DIV_FRAC_BITS - data->frac_bits));
+	/* different clamping limits apply for a mash clock */
+	if (data->is_mash_clock) {
+		/* clamp to min divider of 2 */
+		mindiv = 2 << CM_DIV_FRAC_BITS;
+		/* clamp to the highest possible integer divider */
+		maxdiv = (BIT(data->int_bits) - 1) << CM_DIV_FRAC_BITS;
+	} else {
+		/* clamp to min divider of 1 */
+		mindiv = 1 << CM_DIV_FRAC_BITS;
+		/* clamp to the highest possible fractional divider */
+		maxdiv = GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
+				 CM_DIV_FRAC_BITS - data->frac_bits);
+	}
+
+	/* apply the clamping  limits */
+	div = max_t(u32, div, mindiv);
+	div = min_t(u32, div, maxdiv);

 	return div;
 }
@@ -1292,9 +1308,26 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
 	u32 div = bcm2835_clock_choose_div(hw, rate, parent_rate, false);
+	u32 ctl;
+
+	spin_lock(&cprman->regs_lock);
+
+	/*
+	 * Setting up frac support
+	 *
+	 * In principle it is recommended to stop/start the clock first,
+	 * but as we set CLK_SET_RATE_GATE during registration of the
+	 * clock this requirement should be take care of by the
+	 * clk-framework.
+	 */
+	ctl = cprman_read(cprman, data->ctl_reg) & ~CM_FRAC;
+	ctl |= (div & CM_DIV_FRAC_MASK) ? CM_FRAC : 0;
+	cprman_write(cprman, data->ctl_reg, ctl);

 	cprman_write(cprman, data->div_reg, div);

+	spin_unlock(&cprman->regs_lock);
+
 	return 0;
 }

--
1.7.10.4
