From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 18 Jul 2014 11:31:25 +0200
Subject: [PATCH 4/9] usb: phy: am335x-control: prevent module from being
 unloaded when in use
In-Reply-To: <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
References: <1405675890-8802-1-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-2-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-3-git-send-email-LW@KARO-electronics.de>
 <1405675890-8802-4-git-send-email-LW@KARO-electronics.de>
Message-ID: <1405675890-8802-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the real cause of the crash that was "fixed" by
commit 7adb5c876e9c usb: musb: Fix panic upon musb_am335x module removal

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 drivers/usb/phy/phy-am335x-control.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/phy/phy-am335x-control.c b/drivers/usb/phy/phy-am335x-control.c
index 35b6083..df3e1ba 100644
--- a/drivers/usb/phy/phy-am335x-control.c
+++ b/drivers/usb/phy/phy-am335x-control.c
@@ -140,6 +140,9 @@ static int am335x_control_usb_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	const struct phy_control *phy_ctrl;
 
+	if (!try_module_get(pdev->dev.parent->driver->owner))
+		return -EPROBE_DEFER;
+
 	of_id = of_match_node(omap_control_usb_id_table, pdev->dev.of_node);
 	if (!of_id)
 		return -EINVAL;
@@ -171,8 +174,15 @@ static int am335x_control_usb_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int am335x_control_usb_remove(struct platform_device *pdev)
+{
+	module_put(pdev->dev.parent->driver->owner);
+	return 0;
+}
+
 static struct platform_driver am335x_control_driver = {
 	.probe		= am335x_control_usb_probe,
+	.remove		= am335x_control_usb_remove,
 	.driver		= {
 		.name	= "am335x-control-usb",
 		.owner	= THIS_MODULE,
-- 
1.7.10.4
