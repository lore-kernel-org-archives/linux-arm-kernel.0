From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 12 Apr 2012 10:54:35 +0530
Subject: [PATCH V3 2/4] pinctrl: Add SPEAr pinctrl drivers
In-Reply-To: <cover.1334207964.git.viresh.kumar@st.com>
References: <cover.1334207964.git.viresh.kumar@st.com>
Message-ID: <3d7a76d17b4366e08b45d528a245147095bbcb10.1334207964.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds pinctrl driver for SPEAr platform. It also updates MAINTAINERS file
for SPEAr pinctrl drivers.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 MAINTAINERS                           |   23 +--
 drivers/pinctrl/Kconfig               |    2 +
 drivers/pinctrl/Makefile              |    2 +
 drivers/pinctrl/spear/Kconfig         |   14 ++
 drivers/pinctrl/spear/Makefile        |    3 +
 drivers/pinctrl/spear/pinctrl-spear.c |  349 +++++++++++++++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear.h |  142 +++++++++++++
 7 files changed, 520 insertions(+), 15 deletions(-)
 create mode 100644 drivers/pinctrl/spear/Kconfig
 create mode 100644 drivers/pinctrl/spear/Makefile
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e7ec09..1f2bc24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5233,6 +5233,14 @@ M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
 F:	drivers/pinctrl/
 
+PIN CONTROLLER - ST SPEAR
+M:	Viresh Kumar <viresh.kumar@st.com>
+L:	spear-devel at list.st.com
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+W:	http://www.st.com/spear
+S:	Maintained
+F:	driver/pinctrl/spear/
+
 PKTCDVD DRIVER
 M:	Peter Osterlund <petero2@telia.com>
 S:	Maintained
@@ -6329,21 +6337,6 @@ F:	arch/arm/mach-spear*/clock.c
 F:	arch/arm/plat-spear/clock.c
 F:	arch/arm/plat-spear/include/plat/clock.h
 
-SPEAR PAD MULTIPLEXING SUPPORT
-M:	Viresh Kumar <viresh.kumar@st.com>
-L:	spear-devel at list.st.com
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-W:	http://www.st.com/spear
-S:	Maintained
-F:	arch/arm/plat-spear/include/plat/padmux.h
-F:	arch/arm/plat-spear/padmux.c
-F:	arch/arm/mach-spear*/spear*xx.c
-F:	arch/arm/mach-spear*/include/mach/generic.h
-F:	arch/arm/mach-spear3xx/spear3*0.c
-F:	arch/arm/mach-spear3xx/spear3*0_evb.c
-F:	arch/arm/mach-spear6xx/spear600.c
-F:	arch/arm/mach-spear6xx/spear600_evb.c
-
 SPI SUBSYSTEM
 M:	Grant Likely <grant.likely@secretlab.ca>
 L:	spi-devel-general at lists.sourceforge.net
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index d68c878..9908bba 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -89,6 +89,8 @@ config PINCTRL_COH901
 	  COH 901 335 and COH 901 571/3. They contain 3, 5 or 7
 	  ports of 8 GPIO pins each.
 
+source "drivers/pinctrl/spear/Kconfig"
+
 endmenu
 
 endif
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 5412f60..878a2dc 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -17,3 +17,5 @@ obj-$(CONFIG_PINCTRL_TEGRA20)	+= pinctrl-tegra20.o
 obj-$(CONFIG_PINCTRL_TEGRA30)	+= pinctrl-tegra30.o
 obj-$(CONFIG_PINCTRL_U300)	+= pinctrl-u300.o
 obj-$(CONFIG_PINCTRL_COH901)	+= pinctrl-coh901.o
