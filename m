From: carlo@caione.org (Carlo Caione)
Date: Sun, 19 Jun 2016 14:39:02 +0200
Subject: [PATCH 4/6] nvmem: amlogic: Add Amlogic Meson EFUSE driver
In-Reply-To: <1466339944-602-1-git-send-email-carlo@caione.org>
References: <1466339944-602-1-git-send-email-carlo@caione.org>
Message-ID: <1466339944-602-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add Amlogic EFUSE driver to access hardware data like ethernet address,
serial number or IDs.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/nvmem/Kconfig       |  11 ++++
 drivers/nvmem/Makefile      |   2 +
 drivers/nvmem/meson-efuse.c | 130 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)
 create mode 100644 drivers/nvmem/meson-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index ca52952..ef17bc9 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -102,4 +102,15 @@ config NVMEM_VF610_OCOTP
 	  This driver can also be build as a module. If so, the module will
 	  be called nvmem-vf610-ocotp.
 
+config MESON_EFUSE
+	tristate "Amlogic eFuse Support"
+	depends on ARCH_MESON || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  This is a driver to retrieve specific values from the eFuse found on
+	  the Amlogic Meson SoCs.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem_meson_efuse.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 45ab1ae..8f942a0 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -22,3 +22,5 @@ obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
 nvmem_sunxi_sid-y		:= sunxi_sid.o
 obj-$(CONFIG_NVMEM_VF610_OCOTP)	+= nvmem-vf610-ocotp.o
 nvmem-vf610-ocotp-y		:= vf610-ocotp.o
+obj-$(CONFIG_MESON_EFUSE)	+= nvmem_meson_efuse.o
+nvmem_meson_efuse-y		:= meson-efuse.o
diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
new file mode 100644
index 0000000..7c80e1c
--- /dev/null
+++ b/drivers/nvmem/meson-efuse.c
@@ -0,0 +1,130 @@
+/*
+ * Amlogic eFuse Driver
+ *
+ * Copyright (c) 2016 Endless Computers, Inc.
+ * Author: Carlo Caione <carlo@endlessm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/firmware/meson/meson_sm.h>
+
+static struct meson_sm_firmware *fw;
+
+static int meson_efuse_write(void *context, const void *data, size_t count)
+{
+	/* Nothing TBD, Read-Only */
+	return 0;
+}
+
+static int meson_efuse_read(void *context,
+			    const void *reg, size_t reg_size,
+			    void *val, size_t val_size)
+{
+	unsigned int offset = *(u32 *)reg;
+	u8 *buf = val;
+	int ret;
+
+	ret = meson_sm_call_read(fw, buf, SM_EFUSE_READ, offset,
+				 val_size, 0, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct nvmem_config econfig = {
+	.name = "meson-efuse",
+	.owner = THIS_MODULE,
+	.read_only = true,
+};
+
+static struct regmap_bus meson_efuse_bus = {
+	.read = meson_efuse_read,
+	.write = meson_efuse_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+};
+
+static struct regmap_config meson_efuse_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 1,
+	.val_bits = 8,
+};
+
+static const struct of_device_id meson_efuse_match[] = {
+	{ .compatible = "amlogic,meson-gxbb-efuse", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, meson_efuse_match);
+
+static int meson_efuse_probe(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem;
+	struct regmap *regmap;
+	unsigned int size;
+
+	fw = meson_sm_get_fw();
+	if (!fw)
+		return -EPROBE_DEFER;
+
+	if (meson_sm_call(fw, SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0)
+		return -EINVAL;
+	meson_efuse_regmap_config.max_register = size - 1;
+
+	regmap = devm_regmap_init(&pdev->dev, &meson_efuse_bus,
+				  NULL, &meson_efuse_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&pdev->dev, "regmap init failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	econfig.dev = &pdev->dev;
+	nvmem = nvmem_register(&econfig);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	platform_set_drvdata(pdev, nvmem);
+
+	return 0;
+}
+
+static int meson_efuse_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static struct platform_driver meson_efuse_driver = {
+	.probe = meson_efuse_probe,
+	.remove = meson_efuse_remove,
+	.driver = {
+		.name = "meson-efuse",
+		.of_match_table = meson_efuse_match,
+	},
+};
+
+module_platform_driver(meson_efuse_driver);
+
+MODULE_AUTHOR("Carlo Caione <carlo@endlessm.com>");
+MODULE_DESCRIPTION("Amlogic Meson NVMEM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
