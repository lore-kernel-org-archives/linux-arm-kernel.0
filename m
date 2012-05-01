From: marex@denx.de (Marek Vasut)
Date: Tue,  1 May 2012 03:56:01 +0200
Subject: [PATCH 09/11] MXS: Add USB PHY driver
In-Reply-To: <1335837363-12376-1-git-send-email-marex@denx.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
Message-ID: <1335837363-12376-10-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver that controls the built-in USB PHY in the i.MX233/i.MX28. This
enables the PHY upon powerup and shuts it down on shutdown.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chen Peter-B29397 <B29397@freescale.com>
Cc: Detlev Zundel <dzu@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Li Frank-B20596 <B20596@freescale.com>
Cc: Linux USB <linux-usb@vger.kernel.org>
Cc: Liu JunJie-B08287 <B08287@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Shi Make-B15407 <B15407@freescale.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Subodh Nijsure <snijsure@grid-net.com>
Cc: Wolfgang Denk <wd@denx.de>
---
 drivers/usb/otg/Kconfig   |   10 ++
 drivers/usb/otg/Makefile  |    1 +
 drivers/usb/otg/mxs-phy.c |  328 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 drivers/usb/otg/mxs-phy.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index e7c6325..1de1495 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -122,6 +122,16 @@ config USB_IMX_COMPOSITE
 	  Composite driver that handles clock and memory mapping for
 	  i.MX USB host and USB PHY.
 
+config USB_MXS_PHY
+	tristate "Freescale i.MX28 USB PHY support"
+	select USB_OTG_UTILS
+	select USB_IMX_COMPOSITE
+	help
+	  Say Y here if you want to build Freescale i.MX28 USB PHY
+	  driver in kernel.
+
+	  To compile this driver as a module, choose M here.
+
 config USB_MV_OTG
 	tristate "Marvell USB OTG support"
 	depends on USB_EHCI_MV && USB_MV_UDC && USB_SUSPEND
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index 7d2c631..b8d7d5c 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
 fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
 obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
 obj-$(CONFIG_USB_IMX_COMPOSITE)	+= imx-otg.o
+obj-$(CONFIG_USB_MXS_PHY)	+= mxs-phy.o
 obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
