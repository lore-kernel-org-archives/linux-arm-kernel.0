From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Sep 2014 22:18:17 +0200
Subject: [PATCH v3 03/12] clk: Add a function to retrieve phase
In-Reply-To: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410466706-27386-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1410466706-27386-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current phase API doesn't look into the actual hardware to get the phase
value, but will rather get it from a variable only set by the set_phase
function.

This will cause issue when the client driver will never call the set_phase
function, where we can end up having a reported phase that will not match what
the hardware has been programmed to by the bootloader or what phase is
programmed out of reset.

Add a new get_phase function for the drivers to implement so that we can get
this value.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/clk.c            | 10 ++++++++++
 include/linux/clk-provider.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index d87661af0c72..113d75db371d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1934,6 +1934,16 @@ int __clk_init(struct device *dev, struct clk *clk)
 		clk->accuracy = 0;
 
 	/*
+	 * Set clk's phase.
+	 * Since a phase is by definition relative to its parent, just
+	 * query the current clock phase, or just assume it's in phase.
+	 */
+	if (clk->ops->get_phase)
+		clk->phase = clk->ops->get_phase(clk->hw);
+	else
+		clk->phase = 0;
+
+	/*
 	 * Set clk's rate.  The preferred method is to use .recalc_rate.  For
 	 * simple clocks and lazy developers the default fallback is to use the
 	 * parent's rate.  If a clock doesn't have a parent (or is orphaned)
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 69b20d4c1e1a..abec961092a7 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -130,6 +130,10 @@ struct dentry;
  *		set then clock accuracy will be initialized to parent accuracy
  *		or 0 (perfect clock) if clock has no parent.
  *
+ * @get_phase:	Queries the hardware to get the current phase of a clock.
+ *		Returned values are 0-359 degrees on success, negative
+ *		error codes on failure.
+ *
  * @set_phase:	Shift the phase this clock signal in degrees specified
  *		by the second argument. Valid values for degrees are
  *		0-359. Return 0 on success, otherwise -EERROR.
@@ -182,6 +186,7 @@ struct clk_ops {
 				    unsigned long parent_rate, u8 index);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
+	int		(*get_phase)(struct clk_hw *hw);
 	int		(*set_phase)(struct clk_hw *hw, int degrees);
 	void		(*init)(struct clk_hw *hw);
 	int		(*debug_init)(struct clk_hw *hw, struct dentry *dentry);
-- 
2.1.0
