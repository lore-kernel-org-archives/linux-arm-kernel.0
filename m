From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  4 Feb 2013 14:24:34 +0100
Subject: [PATCH 8/9] USB mxs-phy: Register phy with framework
In-Reply-To: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1359984275-24646-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have usb_add_phy_dev(), so use it to register with the framework
to be able to find the phy from the USB driver.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/usb/otg/mxs-phy.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
index 5158332..5b39885 100644
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
