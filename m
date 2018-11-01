From: jianxin.pan@amlogic.com (Jianxin Pan)
Date: Fri, 2 Nov 2018 00:30:53 +0800
Subject: [PATCH v6 1/3] clk: meson: add emmc sub clock phase delay driver
In-Reply-To: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
References: <1541089855-19356-1-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <1541089855-19356-2-git-send-email-jianxin.pan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yixun Lan <yixun.lan@amlogic.com>

Export the emmc sub clock phase delay ops which will be used
by the emmc sub clock driver itself.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/clk/meson/Makefile          |  2 +-
 drivers/clk/meson/clk-phase-delay.c | 66 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h            | 13 ++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/clk-phase-delay.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 72ec8c4..39ce566 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Meson specific clk
 #
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o clk-phase-delay.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-phase-delay.c
new file mode 100644
index 0000000..83e74ed
--- /dev/null
+++ b/drivers/clk/meson/clk-phase-delay.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Amlogic Meson MMC Sub Clock Controller Driver
+ *
+ * Copyright (c) 2017 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ * Author: Jianxin Pan <jianxin.pan@amlogic.com>
+ */
+
+#include <linux/clk-provider.h>
+#include "clkc.h"
+
+static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_phase_delay_data *ph =
+		meson_clk_get_phase_delay_data(clk);
+	unsigned long period_ps, p, d;
+	int degrees;
+
+	p = meson_parm_read(clk->map, &ph->phase);
+	degrees = p * 360 / (1 << (ph->phase.width));
+
+	period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+				 clk_hw_get_rate(hw));
+
+	d = meson_parm_read(clk->map, &ph->delay);
+	degrees += d * ph->delay_step_ps * 360 / period_ps;
+	degrees %= 360;
+
+	return degrees;
+}
+
+static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_phase_delay_data *ph =
+		meson_clk_get_phase_delay_data(clk);
+	unsigned long period_ps, d = 0, r;
+	u64 p;
+
+	p = degrees % 360;
+	period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+				 clk_hw_get_rate(hw));
+
+	/* First compute the phase index (p), the remainder (r) is the
+	 * part we'll try to acheive using the delays (d).
+	 */
+	r = do_div(p, 360 / (1 << (ph->phase.width)));
+	d = DIV_ROUND_CLOSEST(r * period_ps,
+			      360 * ph->delay_step_ps);
+	d = min(d, PMASK(ph->delay.width));
+
+	meson_parm_write(clk->map, &ph->phase, p);
+	meson_parm_write(clk->map, &ph->delay, d);
+	return 0;
+}
+
+const struct clk_ops meson_clk_phase_delay_ops = {
+	.get_phase = meson_clk_phase_delay_get_phase,
+	.set_phase = meson_clk_phase_delay_set_phase,
+};
+EXPORT_SYMBOL_GPL(meson_clk_phase_delay_ops);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 6b96d55..30470c6 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -105,6 +105,18 @@ struct clk_regmap _name = {						\
 	},								\
 };
 
+struct meson_clk_phase_delay_data {
+	struct parm			phase;
+	struct parm			delay;
+	unsigned int			delay_step_ps;
+};
+
+static inline struct meson_clk_phase_delay_data *
+meson_clk_get_phase_delay_data(struct clk_regmap *clk)
+{
+	return clk->data;
+}
+
 /* clk_ops */
 extern const struct clk_ops meson_clk_pll_ro_ops;
 extern const struct clk_ops meson_clk_pll_ops;
@@ -112,5 +124,6 @@ struct clk_regmap _name = {						\
 extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_phase_ops;
+extern const struct clk_ops meson_clk_phase_delay_ops;
 
 #endif /* __CLKC_H */
-- 
1.9.1