+
+obj-$(CONFIG_PLAT_SPEAR)	+= spear/
diff --git a/drivers/pinctrl/spear/Kconfig b/drivers/pinctrl/spear/Kconfig
new file mode 100644
index 0000000..47a0e295
--- /dev/null
+++ b/drivers/pinctrl/spear/Kconfig
@@ -0,0 +1,14 @@
+#
+# ST Microelectronics SPEAr PINCTRL drivers
+#
+
+if PLAT_SPEAR
+
+config PINCTRL_SPEAR
+	bool
+	depends on OF
+	select PINMUX
+	help
+	  This enables pin control drivers for SPEAr Platform
+
+endif
diff --git a/drivers/pinctrl/spear/Makefile b/drivers/pinctrl/spear/Makefile
new file mode 100644
index 0000000..69c1a51
--- /dev/null
+++ b/drivers/pinctrl/spear/Makefile
@@ -0,0 +1,3 @@
+# SPEAr pinmux support
+
+obj-$(CONFIG_PINCTRL_SPEAR)	+= pinctrl-spear.o
diff --git a/drivers/pinctrl/spear/pinctrl-spear.c b/drivers/pinctrl/spear/pinctrl-spear.c
new file mode 100644
index 0000000..c86a7fb
--- /dev/null
+++ b/drivers/pinctrl/spear/pinctrl-spear.c
@@ -0,0 +1,349 @@
+/*
+ * Driver for the ST Microelectronics SPEAr pinmux
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * Inspired from:
+ * - U300 Pinctl drivers
+ * - Tegra Pinctl drivers
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "pinctrl-spear.h"
+
+#define DRIVER_NAME "spear-pinmux"
+
+static inline u32 pmx_readl(struct spear_pmx *pmx, u32 reg)
+{
+	return readl_relaxed(pmx->vbase + reg);
+}
+
+static inline void pmx_writel(struct spear_pmx *pmx, u32 val, u32 reg)
+{
+	writel_relaxed(val, pmx->vbase + reg);
+}
+
+static int set_mode(struct spear_pmx *pmx, int mode)
+{
+	struct spear_pmx_mode *pmx_mode = NULL;
+	int i;
+	u32 val;
+
+	if (!pmx->machdata->pmx_modes || !pmx->machdata->npmx_modes)
+		return -EINVAL;
+
+	for (i = 0; i < pmx->machdata->npmx_modes; i++) {
+		if (pmx->machdata->pmx_modes[i]->mode == (1 << mode)) {
+			pmx_mode = pmx->machdata->pmx_modes[i];
+			break;
+		}
+	}
+
+	if (!pmx_mode)
+		return -EINVAL;
+
+	val = pmx_readl(pmx, pmx_mode->reg);
+	val &= ~pmx_mode->mask;
+	val |= pmx_mode->val;
+	pmx_writel(pmx, val, pmx_mode->reg);
+
+	pmx->machdata->mode = pmx_mode->mode;
+	dev_info(pmx->dev, "Configured Mode: %s with id: %x\n\n",
+			pmx_mode->name ? pmx_mode->name : "no_name",
+			pmx_mode->reg);
+
+	return 0;
+}
+
+void __devinit pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg)
+{
+	struct spear_pingroup *pgroup;
+	struct spear_modemux *modemux;
+	int i, j, group;
+
+	for (group = 0; group < machdata->ngroups; group++) {
+		pgroup = machdata->groups[group];
+
+		for (i = 0; i < pgroup->nmodemuxs; i++) {
+			modemux = &pgroup->modemuxs[i];
+
+			for (j = 0; j < modemux->nmuxregs; j++)
+				if (modemux->muxregs[j].reg == 0xFFFF)
+					modemux->muxregs[j].reg = reg;
+		}
+	}
+}
+
+static int spear_pinctrl_get_groups_cnt(struct pinctrl_dev *pctldev)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pmx->machdata->ngroups;
+}
+
+static const char *spear_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+		unsigned group)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pmx->machdata->groups[group]->name;
+}
+
+static int spear_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+		unsigned group, const unsigned **pins, unsigned *num_pins)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	*pins = pmx->machdata->groups[group]->pins;
+	*num_pins = pmx->machdata->groups[group]->npins;
+
+	return 0;
+}
+
+static void spear_pinctrl_pin_dbg_show(struct pinctrl_dev *pctldev,
+		struct seq_file *s, unsigned offset)
+{
+	seq_printf(s, " " DRIVER_NAME);
+}
+
+int spear_pinctrl_dt_node_to_map(struct pinctrl_dev *pctldev,
+				 struct device_node *np_config,
+				 struct pinctrl_map **map, unsigned *num_maps)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+	struct device_node *np;
+	struct property *prop;
+	const char *function, *group;
+	int ret, index = 0, count = 0;
+
+	/* calculate number of maps required */
+	for_each_child_of_node(np_config, np) {
+		ret = of_property_read_string(np, "st,function", &function);
+		if (ret < 0)
+			return ret;
+
+		ret = of_property_count_strings(np, "st,pins");
+		if (ret < 0)
+			return ret;
+
+		count += ret;
+	}
+
+	if (!count) {
+		dev_err(pmx->dev, "No child nodes passed via DT\n");
+		return -ENODEV;
+	}
+
+	*map = kzalloc(sizeof(*map) * count, GFP_KERNEL);
+	if (!*map)
+		return -ENOMEM;
+
+	for_each_child_of_node(np_config, np) {
+		of_property_read_string(np, "st,function", &function);
+		of_property_for_each_string(np, "st,pins", prop, group) {
+			(*map)[index].type = PIN_MAP_TYPE_MUX_GROUP;
+			(*map)[index].data.mux.group = group;
+			(*map)[index].data.mux.function = function;
+			index++;
+		}
+	}
+
+	*num_maps = count;
+
+	return 0;
+}
+
+void spear_pinctrl_dt_free_map(struct pinctrl_dev *pctldev,
+		struct pinctrl_map *map, unsigned num_maps)
+{
+	kfree(map);
+}
+
+static struct pinctrl_ops spear_pinctrl_ops = {
+	.get_groups_count = spear_pinctrl_get_groups_cnt,
+	.get_group_name = spear_pinctrl_get_group_name,
+	.get_group_pins = spear_pinctrl_get_group_pins,
+	.pin_dbg_show = spear_pinctrl_pin_dbg_show,
+	.dt_node_to_map = spear_pinctrl_dt_node_to_map,
+	.dt_free_map = spear_pinctrl_dt_free_map,
+};
+
+static int spear_pinctrl_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pmx->machdata->nfunctions;
+}
+
+static const char *spear_pinctrl_get_func_name(struct pinctrl_dev *pctldev,
+		unsigned function)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	return pmx->machdata->functions[function]->name;
+}
+
+static int spear_pinctrl_get_func_groups(struct pinctrl_dev *pctldev,
+		unsigned function, const char *const **groups,
+		unsigned * const ngroups)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = pmx->machdata->functions[function]->groups;
+	*ngroups = pmx->machdata->functions[function]->ngroups;
+
+	return 0;
+}
+
+static int spear_pinctrl_endisable(struct pinctrl_dev *pctldev,
+		unsigned function, unsigned group, bool enable)
+{
+	struct spear_pmx *pmx = pinctrl_dev_get_drvdata(pctldev);
+	const struct spear_pingroup *pgroup;
+	const struct spear_modemux *modemux;
+	struct spear_muxreg *muxreg;
+	u32 val, temp;
+	int i, j;
+	bool found = false;
+
+	pgroup = pmx->machdata->groups[group];
+
+	for (i = 0; i < pgroup->nmodemuxs; i++) {
+		modemux = &pgroup->modemuxs[i];
+
+		/* SoC have any modes */
+		if (pmx->machdata->modes_supported) {
+			if (!(pmx->machdata->mode & modemux->modes))
+				continue;
+		}
+
+		found = true;
+		for (j = 0; j < modemux->nmuxregs; j++) {
+			muxreg = &modemux->muxregs[j];
+
+			val = pmx_readl(pmx, muxreg->reg);
+			val &= ~muxreg->mask;
+
+			if (enable)
+				temp = muxreg->val;
+			else
+				temp = ~muxreg->val;
+
+			val |= temp;
+			pmx_writel(pmx, val, muxreg->reg);
+		}
+	}
+
+	if (!found) {
+		dev_err(pmx->dev, "pinmux group: %s not supported\n",
+				pgroup->name);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int spear_pinctrl_enable(struct pinctrl_dev *pctldev, unsigned function,
+		unsigned group)
+{
+	return spear_pinctrl_endisable(pctldev, function, group, true);
+}
+
+static void spear_pinctrl_disable(struct pinctrl_dev *pctldev,
+		unsigned function, unsigned group)
+{
+	spear_pinctrl_endisable(pctldev, function, group, false);
+}
+
+static struct pinmux_ops spear_pinmux_ops = {
+	.get_functions_count = spear_pinctrl_get_funcs_count,
+	.get_function_name = spear_pinctrl_get_func_name,
+	.get_function_groups = spear_pinctrl_get_func_groups,
+	.enable = spear_pinctrl_enable,
+	.disable = spear_pinctrl_disable,
+};
+
+static struct pinctrl_desc spear_pinctrl_desc = {
+	.name = DRIVER_NAME,
+	.pctlops = &spear_pinctrl_ops,
+	.pmxops = &spear_pinmux_ops,
+	.owner = THIS_MODULE,
+};
+
+int __devinit spear_pinctrl_probe(struct platform_device *pdev,
+		struct spear_pinctrl_machdata *machdata)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct spear_pmx *pmx;
+
+	if (!machdata)
+		return -ENODEV;
+
+	pmx = devm_kzalloc(&pdev->dev, sizeof(*pmx), GFP_KERNEL);
+	if (!pmx) {
+		dev_err(&pdev->dev, "Can't alloc spear_pmx\n");
+		return -ENOMEM;
+	}
+
+	pmx->vbase = of_iomap(np, 0);
+	if (!pmx->vbase) {
+		dev_err(&pdev->dev, "Couldn't ioremap at index 0\n");
+		return -ENODEV;
+	}
+
+	pmx->dev = &pdev->dev;
+	pmx->machdata = machdata;
+
+	/* configure mode, if supported by SoC */
+	if (machdata->modes_supported) {
+		int mode = 0;
+
+		if (of_property_read_u32(np, "st,pinmux-mode", &mode)) {
+			dev_err(&pdev->dev, "OF: pinmux mode not passed\n");
+			return -EINVAL;
+		}
+
+		if (set_mode(pmx, mode)) {
+			dev_err(&pdev->dev, "OF: Couldn't configure mode: %x\n",
+					mode);
+			return -EINVAL;
+		}
+	}
+
+	platform_set_drvdata(pdev, pmx);
+
+	spear_pinctrl_desc.pins = machdata->pins;
+	spear_pinctrl_desc.npins = machdata->npins;
+
+	pmx->pctl = pinctrl_register(&spear_pinctrl_desc, &pdev->dev, pmx);
+	if (IS_ERR(pmx->pctl)) {
+		dev_err(&pdev->dev, "Couldn't register pinctrl driver\n");
+		return PTR_ERR(pmx->pctl);
+	}
+
+	return 0;
+}
+
+int __devexit spear_pinctrl_remove(struct platform_device *pdev)
+{
+	struct spear_pmx *pmx = platform_get_drvdata(pdev);
+
+	pinctrl_unregister(pmx->pctl);
+
+	return 0;
+}
diff --git a/drivers/pinctrl/spear/pinctrl-spear.h b/drivers/pinctrl/spear/pinctrl-spear.h
new file mode 100644
index 0000000..47a6b5b
--- /dev/null
+++ b/drivers/pinctrl/spear/pinctrl-spear.h
@@ -0,0 +1,142 @@
+/*
+ * Driver header file for the ST Microelectronics SPEAr pinmux
+ *
+ * Copyright (C) 2012 ST Microelectronics
+ * Viresh Kumar <viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __PINMUX_SPEAR_H__
+#define __PINMUX_SPEAR_H__
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/types.h>
+
+struct platform_device;
+struct device;
+
+/**
+ * struct spear_pmx_mode - SPEAr pmx mode
+ * @name: name of pmx mode
+ * @mode: mode id
+ * @reg: register for configuring this mode
+ * @mask: mask of this mode in reg
+ * @val: val to be configured at reg after doing (val & mask)
+ */
+struct spear_pmx_mode {
+	const char *const name;
+	u16 mode;
+	u16 reg;
+	u16 mask;
+	u32 val;
+};
+
+/**
+ * struct spear_muxreg - SPEAr mux reg configuration
+ * @reg: register offset
+ * @mask: mask bits
+ * @val: val to be written on mask bits
+ */
+struct spear_muxreg {
+	u16 reg;
+	u32 mask;
+	u32 val;
+};
+
+/**
+ * struct spear_modemux - SPEAr mode mux configuration
+ * @modes: mode ids supported by this group of muxregs
+ * @nmuxregs: number of muxreg configurations to be done for modes
+ * @muxregs: array of muxreg configurations to be done for modes
+ */
+struct spear_modemux {
+	u16 modes;
+	u8 nmuxregs;
+	struct spear_muxreg *muxregs;
+};
+
+/**
+ * struct spear_pingroup - SPEAr pin group configurations
+ * @name: name of pin group
+ * @pins: array containing pin numbers
+ * @npins: size of pins array
+ * @modemuxs: array of modemux configurations for this pin group
+ * @nmodemuxs: size of array modemuxs
+ *
+ * A representation of a group of pins in the SPEAr pin controller. Each group
+ * allows some parameter or parameters to be configured.
+ */
+struct spear_pingroup {
+	const char *name;
+	const unsigned *pins;
+	unsigned npins;
+	struct spear_modemux *modemuxs;
+	unsigned nmodemuxs;
+};
+
+/**
+ * struct spear_function - SPEAr pinctrl mux function
+ * @name: The name of the function, exported to pinctrl core.
+ * @groups: An array of pin groups that may select this function.
+ * @ngroups: The number of entries in @groups.
+ */
+struct spear_function {
+	const char *name;
+	const char *const *groups;
+	unsigned ngroups;
+};
+
+/**
+ * struct spear_pinctrl_machdata - SPEAr pin controller machine driver
+ *	configuration
+ * @pins: An array describing all pins the pin controller affects.
+ *	All pins which are also GPIOs must be listed first within the *array,
+ *	and be numbered identically to the GPIO controller's *numbering.
+ * @npins: The numbmer of entries in @pins.
+ * @functions: An array describing all mux functions the SoC supports.
+ * @nfunctions: The numbmer of entries in @functions.
+ * @groups: An array describing all pin groups the pin SoC supports.
+ * @ngroups: The numbmer of entries in @groups.
+ *
+ * @modes_supported: Does SoC support modes
+ * @mode: mode configured from probe
+ * @pmx_modes: array of modes supported by SoC
+ * @npmx_modes: number of entries in pmx_modes.
+ */
+struct spear_pinctrl_machdata {
+	const struct pinctrl_pin_desc *pins;
+	unsigned npins;
+	struct spear_function **functions;
+	unsigned nfunctions;
+	struct spear_pingroup **groups;
+	unsigned ngroups;
+
+	bool modes_supported;
+	u16 mode;
+	struct spear_pmx_mode **pmx_modes;
+	unsigned npmx_modes;
+};
+
+/**
+ * struct spear_pmx - SPEAr pinctrl mux
+ * @dev: pointer to struct dev of platform_device registered
+ * @pctl: pointer to struct pinctrl_dev
+ * @machdata: pointer to SoC or machine specific structure
+ * @vbase: virtual base address of pinmux controller
+ */
+struct spear_pmx {
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct spear_pinctrl_machdata *machdata;
+	void __iomem *vbase;
+};
+
+/* exported routines */
+void __devinit pmx_init_addr(struct spear_pinctrl_machdata *machdata, u16 reg);
+int __devinit spear_pinctrl_probe(struct platform_device *pdev,
+		struct spear_pinctrl_machdata *machdata);
+int __devexit spear_pinctrl_remove(struct platform_device *pdev);
+#endif /* __PINMUX_SPEAR_H__ */
-- 
1.7.9
