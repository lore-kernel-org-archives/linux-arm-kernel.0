From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 15:37:02 +0800
Subject: [PATCH v4 08/17] usb: phy-mxs: Add implementation of nofity_suspend
 and notify_resume
In-Reply-To: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1386056231-17258-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implementation of notify_suspend and notify_resume will be different
according to mxs_phy_data->flags.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   55 ++++++++++++++++++++++++++++++++++++++---
 1 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index d34df4c..8738890 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -166,8 +166,8 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
 static int mxs_phy_on_connect(struct usb_phy *phy,
 		enum usb_device_speed speed)
 {
-	dev_dbg(phy->dev, "%s speed device has connected\n",
-		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
+	dev_dbg(phy->dev, "%s device has connected\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
 
 	if (speed == USB_SPEED_HIGH)
 		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
@@ -179,8 +179,8 @@ static int mxs_phy_on_connect(struct usb_phy *phy,
 static int mxs_phy_on_disconnect(struct usb_phy *phy,
 		enum usb_device_speed speed)
 {
-	dev_dbg(phy->dev, "%s speed device has disconnected\n",
-		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
+	dev_dbg(phy->dev, "%s device has disconnected\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
 
 	if (speed == USB_SPEED_HIGH)
 		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
@@ -189,6 +189,48 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy,
 	return 0;
 }
 
+static int mxs_phy_on_suspend(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
+
+	dev_dbg(phy->dev, "%s device has suspended\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
+
+	/* delay 4ms to wait bus entering idle */
+	usleep_range(4000, 5000);
+
+	if (mxs_phy->data->flags & MXS_PHY_ABNORAML_IN_SUSPEND) {
+		writel_relaxed(0xffffffff, phy->io_priv + HW_USBPHY_PWD);
+		writel_relaxed(0, phy->io_priv + HW_USBPHY_PWD);
+	}
+
+	if (speed == USB_SPEED_HIGH)
+		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+				phy->io_priv + HW_USBPHY_CTRL_CLR);
+
+	return 0;
+}
+
+/*
+ * The resume signal must be finished here.
+ */
+static int mxs_phy_on_resume(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	dev_dbg(phy->dev, "%s device has resumed\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
+
+	if (speed == USB_SPEED_HIGH) {
+		/* Make sure the device has switched to High-Speed mode */
+		udelay(500);
+		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+				phy->io_priv + HW_USBPHY_CTRL_SET);
+	}
+
+	return 0;
+}
+
 static int mxs_phy_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -235,6 +277,11 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mxs_phy);
 
+	if (mxs_phy->data->flags & MXS_PHY_SENDING_SOF_TOO_FAST) {
+		mxs_phy->phy.notify_suspend = mxs_phy_on_suspend;
+		mxs_phy->phy.notify_resume = mxs_phy_on_resume;
+	}
+
 	if (mxs_phy->data->flags & MXS_PHY_HAS_ANATOP) {
 		mxs_phy->regmap_anatop = syscon_regmap_lookup_by_phandle
 			(np, "fsl,anatop");
-- 
1.7.8
