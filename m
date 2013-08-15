From: rogerq@ti.com (Roger Quadros)
Date: Thu, 15 Aug 2013 16:15:07 +0300
Subject: [PATCH v2 3/8] usb: phy: omap-usb2: Don't use omap_get_control_dev()
In-Reply-To: <1376572512-9561-1-git-send-email-rogerq@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Message-ID: <1376572512-9561-4-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap_get_control_dev() is being deprecated as it doesn't support
multiple instances. As control device is present only from OMAP4
onwards which supports DT only, we use phandles to get the
reference to the control device.

As we don't support non-DT boot, we just bail out on probe
if device node is not present.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/phy/phy-omap-usb2.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-usb2.c b/drivers/usb/phy/phy-omap-usb2.c
index 376b367..77e0cf4 100644
--- a/drivers/usb/phy/phy-omap-usb2.c
+++ b/drivers/usb/phy/phy-omap-usb2.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/usb/omap_control_usb.h>
+#include <linux/of_platform.h>
 
 /**
  * omap_usb2_set_comparator - links the comparator present in the sytem with
@@ -124,6 +125,8 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	struct omap_usb			*phy;
 	struct usb_otg			*otg;
 	struct device_node *node = pdev->dev.of_node;
+	struct device_node *control_node;
+	struct platform_device *control_pdev;
 
 	if (!node)
 		return -ENODEV;
@@ -148,11 +151,18 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	phy->phy.otg		= otg;
 	phy->phy.type		= USB_PHY_TYPE_USB2;
 
-	phy->control_dev = omap_get_control_dev();
-	if (IS_ERR(phy->control_dev)) {
-		dev_dbg(&pdev->dev, "Failed to get control device\n");
+	control_node = of_parse_phandle(node, "ctrl-module", 0);
+	if (!control_node) {
+		dev_err(&pdev->dev, "Failed to get control device phandle\n");
 		return -ENODEV;
 	}
+	control_pdev = of_find_device_by_node(control_node);
+	if (!control_pdev) {
+		dev_err(&pdev->dev, "Failed to get control device\n");
+		return -ENODEV;
+	}
+
+	phy->control_dev = &control_pdev->dev;
 
 	phy->is_suspended	= 1;
 	omap_control_usb_phy_power(phy->control_dev, 0);
-- 
1.7.4.1
