From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:36:54 +0000
Subject: [PATCH v5 03/20] clk: bcm2835: add locking to pll*_on/off methods
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-4-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Add missing locking to:
* bcm2835_pll_on
* bcm2835_pll_off
* bcm2835_pll_divider_on

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 3aa3e7a..d999a13 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -910,12 +910,14 @@ static void bcm2835_pll_off(struct clk_hw *hw)
 	struct bcm2835_cprman *cprman = pll->cprman;
 	const struct bcm2835_pll_data *data = pll->data;

+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->cm_ctrl_reg,
 		     cprman_read(cprman, data->cm_ctrl_reg) |
 		     CM_PLL_ANARST);
 	cprman_write(cprman, data->a2w_ctrl_reg,
 		     cprman_read(cprman, data->a2w_ctrl_reg) |
 		     A2W_PLL_CTRL_PWRDN);
+	spin_unlock(&cprman->regs_lock);
 }

 static int bcm2835_pll_on(struct clk_hw *hw)
@@ -1083,10 +1085,12 @@ static void bcm2835_pll_divider_off(struct clk_hw *hw)
 	struct bcm2835_cprman *cprman = divider->cprman;
 	const struct bcm2835_pll_divider_data *data = divider->data;

+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->cm_reg,
 		     (cprman_read(cprman, data->cm_reg) &
 		      ~data->load_mask) | data->hold_mask);
 	cprman_write(cprman, data->a2w_reg, A2W_PLL_CHANNEL_DISABLE);
+	spin_unlock(&cprman->regs_lock);
 }

 static int bcm2835_pll_divider_on(struct clk_hw *hw)
@@ -1095,12 +1099,14 @@ static int bcm2835_pll_divider_on(struct clk_hw *hw)
 	struct bcm2835_cprman *cprman = divider->cprman;
 	const struct bcm2835_pll_divider_data *data = divider->data;

+	spin_lock(&cprman->regs_lock);
 	cprman_write(cprman, data->a2w_reg,
 		     cprman_read(cprman, data->a2w_reg) &
 		     ~A2W_PLL_CHANNEL_DISABLE);

 	cprman_write(cprman, data->cm_reg,
 		     cprman_read(cprman, data->cm_reg) & ~data->hold_mask);
+	spin_unlock(&cprman->regs_lock);

 	return 0;
 }
--
1.7.10.4
