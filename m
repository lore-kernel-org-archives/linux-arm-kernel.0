From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 28 Jul 2012 14:58:38 +0800
Subject: [PATCH 2/6] pinctrl: add pinconf support in pxa3xx
In-Reply-To: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1343458722-17127-3-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 drivers/pinctrl/pinctrl-pxa3xx.c |  189 ++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-pxa3xx.h |   17 ++++
 2 files changed, 206 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-pxa3xx.c b/drivers/pinctrl/pinctrl-pxa3xx.c
index f14cd6b..cae74db 100644
--- a/drivers/pinctrl/pinctrl-pxa3xx.c
+++ b/drivers/pinctrl/pinctrl-pxa3xx.c
@@ -16,6 +16,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/pinctrl/machine.h>
+#include <linux/pinctrl/pinconf.h>
 #include "pinctrl-pxa3xx.h"
 
 static struct pinctrl_gpio_range pxa3xx_pinctrl_gpio_range = {
@@ -168,6 +170,192 @@ static struct pinmux_ops pxa3xx_pmx_ops = {
 	.gpio_request_enable	= pxa3xx_pmx_request_gpio,
 };
 
+static int pxa3xx_pinconf_get(struct pinctrl_dev *pctrldev,
+			      unsigned pin, unsigned long *config)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	unsigned int data, mask;
+	int mfpr;
+
+	mfpr = info->mfp[pin].mfpr;
+	data = readl_relaxed(info->virt_base + mfpr);
+
+	*config = 0;
+	mask = PXA3XX_MFPR_PULL_SEL | PXA3XX_MFPR_PULL_UP;
+	if ((data & mask) == mask)
+		*config |= PXA3XX_PINCONF_PULL_UP;
+	mask = PXA3XX_MFPR_PULL_SEL | PXA3XX_MFPR_PULL_DOWN;
+	if ((data & mask) == mask)
+		*config |= PXA3XX_PINCONF_PULL_DOWN;
+	mask = info->ds_mask;
+	if (data & mask) {
+		*config |= PXA3XX_PINCONF_DRIVE_STRENGTH;
+		*config |= ((data & mask) >> info->ds_shift)
+				<< PXA3XX_PINCONF_DS_SHIFT;
+	}
+	mask = info->slp_mask;
+	if (data & mask) {
+		if (data & info->slp_input_low)
+			*config |= PXA3XX_PINCONF_LOWPOWER_PULL_DOWN;
+		if (data & info->slp_input_high)
+			*config |= PXA3XX_PINCONF_LOWPOWER_PULL_UP;
+		if (data & info->slp_output_low)
+			*config |= PXA3XX_PINCONF_LOWPOWER_DRIVE_LOW;
+		if (data & info->slp_output_high)
+			*config |= PXA3XX_PINCONF_LOWPOWER_DRIVE_HIGH;
+		if (data & info->slp_float)
+			*config |= PXA3XX_PINCONF_LOWPOWER_FLOAT;
+	} else
+		*config |= PXA3XX_PINCONF_LOWPOWER_ZERO;
+	return 0;
+}
+
+static int pxa3xx_pinconf_set(struct pinctrl_dev *pctrldev,
+			      unsigned pin, unsigned long config)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	unsigned int data;
+	int mfpr;
+
+	mfpr = info->mfp[pin].mfpr;
+	data = readl_relaxed(info->virt_base + mfpr);
+	switch (config & PXA3XX_PINCONF_MASK) {
+	case PXA3XX_PINCONF_PULL_DOWN:
+		data |= PXA3XX_MFPR_PULL_SEL | PXA3XX_MFPR_PULL_DOWN;
+		break;
+	case PXA3XX_PINCONF_PULL_UP:
+		data |= PXA3XX_MFPR_PULL_SEL | PXA3XX_MFPR_PULL_UP;
+		break;
+	case PXA3XX_PINCONF_DRIVE_STRENGTH:
+		data &= ~info->ds_mask;
+		data |= (config >> PXA3XX_PINCONF_DS_SHIFT) << info->ds_shift;
+		break;
+	case PXA3XX_PINCONF_LOWPOWER_DRIVE_HIGH:
+		data &= ~info->slp_mask;
+		data |= info->slp_output_high;
+		break;
+	case PXA3XX_PINCONF_LOWPOWER_DRIVE_LOW:
+		data &= ~info->slp_mask;
+		data |= info->slp_output_low;
+		break;
+	case PXA3XX_PINCONF_LOWPOWER_PULL_UP:
+		data &= ~info->slp_mask;
+		data |= info->slp_input_high;
+		break;
+	case PXA3XX_PINCONF_LOWPOWER_PULL_DOWN:
+		data &= ~info->slp_mask;
+		data |= info->slp_input_low;
+		break;
+	case PXA3XX_PINCONF_LOWPOWER_FLOAT:
+		data &= ~info->slp_mask;
+		data |= info->slp_float;
+		break;
+	case PXA3XX_PINCONF_LOWPOWER_ZERO:
+		data &= ~info->slp_mask;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+	writel_relaxed(data, info->virt_base + mfpr);
+	return 0;
+}
+
+static int pxa3xx_pinconf_group_get(struct pinctrl_dev *pctrldev,
+				    unsigned group, unsigned long *config)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	const unsigned *pins = info->grps[group].pins;
+	int npins, i;
+	unsigned long conf, match = 0;
+
+	npins = info->grps[group].npins;
+	for (i = 0; i < npins; i++) {
+		pxa3xx_pinconf_get(pctrldev, pins[i], &conf);
+		if (!match)
+			match = conf;
+		else if (match != conf) {
+			*config = conf;
+			return -EINVAL;
+		}
+	}
+	*config = conf;
+	return 0;
+}
+
+static int pxa3xx_pinconf_group_set(struct pinctrl_dev *pctrldev,
+				    unsigned group, unsigned long config)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	const unsigned *pins = info->grps[group].pins;
+	int npins, i;
+
+	npins = info->grps[group].npins;
+	for (i = 0; i < npins; i++)
+		pxa3xx_pinconf_set(pctrldev, pins[i], config);
+	return 0;
+}
+
+static void pxa3xx_pinconf_dbg_show(struct pinctrl_dev *pctrldev,
+				    struct seq_file *s, unsigned offset)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	unsigned long config;
+	char buf[80];
+	int i = 0, mfpr;
+
+	pxa3xx_pinconf_get(pctrldev, offset, &config);
+	memset(buf, 0, 80);
+	if (config & PXA3XX_PINCONF_PULL_UP)
+		i += sprintf(buf + i, "PULL UP, ");
+	if (config & PXA3XX_PINCONF_PULL_DOWN)
+		i += sprintf(buf + i, "PULL DOWN, ");
+	if (config & PXA3XX_PINCONF_DRIVE_STRENGTH)
+		i += sprintf(buf + i, "DRIVE STRENGTH (%ld), ",
+			config >> PXA3XX_PINCONF_DS_SHIFT);
+	if (config & PXA3XX_PINCONF_LOWPOWER_PULL_UP)
+		i += sprintf(buf + i, "LP PULL UP, ");
+	if (config & PXA3XX_PINCONF_LOWPOWER_PULL_DOWN)
+		i += sprintf(buf + i, "LP PULL DOWN, ");
+	if (config & PXA3XX_PINCONF_LOWPOWER_DRIVE_HIGH)
+		i += sprintf(buf + i, "LP DRIVE HIGH, ");
+	if (config & PXA3XX_PINCONF_LOWPOWER_DRIVE_LOW)
+		i += sprintf(buf + i, "LP DRIVE LOW, ");
+	if (config & PXA3XX_PINCONF_LOWPOWER_FLOAT)
+		i += sprintf(buf + i, "LP FLOAT, ");
+	if (config & PXA3XX_PINCONF_LOWPOWER_ZERO)
+		i += sprintf(buf + i, "LP ZERO, ");
+	seq_printf(s, "%s\n", buf);
+
+	mfpr = info->mfp[offset].mfpr;
+	seq_printf(s, "reg[0x%x]:0x%x\n", info->phy_base + mfpr,
+		   readl_relaxed(info->virt_base + mfpr));
+}
+
+static void pxa3xx_pinconf_group_dbg_show(struct pinctrl_dev *pctrldev,
+					  struct seq_file *s, unsigned group)
+{
+	struct pxa3xx_pinmux_info *info = pinctrl_dev_get_drvdata(pctrldev);
+	const unsigned *pins = info->grps[group].pins;
+	int ret;
+	unsigned long config;
+
+	ret = pxa3xx_pinconf_group_get(pctrldev, group, &config);
+	if (ret < 0) {
+		seq_printf(s, "group config is not consistent\n");
+		return;
+	}
+	pxa3xx_pinconf_dbg_show(pctrldev, s, pins[0]);
+}
+
+static struct pinconf_ops pxa3xx_pinconf_ops = {
+	.pin_config_get		= pxa3xx_pinconf_get,
+	.pin_config_set		= pxa3xx_pinconf_set,
+	.pin_config_group_get	= pxa3xx_pinconf_group_get,
+	.pin_config_group_set	= pxa3xx_pinconf_group_set,
+	.pin_config_dbg_show	= pxa3xx_pinconf_dbg_show,
+	.pin_config_group_dbg_show = pxa3xx_pinconf_group_dbg_show,
+};
+
 int pxa3xx_pinctrl_register(struct platform_device *pdev,
 			    struct pxa3xx_pinmux_info *info)
 {
@@ -182,6 +370,7 @@ int pxa3xx_pinctrl_register(struct platform_device *pdev,
 	desc->npins = info->num_pads;
 	desc->pctlops = &pxa3xx_pctrl_ops;
 	desc->pmxops = &pxa3xx_pmx_ops;
+	desc->confops = &pxa3xx_pinconf_ops;
 	info->dev = &pdev->dev;
 	pxa3xx_pinctrl_gpio_range.npins = info->num_gpio;
 
diff --git a/drivers/pinctrl/pinctrl-pxa3xx.h b/drivers/pinctrl/pinctrl-pxa3xx.h
index 8135744..fdcf805 100644
--- a/drivers/pinctrl/pinctrl-pxa3xx.h
+++ b/drivers/pinctrl/pinctrl-pxa3xx.h
@@ -12,6 +12,7 @@
  */
 
 #ifndef __PINCTRL_PXA3XX_H
+#define __PINCTRL_PXA3XX_H
 
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
@@ -23,6 +24,22 @@
 #define PXA3xx_MAX_MUX		8
 #define MFPR_FUNC_MASK		0x7
 
+#define PXA3XX_PINCONF_PULL_UP			(1 << 0)
+#define PXA3XX_PINCONF_PULL_DOWN		(1 << 1)
+#define PXA3XX_PINCONF_DRIVE_STRENGTH		(1 << 2)
+#define PXA3XX_PINCONF_LOWPOWER_PULL_UP		(1 << 3)
+#define PXA3XX_PINCONF_LOWPOWER_PULL_DOWN	(1 << 4)
+#define PXA3XX_PINCONF_LOWPOWER_DRIVE_HIGH	(1 << 5)
+#define PXA3XX_PINCONF_LOWPOWER_DRIVE_LOW	(1 << 6)
+#define PXA3XX_PINCONF_LOWPOWER_FLOAT		(1 << 7)
+#define PXA3XX_PINCONF_LOWPOWER_ZERO		(1 << 8) /* lowpower bits: 0 */
+#define PXA3XX_PINCONF_MASK			0xffff
+#define PXA3XX_PINCONF_DS_SHIFT			16
+
+#define PXA3XX_MFPR_PULL_SEL			(1 << 15)
+#define PXA3XX_MFPR_PULL_UP			(1 << 14)
+#define PXA3XX_MFPR_PULL_DOWN			(1 << 13)
+
 enum pxa_cpu_type {
 	PINCTRL_INVALID = 0,
 	PINCTRL_PXA300,
-- 
1.7.9.5
