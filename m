From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 24 Feb 2014 10:21:04 +0800
Subject: [PATCH v11 12/15] usb: phy-mxs: Add sync time after controller clear
 phcd
In-Reply-To: <1393208467-6355-1-git-send-email-peter.chen@freescale.com>
References: <1393208467-6355-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1393208467-6355-13-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After clear portsc.phcd, PHY needs 200us stable time for switch
32K clock to AHB clock.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 31ef59f..c42bdf0 100644
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
@@ -261,6 +270,7 @@ static int mxs_phy_init(struct usb_phy *phy)
 	int ret;
 	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
 
+	mxs_phy_clock_switch_delay();
 	ret = clk_prepare_enable(mxs_phy->clk);
 	if (ret)
 		return ret;
@@ -289,6 +299,7 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
 		       x->io_priv + HW_USBPHY_CTRL_SET);
 		clk_disable_unprepare(mxs_phy->clk);
 	} else {
+		mxs_phy_clock_switch_delay();
 		ret = clk_prepare_enable(mxs_phy->clk);
 		if (ret)
 			return ret;
-- 
1.7.8
