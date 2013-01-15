From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 15 Jan 2013 14:08:36 +0800
Subject: [PATCH v2 3/4] usb: mxs-phy: add set_suspend API
In-Reply-To: <1358230117-19443-1-git-send-email-peter.chen@freescale.com>
References: <1358230117-19443-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1358230117-19443-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It needs to call set_suspend during USB suspend/resume

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/otg/mxs-phy.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/mxs-phy.c b/drivers/usb/otg/mxs-phy.c
index 49727dd..cad16e5 100644
--- a/drivers/usb/otg/mxs-phy.c
+++ b/drivers/usb/otg/mxs-phy.c
@@ -84,6 +84,25 @@ static void mxs_phy_shutdown(struct usb_phy *phy)
 	clk_disable_unprepare(mxs_phy->clk);
 }
 
+static int mxs_phy_suspend(struct usb_phy *x, int suspend)
+{
+	struct mxs_phy *mxs_phy = to_mxs_phy(x);
+
+	if (suspend) {
+		writel_relaxed(0xffffffff, x->io_priv + HW_USBPHY_PWD);
+		writel_relaxed(BM_USBPHY_CTRL_CLKGATE,
+			x->io_priv + HW_USBPHY_CTRL_SET);
+		clk_disable_unprepare(mxs_phy->clk);
+	} else {
+		clk_prepare_enable(mxs_phy->clk);
+		writel_relaxed(BM_USBPHY_CTRL_CLKGATE,
+			x->io_priv + HW_USBPHY_CTRL_CLR);
+		writel_relaxed(0, x->io_priv + HW_USBPHY_PWD);
+	}
+
+	return 0;
+}
+
 static int mxs_phy_on_connect(struct usb_phy *phy,
 		enum usb_device_speed speed)
 {
@@ -146,6 +165,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 	mxs_phy->phy.label		= DRIVER_NAME;
 	mxs_phy->phy.init		= mxs_phy_init;
 	mxs_phy->phy.shutdown		= mxs_phy_shutdown;
+	mxs_phy->phy.set_suspend	= mxs_phy_suspend;
 	mxs_phy->phy.notify_connect	= mxs_phy_on_connect;
 	mxs_phy->phy.notify_disconnect	= mxs_phy_on_disconnect;
 
-- 
1.7.0.4
