From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:37:01 +0000
Subject: [PATCH v5 10/20] clk: bcm2835: implement correct clamping for mash
 clocks
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-11-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835-soc has 2 kindes of clocks:
* normal clocks
* mash-enabled clocks that can spread frequency noise better
  into non-audiable frequency ranges

The mash clocks have distinct clock-divider requirements
and if the requested divider is not in range, then there will
no clock output.

This patch implements the clamping limits for first order
fractual mash dividers.

Only dividers that are impacted by this patch are: pcm and pwm

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 3df17a5..2fb9923 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -407,6 +407,7 @@ struct bcm2835_clock_data {
 	/* Number of fractional bits in the divider */
 	u32 frac_bits;
 
+	bool is_mash_clock;
 	bool is_vpu_clock;
 };
 
@@ -780,10 +781,19 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 		div += unused_frac_mask + 1;
 	div &= ~unused_frac_mask;
 
-	/* Clamp to the limits. */
-	div = max(div, unused_frac_mask + 1);
-	div = min_t(u32, div, GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
-				      CM_DIV_FRAC_BITS - data->frac_bits));
+	/* Clamp to the limits for the clock type */
+	if (data->is_mash_clock) {
+		/* clamp to min divider 2 */
+		div = max_t(u32, div, 2 << CM_DIV_FRAC_BITS);
+		/* clamp to max int divider */
+		div = min_t(u32, div,
+			    (BIT(data->int_bits) - 1) << CM_DIV_FRAC_BITS);
+	} else {
+		div = max(div, unused_frac_mask + 1);
+		div = min_t(u32, div,
+			    GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
+				    CM_DIV_FRAC_BITS - data->frac_bits));
+	}
 
 	return div;
 }
@@ -1512,13 +1522,15 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
 		.ctl_reg = CM_PCMCTL,
 		.div_reg = CM_PCMDIV,
 		.int_bits = 12,
-		.frac_bits = 12),
+		.frac_bits = 12,
+		.is_mash_clock = true),
 	[BCM2835_CLOCK_PWM]	= REGISTER_PER_CLK(
 		.name = "pwm",
 		.ctl_reg = CM_PWMCTL,
 		.div_reg = CM_PWMDIV,
 		.int_bits = 12,
-		.frac_bits = 12),
+		.frac_bits = 12,
+		.is_mash_clock = true),
 	[BCM2835_CLOCK_UART]	= REGISTER_PER_CLK(
 		.name = "uart",
 		.ctl_reg = CM_UARTCTL,
-- 
1.7.10.4
