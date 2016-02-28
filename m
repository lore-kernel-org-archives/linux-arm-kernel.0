From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sun, 28 Feb 2016 15:36:59 +0000
Subject: [PATCH v5 08/20] clk: bcm2835: add fractional support
In-Reply-To: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
References: <1456673831-2408-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1456673831-2408-9-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The current driver calculates the clock divider with
fractional support enabled.
But it does not enable fractional support in the control register.

This patch enables fractional support in the control register
whenever there is a fractional bit set in the requested clock divider.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 144d5d5..ffc5b3c 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -49,6 +49,7 @@
 #define CM_GNRICCTL		0x000
 #define CM_GNRICDIV		0x004
 # define CM_DIV_FRAC_BITS	12
+# define CM_DIV_FRAC_MASK	GENMASK(CM_DIV_FRAC_BITS - 1, 0)
 
 #define CM_VPUCTL		0x008
 #define CM_VPUDIV		0x00c
@@ -126,6 +127,7 @@
 # define CM_GATE			BIT(CM_GATE_BIT)
 # define CM_BUSY			BIT(7)
 # define CM_BUSYD			BIT(8)
+# define CM_FRAC			BIT(9)
 # define CM_SRC_SHIFT			0
 # define CM_SRC_BITS			4
 # define CM_SRC_MASK			0xf
@@ -875,9 +877,26 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
 	u32 div = bcm2835_clock_choose_div(hw, rate, parent_rate, false);
+	u32 ctl;
+
+	spin_lock(&cprman->regs_lock);
+
+	/*
+	 * Setting up frac support
+	 *
+	 * In principle it is recommended to stop/start the clock first,
+	 * but as we set CLK_SET_RATE_GATE during registration of the
+	 * clock this requirement should be take care of by the
+	 * clk-framework.
+	 */
+	ctl = cprman_read(cprman, data->ctl_reg) & ~CM_FRAC;
+	ctl |= (div & CM_DIV_FRAC_MASK) ? CM_FRAC : 0;
+	cprman_write(cprman, data->ctl_reg, ctl);
 
 	cprman_write(cprman, data->div_reg, div);
 
+	spin_unlock(&cprman->regs_lock);
+
 	return 0;
 }
 
-- 
1.7.10.4
