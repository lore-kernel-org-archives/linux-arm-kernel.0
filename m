From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri, 10 Aug 2018 15:21:11 +0530
Subject: [PATCH v3 7/9] clk: actions: Add Actions Semi Owl SoCs Reset
 Management Unit support
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180810095113.25292-8-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Reset Management Unit (RMU) support for Actions Semi Owl SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Kconfig      |  1 +
 drivers/clk/actions/Makefile     |  1 +
 drivers/clk/actions/owl-common.h |  2 +
 drivers/clk/actions/owl-reset.c  | 66 ++++++++++++++++++++++++++++++++
 drivers/clk/actions/owl-reset.h  | 31 +++++++++++++++
 5 files changed, 101 insertions(+)
 create mode 100644 drivers/clk/actions/owl-reset.c
 create mode 100644 drivers/clk/actions/owl-reset.h

diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
index dc38c85a4833..04f0a6355726 100644
--- a/drivers/clk/actions/Kconfig
+++ b/drivers/clk/actions/Kconfig
@@ -2,6 +2,7 @@ config CLK_ACTIONS
 	bool "Clock driver for Actions Semi SoCs"
 	depends on ARCH_ACTIONS || COMPILE_TEST
 	select REGMAP_MMIO
+	select RESET_CONTROLLER
 	default ARCH_ACTIONS
 
 if CLK_ACTIONS
diff --git a/drivers/clk/actions/Makefile b/drivers/clk/actions/Makefile
index 78c17d56f991..ccfdf9781cef 100644
--- a/drivers/clk/actions/Makefile
+++ b/drivers/clk/actions/Makefile
@@ -7,6 +7,7 @@ clk-owl-y			+= owl-divider.o
 clk-owl-y			+= owl-factor.o
 clk-owl-y			+= owl-composite.o
 clk-owl-y			+= owl-pll.o
+clk-owl-y			+= owl-reset.o
 
 # SoC support
 obj-$(CONFIG_CLK_OWL_S700)	+= owl-s700.o
diff --git a/drivers/clk/actions/owl-common.h b/drivers/clk/actions/owl-common.h
index 56f01f7774aa..5a866a8b913d 100644
--- a/drivers/clk/actions/owl-common.h
+++ b/drivers/clk/actions/owl-common.h
@@ -26,6 +26,8 @@ struct owl_clk_desc {
 	struct owl_clk_common		**clks;
 	unsigned long			num_clks;
 	struct clk_hw_onecell_data	*hw_clks;
+	const struct owl_reset_map	*resets;
+	unsigned long			num_resets;
 	struct regmap			*regmap;
 };
 
diff --git a/drivers/clk/actions/owl-reset.c b/drivers/clk/actions/owl-reset.c
new file mode 100644
index 000000000000..203f8f34a8d4
--- /dev/null
+++ b/drivers/clk/actions/owl-reset.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Actions Semi Owl SoCs Reset Management Unit driver
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#include "owl-reset.h"
+
+static int owl_reset_assert(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->reset_map[id];
+
+	return regmap_update_bits(reset->regmap, map->reg, map->bit, 0);
+}
+
+static int owl_reset_deassert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->reset_map[id];
+
+	return regmap_update_bits(reset->regmap, map->reg, map->bit, map->bit);
+}
+
+static int owl_reset_reset(struct reset_controller_dev *rcdev,
+			   unsigned long id)
+{
+	owl_reset_assert(rcdev, id);
+	udelay(1);
+	owl_reset_deassert(rcdev, id);
+
+	return 0;
+}
+
+static int owl_reset_status(struct reset_controller_dev *rcdev,
+			    unsigned long id)
+{
+	struct owl_reset *reset = to_owl_reset(rcdev);
+	const struct owl_reset_map *map = &reset->reset_map[id];
+	u32 reg;
+	int ret;
+
+	ret = regmap_read(reset->regmap, map->reg, &reg);
+	if (ret)
+		return ret;
+
+	/*
+	 * The reset control API expects 0 if reset is not asserted,
+	 * which is the opposite of what our hardware uses.
+	 */
+	return !(map->bit & reg);
+}
+
+const struct reset_control_ops owl_reset_ops = {
+	.assert		= owl_reset_assert,
+	.deassert	= owl_reset_deassert,
+	.reset		= owl_reset_reset,
+	.status		= owl_reset_status,
+};
diff --git a/drivers/clk/actions/owl-reset.h b/drivers/clk/actions/owl-reset.h
new file mode 100644
index 000000000000..10f5774979a6
--- /dev/null
+++ b/drivers/clk/actions/owl-reset.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Actions Semi Owl SoCs Reset Management Unit driver
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_RESET_H_
+#define _OWL_RESET_H_
+
+#include <linux/reset-controller.h>
+
+struct owl_reset_map {
+	u32	reg;
+	u32	bit;
+};
+
+struct owl_reset {
+	struct reset_controller_dev	rcdev;
+	const struct owl_reset_map	*reset_map;
+	struct regmap			*regmap;
+};
+
+static inline struct owl_reset *to_owl_reset(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct owl_reset, rcdev);
+}
+
+extern const struct reset_control_ops owl_reset_ops;
+
+#endif /* _OWL_RESET_H_ */
-- 
2.17.1
