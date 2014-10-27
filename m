From: rbyshko@gmail.com (Roman Byshko)
Date: Mon, 27 Oct 2014 22:43:01 +0100
Subject: [PATCH 1/5] phy: sun4i: add support for USB phy0
In-Reply-To: <cover.1414444953.git.rbyshko@gmail.com>
References: <cover.1414444953.git.rbyshko@gmail.com>
Message-ID: <668c1b5541fc0175957573bd5f8d40dd2eaccae1.1414444953.git.rbyshko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver for sun4i USB phys currently supports
only phy1 and phy2 which are used for USB host
controllers. This patch adds support for USB phy0,
which is used by the musb hdrc USB controller.
---
 drivers/phy/phy-sun4i-usb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
index 0baf5ef..a24728b 100644
--- a/drivers/phy/phy-sun4i-usb.c
+++ b/drivers/phy/phy-sun4i-usb.c
@@ -157,6 +157,10 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		return ret;
 	}
 
+	/* Regulation 45 ohms */
+	if (phy->index == 0)
+		sun4i_usb_phy_write(phy, PHY_RES45_CAL_EN, 0x01, 1);
+
 	/* Adjust PHY's magnitude and rate */
 	sun4i_usb_phy_write(phy, PHY_TX_AMPLITUDE_TUNE, 0x14, 5);
 
@@ -213,7 +217,7 @@ static struct phy *sun4i_usb_phy_xlate(struct device *dev,
 {
 	struct sun4i_usb_phy_data *data = dev_get_drvdata(dev);
 
-	if (WARN_ON(args->args[0] == 0 || args->args[0] >= data->num_phys))
+	if (args->args[0] >= data->num_phys)
 		return ERR_PTR(-ENODEV);
 
 	return data->phys[args->args[0]].phy;
@@ -255,8 +259,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-	/* Skip 0, 0 is the phy for otg which is not yet supported. */
-	for (i = 1; i < data->num_phys; i++) {
+	for (i = 0; i < data->num_phys; i++) {
 		struct sun4i_usb_phy *phy = data->phys + i;
 		char name[16];
 
-- 
2.1.2
