From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Tue, 4 Sep 2018 15:22:34 +0530
Subject: [RFC PATCH v2 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
In-Reply-To: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
References: <1536054754-3119-1-git-send-email-nava.manne@xilinx.com>
Message-ID: <1536054754-3119-4-git-send-email-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds zynqmp nvmem firmware driver to access the
SoC revision information from the hardware register.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
		-None.

 drivers/nvmem/Kconfig        | 10 ++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/zynqmp_nvmem.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 54a3c29..2edb142 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -181,4 +181,14 @@ config RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
+	help
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
+
+	  If sure, say yes. If unsure, say no.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 27e96a8..0b3abd7 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -39,4 +39,6 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
 obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
+obj-$(CONFIG_NVMEM_ZYNQMP)     += nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y           := zynqmp_nvmem.o
 
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
new file mode 100644
index 0000000..e377900
--- /dev/null
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define SILICON_REVISION_MASK 0xF
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	int ret;
+	int idcode, version;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_chipid)
+		return -ENXIO;
+
+	ret = eemi_ops->get_chipid(&idcode, &version);
+	if (ret < 0)
+		return ret;
+
+	pr_debug("Read chipid val %x %x\n", idcode, version);
+	*(int *)val = version & SILICON_REVISION_MASK;
+
+	return 0;
+}
+
+static struct nvmem_config econfig = {
+	.name = "zynqmp-nvmem",
+	.owner = THIS_MODULE,
+	.word_size = 1,
+	.size = 1,
+	.read_only = true,
+};
+
+static const struct of_device_id zynqmp_nvmem_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_nvmem_match);
+
+static int zynqmp_nvmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem;
+
+	econfig.dev = &pdev->dev;
+	econfig.reg_read = zynqmp_nvmem_read;
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
+static int zynqmp_nvmem_remove(struct platform_device *pdev)
+{
+	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
+
+	return nvmem_unregister(nvmem);
+}
+
+static struct platform_driver zynqmp_nvmem_driver = {
+	.probe = zynqmp_nvmem_probe,
+	.remove = zynqmp_nvmem_remove,
+	.driver = {
+		.name = "zynqmp-nvmem",
+		.of_match_table = zynqmp_nvmem_match,
+	},
+};
+
+module_platform_driver(zynqmp_nvmem_driver);
+
+MODULE_AUTHOR("Michal Simek <michal.simek@xilinx.com>, Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("ZynqMP NVMEM driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4
