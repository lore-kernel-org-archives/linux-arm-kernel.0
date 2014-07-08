From: ulrich.hecht@gmail.com (Ulrich Hecht)
Date: Tue,  8 Jul 2014 16:59:30 +0200
Subject: [PATCH 1/2] usb: renesas_usbhs: add R-Car Gen. 2 init and power
 control
Message-ID: <1404831571-19817-1-git-send-email-ulrich.hecht+renesas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for DT conversion to reduce reliance on platform device
callbacks.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/usb/renesas_usbhs/Makefile |  2 +-
 drivers/usb/renesas_usbhs/common.c | 39 ++++++++++++++++---
 drivers/usb/renesas_usbhs/rcar2.c  | 76 ++++++++++++++++++++++++++++++++++++++
 drivers/usb/renesas_usbhs/rcar2.h  |  4 ++
 include/linux/usb/renesas_usbhs.h  |  8 ++++
 5 files changed, 123 insertions(+), 6 deletions(-)
 create mode 100644 drivers/usb/renesas_usbhs/rcar2.c
 create mode 100644 drivers/usb/renesas_usbhs/rcar2.h

diff --git a/drivers/usb/renesas_usbhs/Makefile b/drivers/usb/renesas_usbhs/Makefile
index bc8aef4..9e47f47 100644
--- a/drivers/usb/renesas_usbhs/Makefile
+++ b/drivers/usb/renesas_usbhs/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_USB_RENESAS_USBHS)	+= renesas_usbhs.o
 
-renesas_usbhs-y			:= common.o mod.o pipe.o fifo.o
+renesas_usbhs-y			:= common.o mod.o pipe.o fifo.o rcar2.o
 
 ifneq ($(CONFIG_USB_RENESAS_USBHS_HCD),)
 	renesas_usbhs-y		+= mod_host.o
diff --git a/drivers/usb/renesas_usbhs/common.c b/drivers/usb/renesas_usbhs/common.c
index 17267b0..619a3bb 100644
--- a/drivers/usb/renesas_usbhs/common.c
+++ b/drivers/usb/renesas_usbhs/common.c
@@ -15,12 +15,14 @@
  *
  */
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include "common.h"
+#include "rcar2.h"
 
 /*
  *		image of renesas_usbhs
@@ -423,8 +425,7 @@ static int usbhs_probe(struct platform_device *pdev)
 	int ret;
 
 	/* check platform information */
