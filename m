From: marex@denx.de (Marek Vasut)
Date: Tue, 17 Apr 2012 12:15:48 +0200
Subject: [PATCH 5/8] MXS: Add USB PHY driver
In-Reply-To: <1334657751-27678-1-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
Message-ID: <1334657751-27678-6-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add driver that controls the built-in USB PHY in the i.MX233/i.MX28. This
enables the PHY upon powerup and shuts it down on shutdown.

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
 drivers/usb/otg/Kconfig   |    9 ++
 drivers/usb/otg/Makefile  |    1 +
 drivers/usb/otg/mxs-phy.c |  256 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 266 insertions(+)
 create mode 100644 drivers/usb/otg/mxs-phy.c

diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 5c87db0..8689081 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -116,6 +116,15 @@ config FSL_USB2_OTG
 	help
 	  Enable this to support Freescale USB OTG transceiver.
 
+config USB_MXS_PHY
+	tristate "Freescale i.MX28 USB PHY support"
+	select USB_OTG_UTILS
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
index 41aa509..a844b8d 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -20,4 +20,5 @@ obj-$(CONFIG_USB_MSM_OTG)	+= msm_otg.o
 obj-$(CONFIG_AB8500_USB)	+= ab8500-usb.o
 fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
 obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
+obj-$(CONFIG_USB_MXS_PHY)	+= mxs-phy.o
 obj-$(CONFIG_USB_MV_OTG)	+= mv_otg.o
diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
new file mode 100644
index 0000000..9963aa8
--- /dev/null
+++ b/drivers/usb/otg/mxs-phy.c
@@ -0,0 +1,256 @@
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
+#include <linux/usb/otg.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/devices-common.h>
+#include <mach/mx28.h>
+
+#define HW_USBPHY_PWD				0x00
+
+#define HW_USBPHY_CTRL				0x30
+#define HW_USBPHY_CTRL_SET			0x34
+#define HW_USBPHY_CTRL_CLR			0x38
+#define HW_USBPHY_CTRL_TOG			0x3c
+
+#define BM_USBPHY_CTRL_SFTRST			(1 << 31)
+#define BM_USBPHY_CTRL_CLKGATE			(1 << 30)
+#define BM_USBPHY_CTRL_ENUTMILEVEL3		(1 << 15)
+#define BM_USBPHY_CTRL_ENUTMILEVEL2		(1 << 14)
+#define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	(1 << 1)
+
+struct mxs_phy {
+	struct usb_phy	phy;
+	struct device	*dev;
+	struct clk	*clk;
+	struct resource	*res;
+	void __iomem	*reg;
+};
+
+static int phy_init(struct usb_phy *x)
+{
+	struct mxs_phy *phy = container_of(x, struct mxs_phy, phy);
+	uint32_t val;
+
+	/* Enable clock to the PHY. */
+	clk_enable(phy->clk);
+
+	/* Reset the PHY block. */
+	mxs_reset_block(phy->reg + HW_USBPHY_CTRL);
+
+	/* Power up the PHY. */
+	writel(0, phy->reg + HW_USBPHY_PWD);
+
+	/* Enable FS/LS compatibility and HS disconnection detector. */
+	val = BM_USBPHY_CTRL_ENUTMILEVEL2 | BM_USBPHY_CTRL_ENUTMILEVEL3 |
+		BM_USBPHY_CTRL_ENHOSTDISCONDETECT;
+	writel(val, phy->reg + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
+static void phy_shutdown(struct usb_phy *x)
+{
+	struct mxs_phy *phy = container_of(x, struct mxs_phy, phy);
+
+	/* Gate off the PHY. */
+	writel(BM_USBPHY_CTRL_CLKGATE, phy->reg + HW_USBPHY_CTRL_SET);
+
+	/* Disable clock to the PHY. */
+	clk_disable(phy->clk);
+}
+
+static int phy_set_vbus(struct usb_otg *otg, bool enabled)
+{
+	struct usb_phy *x = otg->phy;
+	struct mxs_phy *phy = container_of(x, struct mxs_phy, phy);
+
+	if (enabled)
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+			phy->reg + HW_USBPHY_CTRL_CLR);
+	else
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+			phy->reg + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
+static int __devinit mxs_phy_probe(struct platform_device *pdev)
+{
+	struct mxs_phy *phy;
+	struct resource *res;
+	int ret;
+
+	/* Allocate PHY driver's private date. */
+	phy = kzalloc(sizeof *phy, GFP_KERNEL);
+	if (!phy) {
+		ret = -ENOMEM;
+		goto err_alloc_phy;
+	}
+
+	/* Allocate OTG structure. */
+	phy->phy.otg = kzalloc(sizeof *phy->phy.otg, GFP_KERNEL);
+	if (!phy->phy.otg) {
+		ret = -ENOMEM;
+		goto err_alloc_otg;
+	}
+
+	/* Claim the PHY clock. */
+	phy->clk = clk_get(&pdev->dev, "usb_phy");
+	if (!phy->clk) {
+		dev_err(&pdev->dev, "Failed to claim clock for USB PHY\n");
+		ret = -EINVAL;
+		goto err_claim_clock;
+	}
+
+	/* Get memory area where this controller resides from resources. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Specify memory area for this controller!\n");
+		ret = -ENODEV;
+		goto err_get_resource;
+	}
+
+	/* Request the memory region for this driver. */
+	if (!request_mem_region(res->start, resource_size(res), pdev->name)) {
+		dev_dbg(&pdev->dev, "PHY memory area already in use!\n");
+		ret = -EBUSY;
+		goto err_get_resource;
+	}
+
+	/* Map the memory region. */
+	phy->reg = ioremap(res->start, resource_size(res));
+	if (!phy->reg) {
+		dev_err(&pdev->dev, "Memory mapping failed!\n");
+		ret = -EFAULT;
+		goto err_ioremap;
+	}
+
+	/* Setup the PHY structures. */
+	phy->dev		= &pdev->dev;
+	phy->phy.dev		= phy->dev;
+	phy->phy.label		= "mxs-phy";
+	phy->phy.init		= phy_init;
+	phy->phy.shutdown	= phy_shutdown;
+	phy->phy.state		= OTG_STATE_A_HOST;
+
+	phy->res		= res;
+
+	phy->phy.otg->phy	= &phy->phy;
+	phy->phy.otg->set_vbus	= phy_set_vbus;
+
+	platform_set_drvdata(pdev, phy);
+
+	ATOMIC_INIT_NOTIFIER_HEAD(&phy->phy.notifier);
+
+	/* Enable the PHY clock. */
+	clk_prepare_enable(phy->clk);
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
+	clk_disable_unprepare(phy->clk);
+	iounmap(phy->reg);
+err_ioremap:
+	release_mem_region(res->start, resource_size(res));
+err_get_resource:
+	clk_put(phy->clk);
+err_claim_clock:
+	kfree(phy->phy.otg);
+err_alloc_otg:
+	kfree(phy);
+err_alloc_phy:
+
+	return ret;
+}
+
+static int __devexit mxs_phy_remove(struct platform_device *pdev)
+{
+	struct mxs_phy *phy = platform_get_drvdata(pdev);
+
+	/* Power down the PHY. */
+	phy_shutdown(&phy->phy);
+
+	/* Stop the PHY clock. */
+	clk_disable_unprepare(phy->clk);
+
+	/* Unmap and release the PHY memory region. */
+	iounmap(phy->reg);
+	release_mem_region(phy->res->start, resource_size(phy->res));
+
+	/* Reclaim the clock. */
+	clk_put(phy->clk);
+
+	/* Free the rest. */
+	usb_set_transceiver(NULL);
+	platform_set_drvdata(pdev, NULL);
+	kfree(phy->phy.otg);
+	kfree(phy);
+
+	return 0;
+}
+
+static struct platform_driver mxs_phy_driver = {
+	.probe		= mxs_phy_probe,
+	.remove		= __devexit_p(mxs_phy_remove),
+	.driver		= {
+		.name	= "mxs-phy",
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
+/*
+ * PHY must be registered via subsys_initcall to get it running before EHCI
+ * controller driver.
+ */
+subsys_initcall(mxs_phy_init);
+module_exit(mxs_phy_exit);
+
+MODULE_ALIAS("platform:mxs_phy");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
+MODULE_DESCRIPTION("Freescale i.MX28 USB PHY driver");
+MODULE_LICENSE("GPL");
-- 
1.7.9.5
