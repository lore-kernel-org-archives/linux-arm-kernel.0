From: nava.manne@xilinx.com (Nava kishore Manne)
Date: Sat, 20 Oct 2018 14:06:03 +0530
Subject: [PATCH 3/3] nvmem: zynqmp: Added zynqmp nvmem firmware driver
In-Reply-To: <20181020083603.27602-1-nava.manne@xilinx.com>
References: <20181020083603.27602-1-nava.manne@xilinx.com>
Message-ID: <20181020083603.27602-4-nava.manne@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds zynqmp nvmem firmware driver to access the
SoC revision information from the hardware register.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v1:
		-None

Changes for RFC-V3:
                -Changed nvmem_register() to devm_nvmem_register()
                 and pr_debug() to dev_dbg() as suggested by srinivas.

Changes for RFC-V2:
                -None.

 drivers/nvmem/Kconfig        | 15 ++++----
 drivers/nvmem/Makefile       |  5 +--
 drivers/nvmem/zynqmp_nvmem.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 10 deletions(-)
 create mode 100644 drivers/nvmem/zynqmp_nvmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 0a7a470e..2edb142 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -181,15 +181,14 @@ config RAVE_SP_EEPROM
 	help
 	  Say y here to enable Rave SP EEPROM support.
 
-config SC27XX_EFUSE
-	tristate "Spreadtrum SC27XX eFuse Support"
-	depends on MFD_SC27XX_PMIC || COMPILE_TEST
-	depends on HAS_IOMEM
+config NVMEM_ZYNQMP
+	bool "Xilinx ZYNQMP SoC nvmem firmware support"
+	depends on ARCH_ZYNQMP
 	help
-	  This is a simple driver to dump specified values of Spreadtrum
-	  SC27XX PMICs from eFuse.
+	  This is a driver to access hardware related data like
+	  soc revision, IDCODE... etc by using the firmware
+	  interface.
 
-	  This driver can also be built as a module. If so, the module
-	  will be called nvmem-sc27xx-efuse.
+	  If sure, say yes. If unsure, say no.
 
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 4e8c616..0b3abd7 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -39,5 +39,6 @@ obj-$(CONFIG_NVMEM_SNVS_LPGPR)	+= nvmem_snvs_lpgpr.o
 nvmem_snvs_lpgpr-y		:= snvs_lpgpr.o
 obj-$(CONFIG_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
 nvmem-rave-sp-eeprom-y		:= rave-sp-eeprom.o
-obj-$(CONFIG_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
-nvmem-sc27xx-efuse-y		:= sc27xx-efuse.o
+obj-$(CONFIG_NVMEM_ZYNQMP)     += nvmem_zynqmp_nvmem.o
+nvmem_zynqmp_nvmem-y           := zynqmp_nvmem.o
+
diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
new file mode 100644
index 0000000..b910864
--- /dev/null
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -0,0 +1,86 @@
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
+struct zynqmp_nvmem_data {
+	struct device *dev;
+	struct nvmem_device *nvmem;
+};
+
+static int zynqmp_nvmem_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	int ret;
+	int idcode, version;
+	struct zynqmp_nvmem_data *priv = context;
+
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->get_chipid)
+		return -ENXIO;
+
+	ret = eemi_ops->get_chipid(&idcode, &version);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(priv->dev, "Read chipid val %x %x\n", idcode, version);
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
+	struct device *dev = &pdev->dev;
+	struct zynqmp_nvmem_data *priv;
+
+	priv = devm_kzalloc(dev, sizeof(struct zynqmp_nvmem_data), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	econfig.dev = dev;
+	econfig.reg_read = zynqmp_nvmem_read;
+	econfig.priv = priv;
+
+	priv->nvmem = devm_nvmem_register(dev, &econfig);
+
+	return PTR_ERR_OR_ZERO(priv->nvmem);
+}
+
+static struct platform_driver zynqmp_nvmem_driver = {
+	.probe = zynqmp_nvmem_probe,
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
