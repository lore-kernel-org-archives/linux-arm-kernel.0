From: wens@csie.org (Chen-Yu Tsai)
Date: Wed,  3 May 2017 11:16:53 +0800
Subject: [PATCH v2 3/8] clk: sunxi-ng: Add class of phase clocks supporting
 MMC new timing modes
In-Reply-To: <20170503031658.29299-1-wens@csie.org>
References: <20170503031658.29299-1-wens@csie.org>
Message-ID: <20170503031658.29299-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMC clocks on newer SoCs, such as the A83T and H3, support the
"new timing mode". Under this mode, the output of the clock is divided
by 2, and the clock delays no longer apply.

Due to how the clock tree is modeled and setup, we need to model
this function in two places, the master mmc clock and the two
child phase clocks. In the mmc clock, we can easily model the
mode bit as an extra variable post-divider. In the phase clocks,
we check the bit and return -ENOTSUPP if the bit is set, signaling
that the phase clocks are not to be used.

This patch introduces a class of phase clocks that checks the
timing mode bit.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/ccu_phase.c | 47 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_phase.h | 16 ++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu_phase.c b/drivers/clk/sunxi-ng/ccu_phase.c
index 400c58ad72fd..e6ff7551c855 100644
--- a/drivers/clk/sunxi-ng/ccu_phase.c
+++ b/drivers/clk/sunxi-ng/ccu_phase.c
@@ -8,6 +8,7 @@
  * the License, or (at your option) any later version.
  */
 
+#include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/spinlock.h>
 
@@ -124,3 +125,49 @@ const struct clk_ops ccu_phase_ops = {
 	.get_phase	= ccu_phase_get_phase,
 	.set_phase	= ccu_phase_set_phase,
 };
+
+/*
+ * The MMC clocks on newer SoCs support the "new timing mode". Under
+ * this mode, the output of the clock is divided by 2, and the clock
+ * delays no longer apply.
+ *
+ * Due to how the clock tree is modeled and setup, we need to model
+ * this function in two places, the master mmc clock and the two
+ * child phase clocks. In the mmc clock, we can easily model the
+ * mode bit as an extra variable post-divider. In the phase clocks,
+ * we check the bit and return -ENOTSUPP if the bit is set, signaling
+ * that the phase clocks are not to be used.
+ *
+ * We do not support runtime configuration of the modes. Instead a
+ * mode is enforced at CCU probe time.
+ */
+#define CCU_MMC_NEW_TIMING_MODE	    BIT(30)
+
+static int ccu_phase_mmc_new_timing_get_phase(struct clk_hw *hw)
+{
+	struct ccu_phase *phase = hw_to_ccu_phase(hw);
+	u32 reg;
+
+	reg = readl(phase->common.base + phase->common.reg);
+	if (reg & CCU_MMC_NEW_TIMING_MODE)
+		return -ENOTSUPP;
+
+	return ccu_phase_get_phase(hw);
+}
+
+static int ccu_phase_mmc_new_timing_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct ccu_phase *phase = hw_to_ccu_phase(hw);
+	u32 reg;
+
+	reg = readl(phase->common.base + phase->common.reg);
+	if (reg & CCU_MMC_NEW_TIMING_MODE)
+		return -ENOTSUPP;
+
+	return ccu_phase_set_phase(hw, degrees);
+}
+
+const struct clk_ops ccu_phase_mmc_new_timing_ops = {
+	.get_phase	= ccu_phase_mmc_new_timing_get_phase,
+	.set_phase	= ccu_phase_mmc_new_timing_set_phase,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_phase.h b/drivers/clk/sunxi-ng/ccu_phase.h
index 75a091a4c565..c514d1798cdd 100644
--- a/drivers/clk/sunxi-ng/ccu_phase.h
+++ b/drivers/clk/sunxi-ng/ccu_phase.h
@@ -38,6 +38,20 @@ struct ccu_phase {
 		}							\
 	}
 
+#define SUNXI_CCU_PHASE_MMC_NEW_TIMING(_struct, _name, _parent, _reg,	\
+				       _shift, _width, _flags)		\
+	struct ccu_phase _struct = {					\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_phase_mmc_new_timing_ops, \
+						      _flags),		\
+		}							\
+	}
+
 static inline struct ccu_phase *hw_to_ccu_phase(struct clk_hw *hw)
 {
 	struct ccu_common *common = hw_to_ccu_common(hw);
@@ -47,4 +61,6 @@ static inline struct ccu_phase *hw_to_ccu_phase(struct clk_hw *hw)
 
 extern const struct clk_ops ccu_phase_ops;
 
+extern const struct clk_ops ccu_phase_mmc_new_timing_ops;
+
 #endif /* _CCU_PHASE_H_ */
-- 
2.11.0
