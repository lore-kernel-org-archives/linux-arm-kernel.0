From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 19 Jan 2016 14:51:37 +0000
Subject: [RFC 6/9] clk: bcm2835: allow to define a minimum fractional divider
 in DT
In-Reply-To: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
References: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1453215100-2382-7-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Allow to define a minimum fractional divider to use
in the devicetree.

This is primarily used to reduce clock-jitter introduced
by the fractional/MASH divider.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index e5313ba..7048ca5 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -711,6 +711,8 @@ struct bcm2835_clock_data {
 	u32 int_bits;
 	/* Number of fractional bits in the divider */
 	u32 frac_bits;
+	/* the minimum divider to allow when fractional */
+	u32 min_frac_div;
 	/* the mash value to use - see CM_MASH */
 	enum bcm2835_clock_mash_type mash;
 	bool mash_forced;
@@ -1709,13 +1711,21 @@ static int bcm2835_clock_determine_closest_rate(struct clk_hw *hw,
 						struct bcm2835_rates *rates,
 						size_t rate_cnt)
 {
+	struct bcm2835_clock *clock = bcm2835_clock_from_hw(hw);
+	const struct bcm2835_clock_data *data = clock->data;
 	struct bcm2835_rates *best = NULL;
 	size_t i;
 
 	/* find best matching */
 	for (i = 0; i < rate_cnt; i++) {
+		/* do not look@anything above the requested rate */
 		if (rates[i].rate > req->rate)
 			continue;
+		/* if we have a divider that is not "safe", then ignore */
+		if (divmash_get_divf(rates[i].dmash) &&
+		    (rates[i].div < data->min_frac_div))
+			continue;
+		/* if we are the first */
 		if (!best) {
 			best = &rates[i];
 			continue;
@@ -2094,6 +2104,10 @@ static const struct bcm2835_clock_data *bcm2835_register_clock_of(
 			break;
 		}
 	}
+	/* add support for min fractional divider */
+	err = of_property_read_u32(nc, "brcm,min-fract-div", &value);
+	if (!err)
+		data->min_frac_div = value << CM_DIV_FRAC_BITS;
 
 	/* and return the result */
 	return data;
-- 
1.7.10.4
