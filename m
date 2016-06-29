From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:27 +0200
Subject: [PATCH v3 06/14] clk: sunxi-ng: Add phase clock support
In-Reply-To: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
Message-ID: <20160629190535.11855-7-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the clocks in the CCU that introduce a phase shift from
their parent clock.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Kconfig     |   3 +
 drivers/clk/sunxi-ng/Makefile    |   1 +
 drivers/clk/sunxi-ng/ccu_phase.c | 126 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_phase.h |  50 ++++++++++++++++
 4 files changed, 180 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_phase.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_phase.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 4699a602e0c1..3a3bc4368a2a 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -15,4 +15,7 @@ config SUNXI_CCU_GATE
 config SUNXI_CCU_MUX
 	bool
 
+config SUNXI_CCU_PHASE
+	bool
+
 endif
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index eaa833721245..a0c53c56ebfe 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
 obj-$(CONFIG_SUNXI_CCU_FRAC)	+= ccu_frac.o
 obj-$(CONFIG_SUNXI_CCU_GATE)	+= ccu_gate.o
 obj-$(CONFIG_SUNXI_CCU_MUX)	+= ccu_mux.o
+obj-$(CONFIG_SUNXI_CCU_PHASE)	+= ccu_phase.o
diff --git a/drivers/clk/sunxi-ng/ccu_phase.c b/drivers/clk/sunxi-ng/ccu_phase.c
new file mode 100644
index 000000000000..400c58ad72fd
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_phase.c
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2016 Maxime Ripard
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
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
+#include "ccu_phase.h"
+
+static int ccu_phase_get_phase(struct clk_hw *hw)
+{
+	struct ccu_phase *phase = hw_to_ccu_phase(hw);
+	struct clk_hw *parent, *grandparent;
+	unsigned int parent_rate, grandparent_rate;
+	u16 step, parent_div;
+	u32 reg;
+	u8 delay;
+
+	reg = readl(phase->common.base + phase->common.reg);
+	delay = (reg >> phase->shift);
+	delay &= (1 << phase->width) - 1;
+
+	if (!delay)
+		return 180;
+
+	/* Get our parent clock, it's the one that can adjust its rate */
+	parent = clk_hw_get_parent(hw);
+	if (!parent)
+		return -EINVAL;
+
+	/* And its rate */
+	parent_rate = clk_hw_get_rate(parent);
+	if (!parent_rate)
+		return -EINVAL;
+
+	/* Now, get our parent's parent (most likely some PLL) */
+	grandparent = clk_hw_get_parent(parent);
+	if (!grandparent)
+		return -EINVAL;
+
+	/* And its rate */
+	grandparent_rate = clk_hw_get_rate(grandparent);
+	if (!grandparent_rate)
+		return -EINVAL;
+
+	/* Get our parent clock divider */
+	parent_div = grandparent_rate / parent_rate;
+
+	step = DIV_ROUND_CLOSEST(360, parent_div);
+	return delay * step;
+}
+
+static int ccu_phase_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct ccu_phase *phase = hw_to_ccu_phase(hw);
+	struct clk_hw *parent, *grandparent;
+	unsigned int parent_rate, grandparent_rate;
+	unsigned long flags;
+	u32 reg;
+	u8 delay;
+
+	/* Get our parent clock, it's the one that can adjust its rate */
+	parent = clk_hw_get_parent(hw);
+	if (!parent)
+		return -EINVAL;
+
+	/* And its rate */
+	parent_rate = clk_hw_get_rate(parent);
+	if (!parent_rate)
+		return -EINVAL;
+
+	/* Now, get our parent's parent (most likely some PLL) */
+	grandparent = clk_hw_get_parent(parent);
+	if (!grandparent)
+		return -EINVAL;
+
+	/* And its rate */
+	grandparent_rate = clk_hw_get_rate(grandparent);
+	if (!grandparent_rate)
+		return -EINVAL;
+
+	if (degrees != 180) {
+		u16 step, parent_div;
+
+		/* Get our parent divider */
+		parent_div = grandparent_rate / parent_rate;
+
+		/*
+		 * We can only outphase the clocks by multiple of the
+		 * PLL's period.
+		 *
+		 * Since our parent clock is only a divider, and the
+		 * formula to get the outphasing in degrees is deg =
+		 * 360 * delta / period
+		 *
+		 * If we simplify this formula, we can see that the
+		 * only thing that we're concerned about is the number
+		 * of period we want to outphase our clock from, and
+		 * the divider set by our parent clock.
+		 */
+		step = DIV_ROUND_CLOSEST(360, parent_div);
+		delay = DIV_ROUND_CLOSEST(degrees, step);
+	} else {
+		delay = 0;
+	}
+
+	spin_lock_irqsave(phase->common.lock, flags);
+	reg = readl(phase->common.base + phase->common.reg);
+	reg &= ~GENMASK(phase->width + phase->shift - 1, phase->shift);
+	writel(reg | (delay << phase->shift),
+	       phase->common.base + phase->common.reg);
+	spin_unlock_irqrestore(phase->common.lock, flags);
+
+	return 0;
+}
+
+const struct clk_ops ccu_phase_ops = {
+	.get_phase	= ccu_phase_get_phase,
+	.set_phase	= ccu_phase_set_phase,
+};
diff --git a/drivers/clk/sunxi-ng/ccu_phase.h b/drivers/clk/sunxi-ng/ccu_phase.h
new file mode 100644
index 000000000000..75a091a4c565
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_phase.h
@@ -0,0 +1,50 @@
+/*
+ * Copyright (c) 2016 Maxime Ripard. All rights reserved.
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
+#ifndef _CCU_PHASE_H_
+#define _CCU_PHASE_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct ccu_phase {
+	u8			shift;
+	u8			width;
+
+	struct ccu_common	common;
+};
+
+#define SUNXI_CCU_PHASE(_struct, _name, _parent, _reg, _shift, _width, _flags) \
+	struct ccu_phase _struct = {					\
+		.shift	= _shift,					\
+		.width	= _width,					\
+		.common	= {						\
+			.reg		= _reg,				\
+			.hw.init	= CLK_HW_INIT(_name,		\
+						      _parent,		\
+						      &ccu_phase_ops,	\
+						      _flags),		\
+		}							\
+	}
+
+static inline struct ccu_phase *hw_to_ccu_phase(struct clk_hw *hw)
+{
+	struct ccu_common *common = hw_to_ccu_common(hw);
+
+	return container_of(common, struct ccu_phase, common);
+}
+
+extern const struct clk_ops ccu_phase_ops;
+
+#endif /* _CCU_PHASE_H_ */
-- 
2.9.0
