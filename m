From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 12 Oct 2017 16:36:59 +0800
Subject: [PATCH 3/9] clk: sunxi-ng: Add sigma-delta modulation support
In-Reply-To: <20171012083705.24409-1-wens@csie.org>
References: <20171012083705.24409-1-wens@csie.org>
Message-ID: <20171012083705.24409-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sigma-delta modulation is supported for some PLLs. This allows
fractional-N multipliers to be used. In reality we don't know
how to configure the individual settings for it. However we can
copy existing settings from the vendor kernel to support clock
rates that cannot be generated from integer factors, but are
really desired. The vendor kernel only uses this for the audio
PLL clock, and only on the latest chips.

This patch adds a new class of clocks, along with helper functions.
It is intended to be merged into N-M-factor style clocks as a
feature, much like fractional clocks.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/clk/sunxi-ng/Makefile     |   1 +
 drivers/clk/sunxi-ng/ccu_common.h |   1 +
 drivers/clk/sunxi-ng/ccu_sdm.c    | 158 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_sdm.h    |  80 +++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_sdm.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_sdm.h

diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 85a0633c1eac..8504d9c6f03a 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -10,6 +10,7 @@ lib-$(CONFIG_SUNXI_CCU)		+= ccu_gate.o
 lib-$(CONFIG_SUNXI_CCU)		+= ccu_mux.o
 lib-$(CONFIG_SUNXI_CCU)		+= ccu_mult.o
 lib-$(CONFIG_SUNXI_CCU)		+= ccu_phase.o
+lib-$(CONFIG_SUNXI_CCU)		+= ccu_sdm.o
 
 # Multi-factor clocks
 lib-$(CONFIG_SUNXI_CCU)		+= ccu_nk.o
diff --git a/drivers/clk/sunxi-ng/ccu_common.h b/drivers/clk/sunxi-ng/ccu_common.h
index cadd1a9f93b6..5d684ce77c54 100644
--- a/drivers/clk/sunxi-ng/ccu_common.h
+++ b/drivers/clk/sunxi-ng/ccu_common.h
@@ -24,6 +24,7 @@
 #define CCU_FEATURE_ALL_PREDIV		BIT(4)
 #define CCU_FEATURE_LOCK_REG		BIT(5)
 #define CCU_FEATURE_MMC_TIMING_SWITCH	BIT(6)
+#define CCU_FEATURE_SIGMA_DELTA_MOD	BIT(7)
 
 /* MMC timing mode switch bit */
 #define CCU_MMC_NEW_TIMING_MODE		BIT(30)
