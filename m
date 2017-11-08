From: yixun.lan@amlogic.com (Yixun Lan)
Date: Wed, 8 Nov 2017 14:47:16 +0800
Subject: [PATCH 2/4] pinctrl: meson-axg: Introduce a pinctrl pinmux ops for
 Meson-AXG SoC
Message-ID: <20171108064717.32577-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

The pin controller has been updated in the Amlogic Meson AXG series,
which use continuous 4-bit register to select function for each pin.
In order to support this, a new pinmux operations "meson_axg_pmx_ops"
has been added.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/pinctrl/meson/Kconfig                 |   3 +
 drivers/pinctrl/meson/Makefile                |   1 +
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c | 118 ++++++++++++++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h |  62 ++++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.h         |   1 +
 5 files changed, 185 insertions(+)
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h

diff --git a/drivers/pinctrl/meson/Kconfig b/drivers/pinctrl/meson/Kconfig
index 1a51778759ea..fe5e6ca88412 100644
--- a/drivers/pinctrl/meson/Kconfig
+++ b/drivers/pinctrl/meson/Kconfig
@@ -38,4 +38,7 @@ config PINCTRL_MESON_GXL
 config PINCTRL_MESON8_PMX
 	bool
 
+config PINCTRL_MESON_AXG_PMX
+	bool
+
 endif
diff --git a/drivers/pinctrl/meson/Makefile b/drivers/pinctrl/meson/Makefile
index cbd47bb74549..8de839512677 100644
--- a/drivers/pinctrl/meson/Makefile
+++ b/drivers/pinctrl/meson/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_PINCTRL_MESON8) += pinctrl-meson8.o
 obj-$(CONFIG_PINCTRL_MESON8B) += pinctrl-meson8b.o
 obj-$(CONFIG_PINCTRL_MESON_GXBB) += pinctrl-meson-gxbb.o
 obj-$(CONFIG_PINCTRL_MESON_GXL) += pinctrl-meson-gxl.o
