From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 9 Dec 2013 17:17:03 -0500
Subject: [PATCH v3 1/2] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
References: <1386627424-373-1-git-send-email-w-kwok2@ti.com>
Message-ID: <1386627424-373-2-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Keystone platform specific glue layer to support
USB3 Host mode.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 drivers/usb/dwc3/Kconfig         |    7 ++
 drivers/usb/dwc3/Makefile        |    1 +
 drivers/usb/dwc3/dwc3-keystone.c |  205 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 drivers/usb/dwc3/dwc3-keystone.c

diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
index 70fc430..e2c730f 100644
--- a/drivers/usb/dwc3/Kconfig
+++ b/drivers/usb/dwc3/Kconfig
@@ -70,6 +70,13 @@ config USB_DWC3_PCI
 	  One such PCIe-based platform is Synopsys' PCIe HAPS model of
 	  this IP.
 
+config USB_DWC3_KEYSTONE
+	tristate "Texas Instruments Keystone2 Platforms"
+	default USB_DWC3
+	help
+	  Support of USB2/3 functionality in TI Keystone2 platforms.
+	  Say 'Y' or 'M' here if you have one such device
+
 comment "Debugging features"
 
 config USB_DWC3_DEBUG
diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
index dd17601..10ac3e7 100644
--- a/drivers/usb/dwc3/Makefile
+++ b/drivers/usb/dwc3/Makefile
@@ -32,3 +32,4 @@ endif
 obj-$(CONFIG_USB_DWC3_OMAP)		+= dwc3-omap.o
 obj-$(CONFIG_USB_DWC3_EXYNOS)		+= dwc3-exynos.o
 obj-$(CONFIG_USB_DWC3_PCI)		+= dwc3-pci.o