diff --git a/drivers/clk/sunxi-ng/ccu_sdm.c b/drivers/clk/sunxi-ng/ccu_sdm.c
new file mode 100644
index 000000000000..3b3dc9bdf2b0
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_sdm.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+
+#include "ccu_sdm.h"
+
+bool ccu_sdm_helper_is_enabled(struct ccu_common *common,
+			       struct ccu_sdm_internal *sdm)
+{
+	if (!(common->features & CCU_FEATURE_SIGMA_DELTA_MOD))
+		return false;
+
+	if (sdm->enable && !(readl(common->base + common->reg) & sdm->enable))
+		return false;
+
+	return !!(readl(common->base + sdm->tuning_reg) & sdm->tuning_enable);
+}
+
+void ccu_sdm_helper_enable(struct ccu_common *common,
+			   struct ccu_sdm_internal *sdm,
+			   unsigned long rate)
+{
+	unsigned long flags;
+	unsigned int i;
+	u32 reg;
+
+	if (!(common->features & CCU_FEATURE_SIGMA_DELTA_MOD))
+		return;
+
+	/* Set the pattern */
+	for (i = 0; i < sdm->table_size; i++)
+		if (sdm->table[i].rate == rate)
+			writel(sdm->table[i].pattern,
+			       common->base + sdm->tuning_reg);
+
+	/* Make sure SDM is enabled */
+	spin_lock_irqsave(common->lock, flags);
+	reg = readl(common->base + sdm->tuning_reg);
+	writel(reg | sdm->tuning_enable, common->base + sdm->tuning_reg);
+	spin_unlock_irqrestore(common->lock, flags);
+
+	spin_lock_irqsave(common->lock, flags);
+	reg = readl(common->base + common->reg);
+	writel(reg | sdm->enable, common->base + common->reg);
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+void ccu_sdm_helper_disable(struct ccu_common *common,
+			    struct ccu_sdm_internal *sdm)
+{
+	unsigned long flags;
+	u32 reg;
+
+	if (!(common->features & CCU_FEATURE_SIGMA_DELTA_MOD))
+		return;
+
+	spin_lock_irqsave(common->lock, flags);
+	reg = readl(common->base + common->reg);
+	writel(reg & ~sdm->enable, common->base + common->reg);
+	spin_unlock_irqrestore(common->lock, flags);
+
+	spin_lock_irqsave(common->lock, flags);
+	reg = readl(common->base + sdm->tuning_reg);
+	writel(reg & ~sdm->tuning_enable, common->base + sdm->tuning_reg);
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+/*
+ * Sigma delta modulation provides a way to do fractional-N frequency
+ * synthesis, in essence allowing the PLL to output any frequency
+ * within its operational range. On earlier SoCs such as the A10/A20,
+ * some PLLs support this. On later SoCs, all PLLs support this.
+ *
+ * The datasheets do not explain what the "wave top" and "wave bottom"
+ * parameters mean or do, nor how to calculate the effective output
+ * frequency. The only examples (and real world usage) are for the audio
+ * PLL to generate 24.576 and 22.5792 MHz clock rates used by the audio
+ * peripherals. The author lacks the underlying domain knowledge to
+ * pursue this.
+ *
+ * The goal and function of the following code is to support the two
+ * clock rates used by the audio subsystem, allowing for proper audio
+ * playback and capture without any pitch or speed changes.
+ */
+bool ccu_sdm_helper_has_rate(struct ccu_common *common,
+			     struct ccu_sdm_internal *sdm,
+			     unsigned long rate)
+{
+	unsigned int i;
+
+	if (!(common->features & CCU_FEATURE_SIGMA_DELTA_MOD))
+		return false;
+
+	for (i = 0; i < sdm->table_size; i++)
+		if (sdm->table[i].rate == rate)
+			return true;
+
+	return false;
+}
+
+unsigned long ccu_sdm_helper_read_rate(struct ccu_common *common,
+				       struct ccu_sdm_internal *sdm,
+				       u32 m, u32 n)
+{
+	unsigned int i;
+	u32 reg;
+
+	pr_debug("%s: Read sigma-delta modulation setting\n",
+		 clk_hw_get_name(&common->hw));
+
+	if (!(common->features & CCU_FEATURE_SIGMA_DELTA_MOD))
+		return 0;
+
+	pr_debug("%s: clock is sigma-delta modulated\n",
+		 clk_hw_get_name(&common->hw));
+
+	reg = readl(common->base + sdm->tuning_reg);
+
+	pr_debug("%s: pattern reg is 0x%x",
+		 clk_hw_get_name(&common->hw), reg);
+
+	for (i = 0; i < sdm->table_size; i++)
+		if (sdm->table[i].pattern == reg &&
+		    sdm->table[i].m == m && sdm->table[i].n == n)
+			return sdm->table[i].rate;
+
+	/* We can't calculate the effective clock rate, so just fail. */
+	return 0;
+}
+
+int ccu_sdm_helper_get_factors(struct ccu_common *common,
+			       struct ccu_sdm_internal *sdm,
+			       unsigned long rate,
+			       unsigned long *m, unsigned long *n)
+{
+	unsigned int i;
+
+	if (!(common->features & CCU_FEATURE_SIGMA_DELTA_MOD))
+		return -EINVAL;
+
+	for (i = 0; i < sdm->table_size; i++)
+		if (sdm->table[i].rate == rate) {
+			*m = sdm->table[i].m;
+			*n = sdm->table[i].n;
+			return 0;
+		}
+
+	/* nothing found */
+	return -EINVAL;
+}
diff --git a/drivers/clk/sunxi-ng/ccu_sdm.h b/drivers/clk/sunxi-ng/ccu_sdm.h
new file mode 100644
index 000000000000..2a9b4a2584d6
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_sdm.h
@@ -0,0 +1,80 @@
+/*
+ * Copyright (c) 2017 Chen-Yu Tsai. All rights reserved.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _CCU_SDM_H
+#define _CCU_SDM_H
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_sdm_setting {
+	unsigned long	rate;
+
+	/*
+	 * XXX We don't know what the step and bottom register fields
+	 * mean. Just copy the whole register value from the vendor
+	 * kernel for now.
+	 */
+	u32		pattern;
+
+	/*
+	 * M and N factors here should be the values used in
+	 * calculation, not the raw values written to registers
+	 */
+	u32		m;
+	u32		n;
+};
+
+struct ccu_sdm_internal {
+	struct ccu_sdm_setting	*table;
+	u32		table_size;
+	/* early SoCs don't have the SDM enable bit in the PLL register */
+	u32		enable;
+	/* second enable bit in tuning register */
+	u32		tuning_enable;
+	u16		tuning_reg;
+};
+
+#define _SUNXI_CCU_SDM(_table, _enable,			\
+		       _reg, _reg_enable)		\
+	{						\
+		.table		= _table,		\
+		.table_size	= ARRAY_SIZE(_table),	\
+		.enable		= _enable,		\
+		.tuning_enable	= _reg_enable,		\
+		.tuning_reg	= _reg,			\
+	}
+
+bool ccu_sdm_helper_is_enabled(struct ccu_common *common,
+			       struct ccu_sdm_internal *sdm);
+void ccu_sdm_helper_enable(struct ccu_common *common,
+			   struct ccu_sdm_internal *sdm,
+			   unsigned long rate);
+void ccu_sdm_helper_disable(struct ccu_common *common,
+			    struct ccu_sdm_internal *sdm);
+
+bool ccu_sdm_helper_has_rate(struct ccu_common *common,
+			     struct ccu_sdm_internal *sdm,
+			     unsigned long rate);
+
+unsigned long ccu_sdm_helper_read_rate(struct ccu_common *common,
+				       struct ccu_sdm_internal *sdm,
+				       u32 m, u32 n);
+
+int ccu_sdm_helper_get_factors(struct ccu_common *common,
+			       struct ccu_sdm_internal *sdm,
+			       unsigned long rate,
+			       unsigned long *m, unsigned long *n);
+
+#endif
-- 
2.14.2
