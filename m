From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 13 Dec 2013 09:23:44 +0800
Subject: [PATCH v6 14/15] usb: phy-mxs: Add system suspend/resume API
In-Reply-To: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1386897825-6130-15-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need this to keep PHY's power on or off during the system
suspend mode. If we need to enable USB wakeup, then we
must keep PHY's power being on during the system suspend mode.
Otherwise, we need to keep PHY's power being off to save power.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   58 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 1bf78ee..885f8d9 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -57,6 +57,10 @@
 #define BM_USBPHY_DEBUG_CLKGATE			BIT(30)
 
 /* Anatop Registers */
+#define ANADIG_ANA_MISC0			0x150
+#define ANADIG_ANA_MISC0_SET			0x154
+#define ANADIG_ANA_MISC0_CLR			0x158
+
 #define ANADIG_USB1_VBUS_DET_STAT		0x1c0
 #define ANADIG_USB2_VBUS_DET_STAT		0x220
 
@@ -65,6 +69,9 @@
 #define ANADIG_USB2_LOOPBACK_SET		0x244
 #define ANADIG_USB2_LOOPBACK_CLR		0x248
 
+#define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	BIT(12)
+#define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG_SL BIT(11)
+
 #define BM_ANADIG_USB1_VBUS_DET_STAT_VBUS_VALID	BIT(3)
 #define BM_ANADIG_USB2_VBUS_DET_STAT_VBUS_VALID	BIT(3)
 
@@ -139,6 +146,16 @@ struct mxs_phy {
 	int port_id;
 };
 
+static inline bool is_imx6q_phy(struct mxs_phy *mxs_phy)
+{
+	return mxs_phy->data == &imx6q_phy_data;
+}
+
+static inline bool is_imx6sl_phy(struct mxs_phy *mxs_phy)
+{
+	return mxs_phy->data == &imx6sl_phy_data;
+}
+
 static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 {
 	int ret;
@@ -244,6 +261,22 @@ static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 
 }
 
+static void mxs_phy_enable_ldo_in_suspend(struct mxs_phy *mxs_phy, bool on)
+{
+	unsigned int reg = on ? ANADIG_ANA_MISC0_SET : ANADIG_ANA_MISC0_CLR;
+
+	/* If the SoCs don't have anatop, quit */
+	if (!mxs_phy->regmap_anatop)
+		return;
+
+	if (is_imx6q_phy(mxs_phy))
+		regmap_write(mxs_phy->regmap_anatop, reg,
+			BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG);
+	else if (is_imx6sl_phy(mxs_phy))
+		regmap_write(mxs_phy->regmap_anatop,
+			reg, BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG_SL);
+}
+
 static int mxs_phy_init(struct usb_phy *phy)
 {
 	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
@@ -435,6 +468,8 @@ static int mxs_phy_probe(struct platform_device *pdev)
 		}
 	}
 
+	device_set_wakeup_capable(&pdev->dev, true);
+
 	ret = usb_add_phy_dev(&mxs_phy->phy);
 	if (ret)
 		return ret;
@@ -451,6 +486,28 @@ static int mxs_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int mxs_phy_system_suspend(struct device *dev)
+{
+	struct mxs_phy *mxs_phy = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		mxs_phy_enable_ldo_in_suspend(mxs_phy, true);
+
+	return 0;
+}
+
+static int mxs_phy_system_resume(struct device *dev)
+{
+	struct mxs_phy *mxs_phy = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		mxs_phy_enable_ldo_in_suspend(mxs_phy, false);
+
+	return 0;
+}
+
+SIMPLE_DEV_PM_OPS(mxs_phy_pm, mxs_phy_system_suspend, mxs_phy_system_resume);
+
 static struct platform_driver mxs_phy_driver = {
 	.probe = mxs_phy_probe,
 	.remove = mxs_phy_remove,
@@ -458,6 +515,7 @@ static struct platform_driver mxs_phy_driver = {
 		.name = DRIVER_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = mxs_phy_dt_ids,
+		.pm = &mxs_phy_pm,
 	 },
 };
 
-- 
1.7.8
