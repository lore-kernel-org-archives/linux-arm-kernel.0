From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 14 Sep 2012 11:21:57 +0800
Subject: [PATCH 2/4] usb: mxs-phy: implement notify_suspend/notify_resume
 callback
Message-ID: <1347592917-13082-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These notify will be called during the bus suspend/resume procedure.

The mxs-phy needs to set/clear HW_USBPHY_CTRL.ENHOSTDISCONDETECT
during the connect, disconnect,suspend and resume procedure.
The phy notification should be added according to below rules:

1. Only set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
during high speed host mode.
2. Do not set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
during the reset and speed negotiation period.
3. Do not set HW_USBPHY_CTRL.ENHOSTDISCONDETECT
during host suspend/resume sequence.

Please refer: i.mx23RM, page: 413.
http://www.freescale.com/files/dsp/doc/ref_manual/IMX23RM.pdf

Freescale i.MX SoC, i.mx23, i.mx28 and i.mx6(i.mx6SL does not
need to follow the 3rd rule) need to follow above rules.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/otg/mxs-phy.c |   56 +++++++++++++++++++++++++++++++++++---------
 1 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
index 88db976..41e0543 100644
--- a/drivers/usb/otg/mxs-phy.c
+++ b/drivers/usb/otg/mxs-phy.c
@@ -96,39 +96,69 @@ static void mxs_phy_enhostdiscondetect_delay(struct work_struct *ws)
 				mxs_phy->phy.io_priv + HW_USBPHY_CTRL_SET);
 }
 
-static int mxs_phy_on_connect(struct usb_phy *phy, int port)
+static int mxs_phy_on_connect(struct usb_phy *phy,
+		enum usb_device_speed speed)
 {
 	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
 
-	dev_dbg(phy->dev, "Connect on port %d\n", port);
-
-	mxs_phy_hw_init(mxs_phy);
+	dev_dbg(phy->dev, "%s speed device has connected\n",
+		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
 
 	/*
 	 * Delay enabling ENHOSTDISCONDETECT so that connection and
 	 * reset processing can be completed for the root hub.
 	 */
-	dev_dbg(phy->dev, "Delaying setting ENHOSTDISCONDETECT\n");
-	PREPARE_DELAYED_WORK(&mxs_phy->enhostdiscondetect_work,
+	if (speed == USB_SPEED_HIGH) {
+		PREPARE_DELAYED_WORK(&mxs_phy->enhostdiscondetect_work,
 			mxs_phy_enhostdiscondetect_delay);
-	schedule_delayed_work(&mxs_phy->enhostdiscondetect_work,
+		schedule_delayed_work(&mxs_phy->enhostdiscondetect_work,
 			msecs_to_jiffies(MXY_PHY_ENHOSTDISCONDETECT_DELAY));
+	}
 
 	return 0;
 }
 
-static int mxs_phy_on_disconnect(struct usb_phy *phy, int port)
+static int mxs_phy_on_disconnect(struct usb_phy *phy,
+		enum usb_device_speed speed)
 {
-	dev_dbg(phy->dev, "Disconnect on port %d\n", port);
+	dev_dbg(phy->dev, "%s speed device has disconnected\n",
+		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
 
-	/* No need to delay before clearing ENHOSTDISCONDETECT. */
-	dev_dbg(phy->dev, "Clearing ENHOSTDISCONDETECT\n");
-	writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+	if (speed == USB_SPEED_HIGH) {
+		/* No need to delay before clearing ENHOSTDISCONDETECT. */
+		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+				phy->io_priv + HW_USBPHY_CTRL_CLR);
+	}
+
+	return 0;
+}
+
+static int mxs_phy_on_suspend(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	dev_dbg(phy->dev, "At suspend, %s speed device on the port\n",
+		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
+
+	if (speed == USB_SPEED_HIGH)
+		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
 			phy->io_priv + HW_USBPHY_CTRL_CLR);
 
 	return 0;
 }
 
+static int mxs_phy_on_resume(struct usb_phy *phy,
+		enum usb_device_speed speed)
+{
+	dev_dbg(phy->dev, "after resume, %s speed device on the port\n",
+		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
+
+	if (speed == USB_SPEED_HIGH)
+		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+			phy->io_priv + HW_USBPHY_CTRL_SET);
+
+	return 0;
+}
+
 static int mxs_phy_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -166,6 +196,8 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	mxs_phy->phy.shutdown		= mxs_phy_shutdown;
 	mxs_phy->phy.notify_connect	= mxs_phy_on_connect;
 	mxs_phy->phy.notify_disconnect	= mxs_phy_on_disconnect;
+	mxs_phy->phy.notify_suspend	= mxs_phy_on_suspend;
+	mxs_phy->phy.notify_resume	= mxs_phy_on_resume;
 
 	ATOMIC_INIT_NOTIFIER_HEAD(&mxs_phy->phy.notifier);
 
-- 
1.7.0.4
