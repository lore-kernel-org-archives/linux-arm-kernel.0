From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 6 Jul 2012 17:09:22 +0800
Subject: [PATCH 1/2] pinctrl: pinctrl-imx: add support for set bits for
 general purpose registers
Message-ID: <1341565763-10074-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dong Aisheng <dong.aisheng@linaro.org>

The General Purpose Registers (GPR) is used to select operating modes for
general features in the SoC, usually not related to the IOMUX itself,
but it does belong to IOMUX controller.
We simply provide an convient API for driver to call to set the general purpose
register bits if needed.

Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
---
 drivers/pinctrl/pinctrl-imx.c   |   19 +++++++++++++++++++
 include/linux/fsl/imx-pinctrl.h |   24 ++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/fsl/imx-pinctrl.h

diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 44e9726..b83b902 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -54,6 +54,24 @@ struct imx_pinctrl {
 	const struct imx_pinctrl_soc_info *info;
 };
 
+static struct imx_pinctrl *imx_pinctrl;
+/*
+ * Set bits for general purpose registers
+ */
+void imx_pinctrl_set_gpr_register(u8 gpr, u8 start_bit, u8 num_bits, u32 value)
+{
+	u32 reg;
+
+	/* general purpose register is 32 bits size */
+	WARN_ON(!imx_pinctrl || start_bit > 31 || num_bits > 32);
+
+	reg = readl(imx_pinctrl->base + gpr * 4);
+	reg &= ~(((1 << num_bits) - 1) << start_bit);
+	reg |= (value << start_bit);
+	writel(reg, imx_pinctrl->base + gpr * 4);
+}
+EXPORT_SYMBOL_GPL(imx_pinctrl_set_gpr_register);
+
 static const struct imx_pin_reg *imx_find_pin_reg(
 				const struct imx_pinctrl_soc_info *info,
 				unsigned pin, bool is_mux, unsigned mux)
@@ -587,6 +605,7 @@ int __devinit imx_pinctrl_probe(struct platform_device *pdev,
 	if (!ipctl->base)
 		return -EBUSY;
 
+	imx_pinctrl = ipctl;
 	imx_pinctrl_desc.name = dev_name(&pdev->dev);
 	imx_pinctrl_desc.pins = info->pins;
 	imx_pinctrl_desc.npins = info->npins;
diff --git a/include/linux/fsl/imx-pinctrl.h b/include/linux/fsl/imx-pinctrl.h
new file mode 100644
index 0000000..0212948
--- /dev/null
+++ b/include/linux/fsl/imx-pinctrl.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __FSL_IMX_PINCTRL_H__
+#define __FSL_IMX_PINCTRL_H__
+
+#ifdef CONFIG_PINCTRL_IMX
+extern void imx_pinctrl_set_gpr_register(u8 gpr, u8 start_bit,
+					u8 num_bits, u32 value);
+#else
+static inline void imx_pinctrl_set_gpr_register(u8 gpr, u8 start_bit,
+						u8 num_bits, u32 value)
+{
+	WARN(1, "CONFIG_PINCTRL_IMX is not selected, simply return\n");
+	return;
+}
+#endif
+
+#endif /* !__FSL_IMX_PINCTRL_H__ */
-- 
1.7.0.4