-	if (!info ||
-	    !info->platform_callback.get_id) {
+	if (!info) {
 		dev_err(&pdev->dev, "no platform information\n");
 		return -EINVAL;
 	}
@@ -451,13 +452,27 @@ static int usbhs_probe(struct platform_device *pdev)
 	/*
 	 * care platform info
 	 */
-	memcpy(&priv->pfunc,
-	       &info->platform_callback,
-	       sizeof(struct renesas_usbhs_platform_callback));
+
 	memcpy(&priv->dparam,
 	       &info->driver_param,
 	       sizeof(struct renesas_usbhs_driver_param));
 
+	switch (priv->dparam.type) {
+	case USBHS_TYPE_R8A7790:
+	case USBHS_TYPE_R8A7791:
+		priv->pfunc = usbhs_rcar2_ops;
+		break;
+	default:
+		if (!info->platform_callback.get_id) {
+			dev_err(&pdev->dev, "no platform callbacks");
+			return -EINVAL;
+		}
+		memcpy(&priv->pfunc,
+		       &info->platform_callback,
+		       sizeof(struct renesas_usbhs_platform_callback));
+		break;
+	}
+
 	/* set driver callback functions for platform */
 	dfunc			= &info->driver_callback;
 	dfunc->notify_hotplug	= usbhsc_drvcllbck_notify_hotplug;
@@ -507,6 +522,20 @@ static int usbhs_probe(struct platform_device *pdev)
 	 */
 	usbhs_sys_clock_ctrl(priv, 0);
 
+	/* check GPIO determining if USB function should be enabled */
+	if (priv->dparam.enable_gpio) {
+		gpio_request_one(priv->dparam.enable_gpio, GPIOF_IN, NULL);
+		ret = !gpio_get_value(priv->dparam.enable_gpio);
+		gpio_free(priv->dparam.enable_gpio);
+		if (ret) {
+			dev_warn(&pdev->dev,
+				 "USB function not selected (GPIO %d)\n",
+				 priv->dparam.enable_gpio);
+			ret = -ENOTSUPP;
+			goto probe_end_mod_exit;
+		}
+	}
+
 	/*
 	 * platform call
 	 *
diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/rcar2.c
new file mode 100644
index 0000000..069704c
--- /dev/null
+++ b/drivers/usb/renesas_usbhs/rcar2.c
@@ -0,0 +1,76 @@
+/*
+ * Renesas USB driver R-Car Gen. 2 initialization and power control
+ *
+ * Copyright (C) 2014 Ulrich Hecht
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/gpio.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_data/gpio-rcar.h>
+#include <linux/usb/phy.h>
+#include "common.h"
+
+static int usbhs_rcar2_hardware_init(struct platform_device *pdev)
+{
+	struct renesas_usbhs_platform_info *info = dev_get_platdata(&pdev->dev);
+	struct usb_phy *phy;
+
+	phy = usb_get_phy_dev(&pdev->dev, 0);
+	if (IS_ERR(phy))
+		return PTR_ERR(phy);
+
+	info->phy = phy;
+	return 0;
+}
+
+static int usbhs_rcar2_hardware_exit(struct platform_device *pdev)
+{
+	struct renesas_usbhs_platform_info *info = dev_get_platdata(&pdev->dev);
+
+	if (!info->phy)
+		return 0;
+
+	usb_put_phy(info->phy);
+	info->phy = NULL;
+
+	return 0;
+}
+
+static int usbhs_rcar2_power_ctrl(struct platform_device *pdev,
+				void __iomem *base, int enable)
+{
+	struct renesas_usbhs_platform_info *info = dev_get_platdata(&pdev->dev);
+
+	if (!info->phy)
+		return -ENODEV;
+
+	if (enable) {
+		int retval = usb_phy_init(info->phy);
+
+		if (!retval)
+			retval = usb_phy_set_suspend(info->phy, 0);
+		return retval;
+	}
+
+	usb_phy_set_suspend(info->phy, 1);
+	usb_phy_shutdown(info->phy);
+	return 0;
+}
+
+static int usbhs_rcar2_get_id(struct platform_device *pdev)
+{
+	return USBHS_GADGET;
+}
+
+const struct renesas_usbhs_platform_callback usbhs_rcar2_ops = {
+	.hardware_init = usbhs_rcar2_hardware_init,
+	.hardware_exit = usbhs_rcar2_hardware_exit,
+	.power_ctrl = usbhs_rcar2_power_ctrl,
+	.get_id = usbhs_rcar2_get_id,
+};
diff --git a/drivers/usb/renesas_usbhs/rcar2.h b/drivers/usb/renesas_usbhs/rcar2.h
new file mode 100644
index 0000000..f07f10d
--- /dev/null
+++ b/drivers/usb/renesas_usbhs/rcar2.h
@@ -0,0 +1,4 @@
+#include "common.h"
+
+extern const struct renesas_usbhs_platform_callback
+	usbhs_rcar2_ops;
diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
index e452ba6..750f0cd 100644
--- a/include/linux/usb/renesas_usbhs.h
+++ b/include/linux/usb/renesas_usbhs.h
@@ -153,6 +153,9 @@ struct renesas_usbhs_driver_param {
 	 */
 	int pio_dma_border; /* default is 64byte */
 
+	u32 type;
+	u32 enable_gpio;
+
 	/*
 	 * option:
 	 */
@@ -160,6 +163,9 @@ struct renesas_usbhs_driver_param {
 	u32 has_sudmac:1; /* for SUDMAC */
 };
 
+#define USBHS_TYPE_R8A7790 1
+#define USBHS_TYPE_R8A7791 2
+
 /*
  * option:
  *
@@ -186,6 +192,8 @@ struct renesas_usbhs_platform_info {
 	 * driver use these param for some register
 	 */
 	struct renesas_usbhs_driver_param	driver_param;
+
+	struct usb_phy *phy;
 };
 
 /*
-- 
1.8.4.5
