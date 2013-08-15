From: rogerq@ti.com (Roger Quadros)
Date: Thu, 15 Aug 2013 16:15:05 +0300
Subject: [PATCH v2 1/8] usb: phy: omap-control: Get rid of platform data
In-Reply-To: <1376572512-9561-1-git-send-email-rogerq@ti.com>
References: <1376572512-9561-1-git-send-email-rogerq@ti.com>
Message-ID: <1376572512-9561-2-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

omap-control device is present from OMAP4 onwards which
support device tree boots only. So get rid of platform data.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/phy/phy-omap-control.c   |   18 +++++++-----------
 include/linux/usb/omap_control_usb.h |    4 ----
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
index a4dda8e..3b9ee83 100644
--- a/drivers/usb/phy/phy-omap-control.c
+++ b/drivers/usb/phy/phy-omap-control.c
@@ -197,8 +197,13 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
 	struct device_node *np = pdev->dev.of_node;
-	struct omap_control_usb_platform_data *pdata =
-			dev_get_platdata(&pdev->dev);
+
+	if (np) {
+		of_property_read_u32(np, "ti,type", &control_usb->type);
+	} else {
+		/* We only support DT boot */
+		return -ENODEV;
+	}
 
 	control_usb = devm_kzalloc(&pdev->dev, sizeof(*control_usb),
 		GFP_KERNEL);
@@ -207,15 +212,6 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	if (np) {
-		of_property_read_u32(np, "ti,type", &control_usb->type);
-	} else if (pdata) {
-		control_usb->type = pdata->type;
-	} else {
-		dev_err(&pdev->dev, "no pdata present\n");
-		return -EINVAL;
-	}
-
 	control_usb->dev	= &pdev->dev;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
diff --git a/include/linux/usb/omap_control_usb.h b/include/linux/usb/omap_control_usb.h
index 27b5b8c..e2416b4 100644
--- a/include/linux/usb/omap_control_usb.h
+++ b/include/linux/usb/omap_control_usb.h
@@ -31,10 +31,6 @@ struct omap_control_usb {
 	u32 type;
 };
 
-struct omap_control_usb_platform_data {
-	u8 type;
-};
-
 enum omap_control_usb_mode {
 	USB_MODE_UNDEFINED = 0,
 	USB_MODE_HOST,
-- 
1.7.4.1
