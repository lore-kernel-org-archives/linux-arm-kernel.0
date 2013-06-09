From: 21cnbao@gmail.com (Barry Song)
Date: Sun,  9 Jun 2013 11:25:37 +0800
Subject: [PATCH 2/3] usb: phy: add driver for CSR SiRFSoC internal phy
In-Reply-To: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
References: <1370748338-13210-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1370748338-13210-3-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rong Wang <Rong.Wang@csr.com>

This patch adds a driver for CSR SiRFSoC internal phy support
for USB Controller 1.

Signed-off-by: Rong Wang <Rong.Wang@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/usb/phy/Kconfig        |   10 ++
 drivers/usb/phy/Makefile       |    1 +
 drivers/usb/phy/phy-sirf-usb.c |  198 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/phy/phy-sirf-usb.c

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 7ef3eb8..ea30195 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -179,6 +179,16 @@ config USB_MXS_PHY
 
 	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
 
+config USB_SIRF_PHY
+	tristate "SiRF USB PHY support"
+	depends on ARCH_SIRF
+	help
+	  Say Y here if you want to build SiRF USB OTG transciever
+	  driver in kernel (including Prima and Atlas series). This driver
+	  implements role switch between EHCI host driver and gadget driver.
+
+	  To compile this driver as a module, choose M here.
+
 config USB_RCAR_PHY
 	tristate "Renesas R-Car USB phy support"
 	depends on USB || USB_GADGET
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index a9169cb..6caa29c 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_USB_ISP1301)		+= phy-isp1301.o
 obj-$(CONFIG_USB_MSM_OTG)		+= phy-msm-usb.o
 obj-$(CONFIG_USB_MV_OTG)		+= phy-mv-usb.o
 obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
+obj-$(CONFIG_USB_SIRF_PHY)		+= phy-sirf-usb.o
 obj-$(CONFIG_USB_RCAR_PHY)		+= phy-rcar-usb.o
 obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
