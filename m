From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Mon, 11 Jan 2016 19:55:54 +0000
Subject: [PATCH V2 2/4] clk: bcm2835: enable fractional and mash support
In-Reply-To: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
References: <1452542157-2387-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1452542157-2387-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

The clk-bcm2835 driver right now does the correct calculation
of the fractional clock divider, but it does not set the FRAC
bit to enable the fractual clock divider in HW

This patch enables FRAC for all clocks with frac_bits > 0
but allows to define the selection of a higher-order MASH
support instead of just FRAC.

Right now there are no limits imposed on maximum frequencies
when using MASH/FRAC is enabled.

There is a documented limit of 25MHz for MASH, but it is not
stated if this also applies to clock dividers that only support
FRAC and not MASH.

As for how higher order MASH works the following may give
some insight: http://www.aholme.co.uk/Frac2/Mash.htm

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/clk/bcm/clk-bcm2835.c |   50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 759202a..7c782d3 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -115,6 +115,13 @@
 # define CM_GATE			BIT(CM_GATE_BIT)
 # define CM_BUSY			BIT(7)
 # define CM_BUSYD			BIT(8)
+# define CM_MASH_BITS			2
+# define CM_MASH_SHIFT			9
+# define CM_MASH_MASK			GENMASK(10, 9)
+# define CM_MASH(v)			((v << CM_MASH_SHIFT) & CM_MASH_MASK)
+# define CM_MASH_FRAC			CM_MASH(1)
+# define CM_MASH_2ND_ORDER		CM_MASH(2)
+# define CM_MASH_3RD_ORDER		CM_MASH(3)
 # define CM_SRC_SHIFT			0
 # define CM_SRC_BITS			4
 # define CM_SRC_MASK			0xf
@@ -632,6 +639,8 @@ struct bcm2835_clock_data {
 	u32 int_bits;
 	/* Number of fractional bits in the divider */
 	u32 frac_bits;
+	/* the mash value to use - see CM_MASH and CM_MASH_FRAC/ORDER */
+	u32 mash;

 	bool is_vpu_clock;
 };
@@ -1274,9 +1283,50 @@ static int bcm2835_clock_set_rate(struct clk_hw *hw,
 	struct bcm2835_cprman *cprman = clock->cprman;
 	const struct bcm2835_clock_data *data = clock->data;
 	u32 div = bcm2835_clock_choose_div(hw, rate, parent_rate, false);
+	u32 ctl, mash;
+	bool enabled;

+	spin_lock(&cprman->regs_lock);
+	/* check if divider is identical, then return */
+	if (div == cprman_read(cprman, data->div_reg))
+		goto unlock;
+
+	/* it is recommended to only set clock registers when disabled */
+	ctl = cprman_read(cprman, data->ctl_reg);
+	enabled = ctl & CM_ENABLE;
+	if (enabled) {
+		/* disable clock */
+		cprman_write(cprman, data->ctl_reg, ctl);
+
+		/* release lock while busy waiting */
+		spin_unlock(&cprman->regs_lock);
+		bcm2835_clock_wait_busy(clock);
+		spin_lock(&cprman->regs_lock);
+
+		/* read the register again */
+		ctl = cprman_read(cprman, data->ctl_reg);
+	}
+
+	/* set the divider */
 	cprman_write(cprman, data->div_reg, div);

+	/* set frac/mash if necessarry */
+	mash = 0;
+	if ((data->frac_bits) && (div & GENMASK(CM_DIV_FRAC_BITS, 0)))
+		mash = (data->mash) ? data->mash : CM_MASH_FRAC;
+
+	/* set mash to the selected value */
+	ctl &= ~CM_MASH_MASK;
+	ctl |= mash & CM_MASH_MASK;
+	cprman_write(cprman, data->ctl_reg, ctl);
+
+	/* re-enable the clock */
+	if (enabled)
+		cprman_write(cprman, data->ctl_reg, ctl | CM_ENABLE);
+
+unlock:
+	spin_unlock(&cprman->regs_lock);
+
 	return 0;
 }

--
1.7.10.4
