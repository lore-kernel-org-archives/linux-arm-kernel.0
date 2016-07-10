From: vw@iommu.org (Wan Zongshun)
Date: Sun, 10 Jul 2016 15:27:26 +0800
Subject: [PATCH v2 06/10] soc: Add SoC specific driver support for nuc900
In-Reply-To: <1468135649-19980-1-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
Message-ID: <1468135649-19980-7-git-send-email-vw@iommu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add SoC specific driver for nuc970 SoC,
it is for getting nuc970 version id and chip id.

Signed-off-by: Wan Zongshun <mcuos.com@gmail.com>
---
 drivers/soc/Kconfig              |   1 +
 drivers/soc/Makefile             |   1 +
 drivers/soc/nuvoton/Kconfig      |  10 ++++
 drivers/soc/nuvoton/Makefile     |   1 +
 drivers/soc/nuvoton/soc-nuc900.c | 100 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 113 insertions(+)
 create mode 100644 drivers/soc/nuvoton/Kconfig
 create mode 100644 drivers/soc/nuvoton/Makefile
 create mode 100644 drivers/soc/nuvoton/soc-nuc900.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index cb58ef0..2119733 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -4,6 +4,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/brcmstb/Kconfig"
 source "drivers/soc/fsl/qe/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
+source "drivers/soc/nuvoton/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 380230f..bb1bfba 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
+obj-$(CONFIG_SOC_NUC900)	+= nuvoton/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_RENESAS)	+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
diff --git a/drivers/soc/nuvoton/Kconfig b/drivers/soc/nuvoton/Kconfig
new file mode 100644
index 0000000..53c106c
--- /dev/null
+++ b/drivers/soc/nuvoton/Kconfig
@@ -0,0 +1,10 @@
+#
+# ARM Versatile SoC drivers
+#
+config SOC_NUC900
+	bool "SoC bus device for the nuvoton NUC900 platforms"
+	depends on ARCH_W90X900
+	select SOC_BUS
+	help
+	  Include support for the SoC bus on the NUC900 platforms
+	  providing some sysfs information about the ASIC variant.
diff --git a/drivers/soc/nuvoton/Makefile b/drivers/soc/nuvoton/Makefile
new file mode 100644
index 0000000..88f9b7e
--- /dev/null
+++ b/drivers/soc/nuvoton/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_SOC_NUC900)	+= soc-nuc900.o
diff --git a/drivers/soc/nuvoton/soc-nuc900.c b/drivers/soc/nuvoton/soc-nuc900.c
new file mode 100644
index 0000000..034ef94
--- /dev/null
+++ b/drivers/soc/nuvoton/soc-nuc900.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright 2016 Wan Zongshun <mcuos.com@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
+#include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+
+/* System ID in syscon */
+#define GCR_CHIPID		0x00
+#define GCR_CHIPID_MASK		0x00ffffff
+
+static const struct of_device_id nuc900_soc_of_match[] = {
+	{ .compatible = "nuvoton,nuc900-soc",	},
+	{ }
+};
+
+static u32 nuc900_chipid;
+
+static ssize_t nuc900_get_chipid(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	return sprintf(buf, "0x%x\n", nuc900_chipid & GCR_CHIPID_MASK);
+}
+
+static struct device_attribute nuc900_chipid_attr =
+	__ATTR(manufacturer,  S_IRUGO, nuc900_get_chipid,  NULL);
+
+static ssize_t nuc900_get_versionid(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	return sprintf(buf, "0x%x\n", (nuc900_chipid >> 24) & 0xff);
+}
+
+static struct device_attribute nuc900_version_attr =
+	__ATTR(board,  S_IRUGO, nuc900_get_versionid,  NULL);
+
+static int nuc900_soc_probe(struct platform_device *pdev)
+{
+	static struct regmap *syscon_regmap;
+	struct soc_device *soc_dev;
+	struct soc_device_attribute *soc_dev_attr;
+	struct device_node *np = pdev->dev.of_node;
+	int ret;
+
+	syscon_regmap = syscon_regmap_lookup_by_phandle(np, "syscon");
+	if (IS_ERR(syscon_regmap))
+		return PTR_ERR(syscon_regmap);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	ret = of_property_read_string(np, "compatible", &soc_dev_attr->soc_id);
+	if (ret)
+		return -EINVAL;
+
+	soc_dev_attr->machine = "NUC900EVB";
+	soc_dev_attr->family = "NUC900";
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(syscon_regmap, GCR_CHIPID, &nuc900_chipid);
+	if (ret)
+		return -ENODEV;
+
+	device_create_file(soc_device_to_device(soc_dev), &nuc900_chipid_attr);
+	device_create_file(soc_device_to_device(soc_dev), &nuc900_version_attr);
+
+	dev_info(&pdev->dev, "Nuvoton Chip ID: 0x%x, Version ID:0x%x\n",
+		 nuc900_chipid & GCR_CHIPID_MASK,
+		 (nuc900_chipid >> 24) & 0xff);
+
+	return 0;
+}
+
+static struct platform_driver nuc900_soc_driver = {
+	.probe = nuc900_soc_probe,
+	.driver = {
+		.name = "nuc900-soc",
+		.of_match_table = nuc900_soc_of_match,
+	},
+};
+builtin_platform_driver(nuc900_soc_driver);
-- 
2.7.4
