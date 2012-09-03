From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:25 +0100
Subject: [PATCH 05/11] clk: Versatile Express clock generators ("osc") driver
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-6-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver provides a common clock framework hardware driver
for Versatile Express clock generators (a.k.a "osc") controlled
via the config bus.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/include/asm/hardware/sp810.h    |    2 +
 drivers/clk/versatile/Makefile           |    1 +
 drivers/clk/versatile/clk-vexpress-osc.c |  154 ++++++++++++++++++++++++++++++
 include/linux/vexpress.h                 |    9 ++
 4 files changed, 166 insertions(+)
 create mode 100644 drivers/clk/versatile/clk-vexpress-osc.c

diff --git a/arch/arm/include/asm/hardware/sp810.h b/arch/arm/include/asm/hardware/sp810.h
index 6b9b077..afd7e91 100644
--- a/arch/arm/include/asm/hardware/sp810.h
+++ b/arch/arm/include/asm/hardware/sp810.h
@@ -56,6 +56,8 @@
 #define SCCTRL_TIMEREN1SEL_REFCLK	(0 << 17)
 #define SCCTRL_TIMEREN1SEL_TIMCLK	(1 << 17)
 
+#define SCCTRL_TIMERENnSEL_SHIFT(n)	(15 + ((n) * 2))
+
 static inline void sysctl_soft_reset(void __iomem *base)
 {
 	/* switch to slow mode */
diff --git a/drivers/clk/versatile/Makefile b/drivers/clk/versatile/Makefile
index c0a0f64..dd32e77 100644
--- a/drivers/clk/versatile/Makefile
+++ b/drivers/clk/versatile/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_ICST)		+= clk-icst.o
 obj-$(CONFIG_ARCH_INTEGRATOR)	+= clk-integrator.o
 obj-$(CONFIG_ARCH_REALVIEW)	+= clk-realview.o
+obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += clk-vexpress-osc.o
diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
new file mode 100644
index 0000000..969e03f
--- /dev/null
+++ b/drivers/clk/versatile/clk-vexpress-osc.c
@@ -0,0 +1,154 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/slab.h>
+#include <linux/vexpress.h>
+
+struct vexpress_osc {
+	struct vexpress_config_device *vecdev;
+	struct clk_hw hw;
+	unsigned long rate_min;
+	unsigned long rate_max;
+};
+
+#define to_vexpress_osc(osc) container_of(osc, struct vexpress_osc, hw)
+
+static unsigned long vexpress_osc_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct vexpress_osc *osc = to_vexpress_osc(hw);
+	u32 rate;
+
+	vexpress_config_read(osc->vecdev, 0, &rate);
+
+	return rate;
+}
+
+static long vexpress_osc_round_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long *parent_rate)
+{
+	struct vexpress_osc *osc = to_vexpress_osc(hw);
+
+	if (WARN_ON(rate < osc->rate_min))
+		rate = osc->rate_min;
+
+	if (WARN_ON(rate > osc->rate_max))
+		rate = osc->rate_max;
+
+	return rate;
+}
+
+static int vexpress_osc_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct vexpress_osc *osc = to_vexpress_osc(hw);
+
+	return vexpress_config_write(osc->vecdev, 0, rate);
+}
+
+static struct clk_ops vexpress_osc_ops = {
+	.recalc_rate = vexpress_osc_recalc_rate,
+	.round_rate = vexpress_osc_round_rate,
+	.set_rate = vexpress_osc_set_rate,
+};
+
+
+static int vexpress_osc_probe(struct vexpress_config_device *vecdev)
+{
+	int err;
+	struct device_node *node = vecdev->dev.of_node;
+	struct vexpress_osc_info *info = vecdev->dev.platform_data;
+	struct clk_init_data init;
+	struct vexpress_osc *osc;
+	struct clk *clk;
+	const char * const *dev_ids = NULL;
+	u32 range[2];
+
+	if (vecdev->status & VEXPRESS_CONFIG_DEVICE_PROBED_EARLY)
+		return 0;
+
+	osc = kzalloc(sizeof(*osc), GFP_KERNEL);
+	if (!osc) {
+		err = -ENOMEM;
+		goto error;
+	}
+	osc->vecdev = vecdev;
+
+	if (info) {
+		init.name = info->clock_name;
+		osc->rate_min = info->rate_min;
+		osc->rate_max = info->rate_max;
+		dev_ids = info->dev_ids;
+	}
+
+	of_property_read_string(node, "clock-output-names", &init.name);
+
+	if (of_property_read_u32_array(node, "freq-range", range,
+			ARRAY_SIZE(range)) == 0) {
+		osc->rate_min = range[0];
+		osc->rate_max = range[1];
+	}
+
+	if (!init.name)
+		init.name = vecdev->name;
+	init.ops = &vexpress_osc_ops;
+	init.flags = CLK_IS_ROOT;
+	init.num_parents = 0;
+
+	osc->hw.init = &init;
+
+	dev_dbg(&vecdev->dev, "New osc %lu-%luHz\n",
+			osc->rate_min, osc->rate_max);
+
+	clk = clk_register(NULL, &osc->hw);
+	if (IS_ERR(clk)) {
+		err = PTR_ERR(clk);
+		goto error;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
+
+	while (dev_ids && *dev_ids) {
+		err = clk_register_clkdev(clk, NULL, *dev_ids);
+		if (err)
+			dev_warn(&vecdev->dev, "Failed to register clkdev lookup for '%s'!\n",
+					*dev_ids);
+		dev_ids++;
+	}
+
+	return 0;
+
+error:
+	kfree(osc);
+	return err;
+}
+
+static const unsigned vexpress_osc_funcs[] = {
+	VEXPRESS_CONFIG_FUNC_OSC,
+	0,
+};
+
+static struct vexpress_config_driver vexpress_osc_driver = {
+	.funcs = vexpress_osc_funcs,
+	.probe = vexpress_osc_probe,
+	.driver.name = "vexpress-osc",
+};
+
+int __init vexpress_osc_driver_register(void)
+{
+	return vexpress_config_driver_register(&vexpress_osc_driver);
+}
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
index 7b02341..4768e6e 100644
--- a/include/linux/vexpress.h
+++ b/include/linux/vexpress.h
@@ -121,4 +121,13 @@ int vexpress_config_write(struct vexpress_config_device *vecdev, int offset,
 void vexpress_power_off(void);
 void vexpress_restart(char str, const char *cmd);
 
+/* Clock generators */
+struct vexpress_osc_info {
+	const char *clock_name;
+	unsigned long rate_min;
+	unsigned long rate_max;
+	const char * const *dev_ids;
+};
+int vexpress_osc_driver_register(void);
+
 #endif
-- 
1.7.9.5