+obj-$(CONFIG_PINCTRL_MESON_AXG_PMX) += pinctrl-meson-axg-pmx.o
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
new file mode 100644
index 000000000000..e8931d9cf863
--- /dev/null
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.c
@@ -0,0 +1,118 @@
+/*
+ * Second generation of pinmux driver for Amlogic Meson-AXG SoC.
+ *
+ * Copyright (c) 2017 Baylibre SAS.
+ * Author:  Jerome Brunet  <jbrunet@baylibre.com>
+ *
+ * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
+ * Author: Xingyu Chen <xingyu.chen@amlogic.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ or MIT)
+ */
+
+/*
+ * This new generation of pinctrl IP is mainly adopted by the
+ * Meson-AXG SoC and later series, which use 4-width continuous
+ * register bit to select the function for each pin.
+ *
+ * The value 0 is always selecting the GPIO mode, while other
+ * values (start from 1) for selecting the function mode.
+ */
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#include "pinctrl-meson.h"
+#include "pinctrl-meson-axg-pmx.h"
+
+static int meson_axg_pmx_get_bank(struct meson_pinctrl *pc,
+			unsigned int pin,
+			struct meson_pmx_bank **bank)
+{
+	int i;
+	struct meson_axg_pmx_data *pmx = pc->data->pmx_data;
+
+	for (i = 0; i < pmx->num_pmx_banks; i++)
+		if (pin >= pmx->pmx_banks[i].first &&
+				pin <= pmx->pmx_banks[i].last) {
+			*bank = &pmx->pmx_banks[i];
+			return 0;
+		}
+
+	return -EINVAL;
+}
+
+static int meson_pmx_calc_reg_and_offset(struct meson_pmx_bank *bank,
+			unsigned int pin, unsigned int *reg,
+			unsigned int *offset)
+{
+	int shift;
+
+	shift = pin - bank->first;
+
+	*reg = bank->reg + (bank->offset + (shift << 2)) / 32;
+	*offset = (bank->offset + (shift << 2)) % 32;
+
+	return 0;
+}
+
+static int meson_axg_pmx_update_function(struct meson_pinctrl *pc,
+			unsigned int pin, unsigned int func)
+{
+	int ret;
+	int reg;
+	int offset;
+	struct meson_pmx_bank *bank;
+
+	ret = meson_axg_pmx_get_bank(pc, pin, &bank);
+	if (ret)
+		return ret;
+
+	meson_pmx_calc_reg_and_offset(bank, pin, &reg, &offset);
+
+	ret = regmap_update_bits(pc->reg_mux, reg << 2,
+		0xf << offset, (func & 0xf) << offset);
+
+	return ret;
+}
+
+static int meson_axg_pmx_set_mux(struct pinctrl_dev *pcdev,
+			unsigned int func_num, unsigned int group_num)
+{
+	int i;
+	int ret;
+	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
+	struct meson_pmx_func *func = &pc->data->funcs[func_num];
+	struct meson_pmx_group *group = &pc->data->groups[group_num];
+	struct meson_pmx_axg_data *pmx_data =
+		(struct meson_pmx_axg_data *)group->data;
+
+	dev_dbg(pc->dev, "enable function %s, group %s\n", func->name,
+		group->name);
+
+	for (i = 0; i < group->num_pins; i++) {
+		ret = meson_axg_pmx_update_function(pc, group->pins[i],
+			pmx_data->func);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int meson_axg_pmx_request_gpio(struct pinctrl_dev *pcdev,
+			struct pinctrl_gpio_range *range, unsigned int offset)
+{
+	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
+
+	return meson_axg_pmx_update_function(pc, offset, 0);
+}
+
+const struct pinmux_ops meson_axg_pmx_ops = {
+	.set_mux = meson_axg_pmx_set_mux,
+	.get_functions_count = meson_pmx_get_funcs_count,
+	.get_function_name = meson_pmx_get_func_name,
+	.get_function_groups = meson_pmx_get_groups,
+	.gpio_request_enable = meson_axg_pmx_request_gpio,
+};
diff --git a/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
new file mode 100644
index 000000000000..8ff88bf2e849
--- /dev/null
+++ b/drivers/pinctrl/meson/pinctrl-meson-axg-pmx.h
@@ -0,0 +1,62 @@
+/*
+ * Copyright (c) 2017 Baylibre SAS.
+ * Author:  Jerome Brunet  <jbrunet@baylibre.com>
+ *
+ * Copyright (c) 2017 Amlogic, Inc. All rights reserved.
+ * Author: Xingyu Chen <xingyu.chen@amlogic.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ or MIT)
+ */
+
+struct meson_pmx_bank {
+	const char *name;
+	unsigned int first;
+	unsigned int last;
+	unsigned int reg;
+	unsigned int offset;
+};
+
+struct meson_axg_pmx_data {
+	struct meson_pmx_bank *pmx_banks;
+	unsigned int num_pmx_banks;
+};
+
+#define BANK_PMX(n, f, l, r, o)				\
+	{							\
+		.name   = n,					\
+		.first	= f,					\
+		.last	= l,					\
+		.reg	= r,					\
+		.offset = o,					\
+	}
+
+struct meson_pmx_axg_data {
+        unsigned int func;
+};
+
+#define PMX_DATA(f)							\
+	{								\
+		.func = f,						\
+	}
+
+#define GROUP(grp, f)							\
+	{								\
+		.name = #grp,						\
+		.pins = grp ## _pins,                                   \
+		.num_pins = ARRAY_SIZE(grp ## _pins),			\
+		.data = (const struct meson_pmx_axg_data[]){		\
+			PMX_DATA(f),					\
+		},							\
+	}
+
+#define GPIO_GROUP(gpio)						\
+	{								\
+		.name = #gpio,						\
+		.pins = (const unsigned int[]){ gpio },			\
+		.num_pins = 1,						\
+		.data = (const struct meson_pmx_axg_data[]){		\
+			PMX_DATA(0),					\
+		},							\
+	}
+
+extern const struct pinmux_ops meson_axg_pmx_ops;
diff --git a/drivers/pinctrl/meson/pinctrl-meson.h b/drivers/pinctrl/meson/pinctrl-meson.h
index 183b6e471635..12a391109329 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.h
+++ b/drivers/pinctrl/meson/pinctrl-meson.h
@@ -108,6 +108,7 @@ struct meson_pinctrl_data {
 	struct meson_bank *banks;
 	unsigned int num_banks;
 	const struct pinmux_ops *pmx_ops;
+	void *pmx_data;
 };
 
 struct meson_pinctrl {
-- 
2.14.1