+obj-$(CONFIG_USB_DWC3_KEYSTONE)		+= dwc3-keystone.o
diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
new file mode 100644
index 0000000..33f71330b
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -0,0 +1,205 @@
+/**
+ * dwc3-keystone.c - Keystone Specific Glue layer
+ *
+ * Copyright (C) 2010-2013 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Author: WingMan Kwok <w-kwok2@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2  of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+
+/* USBSS register offsets */
+#define USBSS_REVISION		0x0000
+#define USBSS_SYSCONFIG		0x0010
+#define USBSS_IRQ_EOI		0x0018
+#define USBSS_IRQSTATUS_RAW_0	0x0020
+#define USBSS_IRQSTATUS_0	0x0024
+#define USBSS_IRQENABLE_SET_0	0x0028
+#define USBSS_IRQENABLE_CLR_0	0x002c
+
+/* IRQ register bits */
+#define USBSS_IRQ_EOI_LINE(n)	BIT(n)
+#define USBSS_IRQ_EVENT_ST	BIT(0)
+#define USBSS_IRQ_COREIRQ_EN	BIT(0)
+#define USBSS_IRQ_COREIRQ_CLR	BIT(0)
+
+static u64 kdwc3_dma_mask;
+
+struct dwc3_keystone {
+	struct device			*dev;
+	struct clk			*clk;
+	void __iomem			*usbss;
+};
+
+static inline u32 kdwc3_readl(void __iomem *base, u32 offset)
+{
+	return readl(base + offset);
+}
+
+static inline void kdwc3_writel(void __iomem *base, u32 offset, u32 value)
+{
+	writel(value, base + offset);
+}
+
+static void kdwc3_enable_irqs(struct dwc3_keystone *kdwc)
+{
+	u32 val;
+
+	val = kdwc3_readl(kdwc->usbss, USBSS_IRQENABLE_SET_0);
+	val = USBSS_IRQ_COREIRQ_EN;
+	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_SET_0, val);
+}
+
+static void kdwc3_disable_irqs(struct dwc3_keystone *kdwc)
+{
+	u32 val;
+
+	val = kdwc3_readl(kdwc->usbss, USBSS_IRQENABLE_SET_0);
+	val &= ~USBSS_IRQ_COREIRQ_EN;
+	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_SET_0, val);
+}
+
+static irqreturn_t dwc3_keystone_interrupt(int irq, void *_kdwc)
+{
+	struct dwc3_keystone	*kdwc = _kdwc;
+
+	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_CLR_0, USBSS_IRQ_COREIRQ_CLR);
+	kdwc3_writel(kdwc->usbss, USBSS_IRQSTATUS_0, USBSS_IRQ_EVENT_ST);
+	kdwc3_writel(kdwc->usbss, USBSS_IRQENABLE_SET_0, USBSS_IRQ_COREIRQ_EN);
+	kdwc3_writel(kdwc->usbss, USBSS_IRQ_EOI, USBSS_IRQ_EOI_LINE(0));
+
+	return IRQ_HANDLED;
+}
+
+static int kdwc3_probe(struct platform_device *pdev)
+{
+	struct device		*dev = &pdev->dev;
+	struct device_node	*node = pdev->dev.of_node;
+	struct dwc3_keystone	*kdwc;
+	struct resource		*res;
+	int			error, irq;
+
+	kdwc = devm_kzalloc(dev, sizeof(*kdwc), GFP_KERNEL);
+	if (!kdwc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, kdwc);
+
+	kdwc->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing usbss resource\n");
+		return -EINVAL;
+	}
+
+	kdwc->usbss = devm_ioremap_resource(dev, res);
+	if (IS_ERR(kdwc->usbss))
+		return PTR_ERR(kdwc->usbss);
+
+	kdwc3_dma_mask = dma_get_mask(dev);
+	dev->dma_mask = &kdwc3_dma_mask;
+
+	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
+	if (IS_ERR_OR_NULL(kdwc->clk)) {
+		dev_err(kdwc->dev, "unable to get kdwc usb clock\n");
+		return -ENODEV;
+	}
+
+	error = clk_prepare_enable(kdwc->clk);
+	if (error < 0) {
+		dev_dbg(kdwc->dev, "unable to enable usb clock, err %d\n",
+			error);
+		return error;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "missing irq\n");
+		goto err_irq;
+	}
+
+	error = devm_request_irq(dev, irq, dwc3_keystone_interrupt, IRQF_SHARED,
+			dev_name(dev), kdwc);
+	if (error) {
+		dev_err(dev, "failed to request IRQ #%d --> %d\n",
+				irq, error);
+		goto err_irq;
+	}
+
+	kdwc3_enable_irqs(kdwc);
+
+	error = of_platform_populate(node, NULL, NULL, dev);
+	if (error) {
+		dev_err(&pdev->dev, "failed to create dwc3 core\n");
+		goto err_core;
+	}
+
+	return 0;
+
+err_core:
+	kdwc3_disable_irqs(kdwc);
+err_irq:
+	clk_disable_unprepare(kdwc->clk);
+
+	return error;
+}
+
+static int kdwc3_remove_core(struct device *dev, void *c)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+
+	platform_device_unregister(pdev);
+
+	return 0;
+}
+
+static int kdwc3_remove(struct platform_device *pdev)
+{
+	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
+
+	kdwc3_disable_irqs(kdwc);
+	clk_disable_unprepare(kdwc->clk);
+	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);
+	platform_set_drvdata(pdev, NULL);
+	return 0;
+}
+
+static const struct of_device_id kdwc3_of_match[] = {
+	{ .compatible = "ti,keystone-dwc3", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, kdwc3_of_match);
+
+static struct platform_driver kdwc3_driver = {
+	.probe		= kdwc3_probe,
+	.remove		= kdwc3_remove,
+	.driver		= {
+		.name	= "keystone-dwc3",
+		.owner	        = THIS_MODULE,
+		.of_match_table	= kdwc3_of_match,
+	},
+};
+
+module_platform_driver(kdwc3_driver);
+
+MODULE_ALIAS("platform:keystone-dwc3");
+MODULE_AUTHOR("WingMan Kwok <w-kwok2@ti.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("DesignWare USB3 KEYSTONE Glue Layer");
-- 
1.7.9.5
