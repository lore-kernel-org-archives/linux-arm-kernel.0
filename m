From: lori.hikichi@broadcom.com (Lori Hikichi)
Date: Mon, 14 Aug 2017 12:00:40 -0700
Subject: [PATCH v1 3/4] clk: iproc: Allow plls to do minor rate changes
 without reset
In-Reply-To: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
References: <1502737241-2040-1-git-send-email-lori.hikichi@broadcom.com>
Message-ID: <1502737241-2040-4-git-send-email-lori.hikichi@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lori Hikichi <lhikichi@broadcom.com>

The iproc plls are capable of doing small rate changes without the
need for a full reset and re-lock procedure.  This feature will
allow for small tweaks to the PLL rate to occur smoothly.

Signed-off-by: Lori Hikichi <lori.hikichi@broadcom.com>
---
 drivers/clk/bcm/clk-iproc-pll.c | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
index 7df010b..ab10819 100644
--- a/drivers/clk/bcm/clk-iproc-pll.c
+++ b/drivers/clk/bcm/clk-iproc-pll.c
@@ -285,6 +285,40 @@ static void __pll_bring_out_reset(struct iproc_pll *pll, unsigned int kp,
 	iproc_pll_write(pll, pll->control_base, reset->offset, val);
 }
 
+/*
+ * Determines if the change to be applied to the PLL is minor (just an update
+ * or the fractional divider). If so, then we can avoid going through a
+ * disruptive reset and lock sequence.
+ */
+static bool pll_fractional_change_only(struct iproc_pll *pll,
+				       struct iproc_pll_vco_param *vco)
+{
+	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
+	u32 val;
+	u32 ndiv_int;
+	unsigned int pdiv;
+
+	/* PLL needs to be locked */
+	val = readl(pll->status_base + ctrl->status.offset);
+	if ((val & (1 << ctrl->status.shift)) == 0)
+		return false;
+
+	val = readl(pll->control_base + ctrl->ndiv_int.offset);
+	ndiv_int = (val >> ctrl->ndiv_int.shift) &
+		bit_mask(ctrl->ndiv_int.width);
+
+	if (ndiv_int != vco->ndiv_int)
+		return false;
+
+	val = readl(pll->control_base + ctrl->pdiv.offset);
+	pdiv = (val >> ctrl->pdiv.shift) & bit_mask(ctrl->pdiv.width);
+
+	if (pdiv != vco->pdiv)
+		return false;
+
+	return true;
+}
+
 static int pll_set_rate(struct iproc_clk *clk, struct iproc_pll_vco_param *vco,
 			unsigned long parent_rate)
 {
@@ -333,6 +367,19 @@ static int pll_set_rate(struct iproc_clk *clk, struct iproc_pll_vco_param *vco,
 		return ret;
 	}
 
+	if (pll_fractional_change_only(clk->pll, vco)) {
+		/* program fractional part of NDIV */
+		if (ctrl->flags & IPROC_CLK_PLL_HAS_NDIV_FRAC) {
+			val = readl(pll->control_base + ctrl->ndiv_frac.offset);
+			val &= ~(bit_mask(ctrl->ndiv_frac.width) <<
+				 ctrl->ndiv_frac.shift);
+			val |= vco->ndiv_frac << ctrl->ndiv_frac.shift;
+			iproc_pll_write(pll, pll->control_base,
+					ctrl->ndiv_frac.offset, val);
+			return 0;
+		}
+	}
+
 	/* put PLL in reset */
 	__pll_put_in_reset(pll);
 
-- 
1.9.1
