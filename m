From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  4 Aug 2015 15:02:21 +0200
Subject: [PATCH 2/3] nvmem: imx-ocotp: Add i.MX6 OCOTP driver
In-Reply-To: <1438693342-605-1-git-send-email-p.zabel@pengutronix.de>
References: <1438693342-605-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1438693342-605-2-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver handles the i.MX On-Chip OTP Controller found in
i.MX6Q/D, i.MX6S/DL, i.MX6SL, and i.MX6SX SoCs. Currently it
just returns the values stored in the shadow registers.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
This patch is based on the v9 "Add simple NVMEM Framework via regmap"
series which can be found here: https://lkml.org/lkml/2015/7/27/342
---
 drivers/nvmem/Kconfig     |  11 ++++
 drivers/nvmem/Makefile    |   2 +
 drivers/nvmem/imx-ocotp.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 drivers/nvmem/imx-ocotp.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8db2978..0b33014 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -36,4 +36,15 @@ config NVMEM_SUNXI_SID
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem_sunxi_sid.
 
+config NVMEM_IMX_OCOTP
+	tristate "i.MX6 On-Chip OTP Controller support"
+	depends on SOC_IMX6
+	help
+	  This is a driver for the On-Chip OTP Controller (OCOTP) available on
+	  i.MX6 SoCs, providing access to 4 Kbits of one-time programmable
+	  eFuses.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-imx-ocotp.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4328b93..b512d77 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -10,3 +10,5 @@ obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
 nvmem_qfprom-y			:= qfprom.o
 obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y		:= sunxi_sid.o
+obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
+nvmem-imx-ocotp-y		:= imx-ocotp.o
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
new file mode 100644
index 0000000..e918967
--- /dev/null
+++ b/drivers/nvmem/imx-ocotp.c
@@ -0,0 +1,155 @@
+/*
+ * i.MX6 OCOTP fusebox driver
+ *
+ * Copyright (c) 2015 Pengutronix, Philipp Zabel <p.zabel@pengutronix.de>
+ *
+ * Based on the barebox ocotp driver,
+ * Copyright (c) 2010 Baruch Siach <baruch@tkos.co.il>,
+ *	Orex Computed Radiography
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation.
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+struct ocotp_priv {
+	struct device *dev;
+	void __iomem *base;
+	unsigned int nregs;
+};
+
+static int imx_ocotp_read(void *context, const void *reg, size_t reg_size,
+			  void *val, size_t val_size)
+{
+	struct ocotp_priv *priv = context;
+	unsigned int offset = *(u32 *)reg;
+	unsigned int count;
+	int i;
+	u32 index;
+
+	index = offset >> 2;
+	count = val_size >> 2;
+
+	if (count > (priv->nregs - index))
+		count = priv->nregs - index;
+
+	for (i = index; i < (index + count); i++) {
+		*(u32 *)val = readl(priv->base + 0x400 + i * 0x10);
+		val += 4;
+	}
+
+	return (i - index) * 4;
+}
+
+static int imx_ocotp_write(void *context, const void *data, size_t count)
+{
+	/* Not implemented */
+	return 0;
+}
+
+static struct regmap_bus imx_ocotp_bus = {
+	.read = imx_ocotp_read,
+	.write = imx_ocotp_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+static bool imx_ocotp_writeable_reg(struct device *dev, unsigned int reg)
+{
+	return false;
+}
+
+static struct regmap_config imx_ocotp_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.writeable_reg = imx_ocotp_writeable_reg,
+	.name = "imx-ocotp",
+};
+
+static struct nvmem_config imx_ocotp_nvmem_config = {
+	.name = "imx-ocotp",
+	.read_only = true,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id imx_ocotp_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-ocotp",  (void *)128 },
+	{ .compatible = "fsl,imx6sl-ocotp", (void *)32 },
+	{ .compatible = "fsl,imx6sx-ocotp", (void *)128 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, imx_ocotp_dt_ids);
+
+static int imx_ocotp_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct regmap *regmap;
+	struct ocotp_priv *priv;
+	struct nvmem_device *nvmem;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	of_id = of_match_device(imx_ocotp_dt_ids, dev);
+	priv->nregs = (unsigned int)of_id->data;
+	imx_ocotp_regmap_config.max_register = 4 * priv->nregs - 4;
+
+	regmap = devm_regmap_init(dev, &imx_ocotp_bus, priv,
+				  &imx_ocotp_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "regmap init failed\n");
+		return PTR_ERR(regmap);
+	}
+	imx_ocotp_nvmem_config.dev = dev;
+	nvmem = nvmem_register(&imx_ocotp_nvmem_config);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static int imx_ocotp_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static struct platform_driver imx_ocotp_driver = {
+	.probe	= imx_ocotp_probe,
+	.remove	= imx_ocotp_remove,
+	.driver = {
+		.name	= "imx_ocotp",
+		.of_match_table = imx_ocotp_dt_ids,
+	},
+};
+module_platform_driver(imx_ocotp_driver);
+
+MODULE_AUTHOR("Philipp Zabel <p.zabel@pengutronix.de>");
+MODULE_DESCRIPTION("i.MX6 OCOTP fuse box driver");
+MODULE_LICENSE("GPL");
-- 
2.1.4