new file mode 100644
index 0000000..45530d8
--- /dev/null
+++ b/drivers/usb/otg/mxs-phy.c
@@ -0,0 +1,328 @@
+/*
+ * drivers/usb/otg/mxs-phy.c
+ *
+ * Freescale i.MX28 USB PHY driver.
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
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/usb/mxs-usb.h>
+
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/ehci_def.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#include <mach/mx28.h>
+
+/* MXS USB PHY register definitions. */
+#define HW_USBPHY_PWD				0x00
+
+#define HW_USBPHY_CTRL				0x30
+#define HW_USBPHY_CTRL_SET			0x34
+#define HW_USBPHY_CTRL_CLR			0x38
+#define HW_USBPHY_CTRL_TOG			0x3c
+
+#define BM_USBPHY_CTRL_SFTRST			(1 << 31)
+#define BM_USBPHY_CTRL_CLKGATE			(1 << 30)
+#define BM_USBPHY_CTRL_ENVBUSCHG_WKUP		(1 << 23)
+#define BM_USBPHY_CTRL_ENIDCHG_WKUP		(1 << 22)
+#define BM_USBPHY_CTRL_ENDPDMCHG_WKUP		(1 << 21)
+#define BM_USBPHY_CTRL_WAKEUP_IRQ		(1 << 17)
+#define BM_USBPHY_CTRL_ENIRQWAKEUP		(1 << 16)
+#define BM_USBPHY_CTRL_ENUTMILEVEL3		(1 << 15)
+#define BM_USBPHY_CTRL_ENUTMILEVEL2		(1 << 14)
+#define BM_USBPHY_CTRL_ENIRQDEVPLUGIN		(1 << 11)
+#define BM_USBPHY_CTRL_RESUME_IRQ		(1 << 10)
+#define BM_USBPHY_CTRL_ENIRQRESUMEDETECT	(1 << 9)
+#define BM_USBPHY_CTRL_ENOTGIDDETECT		(1 << 7)
+#define BM_USBPHY_CTRL_ENDEVPLUGINDETECT	(1 << 4)
+#define BM_USBPHY_CTRL_HOSTDISCONDETECT_IRQ	(1 << 3)
+#define BM_USBPHY_CTRL_ENIRQHOSTDISCON		(1 << 2)
+#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	(1 << 1)
+
+#define HW_USBPHY_STATUS			0x40
+
+#define BM_USBPHY_STATUS_OTGID_STATUS		(1 << 8)
+#define BM_USBPHY_STATUS_DEVPLUGIN_STATUS	(1 << 6)
+#define BM_USBPHY_STATUS_HOSTDISCON_STATUS	(1 << 3)
+
+struct mxs_usb_phy {
+	struct usb_phy		phy;
+	struct clk		*clk;
+	int			irq;
+	uint32_t		status;
+};
+
+static int mxs_usb_phy_init(struct usb_phy *x)
+{
+	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
+	uint32_t val;
+
+	/* Enable clock to the PHY. */
+	clk_enable(phy->clk);
+
+	/* Reset the PHY block. */
+	mxs_reset_block(x->io_priv + HW_USBPHY_CTRL);
+
+	/* Power up the PHY. */
+	writel(0, x->io_priv + HW_USBPHY_PWD);
+
+	/* Clear the wakeup IRQ before enabling them below. */
+	writel(BM_USBPHY_CTRL_RESUME_IRQ | BM_USBPHY_CTRL_WAKEUP_IRQ,
+		x->io_priv + HW_USBPHY_CTRL_CLR);
+
+	/* Enable FS/LS compatibility and wakeup IRQs. */
+	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3 |
+		BM_USBPHY_CTRL_ENIRQWAKEUP;
+
+	/* Enable IRQ sources. */
+	val |= BM_USBPHY_CTRL_ENIDCHG_WKUP | BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
+		BM_USBPHY_CTRL_ENVBUSCHG_WKUP;
+
+	writel(val, x->io_priv + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
+static void mxs_usb_phy_shutdown(struct usb_phy *x)
+{
+	struct mxs_usb_phy *phy = container_of(x, struct mxs_usb_phy, phy);
+	uint32_t val;
+
+	/* Clear the wakeup IRQ before disabling them below. */
+	writel(BM_USBPHY_CTRL_RESUME_IRQ | BM_USBPHY_CTRL_WAKEUP_IRQ,
+		x->io_priv + HW_USBPHY_CTRL_CLR);
+
+	/* Disable FS/LS compatibility and wakeup IRQs. */
+	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3 |
+		BM_USBPHY_CTRL_ENIRQWAKEUP;
+
+	/* Disable IRQ sources. */
+	val |= BM_USBPHY_CTRL_ENIDCHG_WKUP | BM_USBPHY_CTRL_ENDPDMCHG_WKUP |
+		BM_USBPHY_CTRL_ENVBUSCHG_WKUP;
+
+	writel(val, x->io_priv + HW_USBPHY_CTRL_CLR);
+
+	/*
+	 * The interrupt must be disabled for at least 3 cycles of the
+	 * standby clock (32kHz), that is 0.094 ms.
+	 */
+	udelay(100);
+
+	/* Gate off the PHY. */
+	writel(BM_USBPHY_CTRL_CLKGATE, x->io_priv + HW_USBPHY_CTRL_SET);
+
+	/* Disable clock to the PHY. */
+	clk_disable(phy->clk);
+}
+
+static irqreturn_t mxs_phy_irq(int irq, void *irqdata)
+{
+	struct mxs_usb_phy *phy = irqdata;
+	struct usb_phy *x = &phy->phy;
+	struct usb_otg *otg = x->otg;
+	struct imx_otg *data = container_of(otg, struct imx_otg, otg);
+	struct imx_otg_res *res = &data->res;
+	uint32_t status;
+
+	if (!otg)
+		return IRQ_NONE;
+
+	if (data->cur_state != OTG_STATE_B_PERIPHERAL) {
+		status = readl(res->mem + 0x144);
+		if (~(phy->status ^ status) & STS_PCD)
+			return IRQ_NONE;
+
+		phy->status = status;
+
+		if (phy->status & STS_PCD) {
+			writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+				x->io_priv + HW_USBPHY_CTRL_CLR);
+		} else {
+			writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+				x->io_priv + HW_USBPHY_CTRL_SET);
+		}
+	}
+
+	return IRQ_NONE;
+}
+
+static int __devinit mxs_phy_probe(struct platform_device *pdev)
+{
+	struct imx_usb_platform_data *pdata = pdev->dev.platform_data;
+	struct mxs_usb_phy *phy;
+	struct resource *mem_res;
+	void *retp;
+	int ret;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "No platform data supplied!\n");
+		ret = -ENODEV;
+		goto err_pdata;
+	}
+
+	/* Allocate PHY driver's private data. */
+	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy) {
+		dev_err(&pdev->dev, "Failed to allocate USB PHY structure!\n");
+		ret = -ENOMEM;
+		goto err_pdata;
+	}
+
+	/* Get memory area for PHY from resources. */
+	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem_res) {
+		dev_err(&pdev->dev, "Specify memory area for this USB PHY!\n");
+		ret = -ENODEV;
+		goto err_pdata;
+	}
+
+	/* Request the memory region for this USB PHY. */
+	retp = devm_request_mem_region(&pdev->dev, mem_res->start,
+			resource_size(mem_res), pdev->name);
+	if (!retp) {
+		dev_err(&pdev->dev, "USB PHY memory area already in use!\n");
+		ret = -EBUSY;
+		goto err_pdata;
+	}
+
+	/* Map the memory region for USB PHY. */
+	phy->phy.io_priv = devm_ioremap(&pdev->dev, mem_res->start,
+				resource_size(mem_res));
+	if (!phy->phy.io_priv) {
+		dev_err(&pdev->dev, "Memory mapping of USB PHY failed!\n");
+		ret = -EFAULT;
+		goto err_pdata;
+	}
+
+	/* Get IRQ for PHY from resources. */
+	phy->irq = platform_get_irq(pdev, 0);
+	if (phy->irq < 0) {
+		dev_err(&pdev->dev, "Specify IRQ for this USB Host!\n");
+		ret = -ENODEV;
+		goto err_pdata;
+	}
+
+	/* Request the PHY IRQ. */
+	ret = devm_request_irq(&pdev->dev, phy->irq, mxs_phy_irq,
+				IRQF_SHARED, "mxs-phy-usb-irq", phy);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ!\n");
+		goto err_pdata;
+	}
+
+	/* Claim the PHY clock. */
+	phy->clk = clk_get(&pdev->dev, "phy");
+	if (!phy->clk) {
+		dev_err(&pdev->dev, "Failed to claim clock for USB PHY!\n");
+		ret = PTR_ERR(phy->clk);
+		goto err_pdata;
+	}
+
+	/* Prepare PHY clock. */
+	ret = clk_prepare(phy->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to prepare clock for USB PHY!\n");
+		goto err_prepare_phy_clock;
+	}
+
+	/* Setup the PHY structures. */
+	phy->phy.dev		= &pdev->dev;
+	phy->phy.label		= "mxs-usb-phy";
+	phy->phy.init		= mxs_usb_phy_init;
+	phy->phy.shutdown	= mxs_usb_phy_shutdown;
+	phy->phy.state		= OTG_STATE_UNDEFINED;
+
+	platform_set_drvdata(pdev, phy);
+
+	ATOMIC_INIT_NOTIFIER_HEAD(&phy->phy.notifier);
+
+	/* Register the transceiver with kernel. */
+	ret = usb_set_transceiver(&phy->phy);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't register transceiver, (%d)\n", ret);
+		goto err_set_transceiver;
+	}
+
+	return 0;
+
+err_set_transceiver:
+	clk_unprepare(phy->clk);
+err_prepare_phy_clock:
+	clk_put(phy->clk);
+err_pdata:
+	return ret;
+}
+
+static int __devexit mxs_phy_remove(struct platform_device *pdev)
+{
+	struct mxs_usb_phy *phy = platform_get_drvdata(pdev);
+
+	/* Power down the PHY. */
+	mxs_usb_phy_shutdown(&phy->phy);
+
+	/* Remove the transceiver. */
+	usb_set_transceiver(NULL);
+
+	/* Stop the PHY clock. */
+	clk_disable_unprepare(phy->clk);
+	clk_put(phy->clk);
+
+	/* Free the rest. */
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver mxs_phy_driver = {
+	.probe		= mxs_phy_probe,
+	.remove		= __devexit_p(mxs_phy_remove),
+	.driver		= {
+		.name	= "mxs-usb-phy",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init mxs_phy_init(void)
+{
+	return platform_driver_register(&mxs_phy_driver);
+}
+
+static void __exit mxs_phy_exit(void)
+{
+	platform_driver_unregister(&mxs_phy_driver);
+}
+
+arch_initcall(mxs_phy_init);
+module_exit(mxs_phy_exit);
+
+MODULE_ALIAS("platform:mxs-usb-phy");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("Freescale i.MX28 USB PHY driver");
+MODULE_LICENSE("GPL");
-- 
1.7.10
