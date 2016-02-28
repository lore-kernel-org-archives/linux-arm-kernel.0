From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:36:52 +0000
Subject: [PATCH v5 01/20] clk: bcm2835: pll_off should only set CM_PLL_ANARST
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-2-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

bcm2835_pll_off is currently assigning CM_PLL_ANARST
to the control register.

This patch only sets the CM_PLL_ANARST bit
not resetting any of the other bits, which allows
restoring the register to its original value
via bcm2834_pll_on.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 5747a9d..d3009a6 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -913,8 +913,12 @@ static void bcm2835_pll_off(struct clk_hw *hw)
 	struct bcm2835_cprman *cprman = pll->cprman;
 	const struct bcm2835_pll_data *data = pll->data;
 
-	cprman_write(cprman, data->cm_ctrl_reg, CM_PLL_ANARST);
-	cprman_write(cprman, data->a2w_ctrl_reg, A2W_PLL_CTRL_PWRDN);
+	cprman_write(cprman, data->cm_ctrl_reg,
+		     cprman_read(cprman, data->cm_ctrl_reg) |
+		     CM_PLL_ANARST);
+	cprman_write(cprman, data->a2w_ctrl_reg,
+		     cprman_read(cprman, data->a2w_ctrl_reg) |
+		     A2W_PLL_CTRL_PWRDN);
 }
 
 static int bcm2835_pll_on(struct clk_hw *hw)
-- 
1.7.10.4
