From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 12 Oct 2013 17:09:42 +0800
Subject: [PATCH 08/12] usb: phy-mxs: Add system suspend/resume API
In-Reply-To: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1381568986-19802-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need this to keep PHY's power on or off during the system
suspend mode. If we need to enable USB wakeup, then we
must keep PHY's power being on during the system suspend mode.
Otherwise, we need to keep PHY's power being off to save power.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   47 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 693f9a4..a91ddc0 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -57,11 +57,18 @@
 #define BM_USBPHY_DEBUG_CLKGATE			BIT(30)
 
 /* Anatop Registers */
+#define ANADIG_ANA_MISC0			0x150
+#define ANADIG_ANA_MISC0_SET			0x154
+#define ANADIG_ANA_MISC0_CLR			0x158
+
 #define ANADIG_USB1_VBUS_DET_STAT		0x1c0
 
 #define ANADIG_USB1_LOOPBACK_SET		0x1e4
 #define ANADIG_USB1_LOOPBACK_CLR		0x1e8
 
+#define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	BIT(12)
+#define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG_SL BIT(11)
+
 #define BM_ANADIG_USB1_VBUS_DET_STAT_VBUS_VALID	BIT(3)
 
 #define BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1	BIT(2)
@@ -192,6 +199,22 @@ static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 			? "disconnected" : "connected");
 }
 
+static void mxs_phy_enable_ldo_in_suspend(struct mxs_phy *mxs_phy, bool on)
+{
+	unsigned int reg = on ? ANADIG_ANA_MISC0_SET : ANADIG_ANA_MISC0_CLR;
+
+	/* Only the SoCs have anatop need below operation */
+	if (!mxs_phy->regmap_anatop)
+		return;
+
+	if (is_mx6q_phy(mxs_phy))
+		regmap_write(mxs_phy->regmap_anatop, reg,
+			BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG);
+	else if (is_mx6sl_phy(mxs_phy))
+		regmap_write(mxs_phy->regmap_anatop,
+			reg, BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG_SL);
+}
+
 static int mxs_phy_init(struct usb_phy *phy)
 {
 	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
@@ -413,6 +436,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &mxs_phy->phy);
 
+	device_set_wakeup_capable(&pdev->dev, true);
 	ret = usb_add_phy_dev(&mxs_phy->phy);
 	if (ret)
 		return ret;
@@ -429,6 +453,28 @@ static int mxs_phy_remove(struct platform_device *pdev)
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
@@ -436,6 +482,7 @@ static struct platform_driver mxs_phy_driver = {
 		.name = DRIVER_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = mxs_phy_dt_ids,
+		.pm = &mxs_phy_pm,
 	 },
 };
 
-- 
1.7.1
