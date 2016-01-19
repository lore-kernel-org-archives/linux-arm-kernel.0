From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Tue, 19 Jan 2016 14:51:36 +0000
Subject: [RFC 5/9] clk: bcm2835: prefer clocks that use integer dividers
In-Reply-To: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
References: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1453215100-2382-6-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

To reduce possible jitter prefer integer dividers over
fractional dividers.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index f1ab525..e5313ba 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1686,6 +1686,24 @@ static int bcm2835_clock_determine_rate_set(struct clk_rate_request *req,
 	return 0;
 }
 
+static int bcm2835_clock_determine_integer_rate(struct clk_hw *hw,
+						struct clk_rate_request *req,
+						struct bcm2835_rates *rates,
+						size_t rate_cnt)
+{
+	size_t i;
+
+	/* find first matching */
+	for (i = 0; i < rate_cnt; i++) {
+		if (!divmash_get_divf(rates[i].dmash))
+			return bcm2835_clock_determine_rate_set(req,
+								&rates[i]);
+	}
+
+	/* nothing found */
+	return -EINVAL;
+}
+
 static int bcm2835_clock_determine_closest_rate(struct clk_hw *hw,
 						struct clk_rate_request *req,
 						struct bcm2835_rates *rates,
@@ -1729,6 +1747,7 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 	struct bcm2835_rates rates[BIT(CM_SRC_BITS)];
 	size_t i, rate_cnt = 0;
 	divmash dm;
+	int err;
 
 	/* fill in rates */
 	for (i = 0; i < clk_hw_get_num_parents(hw); ++i) {
@@ -1745,7 +1764,12 @@ static int bcm2835_clock_determine_rate(struct clk_hw *hw,
 		rate_cnt++;
 	}
 
-	/* choose the "closest" one */
+	/* find integer rates with preference */
+	err = bcm2835_clock_determine_integer_rate(hw, req, rates, rate_cnt);
+	if (!err)
+		return 0;
+
+	/* otherwise choose the "closest" one */
 	return bcm2835_clock_determine_closest_rate(hw, req, rates,
 						    rate_cnt);
 }
-- 
1.7.10.4
