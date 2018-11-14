From: aisheng.dong@nxp.com (A.s. Dong)
Date: Wed, 14 Nov 2018 13:01:39 +0000
Subject: [PATCH V6 2/9] clk: fractional-divider: add
 CLK_FRAC_DIVIDER_ZERO_BASED flag support
In-Reply-To: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1542200198-3017-3-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding CLK_FRAC_DIVIDER_ZERO_BASED flag to indicate the numerator and
denominator value in register are start from 0.

This can be used to support frac dividers like below:
Divider output clock = Divider input clock x [(frac +1) / (div +1)]
where frac/div in register is:
000b - Divide by 1.
001b - Divide by 2.
010b - Divide by 3.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * no changes
v1->v2:
 * improve comments suggested by Stephen
---
 drivers/clk/clk-fractional-divider.c | 10 ++++++++++
 include/linux/clk-provider.h         |  8 ++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index fdf625f..7ccde6b 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -40,6 +40,11 @@ static unsigned long clk_fd_recalc_rate(struct clk_hw *hw,
 	m = (val & fd->mmask) >> fd->mshift;
 	n = (val & fd->nmask) >> fd->nshift;
 
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m++;
+		n++;
+	}
+
 	if (!n || !m)
 		return parent_rate;
 
@@ -103,6 +108,11 @@ static int clk_fd_set_rate(struct clk_hw *hw, unsigned long rate,
 			GENMASK(fd->mwidth - 1, 0), GENMASK(fd->nwidth - 1, 0),
 			&m, &n);
 
+	if (fd->flags & CLK_FRAC_DIVIDER_ZERO_BASED) {
+		m--;
+		n--;
+	}
+
 	if (fd->lock)
 		spin_lock_irqsave(fd->lock, flags);
 	else
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 08b1aa7..bee6453 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -594,6 +594,12 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw);
  * @lock:	register lock
  *
  * Clock with adjustable fractional divider affecting its output frequency.
+ *
+ * Flags:
+ * CLK_FRAC_DIVIDER_ZERO_BASED - by default the numerator and denominator
+ *	is the value read from the register. If CLK_FRAC_DIVIDER_ZERO_BASED
+ *	is set then the numerator and denominator are both the value read
+ *	plus one.
  */
 struct clk_fractional_divider {
 	struct clk_hw	hw;
@@ -613,6 +619,8 @@ struct clk_fractional_divider {
 
 #define to_clk_fd(_hw) container_of(_hw, struct clk_fractional_divider, hw)
 
+#define CLK_FRAC_DIVIDER_ZERO_BASED		BIT(0)
+
 extern const struct clk_ops clk_fractional_divider_ops;
 struct clk *clk_register_fractional_divider(struct device *dev,
 		const char *name, const char *parent_name, unsigned long flags,
-- 
2.7.4
