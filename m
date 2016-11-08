From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue,  8 Nov 2016 19:58:30 +0100
Subject: [PATCH 2/3] USB: ohci: da8xx: Allow probing from DT
In-Reply-To: <20161108185831.17683-1-ahaslam@baylibre.com>
References: <20161108185831.17683-1-ahaslam@baylibre.com>
Message-ID: <20161108185831.17683-3-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the compatible string to the ohci driver
to be able to probe from DT

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/usb/host/ohci-da8xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
index 83b182e..bbfe342 100644
--- a/drivers/usb/host/ohci-da8xx.c
+++ b/drivers/usb/host/ohci-da8xx.c
@@ -321,6 +321,13 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 }
 
 /*-------------------------------------------------------------------------*/
+#ifdef CONFIG_OF
+static const struct of_device_id da8xx_ohci_ids[] = {
+	{ .compatible = "ti,da830-ohci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, da8xx_ohci_ids);
+#endif
 
 static int ohci_da8xx_probe(struct platform_device *pdev)
 {
@@ -472,6 +479,7 @@ static struct platform_driver ohci_hcd_da8xx_driver = {
 #endif
 	.driver		= {
 		.name	= DRV_NAME,
+		.of_match_table = of_match_ptr(da8xx_ohci_ids),
 	},
 };
 
-- 
2.10.1
