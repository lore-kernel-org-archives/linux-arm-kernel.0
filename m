From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Feb 2013 11:52:30 +0100
Subject: [PATCH 3/4] USB mxs-phy: use readl(),
 writel() instead of the _relaxed() versions
In-Reply-To: <1362048751-4061-1-git-send-email-mkl@pengutronix.de>
References: <1362048751-4061-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1362048751-4061-4-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch converts the mxs-phy driver from readl_relaxed(), writel_relaxed()
to the plain readl(), writel() functions, which are available on all platforms.
This is done to enable compile time testing on non ARM platforms.

Reported-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/otg/mxs-phy.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
index b0d9f11..dff10f2 100644
--- a/drivers/usb/otg/mxs-phy.c
+++ b/drivers/usb/otg/mxs-phy.c
@@ -48,12 +48,12 @@ static void mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 	stmp_reset_block(base + HW_USBPHY_CTRL);
 
 	/* Power up the PHY */
-	writel_relaxed(0, base + HW_USBPHY_PWD);
+	writel(0, base + HW_USBPHY_PWD);
 
 	/* enable FS/LS device */
-	writel_relaxed(BM_USBPHY_CTRL_ENUTMILEVEL2 |
-			BM_USBPHY_CTRL_ENUTMILEVEL3,
-			base + HW_USBPHY_CTRL_SET);
+	writel(BM_USBPHY_CTRL_ENUTMILEVEL2 |
+	       BM_USBPHY_CTRL_ENUTMILEVEL3,
+	       base + HW_USBPHY_CTRL_SET);
 }
 
 static int mxs_phy_init(struct usb_phy *phy)
@@ -70,8 +70,8 @@ static void mxs_phy_shutdown(struct usb_phy *phy)
 {
 	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
 
-	writel_relaxed(BM_USBPHY_CTRL_CLKGATE,
-			phy->io_priv + HW_USBPHY_CTRL_SET);
+	writel(BM_USBPHY_CTRL_CLKGATE,
+	       phy->io_priv + HW_USBPHY_CTRL_SET);
 
 	clk_disable_unprepare(mxs_phy->clk);
 }
@@ -81,15 +81,15 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
 	struct mxs_phy *mxs_phy = to_mxs_phy(x);
 
 	if (suspend) {
-		writel_relaxed(0xffffffff, x->io_priv + HW_USBPHY_PWD);
-		writel_relaxed(BM_USBPHY_CTRL_CLKGATE,
-			x->io_priv + HW_USBPHY_CTRL_SET);
+		writel(0xffffffff, x->io_priv + HW_USBPHY_PWD);
+		writel(BM_USBPHY_CTRL_CLKGATE,
+		       x->io_priv + HW_USBPHY_CTRL_SET);
 		clk_disable_unprepare(mxs_phy->clk);
 	} else {
 		clk_prepare_enable(mxs_phy->clk);
-		writel_relaxed(BM_USBPHY_CTRL_CLKGATE,
-			x->io_priv + HW_USBPHY_CTRL_CLR);
-		writel_relaxed(0, x->io_priv + HW_USBPHY_PWD);
+		writel(BM_USBPHY_CTRL_CLKGATE,
+		       x->io_priv + HW_USBPHY_CTRL_CLR);
+		writel(0, x->io_priv + HW_USBPHY_PWD);
 	}
 
 	return 0;
@@ -102,8 +102,8 @@ static int mxs_phy_on_connect(struct usb_phy *phy,
 		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
 
 	if (speed == USB_SPEED_HIGH)
-		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
-				phy->io_priv + HW_USBPHY_CTRL_SET);
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+		       phy->io_priv + HW_USBPHY_CTRL_SET);
 
 	return 0;
 }
@@ -115,8 +115,8 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy,
 		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
 
 	if (speed == USB_SPEED_HIGH)
-		writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
-				phy->io_priv + HW_USBPHY_CTRL_CLR);
+		writel(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
+		       phy->io_priv + HW_USBPHY_CTRL_CLR);
 
 	return 0;
 }
-- 
1.7.10.4
