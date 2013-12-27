From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 27 Dec 2013 10:38:41 +0800
Subject: [PATCH v9 12/12] usb: phy-mxs: Add sync time after controller clear
 phcd
In-Reply-To: <1388111921-17326-1-git-send-email-peter.chen@freescale.com>
References: <1388111921-17326-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1388111921-17326-13-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After clear portsc.phcd, PHY needs 200us stable time for switch
32K clock to AHB clock.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 53b8dad..4652fc9 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -151,6 +151,15 @@ static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
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
@@ -260,6 +269,7 @@ static int mxs_phy_init(struct usb_phy *phy)
 {
 	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
 
+	mxs_phy_clock_switch_delay();
 	clk_prepare_enable(mxs_phy->clk);
 	return mxs_phy_hw_init(mxs_phy);
 }
@@ -284,6 +294,7 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
 		       x->io_priv + HW_USBPHY_CTRL_SET);
 		clk_disable_unprepare(mxs_phy->clk);
 	} else {
+		mxs_phy_clock_switch_delay();
 		clk_prepare_enable(mxs_phy->clk);
 		writel(BM_USBPHY_CTRL_CLKGATE,
 		       x->io_priv + HW_USBPHY_CTRL_CLR);
-- 
1.7.8
