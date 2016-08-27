From: carlo@caione.org (Carlo Caione)
Date: Sat, 27 Aug 2016 15:43:46 +0200
Subject: [PATCH v3 4/6] nvmem: amlogic: Add Amlogic Meson EFUSE driver
In-Reply-To: <1472305428-16874-1-git-send-email-carlo@caione.org>
References: <1472305428-16874-1-git-send-email-carlo@caione.org>
Message-ID: <1472305428-16874-5-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add Amlogic EFUSE driver to access hardware data like ethernet address,
serial number or IDs.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 drivers/nvmem/Kconfig       | 10 +++++
 drivers/nvmem/Makefile      |  2 +
 drivers/nvmem/meson-efuse.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 drivers/nvmem/meson-efuse.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index f550c45..ba140ea 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -101,4 +101,14 @@ config NVMEM_VF610_OCOTP
 	  This driver can also be build as a module. If so, the module will
 	  be called nvmem-vf610-ocotp.
 
+config MESON_EFUSE
+	tristate "Amlogic eFuse Support"
+	depends on (ARCH_MESON || COMPILE_TEST) && MESON_SM
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
index 0000000..f207c3b
--- /dev/null
+++ b/drivers/nvmem/meson-efuse.c
@@ -0,0 +1,93 @@
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
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include <linux/firmware/meson/meson_sm.h>
+
+static int meson_efuse_read(void *context, unsigned int offset,
+			    void *val, size_t bytes)
+{
+	u8 *buf = val;
+	int ret;
+
+	ret = meson_sm_call_read(buf, SM_EFUSE_READ, offset,
+				 bytes, 0, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct nvmem_config econfig = {
+	.name = "meson-efuse",
+	.owner = THIS_MODULE,
+	.stride = 1,
+	.word_size = 1,
+	.read_only = true,
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
+	unsigned int size;
+
+	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0)
+		return -EINVAL;
+
+	econfig.dev = &pdev->dev;
+	econfig.reg_read = meson_efuse_read;
+	econfig.size = size;
+
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
