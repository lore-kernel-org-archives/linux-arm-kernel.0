From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 13:58:42 +0800
Subject: [Patch v2 08/14] usb: phy-mxs: Add implementation of nofity_suspend
 and notify_resume
In-Reply-To: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382421528-17897-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add notify_suspend and notify_resume according to different SoCs.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   91 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 6d48bde..4416ed6 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -164,8 +164,8 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
 static int mxs_phy_on_connect(struct usb_phy *phy,
 		enum usb_device_speed speed)
 {
-	dev_dbg(phy->dev, "%s speed device has connected\n",
-		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
+	dev_dbg(phy->dev, "%s device has connected\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
 
 	if (speed == USB_SPEED_HIGH)
 		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
@@ -177,8 +177,8 @@ static int mxs_phy_on_connect(struct usb_phy *phy,
 static int mxs_phy_on_disconnect(struct usb_phy *phy,
 		enum usb_device_speed speed)
 {
-	dev_dbg(phy->dev, "%s speed device has disconnected\n",
-		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
+	dev_dbg(phy->dev, "%s device has disconnected\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
 
 	if (speed == USB_SPEED_HIGH)
 		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
@@ -187,6 +187,88 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy,
 	return 0;
 }
 
+static int mxs_phy_on_suspend_workaround(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	dev_dbg(phy->dev, "%s device has suspended\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
+
+	/* delay 4ms to wait bus entering idle */
+	usleep_range(4000, 5000);
+
+	/*
+	 * Workaround for wakeup signal between portsc.suspendM
+	 * and PHY enters low power mode.
+	 */
+	writel_relaxed(0xffffffff, phy->io_priv + HW_USBPHY_PWD);
+	writel_relaxed(0, phy->io_priv + HW_USBPHY_PWD);
+
+	if (speed == USB_SPEED_HIGH)
+		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+				phy->io_priv + HW_USBPHY_CTRL_CLR);
+
+	return 0;
+}
+
+static int mxs_phy_on_suspend(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	dev_dbg(phy->dev, "%s device has suspended\n",
+		(speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
+
+	/* delay 4ms to wait bus entering idle */
+	usleep_range(4000, 5000);
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
+/*
+ * For mxs PHY, there are two PHY issues related to suspend/resume.
+ *
+ * 1. The PHY will be in messy if there is an wakeup after putting
+ * bus to suspend (set portsc.suspendM) but before setting PHY to low
+ * power mode (set portsc.phcd).
+ * 2. The SOF sends too fast after resuming, it will cause disconnection
+ * between host and high speed device.
+ *
+ * For mx23 and mx28, both of two issues are existed.
+ * For mx6q and mx6dl, only the second issue is existed.
+ * For mx6 sololite and later SoCs, none issue is existed.
+ */
+static void mxs_phy_workaround(struct mxs_phy *mxs_phy)
+{
+	if (is_mx23_phy(mxs_phy)) {
+		mxs_phy->phy.notify_suspend = mxs_phy_on_suspend_workaround;
+		mxs_phy->phy.notify_resume = mxs_phy_on_resume;
+	} else if (is_mx6q_phy(mxs_phy)) {
+		mxs_phy->phy.notify_suspend = mxs_phy_on_suspend;
+		mxs_phy->phy.notify_resume = mxs_phy_on_resume;
+	}
+}
+
 static int mxs_phy_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -247,6 +329,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	mxs_phy->clk = clk;
 	mxs_phy->devtype = pdev->id_entry->driver_data;
+	mxs_phy_workaround(mxs_phy);
 
 	platform_set_drvdata(pdev, &mxs_phy->phy);
 
-- 
1.7.1
