From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 13 Dec 2013 09:23:45 +0800
Subject: [PATCH v6 15/15] usb: phy-mxs: Add sync time after controller clear
 phcd
In-Reply-To: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1386897825-6130-16-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After clear portsc.phcd, PHY needs 200us stable time for switch
32K clock to AHB clock.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 885f8d9..68bd981 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -156,6 +156,15 @@ static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
 	return mxs_phy->data == &imx6sl_phy_data;
 }
 
+/*
+ * PHY needs some 32K cycles to switch from 32K clock to
+ * bus (such as AHB/AXI, etc) clock.
+ */
+static void mxs_phy_clock_switch_delay(void)
+{
+	usleep_range(300, 400);
+}
+
 static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 {
 	int ret;
@@ -281,6 +290,7 @@ static int mxs_phy_init(struct usb_phy *phy)
 {
 	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
 
+	mxs_phy_clock_switch_delay();
 	clk_prepare_enable(mxs_phy->clk);
 	return mxs_phy_hw_init(mxs_phy);
 }
@@ -305,6 +315,7 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
 		       x->io_priv + HW_USBPHY_CTRL_SET);
 		clk_disable_unprepare(mxs_phy->clk);
 	} else {
+		mxs_phy_clock_switch_delay();
 		clk_prepare_enable(mxs_phy->clk);
 		writel(BM_USBPHY_CTRL_CLKGATE,
 		       x->io_priv + HW_USBPHY_CTRL_CLR);
-- 
1.7.8
