From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 Aug 2016 14:21:58 +0800
Subject: [PATCH v3 4/6] clk: sunxi-ng: mux: Add clk notifier functions
In-Reply-To: <20160825062200.17206-1-wens@csie.org>
References: <20160825062200.17206-1-wens@csie.org>
Message-ID: <20160825062200.17206-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sunxi we support cpufreq by changing the clock rate of PLL-CPU.
It's possible the clock output of the PLL goes out of the CPU's
operational limits when the PLL's multipliers / dividers are changed
and it hasn't stabilized yet. This would result in the CPU hanging.

To circumvent this, we temporarily switch the CPU mux clock to another
stable clock before the rate change, and switch it back after the PLL
stabilizes. This is done with clk notifiers registered on the PLL.

This patch adds common functions for notifiers to reparent mux clocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2: none
Changes since v1: none
---
 drivers/clk/sunxi-ng/ccu_mux.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_mux.h | 14 ++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 7b17e0c26b01..a43ad52a957d 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -8,7 +8,9 @@
  * the License, or (at your option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 
 #include "ccu_gate.h"
 #include "ccu_mux.h"
@@ -199,3 +201,37 @@ const struct clk_ops ccu_mux_ops = {
 	.determine_rate	= __clk_mux_determine_rate,
 	.recalc_rate	= ccu_mux_recalc_rate,
 };
+
+/*
+ * This clock notifier is called when the frequency of the of the parent
+ * PLL clock is to be changed. The idea is to switch the parent to a
+ * stable clock, such as the main oscillator, while the PLL frequency
+ * stabilizes.
+ */
+static int ccu_mux_notifier_cb(struct notifier_block *nb,
+			       unsigned long event, void *data)
+{
+	struct ccu_mux_nb *mux = to_ccu_mux_nb(nb);
+	int ret = 0;
+
+	if (event == PRE_RATE_CHANGE) {
+		mux->original_index = ccu_mux_helper_get_parent(mux->common,
+								mux->cm);
+		ret = ccu_mux_helper_set_parent(mux->common, mux->cm,
+						mux->bypass_index);
+	} else if (event == POST_RATE_CHANGE) {
+		ret = ccu_mux_helper_set_parent(mux->common, mux->cm,
+						mux->original_index);
+	}
+
+	udelay(mux->delay_us);
+
+	return notifier_from_errno(ret);
+}
+
+int ccu_mux_notifier_register(struct clk *clk, struct ccu_mux_nb *mux_nb)
+{
+	mux_nb->clk_nb.notifier_call = ccu_mux_notifier_cb;
+
+	return clk_notifier_register(clk, &mux_nb->clk_nb);
+}
diff --git a/drivers/clk/sunxi-ng/ccu_mux.h b/drivers/clk/sunxi-ng/ccu_mux.h
index 8eab1733eeac..f5123a1a6603 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.h
+++ b/drivers/clk/sunxi-ng/ccu_mux.h
@@ -96,4 +96,18 @@ int ccu_mux_helper_set_parent(struct ccu_common *common,
 			      struct ccu_mux_internal *cm,
 			      u8 index);
 
+struct ccu_mux_nb {
+	struct notifier_block	clk_nb;
+	struct ccu_common	*common;
+	struct ccu_mux_internal	*cm;
+
+	u32	delay_us;	/* How many us to wait after reparenting */
+	u8	bypass_index;	/* Which parent to temporarily use */
+	u8	original_index;	/* This is set by the notifier callback */
+};
+
+#define to_ccu_mux_nb(_nb) container_of(_nb, struct ccu_mux_nb, clk_nb)
+
+int ccu_mux_notifier_register(struct clk *clk, struct ccu_mux_nb *mux_nb);
+
 #endif /* _CCU_MUX_H_ */
-- 
2.9.3
