From: marex@denx.de (Marek Vasut)
Date: Tue,  1 May 2012 03:55:58 +0200
Subject: [PATCH 06/11] MXS: Add small registration glue for ci13xxx_udc
In-Reply-To: <1335837363-12376-1-git-send-email-marex@denx.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
Message-ID: <1335837363-12376-7-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds small registration glue for the ci13xxx_udc that is compatible
with the imx-otg driver.

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
 drivers/usb/gadget/Kconfig       |   17 +++++++++
 drivers/usb/gadget/Makefile      |    1 +
 drivers/usb/gadget/ci13xxx_mxs.c |   73 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 drivers/usb/gadget/ci13xxx_mxs.c

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 2633f75..1fa6b0d 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -494,6 +494,23 @@ config USB_CI13XXX_MSM
 	  dynamically linked module called "ci13xxx_msm" and force all
 	  gadget drivers to also be dynamically linked.
 
+config USB_CI13XXX_MXS
+	tristate "MIPS USB CI13xxx for i.MX23/28"
+	depends on ARCH_MXS
+	select USB_GADGET_DUALSPEED
+	select USB_IMX_COMPOSITE
+	help
+	  i.MX SoC has chipidea USB controller.  This driver uses
+	  ci13xxx_udc core.
+	  This driver depends on OTG driver for PHY initialization,
+	  clock management, powering up VBUS, and power management.
+	  This driver is not supported on boards like trout which
+	  has an external PHY.
+
+	  Say "y" to link the driver statically, or "m" to build a
+	  dynamically linked module called "ci13xxx_mxs" and force all
+	  gadget drivers to also be dynamically linked.
+
 #
 # LAST -- dummy/emulated controller
 #
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index b7f6eef..1f159a9 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_USB_EG20T)		+= pch_udc.o
 obj-$(CONFIG_USB_MV_UDC)	+= mv_udc.o
 mv_udc-y			:= mv_udc_core.o
 obj-$(CONFIG_USB_CI13XXX_MSM)	+= ci13xxx_msm.o
+obj-$(CONFIG_USB_CI13XXX_MXS)	+= ci13xxx_mxs.o
 obj-$(CONFIG_USB_FUSB300)	+= fusb300_udc.o
 
 #
diff --git a/drivers/usb/gadget/ci13xxx_mxs.c b/drivers/usb/gadget/ci13xxx_mxs.c
new file mode 100644
index 0000000..c99e558
--- /dev/null
+++ b/drivers/usb/gadget/ci13xxx_mxs.c
@@ -0,0 +1,73 @@
+/* Copyright (c) 2010, Code Aurora Forum. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/usb/ulpi.h>
+#include <linux/usb/mxs-usb.h>
+
+#include "ci13xxx_udc.c"
+
+#define MSM_USB_BASE	(udc->regs)
+
+static irqreturn_t mxs_udc_irq(int irq, void *data)
+{
+	return udc_irq();
+}
+
+static struct ci13xxx_udc_driver ci13xxx_mxs_udc_driver = {
+	.name			= "ci13xxx-mxs",
+	.flags			= CI13XXX_REQUIRE_TRANSCEIVER |
+				  CI13XXX_DISABLE_STREAMING |
+				  CI13XXX_DONT_REGISTER_GADGET,
+};
+
+static int __devinit ci13xxx_mxs_probe(struct platform_device *pdev)
+{
+	struct imx_otg_res *data = pdev->dev.platform_data;
+	int ret;
+
+	imx_otg_set_irq_handler(data->dev, mxs_udc_irq, data, 0);
+
+	ret = udc_probe(&ci13xxx_mxs_udc_driver, &pdev->dev, data->mem);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to probe CI13xxx-mxs!\n");
+		imx_otg_set_irq_handler(data->dev, NULL, NULL, 0);
+	}
+
+	pm_runtime_no_callbacks(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	return ret;
+}
+
+static void __devexit ci13xxx_mxs_remove(struct platform_device *pdev)
+{
+	struct imx_otg_res *data = pdev->dev.platform_data;
+
+	imx_otg_set_irq_handler(data->dev, NULL, NULL, 0);
+	udc_remove();
+}
+
+static struct platform_driver ci13xxx_mxs_driver = {
+	.probe		= ci13xxx_mxs_probe,
+	.remove		= __exit_p(ci13xxx_mxs_remove),
+	.driver		= {
+		.name	= "ci13xxx-mxs",
+	},
+};
+
+static int __init ci13xxx_mxs_init(void)
+{
+	return platform_driver_register(&ci13xxx_mxs_driver);
+}
+
+module_init(ci13xxx_mxs_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:ci13xxx-mxs");
-- 
1.7.10
