From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 15 Jan 2016 14:21:01 +0000
Subject: [PATCH V4 2/7] clk: bcm2835: clamp clock divider to highest integer
 only
In-Reply-To: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452867667-2447-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The clock divider calculation right now clamps the
divider to the highest possible fractional divider.
So typically (BIT(div_int_bits) - 1) + 4095 / 4096.

As the fractional clock divider is alterating between
(Fosc / div_int) and (Fosc / (div_int + 1))
the divider will overflow for the (div_int + 1) case.
As with the "underflow" case we have seen for (div < 2),
we can assume that the same applies on the upper limit
as well.

So this patch will instead clamp to the divider to the
max of (BIT(div_int_bits) - 1)

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 10e97b7..3d6490f 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1182,9 +1182,9 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 	/* divider must be >= 2 */
 	div = max_t(u32, div, (2 << CM_DIV_FRAC_BITS));
 
-	/* clamp to max divider allowed */
+	/* clamp to max divider allowed - max is integer divider */
 	div = min_t(u32, div, GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
-				      CM_DIV_FRAC_BITS - data->frac_bits));
+				      CM_DIV_FRAC_BITS));
 
 	return div;
 }
-- 
1.7.10.4
