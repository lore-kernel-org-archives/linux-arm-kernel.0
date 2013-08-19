From: rogerq@ti.com (Roger Quadros)
Date: Mon, 19 Aug 2013 13:37:45 +0300
Subject: [PATCH v4 6/8] usb: phy: omap: get rid of omap_get_control_dev()
In-Reply-To: <1376908667-14974-1-git-send-email-rogerq@ti.com>
References: <1376908667-14974-1-git-send-email-rogerq@ti.com>
Message-ID: <1376908667-14974-7-git-send-email-rogerq@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function was preventing us from supporting multiple
instances. Get rid of it. Since we support DT boots only,
users can get the control device phandle from the DT node.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/phy/phy-omap-control.c   |   31 ++++++++++---------------------
 include/linux/usb/omap_control_usb.h |    5 -----
 2 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/phy/phy-omap-control.c b/drivers/usb/phy/phy-omap-control.c
index 4c4c85c..1a7e19a 100644
--- a/drivers/usb/phy/phy-omap-control.c
+++ b/drivers/usb/phy/phy-omap-control.c
@@ -26,26 +26,6 @@
 #include <linux/clk.h>
 #include <linux/usb/omap_control_usb.h>
 
-static struct omap_control_usb *control_usb;
-
-/**
- * omap_get_control_dev - returns the device pointer for this control device
- *
- * This API should be called to get the device pointer for this control
- * module device. This device pointer should be used for called other
- * exported API's in this driver.
- *
- * To be used by PHY driver and glue driver.
- */
-struct device *omap_get_control_dev(void)
-{
-	if (!control_usb)
-		return ERR_PTR(-ENODEV);
-
-	return control_usb->dev;
-}
-EXPORT_SYMBOL_GPL(omap_get_control_dev);
-
 /**
  * omap_control_usb_phy_power - power on/off the phy using control module reg
  * @dev: the control module device
@@ -188,11 +168,19 @@ void omap_control_usb_set_mode(struct device *dev,
 {
 	struct omap_control_usb	*ctrl_usb;
 
-	if (IS_ERR(dev) || control_usb->type != OMAP_CTRL_TYPE_OMAP4)
+	if (IS_ERR(dev) || !dev)
 		return;
 
 	ctrl_usb = dev_get_drvdata(dev);
 
+	if (!ctrl_usb) {
+		dev_err(dev, "Invalid control usb device\n");
+		return;
+	}
+
+	if (ctrl_usb->type != OMAP_CTRL_TYPE_OMAP4)
+		return;
+
 	switch (mode) {
 	case USB_MODE_HOST:
 		omap_control_usb_host_mode(ctrl_usb);
@@ -215,6 +203,7 @@ static int omap_control_usb_probe(struct platform_device *pdev)
 {
 	struct resource	*res;
 	const struct of_device_id *of_id;
+	struct omap_control_usb *control_usb;
 
 	of_id = of_match_device(omap_control_usb_id_table, &pdev->dev);
 	if (!of_id)
diff --git a/include/linux/usb/omap_control_usb.h b/include/linux/usb/omap_control_usb.h
index 450b5c1..8008e8d 100644
--- a/include/linux/usb/omap_control_usb.h
+++ b/include/linux/usb/omap_control_usb.h
@@ -65,15 +65,10 @@ enum omap_control_usb_mode {
 #define OMAP_CTRL_USB2_PHY_PD		BIT(28)
 
 #if IS_ENABLED(CONFIG_OMAP_CONTROL_USB)
-extern struct device *omap_get_control_dev(void);
 extern void omap_control_usb_phy_power(struct device *dev, int on);
 extern void omap_control_usb_set_mode(struct device *dev,
 	enum omap_control_usb_mode mode);
 #else
-static inline struct device *omap_get_control_dev(void)
-{
-	return ERR_PTR(-ENODEV);
-}
 
 static inline void omap_control_usb_phy_power(struct device *dev, int on)
 {
-- 
1.7.4.1
