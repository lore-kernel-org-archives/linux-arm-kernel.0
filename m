From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 15 Jan 2016 14:21:06 +0000
Subject: [PATCH V4 7/7] clk: bcm2835: apply limits on dividers to MASH mode.
In-Reply-To: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452867667-2447-8-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

There are several limits on the divider as well as effective frequency
that apply when a fractional divider with higher order MASH is used.

This patch applies all the information about limits that is available
at this time and all of which has been tested empirically by
Mathias Reichl using primarily the pcm clock.

The patch tries to use the "highest" order of MASH support and when it
fails it reduces MASH order and retries the test - fall back all the way
to integer divide if necessary, where "normal" clamping of limits
happens.

Note that http://www.aholme.co.uk/Frac2/Mash.htm
contains a description of MASH, the author - allegedly - was
working for Broadcom at that time.

Suggested-by: Mathias Reichl <hias@horus.com>
Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   52 ++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 545c21a..637f8ae 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -300,6 +300,7 @@

 #define LOCK_TIMEOUT_NS		100000000
 #define BCM2835_MAX_FB_RATE	1750000000u
+#define BCM2835_MASH_MAX_FREQ	25000000u

 enum bcm2835_clock_mash_type {
 	MASH_NONE = 0,
@@ -1489,7 +1490,9 @@ static divmash bcm2835_clock_choose_div(struct clk_hw *hw,
 	u64 temp = (u64)parent_rate << CM_DIV_FRAC_BITS;
 	enum bcm2835_clock_mash_type mash = MASH_NONE;
 	u64 rem;
-	u32 div;
+	u32 div, divi, divf;
+	const u32 divi_max = BIT(data->int_bits) - 1;
+	const u32 divi_min = 2;

 	rem = do_div(temp, rate);
 	div = temp;
@@ -1499,20 +1502,47 @@ static divmash bcm2835_clock_choose_div(struct clk_hw *hw,
 		div += unused_frac_mask + 1;
 	div &= ~unused_frac_mask;

-	/* Clamp to the limits. */
+	divi = div >> CM_DIV_FRAC_BITS;
+	divf = div & GENMASK(CM_DIV_FRAC_BITS - 1, 0);

-	/* divider must be >= 2 */
-	div = max_t(u32, div, (2 << CM_DIV_FRAC_BITS));
+	/* select mash mode */
+	if (data->frac_bits && divf)
+		mash = data->mash ? data->mash : MASH_FRAC;

-	/* clamp to max divider allowed - max is integer divider */
-	div = min_t(u32, div, GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
-				      CM_DIV_FRAC_BITS));
+	/*
+	 * handle possible limits for different mash levels with fall-tru
+	 * For offset values see page 105 table 6-32 in
+	 * BCM2835-ARM-Peripherials as well as the errata at:
+	 *   http://elinux.org/BCM2835_datasheet_errata#p105_table
+	 */
+	switch (mash) {
+	case MASH_3RD_ORDER:
+		if ((divi >= divi_min + 3) &&
+		    (divi + 4 <= divi_max) &&
+		    (parent_rate / (divi - 3) <= BCM2835_MASH_MAX_FREQ))
+			return divmash_calc(MASH_3RD_ORDER, div);
+		/* fall tru if not in bounds */
+	case MASH_2ND_ORDER:
+		if ((divi >= divi_min + 1) &&
+		    (divi + 2 <= divi_max) &&
+		    (parent_rate / (divi - 1) <= BCM2835_MASH_MAX_FREQ))
+			return divmash_calc(MASH_2ND_ORDER, div);
+		/* fall tru if not in bounds */
+	case MASH_FRAC:
+		if ((divi >= divi_min) &&
+		    (divi + 1 <= divi_max))
+			return divmash_calc(MASH_FRAC, div);
+		/* fall tru if not in bounds */
+	case MASH_NONE:
+	default:
+		break;
+	}

-	/* set mash if necessary */
-	if (data->frac_bits && (div & GENMASK(CM_DIV_FRAC_BITS - 1, 0)))
-		mash = data->mash ? data->mash : MASH_FRAC;
+	/* we apply standard clamping based on divi alone */
+	divi = max(divi, divi_min);
+	divi = min(divi, divi_max);

-	return divmash_calc(mash, div);
+	return divmash_calc(MASH_NONE, divi << CM_DIV_FRAC_BITS);
 }

 static long bcm2835_clock_rate_from_divisor(struct bcm2835_clock *clock,
--
1.7.10.4
