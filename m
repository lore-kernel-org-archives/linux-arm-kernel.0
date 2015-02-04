From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed,  4 Feb 2015 15:20:14 +0100
Subject: [PATCH] clk: at91: usb: propagate rate modification to the parent clk
Message-ID: <1423059614-10450-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91sam9n12 and at91sam9x5 usb clocks do not propagate rate
modification requests to their parents.
This causes a bug when the PLLB is left uninitialized by the bootloader
(PLL multiplier set to 0, or in other words, PLL rate = 0 Hz).

Implement the determinate_rate method and propagate the change rate
request to the parent clk.

Cc: <stable@vger.kernel.org> # v3.14+
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Bo Shen <voice.shen@atmel.com>
Tested-by: Bo Shen <voice.shen@atmel.com>
---
Hi Mike,

I haven't taken Tomeu's rework of the determine_rate prototype [1] into
account in this patch, but will do once his patch series is accepted.

Best Regards,

Boris

[1] https://lkml.org/lkml/2015/1/23/222

 drivers/clk/at91/clk-usb.c | 62 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/at91/clk-usb.c b/drivers/clk/at91/clk-usb.c
index a23ac0c..0283a57 100644
--- a/drivers/clk/at91/clk-usb.c
+++ b/drivers/clk/at91/clk-usb.c
@@ -56,22 +56,53 @@ static unsigned long at91sam9x5_clk_usb_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_CLOSEST(parent_rate, (usbdiv + 1));
 }
 
-static long at91sam9x5_clk_usb_round_rate(struct clk_hw *hw, unsigned long rate,
-					  unsigned long *parent_rate)
+static long at91sam9x5_clk_usb_determine_rate(struct clk_hw *hw,
+					      unsigned long rate,
+					      unsigned long *best_parent_rate,
+					      struct clk_hw **best_parent_hw)
 {
-	unsigned long div;
+	struct clk *parent = NULL;
+	long best_rate = -EINVAL;
+	unsigned long tmp_rate;
+	int best_diff = -1;
+	int tmp_diff;
+	int i;
 
-	if (!rate)
-		return -EINVAL;
+	for (i = 0; i < __clk_get_num_parents(hw->clk); i++) {
+		int div;
 
-	if (rate >= *parent_rate)
-		return *parent_rate;
+		parent = clk_get_parent_by_index(hw->clk, i);
+		if (!parent)
+			continue;
+
+		for (div = 1; div < SAM9X5_USB_MAX_DIV + 2; div++) {
+			unsigned long tmp_parent_rate;
+
+			tmp_parent_rate = rate * div;
+			tmp_parent_rate = __clk_round_rate(parent,
+							   tmp_parent_rate);
+			tmp_rate = DIV_ROUND_CLOSEST(tmp_parent_rate, div);
+			if (tmp_rate < rate)
+				tmp_diff = rate - tmp_rate;
+			else
+				tmp_diff = tmp_rate - rate;
+
+			if (best_diff < 0 || best_diff > tmp_diff) {
+				best_rate = tmp_rate;
+				best_diff = tmp_diff;
+				*best_parent_rate = tmp_parent_rate;
+				*best_parent_hw = __clk_get_hw(parent);
+			}
+
+			if (!best_diff || tmp_rate < rate)
+				break;
+		}
 
-	div = DIV_ROUND_CLOSEST(*parent_rate, rate);
-	if (div > SAM9X5_USB_MAX_DIV + 1)
-		div = SAM9X5_USB_MAX_DIV + 1;
+		if (!best_diff)
+			break;
+	}
 
-	return DIV_ROUND_CLOSEST(*parent_rate, div);
+	return best_rate;
 }
 
 static int at91sam9x5_clk_usb_set_parent(struct clk_hw *hw, u8 index)
@@ -121,7 +152,7 @@ static int at91sam9x5_clk_usb_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops at91sam9x5_usb_ops = {
 	.recalc_rate = at91sam9x5_clk_usb_recalc_rate,
-	.round_rate = at91sam9x5_clk_usb_round_rate,
+	.determine_rate = at91sam9x5_clk_usb_determine_rate,
 	.get_parent = at91sam9x5_clk_usb_get_parent,
 	.set_parent = at91sam9x5_clk_usb_set_parent,
 	.set_rate = at91sam9x5_clk_usb_set_rate,
@@ -159,7 +190,7 @@ static const struct clk_ops at91sam9n12_usb_ops = {
 	.disable = at91sam9n12_clk_usb_disable,
 	.is_enabled = at91sam9n12_clk_usb_is_enabled,
 	.recalc_rate = at91sam9x5_clk_usb_recalc_rate,
-	.round_rate = at91sam9x5_clk_usb_round_rate,
+	.determine_rate = at91sam9x5_clk_usb_determine_rate,
 	.set_rate = at91sam9x5_clk_usb_set_rate,
 };
 
@@ -179,7 +210,8 @@ at91sam9x5_clk_register_usb(struct at91_pmc *pmc, const char *name,
 	init.ops = &at91sam9x5_usb_ops;
 	init.parent_names = parent_names;
 	init.num_parents = num_parents;
-	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE;
+	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
+		     CLK_SET_RATE_PARENT;
 
 	usb->hw.init = &init;
 	usb->pmc = pmc;
@@ -207,7 +239,7 @@ at91sam9n12_clk_register_usb(struct at91_pmc *pmc, const char *name,
 	init.ops = &at91sam9n12_usb_ops;
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
-	init.flags = CLK_SET_RATE_GATE;
+	init.flags = CLK_SET_RATE_GATE | CLK_SET_RATE_PARENT;
 
 	usb->hw.init = &init;
 	usb->pmc = pmc;
-- 
1.9.1
