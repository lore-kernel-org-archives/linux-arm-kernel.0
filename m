From: stefan@agner.ch (Stefan Agner)
Date: Wed,  9 Mar 2016 18:16:52 -0800
Subject: [PATCH 11/18] pinctrl: pinctrl-imx: implement suspend/resume
In-Reply-To: <1457576219-7971-1-git-send-email-stefan@agner.ch>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
Message-ID: <1457576219-7971-12-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In some SoC's using the IMX pin controller, the IP looses its state
when entering lowest power modes. Enhance the driver with suspend/
resume functions restoring the pin states.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/pinctrl/freescale/pinctrl-imx.c   | 63 +++++++++++++++++++++++++++++++
 drivers/pinctrl/freescale/pinctrl-imx.h   |  3 ++
 drivers/pinctrl/freescale/pinctrl-vf610.c |  6 +++
 3 files changed, 72 insertions(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index a5bb939..42fc9a9 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -24,6 +24,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 
 #include "../core.h"
 #include "pinctrl-imx.h"
@@ -42,6 +43,8 @@ struct imx_pinctrl {
 	void __iomem *base;
 	void __iomem *input_sel_base;
 	const struct imx_pinctrl_soc_info *info;
+	u32 *mux_regs;
+	u32 *input_regs;
 };
 
 static const inline struct imx_pin_group *imx_pinctrl_find_group_by_name(
@@ -689,6 +692,54 @@ static int imx_pinctrl_probe_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int __maybe_unused imx_pinctrl_suspend(struct device *dev)
+{
+	struct imx_pinctrl *ipctl = dev_get_drvdata(dev);
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
+	int i;
+
+	for (i = 0; i < info->npins; i++) {
+		const struct imx_pin_reg *pin_reg = &info->pin_regs[i];
+
+		if (pin_reg->mux_reg == -1)
+			continue;
+
+		ipctl->mux_regs[i] = readl(ipctl->base + pin_reg->mux_reg);
+	}
+
+	for (i = 0; i < info->ninput_regs; i++)
+		ipctl->input_regs[i] = readl(ipctl->base +
+				info->input_regs_offset + i * sizeof(u32 *));
+
+	return 0;
+}
+
+static int __maybe_unused imx_pinctrl_resume(struct device *dev)
+{
+	struct imx_pinctrl *ipctl = dev_get_drvdata(dev);
+	const struct imx_pinctrl_soc_info *info = ipctl->info;
+	const struct imx_pin_reg *pin_reg;
+	int i;
+
+	for (i = 0; i < info->npins; i++) {
+		pin_reg = &info->pin_regs[i];
+		if (pin_reg->mux_reg == -1)
+			continue;
+
+		writel(ipctl->mux_regs[i], ipctl->base + pin_reg->mux_reg);
+	}
+
+	for (i = 0; i < info->ninput_regs; i++)
+		writel(ipctl->input_regs[i], ipctl->base +
+				info->input_regs_offset + i * sizeof(u32 *));
+
+	return 0;
+}
+
+const struct dev_pm_ops imx_pinctrl_dev_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(imx_pinctrl_suspend, imx_pinctrl_resume)
+};
+
 int imx_pinctrl_probe(struct platform_device *pdev,
 		      struct imx_pinctrl_soc_info *info)
 {
@@ -719,6 +770,18 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 		info->pin_regs[i].conf_reg = -1;
 	}
 
+#ifdef CONFIG_PM_SLEEP
+	ipctl->mux_regs = devm_kzalloc(&pdev->dev, sizeof(u32 *) *
+				       info->npins, GFP_KERNEL);
+	if (!ipctl->mux_regs)
+		return -ENOMEM;
+
+	ipctl->input_regs = devm_kzalloc(&pdev->dev, sizeof(u32 *) *
+					 info->ninput_regs, GFP_KERNEL);
+	if (!ipctl->input_regs)
+		return -ENOMEM;
+#endif
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ipctl->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(ipctl->base))
diff --git a/drivers/pinctrl/freescale/pinctrl-imx.h b/drivers/pinctrl/freescale/pinctrl-imx.h
index 2a592f6..56851a6 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.h
+++ b/drivers/pinctrl/freescale/pinctrl-imx.h
@@ -81,6 +81,8 @@ struct imx_pinctrl_soc_info {
 	unsigned int group_index;
 	struct imx_pmx_func *functions;
 	unsigned int nfunctions;
+	unsigned int input_regs_offset;
+	unsigned int ninput_regs;
 	unsigned int flags;
 };
 
@@ -99,4 +101,5 @@ struct imx_pinctrl_soc_info {
 int imx_pinctrl_probe(struct platform_device *pdev,
 			struct imx_pinctrl_soc_info *info);
 int imx_pinctrl_remove(struct platform_device *pdev);
+extern const struct dev_pm_ops imx_pinctrl_dev_pm_ops;
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/freescale/pinctrl-vf610.c b/drivers/pinctrl/freescale/pinctrl-vf610.c
index 587d1ff..b6280a8 100644
--- a/drivers/pinctrl/freescale/pinctrl-vf610.c
+++ b/drivers/pinctrl/freescale/pinctrl-vf610.c
@@ -19,6 +19,9 @@
 
 #include "pinctrl-imx.h"
 
+#define VF610_INPUT_REG_CNT		49
+#define VF610_INPUT_REG_BASE		0x2ec
+
 enum vf610_pads {
 	VF610_PAD_PTA6 = 0,
 	VF610_PAD_PTA8 = 1,
@@ -299,6 +302,8 @@ static const struct pinctrl_pin_desc vf610_pinctrl_pads[] = {
 static struct imx_pinctrl_soc_info vf610_pinctrl_info = {
 	.pins = vf610_pinctrl_pads,
 	.npins = ARRAY_SIZE(vf610_pinctrl_pads),
+	.input_regs_offset = VF610_INPUT_REG_BASE,
+	.ninput_regs = VF610_INPUT_REG_CNT,
 	.flags = SHARE_MUX_CONF_REG | ZERO_OFFSET_VALID,
 };
 
@@ -316,6 +321,7 @@ static struct platform_driver vf610_pinctrl_driver = {
 	.driver = {
 		.name = "vf610-pinctrl",
 		.of_match_table = vf610_pinctrl_of_match,
+		.pm = &imx_pinctrl_dev_pm_ops,
 	},
 	.probe = vf610_pinctrl_probe,
 	.remove = imx_pinctrl_remove,
-- 
2.7.2
