From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 21 Nov 2012 15:06:27 +0100
Subject: [PATCH v3 1/7] usb: chipidea: usbmisc: rename file,
 struct and functions to usbmisc_imx
In-Reply-To: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1353506793-8354-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1353506793-8354-2-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver will be used for every Freescale SoC which has this misc
memory layout to control the basic usb handling. So better name this
driver, function and struct names in a more generic way.

Reported-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Changes since v1:
* added Makefile change to be build as well
* moved this patch infront all other

 drivers/usb/chipidea/Makefile                      |    2 +-
 .../chipidea/{usbmisc_imx6q.c => usbmisc_imx.c}    |   38 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)
 rename drivers/usb/chipidea/{usbmisc_imx6q.c => usbmisc_imx.c} (75%)

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
index 11f513c..146ecd7 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -17,5 +17,5 @@ ifneq ($(CONFIG_PCI),)
 endif
 
 ifneq ($(CONFIG_OF_DEVICE),)
-	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o usbmisc_imx6q.o
+	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_imx.o usbmisc_imx.o
 endif
diff --git a/drivers/usb/chipidea/usbmisc_imx6q.c b/drivers/usb/chipidea/usbmisc_imx.c
similarity index 75%
rename from drivers/usb/chipidea/usbmisc_imx6q.c
rename to drivers/usb/chipidea/usbmisc_imx.c
index 416e3fc..5da379a 100644
--- a/drivers/usb/chipidea/usbmisc_imx6q.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -21,14 +21,14 @@
 
 #define BM_OVER_CUR_DIS		BIT(7)
 
-struct imx6q_usbmisc {
+struct imx_usbmisc {
 	void __iomem *base;
 	spinlock_t lock;
 	struct clk *clk;
 	struct usbmisc_usb_device usbdev[USB_DEV_MAX];
 };
 
-static struct imx6q_usbmisc *usbmisc;
+static struct imx_usbmisc *usbmisc;
 
 static struct usbmisc_usb_device *get_usbdev(struct device *dev)
 {
@@ -77,15 +77,15 @@ static const struct usbmisc_ops imx6q_usbmisc_ops = {
 	.init = usbmisc_imx6q_init,
 };
 
-static const struct of_device_id usbmisc_imx6q_dt_ids[] = {
+static const struct of_device_id usbmisc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-usbmisc"},
 	{ /* sentinel */ }
 };
 
-static int __devinit usbmisc_imx6q_probe(struct platform_device *pdev)
+static int __devinit usbmisc_imx_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
-	struct imx6q_usbmisc *data;
+	struct imx_usbmisc *data;
 	int ret;
 
 	if (usbmisc)
@@ -127,36 +127,36 @@ static int __devinit usbmisc_imx6q_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit usbmisc_imx6q_remove(struct platform_device *pdev)
+static int __devexit usbmisc_imx_remove(struct platform_device *pdev)
 {
 	usbmisc_unset_ops(&imx6q_usbmisc_ops);
 	clk_disable_unprepare(usbmisc->clk);
 	return 0;
 }
 
-static struct platform_driver usbmisc_imx6q_driver = {
-	.probe = usbmisc_imx6q_probe,
-	.remove = __devexit_p(usbmisc_imx6q_remove),
+static struct platform_driver usbmisc_imx_driver = {
+	.probe = usbmisc_imx_probe,
+	.remove = __devexit_p(usbmisc_imx_remove),
 	.driver = {
-		.name = "usbmisc_imx6q",
+		.name = "usbmisc_imx",
 		.owner = THIS_MODULE,
-		.of_match_table = usbmisc_imx6q_dt_ids,
+		.of_match_table = usbmisc_imx_dt_ids,
 	 },
 };
 
-int __init usbmisc_imx6q_drv_init(void)
+int __init usbmisc_imx_drv_init(void)
 {
-	return platform_driver_register(&usbmisc_imx6q_driver);
+	return platform_driver_register(&usbmisc_imx_driver);
 }
-subsys_initcall(usbmisc_imx6q_drv_init);
+subsys_initcall(usbmisc_imx_drv_init);
 
-void __exit usbmisc_imx6q_drv_exit(void)
+void __exit usbmisc_imx_drv_exit(void)
 {
-	platform_driver_unregister(&usbmisc_imx6q_driver);
+	platform_driver_unregister(&usbmisc_imx_driver);
 }
-module_exit(usbmisc_imx6q_drv_exit);
+module_exit(usbmisc_imx_drv_exit);
 
-MODULE_ALIAS("platform:usbmisc-imx6q");
+MODULE_ALIAS("platform:usbmisc-imx");
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("driver for imx6q usb non-core registers");
+MODULE_DESCRIPTION("driver for imx usb non-core registers");
 MODULE_AUTHOR("Richard Zhao <richard.zhao@freescale.com>");
-- 
1.7.10.4
