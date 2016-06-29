From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Jun 2016 21:05:24 +0200
Subject: [PATCH v3 03/14] clk: sunxi-ng: Add fractional lib
In-Reply-To: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
References: <20160629190535.11855-1-maxime.ripard@free-electrons.com>
Message-ID: <20160629190535.11855-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some clocks can be switched to a mode called fractional that have two fixed
output rate you can choose from.

Add a small library to deal with those clocks.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/clk/sunxi-ng/Kconfig    |   9 ++++
 drivers/clk/sunxi-ng/Makefile   |   3 ++
 drivers/clk/sunxi-ng/ccu_frac.c | 110 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu_frac.h |  53 +++++++++++++++++++
 4 files changed, 175 insertions(+)
 create mode 100644 drivers/clk/sunxi-ng/ccu_frac.c
 create mode 100644 drivers/clk/sunxi-ng/ccu_frac.h

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index df5b2768d8b4..3d117d7a3621 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -1,3 +1,12 @@
 config SUNXI_CCU
 	bool "Clock support for Allwinner SoCs"
 	default ARCH_SUNXI
+
+if SUNXI_CCU
+
+# Base clock types
+
+config SUNXI_CCU_FRAC
+	bool
+
+endif
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 886d0786ca51..46f417cb682a 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -1,3 +1,6 @@
 # Common objects
 obj-$(CONFIG_SUNXI_CCU)		+= ccu_common.o
 obj-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
+
+# Base clock types
+obj-$(CONFIG_SUNXI_CCU_FRAC)	+= ccu_frac.o
diff --git a/drivers/clk/sunxi-ng/ccu_frac.c b/drivers/clk/sunxi-ng/ccu_frac.c
new file mode 100644
index 000000000000..5c4b10cd15b5
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_frac.c
@@ -0,0 +1,110 @@
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
+#include "ccu_frac.h"
+
+bool ccu_frac_helper_is_enabled(struct ccu_common *common,
+				struct _ccu_frac *cf)
+{
+	if (!(common->features & CCU_FEATURE_FRACTIONAL))
+		return false;
+
+	return !(readl(common->base + common->reg) & cf->enable);
+}
+
+void ccu_frac_helper_enable(struct ccu_common *common,
+			    struct _ccu_frac *cf)
+{
+	unsigned long flags;
+	u32 reg;
+
+	if (!(common->features & CCU_FEATURE_FRACTIONAL))
+		return;
+
+	spin_lock_irqsave(common->lock, flags);
+	reg = readl(common->base + common->reg);
+	writel(reg & ~cf->enable, common->base + common->reg);
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+void ccu_frac_helper_disable(struct ccu_common *common,
+			     struct _ccu_frac *cf)
+{
+	unsigned long flags;
+	u32 reg;
+
+	if (!(common->features & CCU_FEATURE_FRACTIONAL))
+		return;
+
+	spin_lock_irqsave(common->lock, flags);
+	reg = readl(common->base + common->reg);
+	writel(reg | cf->enable, common->base + common->reg);
+	spin_unlock_irqrestore(common->lock, flags);
+}
+
+bool ccu_frac_helper_has_rate(struct ccu_common *common,
+			      struct _ccu_frac *cf,
+			      unsigned long rate)
+{
+	if (!(common->features & CCU_FEATURE_FRACTIONAL))
+		return false;
+
+	return (cf->rates[0] == rate) || (cf->rates[1] == rate);
+}
+
+unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
+					struct _ccu_frac *cf)
+{
+	u32 reg;
+
+	printk("%s: Read fractional\n", clk_hw_get_name(&common->hw));
+
+	if (!(common->features & CCU_FEATURE_FRACTIONAL))
+		return 0;
+
+	printk("%s: clock is fractional (rates %lu and %lu)\n",
+	       clk_hw_get_name(&common->hw), cf->rates[0], cf->rates[1]);
+
+	reg = readl(common->base + common->reg);
+
+	printk("%s: clock reg is 0x%x (select is 0x%x)\n",
+	       clk_hw_get_name(&common->hw), reg, cf->select);
+
+	return (reg & cf->select) ? cf->rates[1] : cf->rates[0];
+}
+
+int ccu_frac_helper_set_rate(struct ccu_common *common,
+			     struct _ccu_frac *cf,
+			     unsigned long rate)
+{
+	unsigned long flags;
+	u32 reg, sel;
+
+	if (!(common->features & CCU_FEATURE_FRACTIONAL))
+		return -EINVAL;
+
+	if (cf->rates[0] == rate)
+		sel = 0;
+	else if (cf->rates[1] == rate)
+		sel = cf->select;
+	else
+		return -EINVAL;
+
+	spin_lock_irqsave(common->lock, flags);
+	reg = readl(common->base + common->reg);
+	reg &= ~cf->select;
+	writel(reg | sel, common->base + common->reg);
+	spin_unlock_irqrestore(common->lock, flags);
+
+	return 0;
+}
diff --git a/drivers/clk/sunxi-ng/ccu_frac.h b/drivers/clk/sunxi-ng/ccu_frac.h
new file mode 100644
index 000000000000..e4c670b1cdfe
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu_frac.h
@@ -0,0 +1,53 @@
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
+#ifndef _CCU_FRAC_H_
+#define _CCU_FRAC_H_
+
+#include <linux/clk-provider.h>
+
+#include "ccu_common.h"
+
+struct _ccu_frac {
+	u32		enable;
+	u32		select;
+
+	unsigned long	rates[2];
+};
+
+#define _SUNXI_CCU_FRAC(_enable, _select, _rate1, _rate2)		\
+	{								\
+		.enable	= _enable,					\
+		.select	= _select,					\
+		.rates = { _rate1, _rate2 },				\
+	}
+
+bool ccu_frac_helper_is_enabled(struct ccu_common *common,
+				struct _ccu_frac *cf);
+void ccu_frac_helper_enable(struct ccu_common *common,
+			    struct _ccu_frac *cf);
+void ccu_frac_helper_disable(struct ccu_common *common,
+			     struct _ccu_frac *cf);
+
+bool ccu_frac_helper_has_rate(struct ccu_common *common,
+			      struct _ccu_frac *cf,
+			      unsigned long rate);
+
+unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
+					struct _ccu_frac *cf);
+
+int ccu_frac_helper_set_rate(struct ccu_common *common,
+			     struct _ccu_frac *cf,
+			     unsigned long rate);
+
+#endif /* _CCU_FRAC_H_ */
-- 
2.9.0
