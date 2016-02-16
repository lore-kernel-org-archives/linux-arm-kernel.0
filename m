From: majun258@huawei.com (MaJun)
Date: Tue, 16 Feb 2016 14:37:26 +0800
Subject: [PATCH v2 3/5] irqchip: add platform device driver for mbigen device
In-Reply-To: <1455604648-20668-1-git-send-email-majun258@huawei.com>
References: <1455604648-20668-1-git-send-email-majun258@huawei.com>
Message-ID: <1455604648-20668-4-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

Add the platform device driver for mbigen chip v1.
This patch just same as mbigen v2.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/Makefile        |    2 +-
 drivers/irqchip/irq-mbigen-v1.c |   76 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 1 deletions(-)
 create mode 100644 drivers/irqchip/irq-mbigen-v1.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d91d99d..d4b9c7f 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_REALVIEW_DT)		+= irq-gic-realview.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-gic-v3-its-platform-msi.o
-obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
+obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o irq-mbigen-v1.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
diff --git a/drivers/irqchip/irq-mbigen-v1.c b/drivers/irqchip/irq-mbigen-v1.c
new file mode 100644
index 0000000..9445658
--- /dev/null
+++ b/drivers/irqchip/irq-mbigen-v1.c
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2015 Hisilicon Limited, All Rights Reserved.
+ * Author: Jun Ma <majun258@huawei.com>
+ * Author: Yun Wu <wuyun.wu@huawei.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/**
+ * struct mbigen_device - holds the information of mbigen device.
+ *
+ * @pdev:		pointer to the platform device structure of mbigen chip.
+ * @base:		mapped address of this mbigen chip.
+ */
+struct mbigen_device {
+	struct platform_device	*pdev;
+	void __iomem		*base;
+};
+
+static int mbigen_device_probe(struct platform_device *pdev)
+{
+	struct mbigen_device *mgn_chip;
+	struct resource *res;
+
+	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
+	if (!mgn_chip)
+		return -ENOMEM;
+
+	mgn_chip->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mgn_chip->base))
+		return PTR_ERR(mgn_chip->base);
+
+	platform_set_drvdata(pdev, mgn_chip);
+
+	return 0;
+}
+
+static const struct of_device_id mbigen_of_match[] = {
+	{ .compatible = "hisilicon,mbigen-v1" },
+	{ /* END */ }
+};
+MODULE_DEVICE_TABLE(of, mbigen_of_match);
+
+static struct platform_driver mbigen_platform_driver = {
+	.driver = {
+		.name		= "Hisilicon MBIGEN-V1",
+		.owner		= THIS_MODULE,
+		.of_match_table	= mbigen_of_match,
+	},
+	.probe			= mbigen_device_probe,
+};
+
+module_platform_driver(mbigen_platform_driver);
+
+MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
+MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Hisilicon MBI Generator driver");
-- 
1.7.1
