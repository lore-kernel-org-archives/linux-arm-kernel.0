From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 29 Feb 2016 11:39:20 +0000
Subject: [PATCH 4/6] clk: bcm2835: divider value has to be 1 or more
In-Reply-To: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
References: <1456745963-2403-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456745963-2403-5-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Current clamping of a normal divider allows a value < 1 to be valid.

A divider of < 1 would actually only be possible if we had a PLL...

So this patch clamps the divider to 1.

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the
audio domain clocks")

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 1fbb55d..edb1f74 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1194,8 +1194,9 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 		div += unused_frac_mask + 1;
 	div &= ~unused_frac_mask;

-	/* Clamp to the limits. */
-	div = max(div, unused_frac_mask + 1);
+	/* clamp to min divider of 1 */
+	div = max_t(u32, div, 1 << CM_DIV_FRAC_BITS);
+	/* clamp to the highest possible fractional divider */
 	div = min_t(u32, div, GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
 				      CM_DIV_FRAC_BITS - data->frac_bits));

--
1.7.10.4
