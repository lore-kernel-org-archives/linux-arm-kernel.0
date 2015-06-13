From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 13 Jun 2015 14:37:48 +0200
Subject: [PATCH v5 4/7] phy-sun4i-usb: Add support for the usb-phys on the
 sun8i-a23 SoC
In-Reply-To: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
References: <1434199071-22127-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1434199071-22127-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usb-phys on the sun8i-a23 SoC have the same setup wrt clocks as on the
sun6i-a31 SoC, but there are only 2 instead of 3 like on the sun5i-a13 SoC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 2 ++
 drivers/phy/phy-sun4i-usb.c                             | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
index 557fa99..f0c640a 100644
--- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
+++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
@@ -7,6 +7,7 @@ Required properties:
   * allwinner,sun5i-a13-usb-phy
   * allwinner,sun6i-a31-usb-phy
   * allwinner,sun7i-a20-usb-phy
+  * allwinner,sun8i-a23-usb-phy
 - reg : a list of offset + length pairs
 - reg-names :
   * "phy_ctrl"
@@ -17,6 +18,7 @@ Required properties:
 - clock-names :
   * "usb_phy" for sun4i, sun5i or sun7i
   * "usb0_phy", "usb1_phy" and "usb2_phy" for sun6i
+  * "usb0_phy", "usb1_phy" for sun8i
 - resets : a list of phandle + reset specifier pairs
 - reset-names :
   * "usb0_reset"
diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index d78a071..6850fcd 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -442,7 +442,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&data->detect, sun4i_usb_phy0_id_vbus_det_scan);
 	dev_set_drvdata(dev, data);
 
-	if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy"))
+	if (of_device_is_compatible(np, "allwinner,sun5i-a13-usb-phy") ||
+	    of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy"))
 		data->num_phys = 2;
 	else
 		data->num_phys = 3;
@@ -453,7 +454,8 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	else
 		data->disc_thresh = 3;
 
-	if (of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy"))
+	if (of_device_is_compatible(np, "allwinner,sun6i-a31-usb-phy") ||
+	    of_device_is_compatible(np, "allwinner,sun8i-a23-usb-phy"))
 		dedicated_clocks = true;
 	else
 		dedicated_clocks = false;
@@ -588,6 +590,7 @@ static const struct of_device_id sun4i_usb_phy_of_match[] = {
 	{ .compatible = "allwinner,sun5i-a13-usb-phy" },
 	{ .compatible = "allwinner,sun6i-a31-usb-phy" },
 	{ .compatible = "allwinner,sun7i-a20-usb-phy" },
+	{ .compatible = "allwinner,sun8i-a23-usb-phy" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_usb_phy_of_match);
-- 
2.4.3
