From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Apr 2012 04:07:45 +0200
Subject: [PATCH 06/10] MXS: Add composite imx-usb driver
In-Reply-To: <1334714869-19282-1-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334714869-19282-1-git-send-email-marex@denx.de>
Message-ID: <1334714869-19282-7-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver handles claiming of clocks and memory areas. These are later
properly delegated to it's child devices, the USB PHY and USB Host.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Lin Tony-B19295 <B19295@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Tony Lin <tony.lin@freescale.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/usb/otg/Kconfig   |    6 +
 drivers/usb/otg/Makefile  |    1 +
 drivers/usb/otg/imx-usb.c |  303 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 310 insertions(+)
 create mode 100644 drivers/usb/otg/imx-usb.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 5c87db0..e7c6325 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -116,6 +116,12 @@ config FSL_USB2_OTG
 	help
 	  Enable this to support Freescale USB OTG transceiver.
 
+config USB_IMX_COMPOSITE
+	bool
+	help
+	  Composite driver that handles clock and memory mapping for
+	  i.MX USB host and USB PHY.
+
 config USB_MV_OTG
 	tristate "Marvell USB OTG support"
 	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index 41aa509..e3feaca 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -20,4 +20,5 @@ obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
 obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
 fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
 obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
+obj-$(CONFIG_USB_IMX_COMPOSITE)	+= imx-usb.o
 obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
