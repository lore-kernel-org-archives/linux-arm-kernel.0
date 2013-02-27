From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Feb 2013 13:27:14 +0100
Subject: [PATCH 8/9] USB mxs-phy: Register phy with framework
In-Reply-To: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
References: <1361968035-18644-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1361968035-18644-9-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

We now have usb_add_phy_dev(), so use it to register with the framework
to be able to find the phy from the USB driver.

Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Peter Chen <peter.chen@freescale.com>
Acked-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/otg/mxs-phy.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
index b0d9f11..aa40325 100644
--- a/drivers/usb/otg/mxs-phy.c
+++ b/drivers/usb/otg/mxs-phy.c
@@ -127,6 +127,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	void __iomem *base;
 	struct clk *clk;
 	struct mxs_phy *mxs_phy;
+	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -166,11 +167,19 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &mxs_phy->phy);
 
+	ret = usb_add_phy_dev(&mxs_phy->phy);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
 static int mxs_phy_remove(struct platform_device *pdev)
 {
+	struct mxs_phy *mxs_phy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&mxs_phy->phy);
+
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.7.10.4
