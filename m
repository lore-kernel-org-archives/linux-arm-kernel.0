From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:02 +0000
Subject: [PATCH v5 11/20] clk: bcm2835: divider value has to be 1 or more
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-12-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Current clamping of a normal divider allows a value < 1 to be valid.

A divider of < 1 would actually only be possible if we had a PLL...

So this patch clamps the divider for non-mash clocks to 1.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 2fb9923..211d231 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -789,7 +789,9 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 		div = min_t(u32, div,
 			    (BIT(data->int_bits) - 1) << CM_DIV_FRAC_BITS);
 	} else {
-		div = max(div, unused_frac_mask + 1);
+		/* clamp to min divider of 1 */
+		div = max_t(u32, div, 1 << CM_DIV_FRAC_BITS);
+		/* clamp to the highest possible fractional divider */
 		div = min_t(u32, div,
 			    GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
 				    CM_DIV_FRAC_BITS - data->frac_bits));
-- 
1.7.10.4
