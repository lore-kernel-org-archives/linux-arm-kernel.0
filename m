From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  1 Dec 2016 20:27:21 +0100
Subject: [PATCH] clk: bcm2835: Avoid overwriting the div info when disabling a
 pll_div clk
Message-ID: <1480620441-5442-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bcm2835_pll_divider_off() is resetting the divider field in the A2W reg
to zero when disabling the clock.

Make sure we preserve this value by reading the previous a2w_reg value
first and ORing the result with A2W_PLL_CHANNEL_DISABLE.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
Cc: <stable@vger.kernel.org>
---
 drivers/clk/bcm/clk-bcm2835.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 836d07550be3..2acaa77ad482 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -751,7 +751,9 @@ static void bcm2835_pll_divider_off(struct clk_hw *hw)
 	cprman_write(cprman, data->cm_reg,
 		     (cprman_read(cprman, data->cm_reg) &
 		      ~data->load_mask) | data->hold_mask);
-	cprman_write(cprman, data->a2w_reg, A2W_PLL_CHANNEL_DISABLE);
+	cprman_write(cprman, data->a2w_reg,
+		     cprman_read(cprman, data->a2w_reg) |
+		     A2W_PLL_CHANNEL_DISABLE);
 	spin_unlock(&cprman->regs_lock);
 }
 
-- 
2.7.4