diff --git a/drivers/usb/phy/phy-sirf-usb.c b/drivers/usb/phy/phy-sirf-usb.c
new file mode 100644
index 0000000..708f40c
--- /dev/null
+++ b/drivers/usb/phy/phy-sirf-usb.c
@@ -0,0 +1,198 @@
+/*
+ * USB PHY Driver for CSR SiRF SoC
+ *
+ * Copyright (c) 2011 Cambridge Silicon Radio Limited, a CSR plc group company.
+ * Rong Wang<Rong.Wang@csr.com>
+ *
+ * Licensed under GPLv2 or later.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/usb/otg.h>
+#include <linux/stmp_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+
+struct sirf_phy {
+	struct usb_phy		phy;
+	struct clk		*clk;
+};
+
+#define DRIVER_NAME	"sirf-usbphy"
+#define to_sirf_phy(p)	container_of((p), struct sirf_phy, phy)
+#define USBPHY_POR	BIT(27)
+
+static inline void sirf_phy_por(void __iomem *base)
+{
+	writel(readl(base) | USBPHY_POR, base);
+	udelay(15);
+	writel(readl(base) & ~USBPHY_POR, base);
+}
+
+static int sirf_phy_init(struct usb_phy *phy)
+{
+	struct sirf_phy *sirf_phy = to_sirf_phy(phy);
+
+	clk_prepare_enable(sirf_phy->clk);
+	sirf_phy_por(phy->io_priv);
+
+	return 0;
+}
+
+static void sirf_phy_shutdown(struct usb_phy *phy)
+{
+	struct sirf_phy *sirf_phy = to_sirf_phy(phy);
+	clk_disable_unprepare(sirf_phy->clk);
+}
+
+static int sirf_phy_suspend(struct usb_phy *phy, int suspend)
+{
+	return 0;
+}
+
+static int sirf_phy_on_connect(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	return 0;
+}
+
+static int sirf_phy_on_disconnect(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	return 0;
+}
+
+static int
+sirf_phy_set_peripheral(struct usb_otg *otg, struct usb_gadget *gadget)
+{
+	dev_info(otg->phy->dev, "set_peripheral\n");
+	if (!otg)
+		return -ENODEV;
+
+	if (!gadget) {
+		otg->gadget = NULL;
+		return -ENODEV;
+	}
+
+	otg->gadget = gadget;
+	otg->phy->state = OTG_STATE_B_IDLE;
+	return 0;
+}
+
+static int sirf_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
+{
+	dev_info(otg->phy->dev, "set_host\n");
+	if (!otg)
+		return -ENODEV;
+
+	if (!host) {
+		otg->host = NULL;
+		return -ENODEV;
+	}
+
+	otg->host = host;
+	return 0;
+}
+
+static int sirf_phy_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+	struct clk *clk;
+	struct sirf_phy *sirf_phy;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev,
+			"Can't get the clock, err=%ld", PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	sirf_phy = devm_kzalloc(&pdev->dev, sizeof(*sirf_phy), GFP_KERNEL);
+	if (!sirf_phy) {
+		dev_err(&pdev->dev, "Failed to allocate USB PHY structure!\n");
+		return -ENOMEM;
+	}
+
+	sirf_phy->phy.otg = devm_kzalloc(&pdev->dev,
+				sizeof(*sirf_phy->phy.otg), GFP_KERNEL);
+	if (!sirf_phy->phy.otg) {
+		dev_err(&pdev->dev, "Failed to allocate USB OTG structure!\n");
+		return -ENOMEM;
+	}
+
+	sirf_phy->phy.io_priv		= base;
+	sirf_phy->phy.dev		= &pdev->dev;
+	sirf_phy->phy.label		= DRIVER_NAME;
+	sirf_phy->phy.init		= sirf_phy_init;
+	sirf_phy->phy.shutdown		= sirf_phy_shutdown;
+	sirf_phy->phy.set_suspend	= sirf_phy_suspend;
+	sirf_phy->phy.notify_connect	= sirf_phy_on_connect;
+	sirf_phy->phy.notify_disconnect	= sirf_phy_on_disconnect;
+
+	sirf_phy->phy.otg->phy			= &sirf_phy->phy;
+	sirf_phy->phy.otg->set_host		= sirf_phy_set_host;
+	sirf_phy->phy.otg->set_peripheral	= sirf_phy_set_peripheral;
+
+	ATOMIC_INIT_NOTIFIER_HEAD(&sirf_phy->phy.notifier);
+
+	sirf_phy->clk = clk;
+
+	platform_set_drvdata(pdev, &sirf_phy->phy);
+
+	ret = usb_add_phy_dev(&sirf_phy->phy);
+	if (ret)
+		return ret;
+	dev_info(&pdev->dev, "Ready\n");
+	return 0;
+}
+
+static int sirf_phy_remove(struct platform_device *pdev)
+{
+	struct sirf_phy *sirf_phy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&sirf_phy->phy);
+	return 0;
+}
+
+static const struct of_device_id sirf_phy_dt_ids[] = {
+	{ .compatible = "sirf,ci13xxx-usbphy", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sirf_phy_dt_ids);
+
+static struct platform_driver sirf_phy_driver = {
+	.probe = sirf_phy_probe,
+	.remove = sirf_phy_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = sirf_phy_dt_ids,
+	 },
+};
+
+static int __init sirf_phy_module_init(void)
+{
+	return platform_driver_register(&sirf_phy_driver);
+}
+postcore_initcall(sirf_phy_module_init);
+
+static void __exit sirf_phy_module_exit(void)
+{
+	platform_driver_unregister(&sirf_phy_driver);
+}
+module_exit(sirf_phy_module_exit);
+
+MODULE_ALIAS("platform:sirf-ci13xxx-usbphy");
+MODULE_AUTHOR("Rong Wang <Rong.Wang@csr.com>");
+MODULE_DESCRIPTION("SiRF CI13XXX USB PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.5.4
