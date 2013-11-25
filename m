From: w-kwok2@ti.com (WingMan Kwok)
Date: Mon, 25 Nov 2013 15:16:19 -0500
Subject: [PATCH 1/3] usb: dwc3: Add Keystone specific glue layer
In-Reply-To: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
References: <1385410581-12148-1-git-send-email-w-kwok2@ti.com>
Message-ID: <1385410581-12148-2-git-send-email-w-kwok2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Keystone platform specific glue layer to support
USB3 Host mode.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: WingMan Kwok <w-kwok2@ti.com>
---
 drivers/usb/dwc3/Kconfig         |    7 +
 drivers/usb/dwc3/Makefile        |    1 +
 drivers/usb/dwc3/dwc3-keystone.c |  272 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)
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
index 0000000..a4c9cbc
--- /dev/null
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -0,0 +1,272 @@
+/**
+ * dwc3-keystone.c - Keystone Specific Glue layer
+ *
+ * Copyright (C) 2010-2013 Texas Instruments Incorporated - http://www.ti.com
+ *
+ * Authors: WingMan Kwok <w-kwok2@ti.com>
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
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/ioport.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/usb/usb_phy_gen_xceiv.h>
+
+
+#define BITS(n)			(BIT(n) - 1)
+#define BITFIELD(x, s, n)	(((x) & BITS(n)) << (s))
+#define MASK			0xffffffff
+#define PHY_REF_SSP_EN(x)	BITFIELD(x, 29, 1)
+
+static u64 kdwc3_dma_mask;
+
+struct kdwc3_phy_ctrl_regs {
+	u32	phy_utmi;
+	u32	phy_pipe;
+	u32	phy_param_ctrl_1;
+	u32	phy_param_ctrl_2;
+	u32	phy_clock;
+	u32	phy_pll;
+};
+
+struct kdwc3_irq_regs {
+	u32		revision;
+	u32		_rsvd0[3];
+	u32		sysconfig;
+	u32		_rsvd1[1];
+	u32		irq_eoi;
+	u32		_rsvd2[1];
+	struct {
+		u32	raw_status;
+		u32	status;
+		u32	enable_set;
+		u32	enable_clr;
+	} irqs[16];
+};
+
+struct dwc3_keystone {
+	spinlock_t				lock;
+	struct device				*dev;
+	struct clk				*clk;
+	int					irqn;
+
+	struct kdwc3_phy_ctrl_regs __iomem	*phy_ctrl;
+	struct kdwc3_irq_regs __iomem		*usbss;
+};
+
+static void kdwc3_enable_irqs(struct dwc3_keystone *kdwc)
+{
+	writel(1, &kdwc->usbss->irqs[kdwc->irqn].enable_set);
+}
+
+static void kdwc3_disable_irqs(struct dwc3_keystone *kdwc)
+{
+	writel(0, &kdwc->usbss->irqs[kdwc->irqn].enable_set);
+}
+
+static int kdwc3_enable(struct dwc3_keystone *kdwc)
+{
+	int error;
+	u32 val;
+
+	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
+	if (IS_ERR_OR_NULL(kdwc->clk)) {
+		dev_err(kdwc->dev, "unable to get kdwc usb clock\n");
+		return -ENODEV;
+	}
+
+	val  = readl(&kdwc->phy_ctrl->phy_clock);
+	writel(val | PHY_REF_SSP_EN(1), &kdwc->phy_ctrl->phy_clock);
+	udelay(20);
+
+	error = clk_prepare_enable(kdwc->clk);
+	if (error < 0) {
+		dev_dbg(kdwc->dev, "unable to enable usb clock, err %d\n",
+			error);
+		writel(val, &kdwc->phy_ctrl->phy_clock);
+		return error;
+	}
+
+	/* soft reset usbss */
+	writel(1, &kdwc->usbss->sysconfig);
+	while (readl(&kdwc->usbss->sysconfig) & 1)
+		;
+
+	val = readl(&kdwc->usbss->revision);
+	dev_info(kdwc->dev, "usbss revision %x\n", val);
+
+	return 0;
+}
+
+static void kdwc3_disable(struct dwc3_keystone *kdwc)
+{
+	u32 val;
+
+	clk_disable_unprepare(kdwc->clk);
+
+	val  = readl(&kdwc->phy_ctrl->phy_clock);
+	val &= ~PHY_REF_SSP_EN(MASK);
+	writel(val, &kdwc->phy_ctrl->phy_clock);
+}
+
+static irqreturn_t dwc3_keystone_interrupt(int irq, void *_kdwc)
+{
+	struct dwc3_keystone	*kdwc = _kdwc;
+	int			irqn = kdwc->irqn;
+
+	spin_lock(&kdwc->lock);
+	writel(1, &kdwc->usbss->irqs[irqn].enable_clr);
+	writel(1, &kdwc->usbss->irqs[irqn].status);
+	writel(1, &kdwc->usbss->irqs[irqn].enable_set);
+	writel(BIT(irqn), &kdwc->usbss->irq_eoi);
+	spin_unlock(&kdwc->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int kdwc3_probe(struct platform_device *pdev)
+{
+	struct device_node	*node = pdev->dev.of_node;
+	struct device		*dev = &pdev->dev;
+	struct dwc3_keystone	*kdwc;
+	struct resource		*res;
+	int			error, irq;
+
+	if (!node) {
+		dev_err(dev, "device node not found\n");
+		return -EINVAL;
+	}
+
+	kdwc = devm_kzalloc(dev, sizeof(*kdwc), GFP_KERNEL);
+	if (!kdwc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, kdwc);
+
+	spin_lock_init(&kdwc->lock);
+	kdwc->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "missing usbss resource\n");
+		return -EINVAL;
+	}
+
+	kdwc->usbss = devm_ioremap_resource(dev, res);
+	if (IS_ERR(kdwc->usbss)) {
+		dev_err(dev, "ioremap failed on usbss region\n");
+		return PTR_ERR(kdwc->usbss);
+	}
+
+	dev_dbg(dev, "usbss control start=%08x size=%d mapped=%08x\n",
+		(u32)(res->start), (int)resource_size(res),
+		(u32)(kdwc->usbss));
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		dev_err(dev, "missing usb phy resource\n");
+		return -EINVAL;
+	}
+
+	kdwc->phy_ctrl = devm_ioremap_resource(dev, res);
+	if (IS_ERR(kdwc->phy_ctrl)) {
+		dev_err(dev, "ioremap failed on usb phy region\n");
+		return PTR_ERR(kdwc->phy_ctrl);
+	}
+
+	dev_dbg(dev, "phy control start=%08x size=%d mapped=%08x\n",
+		(u32)(res->start), (int)resource_size(res),
+		(u32)(kdwc->phy_ctrl));
+
+	kdwc3_dma_mask = dma_get_mask(dev);
+	dev->dma_mask = &kdwc3_dma_mask;
+
+	error = kdwc3_enable(kdwc);
+	if (error)
+		return error;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "missing irq\n");
+		goto err_irq;
+	}
+
+	error = devm_request_irq(dev, irq, dwc3_keystone_interrupt, IRQF_SHARED,
+			"keystone-dwc3", kdwc);
+	if (error) {
+		dev_err(dev, "failed to request IRQ #%d --> %d\n",
+				irq, error);
+		goto err_irq;
+	}
+
+	kdwc->irqn = 0;
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
+	kdwc3_disable(kdwc);
+
+	return error;
+}
+
+static int kdwc3_remove(struct platform_device *pdev)
+{
+	struct dwc3_keystone *kdwc = platform_get_drvdata(pdev);
+
+	if (kdwc) {
+		kdwc3_disable_irqs(kdwc);
+		kdwc3_disable(kdwc);
+		platform_set_drvdata(pdev, NULL);
+	}
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
