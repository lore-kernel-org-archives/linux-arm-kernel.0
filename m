From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 28 Jun 2017 15:56:38 +0530
Subject: [RFC 5/5] drivers: Code to test boot constraints
In-Reply-To: <cover.1498642745.git.viresh.kumar@linaro.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
Message-ID: <f87b40d4607e2d4169fdaba117cb76cac733e0d0.1498642745.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NOT FOR MERGE

This is test code to show how this is tested for now on the hikey
platform with the MMC device.

Not-signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/Makefile                    |  2 +-
 drivers/base/test_plat_boot_constraint.c | 51 ++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/test_plat_boot_constraint.c

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 6094b3b75184..a1ffa9f1a0b6 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -5,7 +5,7 @@ obj-y			:= component.o core.o bus.o dd.o syscore.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o \
 			   topology.o container.o property.o cacheinfo.o
-obj-$(CONFIG_BOOT_CONSTRAINTS) += boot_constraint.o
+obj-$(CONFIG_BOOT_CONSTRAINTS) += boot_constraint.o test_plat_boot_constraint.o
 obj-$(CONFIG_DEVTMPFS)	+= devtmpfs.o
 obj-$(CONFIG_DMA_CMA) += dma-contiguous.o
 obj-y			+= power/
diff --git a/drivers/base/test_plat_boot_constraint.c b/drivers/base/test_plat_boot_constraint.c
new file mode 100644
index 000000000000..498f87056409
--- /dev/null
+++ b/drivers/base/test_plat_boot_constraint.c
@@ -0,0 +1,51 @@
+#include <linux/boot_constraint.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+static int test_constraints_probe(struct platform_device *platform_dev)
+{
+	struct device_node *np;
+	struct boot_constraint_supply_info info = {
+		.enable = true,
+		.name = "vmmc",
+		.u_volt_min = 1800000,
+		.u_volt_max = 3000000,
+	};
+	struct platform_device *pdev;
+	int ret;
+
+	np = of_find_compatible_node(NULL, NULL, "hisilicon,hi6220-dw-mshc");
+	if (!np)
+		return -ENODEV;
+
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+
+	if (!pdev) {
+		pr_err("%s: device not found\n", __func__);
+		return -ENODEV;
+	}
+
+	ret = boot_constraint_add(&pdev->dev, BOOT_CONSTRAINT_SUPPLY, &info);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static struct platform_driver test_constraints_driver = {
+	.driver = {
+		.name	= "test-constraints",
+	},
+	.probe	= test_constraints_probe,
+};
+
+static int __init test_constraints_init(void)
+{
+	platform_device_register_data(NULL, "test-constraints", -1, NULL, 0);
+
+	return platform_driver_register(&test_constraints_driver);
+}
+subsys_initcall(test_constraints_init);
-- 
2.13.0.71.gd7076ec9c9cb
