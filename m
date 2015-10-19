From: ariel@vanguardiasur.com.ar (Ariel D'Alessandro)
Date: Mon, 19 Oct 2015 14:32:24 -0300
Subject: [PATCH v2 2/4] nvmem: NXP LPC18xx EEPROM memory NVMEM driver
In-Reply-To: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
References: <1445275946-32653-1-git-send-email-ariel@vanguardiasur.com.ar>
Message-ID: <1445275946-32653-3-git-send-email-ariel@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds support for NXP LPC18xx EEPROM memory found in NXP
LPC185x/3x and LPC435x/3x/2x/1x devices.

EEPROM size is 16384 bytes and it can be entirely read and
written/erased with 1 word (4 bytes) granularity. The last page
(128 bytes) contains the EEPROM initialization data and is not writable.

Erase/program time is less than 3ms. The EEPROM device requires a
~1500 kHz clock (min 800 kHz, max 1600 kHz) that is generated dividing
the system bus clock by the division factor, contained in the divider
register (minus 1 encoded).

Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
---
 drivers/nvmem/Kconfig          |   9 ++
 drivers/nvmem/Makefile         |   2 +
 drivers/nvmem/lpc18xx_eeprom.c | 266 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 277 insertions(+)
 create mode 100644 drivers/nvmem/lpc18xx_eeprom.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index bc4ea58..6ff1b50 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -25,6 +25,15 @@ config NVMEM_IMX_OCOTP
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-imx-ocotp.
 
+config NVMEM_LPC18XX_EEPROM
+	tristate "NXP LPC18XX EEPROM Memory Support"
+	depends on ARCH_LPC18XX || COMPILE_TEST
+	help
+	  Say Y here to include support for NXP LPC18xx EEPROM memory found in
+	  NXP LPC185x/3x and LPC435x/3x/2x/1x devices.
+	  To compile this driver as a module, choose M here: the module
+	  will be called nvmem_lpc18xx_eeprom.
+
 config NVMEM_MXS_OCOTP
 	tristate "Freescale MXS On-Chip OTP Memory Support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 95dde3f..c14a556 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -8,6 +8,8 @@ nvmem_core-y			:= core.o
 # Devices
 obj-$(CONFIG_NVMEM_IMX_OCOTP)	+= nvmem-imx-ocotp.o
 nvmem-imx-ocotp-y		:= imx-ocotp.o
+obj-$(CONFIG_NVMEM_LPC18XX_EEPROM)	+= nvmem_lpc18xx_eeprom.o
+nvmem_lpc18xx_eeprom-y	:= lpc18xx_eeprom.o
 obj-$(CONFIG_NVMEM_MXS_OCOTP)	+= nvmem-mxs-ocotp.o
 nvmem-mxs-ocotp-y		:= mxs-ocotp.o
 obj-$(CONFIG_QCOM_QFPROM)	+= nvmem_qfprom.o
diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
new file mode 100644
index 0000000..ccdda66
--- /dev/null
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -0,0 +1,266 @@
+/*
+ * NXP LPC18xx/LPC43xx EEPROM memory NVMEM driver
+ *
+ * Copyright (c) 2015 Ariel D'Alessandro <ariel@vanguardiasur.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+/* Registers */
+#define LPC18XX_EEPROM_AUTOPROG		0x00c
+#define LPC18XX_EEPROM_AUTOPROG_WORD	0x1
+
+#define LPC18XX_EEPROM_CLKDIV		0x014
+
+#define LPC18XX_EEPROM_PWRDWN		0x018
+#define LPC18XX_EEPROM_PWRDWN_NO	0x0
+#define LPC18XX_EEPROM_PWRDWN_YES	0x1
+
+/* Fixed page size (bytes) */
+#define LPC18XX_EEPROM_PAGE_SIZE	0x80
+
+/* EEPROM device requires a ~1500 kHz clock (min 800 kHz, max 1600 kHz) */
+#define LPC18XX_EEPROM_CLOCK_HZ		1500000
+
+struct lpc18xx_eeprom_dev {
+	struct clk *clk;
+	void __iomem *reg_base;
+	void __iomem *mem_base;
+	struct nvmem_device *nvmem;
+	unsigned reg_bytes;
+	unsigned val_bytes;
+};
+
+static inline void lpc18xx_eeprom_writel(struct lpc18xx_eeprom_dev *eeprom,
+					 u32 reg, u32 val)
+{
+	writel(val, eeprom->reg_base + reg);
+}
+
+static int lpc18xx_eeprom_gather_write(void *context, const void *reg,
+				       size_t reg_size, const void *val,
+				       size_t val_size)
+{
+	struct lpc18xx_eeprom_dev *eeprom = context;
+	unsigned int offset = *(u32 *)reg;
+
+	/* 3 ms of erase/program time between each writing */
+	while (val_size) {
+		writel(*(u32 *)val, eeprom->mem_base + offset);
+		usleep_range(3000, 4000);
+		val_size -= eeprom->val_bytes;
+		val += eeprom->val_bytes;
+		offset += eeprom->val_bytes;
+	}
+
+	return 0;
+}
+
+static int lpc18xx_eeprom_write(void *context, const void *data, size_t count)
+{
+	struct lpc18xx_eeprom_dev *eeprom = context;
+	unsigned int offset = eeprom->reg_bytes;
+
+	if (count <= offset)
+		return -EINVAL;
+
+
+	return lpc18xx_eeprom_gather_write(context, data, eeprom->reg_bytes,
+					   data + offset, count - offset);
+}
+
+static int lpc18xx_eeprom_read(void *context, const void *reg, size_t reg_size,
+			       void *val, size_t val_size)
+{
+	struct lpc18xx_eeprom_dev *eeprom = context;
+	unsigned int offset = *(u32 *)reg;
+
+	while (val_size) {
+		*(u32 *)val = readl(eeprom->mem_base + offset);
+		val_size -= eeprom->val_bytes;
+		val += eeprom->val_bytes;
+		offset += eeprom->val_bytes;
+	}
+
+	return 0;
+}
+
+static struct regmap_bus lpc18xx_eeprom_bus = {
+	.write = lpc18xx_eeprom_write,
+	.gather_write = lpc18xx_eeprom_gather_write,
+	.read = lpc18xx_eeprom_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+static struct regmap_config lpc18xx_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static bool lpc18xx_eeprom_writeable_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * The last page contains the EEPROM initialization data and is not
+	 * writable.
+	 */
+	return reg <= lpc18xx_regmap_config.max_register -
+						LPC18XX_EEPROM_PAGE_SIZE;
+}
+
+static bool lpc18xx_eeprom_readable_reg(struct device *dev, unsigned int reg)
+{
+	return reg <= lpc18xx_regmap_config.max_register;
+}
+
+static struct nvmem_config lpc18xx_nvmem_config = {
+	.name = "lpc18xx-eeprom",
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id lpc18xx_eeprom_of_match[] = {
+	{ .compatible = "nxp,lpc1857-eeprom" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lpc18xx_eeprom_of_match);
+
+static int lpc18xx_eeprom_probe(struct platform_device *pdev)
+{
+	struct lpc18xx_eeprom_dev *eeprom;
+	struct device *dev = &pdev->dev;
+	struct reset_control *rst;
+	unsigned long clk_rate;
+	struct regmap *regmap;
+	struct resource *res;
+	int ret;
+
+	eeprom = devm_kzalloc(dev, sizeof(*eeprom), GFP_KERNEL);
+	if (!eeprom)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
+	eeprom->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(eeprom->reg_base))
+		return PTR_ERR(eeprom->reg_base);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mem");
+	eeprom->mem_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(eeprom->mem_base))
+		return PTR_ERR(eeprom->mem_base);
+
+	eeprom->clk = devm_clk_get(&pdev->dev, "eeprom");
+	if (IS_ERR(eeprom->clk)) {
+		dev_err(&pdev->dev, "failed to get eeprom clock\n");
+		return PTR_ERR(eeprom->clk);
+	}
+
+	ret = clk_prepare_enable(eeprom->clk);
+	if (ret < 0) {
+		dev_err(dev, "failed to prepare/enable eeprom clk: %d\n", ret);
+		return ret;
+	}
+
+	rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(rst)) {
+		dev_err(dev, "failed to get reset: %ld\n", PTR_ERR(rst));
+		ret = PTR_ERR(rst);
+		goto err_clk;
+	}
+
+	ret = reset_control_deassert(rst);
+	if (ret < 0) {
+		dev_err(dev, "failed to deassert reset: %d\n", ret);
+		goto err_clk;
+	}
+
+	eeprom->val_bytes = lpc18xx_regmap_config.val_bits / 8;
+	eeprom->reg_bytes = lpc18xx_regmap_config.reg_bits / 8;
+
+	/*
+	 * Clock rate is generated by dividing the system bus clock by the
+	 * division factor, contained in the divider register (minus 1 encoded).
+	 */
+	clk_rate = clk_get_rate(eeprom->clk);
+	clk_rate = DIV_ROUND_UP(clk_rate, LPC18XX_EEPROM_CLOCK_HZ) - 1;
+	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_CLKDIV, clk_rate);
+
+	/*
+	 * Writing a single word to the page will start the erase/program cycle
+	 * automatically
+	 */
+	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_AUTOPROG,
+			      LPC18XX_EEPROM_AUTOPROG_WORD);
+
+	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
+			      LPC18XX_EEPROM_PWRDWN_NO);
+
+	lpc18xx_regmap_config.max_register = resource_size(res) - 1;
+	lpc18xx_regmap_config.writeable_reg = lpc18xx_eeprom_writeable_reg;
+	lpc18xx_regmap_config.readable_reg = lpc18xx_eeprom_readable_reg;
+
+	regmap = devm_regmap_init(dev, &lpc18xx_eeprom_bus, eeprom,
+				  &lpc18xx_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "regmap init failed: %ld\n", PTR_ERR(regmap));
+		ret = PTR_ERR(regmap);
+		goto err_clk;
+	}
+
+	lpc18xx_nvmem_config.dev = dev;
+
+	eeprom->nvmem = nvmem_register(&lpc18xx_nvmem_config);
+	if (IS_ERR(eeprom->nvmem)) {
+		ret = PTR_ERR(eeprom->nvmem);
+		goto err_clk;
+	}
+
+	platform_set_drvdata(pdev, eeprom);
+
+	return 0;
+
+err_clk:
+	clk_disable_unprepare(eeprom->clk);
+
+	return ret;
+}
+
+static int lpc18xx_eeprom_remove(struct platform_device *pdev)
+{
+	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
+
+	lpc18xx_eeprom_writel(eeprom, LPC18XX_EEPROM_PWRDWN,
+			      LPC18XX_EEPROM_PWRDWN_YES);
+
+	clk_disable_unprepare(eeprom->clk);
+
+	return nvmem_unregister(eeprom->nvmem);
+}
+
+static struct platform_driver lpc18xx_eeprom_driver = {
+	.probe = lpc18xx_eeprom_probe,
+	.remove = lpc18xx_eeprom_remove,
+	.driver = {
+		.name = "lpc18xx-eeprom",
+		.of_match_table = lpc18xx_eeprom_of_match,
+	},
+};
+
+module_platform_driver(lpc18xx_eeprom_driver);
+
+MODULE_AUTHOR("Ariel D'Alessandro <ariel@vanguardiasur.com.ar>");
+MODULE_DESCRIPTION("NXP LPC18xx EEPROM memory Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.6.1
