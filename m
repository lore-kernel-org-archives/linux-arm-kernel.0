From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 15 Jan 2016 14:21:00 +0000
Subject: [PATCH V4 1/7] clk: bcm2835: the minimum clock divider is 2
In-Reply-To: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
References: <1452867667-2447-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452867667-2447-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Testing with different clock divider values has shown
that (at least for the PCM clock) the clock divider
has to be at least 2, otherwise the clock will not
output a signal.

So the clamping has changed from 1 to 2 and comments
about the kind of clamping applied have been added.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 015e687..10e97b7 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1178,7 +1178,11 @@ static u32 bcm2835_clock_choose_div(struct clk_hw *hw,
 	div &= ~unused_frac_mask;
 
 	/* Clamp to the limits. */
-	div = max(div, unused_frac_mask + 1);
+
+	/* divider must be >= 2 */
+	div = max_t(u32, div, (2 << CM_DIV_FRAC_BITS));
+
+	/* clamp to max divider allowed */
 	div = min_t(u32, div, GENMASK(data->int_bits + CM_DIV_FRAC_BITS - 1,
 				      CM_DIV_FRAC_BITS - data->frac_bits));
 
-- 
1.7.10.4
