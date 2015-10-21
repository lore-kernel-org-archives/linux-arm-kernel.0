From: majun258@huawei.com (MaJun)
Date: Wed, 21 Oct 2015 14:04:30 +0800
Subject: [PATCH v7 2/4] irqchip: add platform device driver for mbigen device
In-Reply-To: <1445407472-6120-1-git-send-email-majun258@huawei.com>
References: <1445407472-6120-1-git-send-email-majun258@huawei.com>
Message-ID: <1445407472-6120-3-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

Mbigen means Message Based Interrupt Generator(MBIGEN).

Its a kind of interrupt controller that collects
the interrupts from external devices and generate msi interrupt.
Mbigen is applied to reduce the number of wire connected interrupts.

As the peripherals increasing, the interrupts lines needed is
increasing much, especially on the Arm64 server SOC.

Therefore, the interrupt pin in GIC is not enough to cover so
many peripherals.

Mbigen is designed to fix this problem.

Mbigen chip locates in ITS or outside of ITS.

Mbigen chip hardware structure shows as below:

		mbigen chip
|---------------------|-------------------|
mgn_node0	  mgn_node1		mgn_node2
 |		 |-------|		|-------|------|
dev1		dev1    dev2		dev1   dev3   dev4

Each mbigen chip contains several mbigen nodes.

External devices can connect to mbigen node through wire connecting way.

Because a mbigen node only can support 128 interrupt maximum, depends
on the interrupt lines number of devices, a device can connects to one
more mbigen nodes.

Also, several different devices can connect to a same mbigen node.

When devices triggered interrupt,mbigen chip detects and collects
the interrupts and generates the MBI interrupts by writing the ITS
Translator register.

To simplify mbigen driver,I used a new conception--mbigen device.
Each mbigen device is initialized as a platform device.

Mbigen device presents the parts(register, pin definition etc.) in
mbigen chip corresponding to a peripheral device.

So from software view, the structure likes below

	            mbigen chip
     |---------------------|-----------------|
mbigen device1       mbigen device2  mbigen device3
      |                   |                |
     dev1                dev2             dev3

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/Kconfig      |    8 ++++
 drivers/irqchip/Makefile     |    1 +
 drivers/irqchip/irq-mbigen.c |   83 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 drivers/irqchip/irq-mbigen.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 4d7294e..b205e15 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -27,6 +27,14 @@ config ARM_GIC_V3_ITS
 	bool
 	select PCI_MSI_IRQ_DOMAIN
 
+config HISILICON_IRQ_MBIGEN
+	bool "Support mbigen interrupt controller"
+	default n
+	depends on ARM_GIC_V3 && ARM_GIC_V3_ITS && GENERIC_MSI_IRQ_DOMAIN
+	help
+	 Enable the mbigen interrupt controller used on
+	 Hisilicon platform.
+
 config ARM_NVIC
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 177f78f..cd76b11 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-pci-msi.o irq-gic-v3-its-platform-msi.o
+obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+= irq-mbigen.o
 obj-$(CONFIG_ARM_NVIC)			+= irq-nvic.o
 obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
 obj-$(CONFIG_ATMEL_AIC_IRQ)		+= irq-atmel-aic-common.o irq-atmel-aic.o
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
new file mode 100644
index 0000000..f18132f
--- /dev/null
+++ b/drivers/irqchip/irq-mbigen.c
@@ -0,0 +1,83 @@
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
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
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
+
+	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
+	if (!mgn_chip)
+		return -ENOMEM;
+
+	mgn_chip->pdev = pdev;
+	mgn_chip->base = of_iomap(pdev->dev.of_node, 0);
+
+	platform_set_drvdata(pdev, mgn_chip);
+
+	return 0;
+}
+
+static int mbigen_device_remove(struct platform_device *pdev)
+{
+	struct mbigen_device *mgn_chip = platform_get_drvdata(pdev);
+
+	iounmap(mgn_chip->base);
+
+	return 0;
+}
+
+static const struct of_device_id mbigen_of_match[] = {
+	{ .compatible = "hisilicon,mbigen-v2" },
+	{ /* END */ }
+};
+MODULE_DEVICE_TABLE(of, mbigen_of_match);
+
+static struct platform_driver mbigen_platform_driver = {
+	.driver = {
+		.name		= "Hisilicon MBIGEN-V2",
+		.owner		= THIS_MODULE,
+		.of_match_table	= mbigen_of_match,
+	},
+	.probe			= mbigen_device_probe,
+	.remove			= mbigen_device_remove,
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