diff --git a/drivers/usb/otg/imx-usb.c b/drivers/usb/otg/imx-usb.c
new file mode 100644
index 0000000..8062dfa
--- /dev/null
+++ b/drivers/usb/otg/imx-usb.c
@@ -0,0 +1,303 @@
+/*
+ * drivers/usb/otg/imx-usb.c
+ *
+ * Freescale i.MX USB composite driver.
+ *
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
+ * on behalf of DENX Software Engineering GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/usb/otg.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fsl_devices.h>
+#include <linux/io.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+
+/*
+ * Allocate platform device with the DMA mask, this is borrowed from
+ * arch/arm/mach-mxs/devices.c
+ */
+static struct platform_device *__devinit add_platform_device(
+		const char *name, int id,
+		const void *data, size_t size_data, u64 dmamask)
+{
+	int ret = -ENOMEM;
+	struct platform_device *pdev;
+
+	pdev = platform_device_alloc(name, id);
+	if (!pdev)
+		goto err;
+
+	if (dmamask) {
+		/*
+		 * This memory isn't freed when the device is put,
+		 * I don't have a nice idea for that though.  Conceptually
+		 * dma_mask in struct device should not be a pointer.
+		 * See http://thread.gmane.org/gmane.linux.kernel.pci/9081
+		 */
+		pdev->dev.dma_mask =
+			kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
+		if (!pdev->dev.dma_mask)
+			/* ret is still -ENOMEM; */
+			goto err;
+
+		*pdev->dev.dma_mask = dmamask;
+		pdev->dev.coherent_dma_mask = dmamask;
+	}
+
+	if (data) {
+		ret = platform_device_add_data(pdev, data, size_data);
+		if (ret)
+			goto err;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+err:
+		if (dmamask)
+			kfree(pdev->dev.dma_mask);
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
+
+	return pdev;
+}
+
+static int __devinit imx_usb_probe(struct platform_device *pdev)
+{
+	struct imx_usb *data;
+	struct imx_usb_data *host_data, *phy_data;
+	int ret;
+	void *retp = NULL;
+
+	/*
+	 * Until further notice, this claims all necessary resources.
+	 */
+
+	/* Allocate driver's private date. */
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err_alloc_data;
+	}
+
+	host_data = &data->host;
+	phy_data = &data->phy;
+
+	/* Claim the Host clock. */
+	host_data->clk = clk_get(&pdev->dev, "usb");
+	if (IS_ERR(host_data->clk)) {
+		dev_err(&pdev->dev, "Failed to claim clock for USB Host\n");
+		ret = PTR_ERR(host_data->clk);
+		goto err_claim_host_clock;
+	}
+
+	/* Claim the PHY clock. */
+	phy_data->clk = clk_get(&pdev->dev, "phy");
+	if (!phy_data->clk) {
+		dev_err(&pdev->dev, "Failed to claim clock for USB PHY\n");
+		ret = PTR_ERR(host_data->clk);
+		goto err_claim_phy_clock;
+	}
+
+	/* Prepare Host clock. */
+	ret = clk_prepare(host_data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to prepare clock for USB Host.\n");
+		goto err_prepare_host_clock;
+	}
+
+	/* Prepare PHY clock. */
+	ret = clk_prepare(phy_data->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to prepare clock for USB PHY.\n");
+		goto err_prepare_phy_clock;
+	}
+
+	/* Get memory area for EHCI host from resources. */
+	host_data->mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!host_data->mem_res) {
+		dev_err(&pdev->dev, "Specify memory area for this USB Host!\n");
+		ret = -ENODEV;
+		goto err_get_host_resource;
+	}
+
+	/* Get memory area for PHY from resources. */
+	phy_data->mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!phy_data->mem_res) {
+		dev_err(&pdev->dev, "Specify memory area for this USB PHY!\n");
+		ret = -ENODEV;
+		goto err_get_phy_resource;
+	}
+
+	/* Request the memory region for this USB Host. */
+	retp = devm_request_mem_region(&pdev->dev, host_data->mem_res->start,
+			resource_size(host_data->mem_res), pdev->name);
+	if (!retp) {
+		dev_err(&pdev->dev, "USB Host memory area already in use!\n");
+		ret = -EBUSY;
+		goto err_get_host_mem;
+	}
+
+	/* Request the memory region for this USB PHY. */
+	retp = devm_request_mem_region(&pdev->dev, phy_data->mem_res->start,
+			resource_size(phy_data->mem_res), pdev->name);
+	if (!retp) {
+		dev_err(&pdev->dev, "USB PHY memory area already in use!\n");
+		ret = -EBUSY;
+		goto err_get_phy_mem;
+	}
+
+	/* Map the memory region for USB Host. */
+	host_data->mem = devm_ioremap(&pdev->dev, host_data->mem_res->start,
+				resource_size(host_data->mem_res));
+	if (!host_data->mem) {
+		dev_err(&pdev->dev, "Memory mapping of USB Host failed!\n");
+		ret = -EFAULT;
+		goto err_map_host_mem;
+	}
+
+	/* Map the memory region for USB PHY. */
+	phy_data->mem = devm_ioremap(&pdev->dev, phy_data->mem_res->start,
+				resource_size(phy_data->mem_res));
+	if (!phy_data->mem) {
+		dev_err(&pdev->dev, "Memory mapping of USB PHY failed!\n");
+		ret = -EFAULT;
+		goto err_map_phy_mem;
+	}
+
+	/* Get IRQ for EHCI host from resources. */
+	host_data->irq = platform_get_irq(pdev, 0);
+	if (host_data->irq < 0) {
+		dev_err(&pdev->dev, "Specify IRQ for this USB Host!\n");
+		ret = -ENODEV;
+		goto err_get_host_irq;
+	}
+
+	/*
+	 * Now finally probe the Host and PHY drivers!
+	 */
+	data->phy_dev = add_platform_device("mxs-usb-phy", -1, &data->phy,
+					sizeof(data->phy), DMA_BIT_MASK(32));
+	if (!data->phy_dev) {
+		dev_err(&pdev->dev, "Failed registering PHY!\n");
+		ret = -ENODEV;
+		goto err_register_phy;
+	}
+
+	data->host_dev = add_platform_device("mxs-ehci", -1, &data->host,
+					sizeof(data->host), DMA_BIT_MASK(32));
+	if (!data->host_dev) {
+		dev_err(&pdev->dev, "Failed registering Host!\n");
+		ret = -ENODEV;
+		goto err_register_host;
+	}
+
+	return 0;
+
+err_register_host:
+err_register_phy:
+	platform_device_unregister(data->phy_dev);
+err_get_host_irq:
+	iounmap(phy_data->mem);
+err_map_phy_mem:
+	iounmap(host_data->mem);
+err_map_host_mem:
+	release_mem_region(phy_data->mem_res->start,
+			resource_size(phy_data->mem_res));
+err_get_phy_mem:
+	release_mem_region(host_data->mem_res->start,
+			resource_size(host_data->mem_res));
+err_get_host_mem:
+	phy_data->mem_res = NULL;
+err_get_phy_resource:
+	host_data->mem_res = NULL;
+err_get_host_resource:
+	clk_unprepare(phy_data->clk);
+err_prepare_phy_clock:
+	clk_unprepare(host_data->clk);
+err_prepare_host_clock:
+	clk_put(phy_data->clk);
+err_claim_phy_clock:
+	clk_put(host_data->clk);
+err_claim_host_clock:
+	kfree(data);
+err_alloc_data:
+	return ret;
+}
+
+static int __devexit imx_usb_remove(struct platform_device *pdev)
+{
+	struct imx_usb *data = platform_get_drvdata(pdev);
+	struct imx_usb_data *host_data, *phy_data;
+
+	host_data = &data->host;
+	phy_data = &data->phy;
+
+	platform_device_unregister(data->host_dev);
+	platform_device_unregister(data->phy_dev);
+
+	iounmap(host_data->mem);
+	iounmap(host_data->mem);
+	release_mem_region(phy_data->mem_res->start,
+			resource_size(phy_data->mem_res));
+	release_mem_region(host_data->mem_res->start,
+			resource_size(host_data->mem_res));
+	phy_data->mem_res = NULL;
+	host_data->mem_res = NULL;
+	clk_unprepare(phy_data->clk);
+	clk_unprepare(host_data->clk);
+	clk_put(phy_data->clk);
+	clk_put(host_data->clk);
+	kfree(data);
+
+	return 0;
+}
+
+static struct platform_driver imx_usb_driver = {
+	.probe		= imx_usb_probe,
+	.remove		= __devexit_p(imx_usb_remove),
+	.driver		= {
+		.name	= "imx-usb",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init imx_usb_init(void)
+{
+	return platform_driver_register(&imx_usb_driver);
+}
+
+static void __exit imx_usb_exit(void)
+{
+	platform_driver_unregister(&imx_usb_driver);
+}
+
+module_init(imx_usb_init);
+module_exit(imx_usb_exit);
+
+MODULE_ALIAS("platform:imx-usb");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("Freescale i.MX USB composite driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
