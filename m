From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:49:43 +0800
Subject: [PATCH v3 11/11] usb: phy-mxs: Add system suspend/resume API
In-Reply-To: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
References: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616183-10511-12-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need this to keep PHY's power on or off during the system
suspend mode. If we need to enable USB wakeup, then we
must keep PHY's power being on during the system suspend mode.
Otherwise, we need to keep PHY's power being off to save power.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   66 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 63 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index ff8b98c..4588c72 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -55,11 +55,18 @@
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
@@ -83,6 +90,15 @@
  */
 #define MXS_PHY_SENDING_SOF_TOO_FAST		BIT(2)
 
+/* imx23 style PHY */
+#define MXS_PHY_IMX23				BIT(3)
+
+/* imx6q style PHY */
+#define MXS_PHY_IMX6Q				BIT(4)
+
+/* imx6sl style PHY */
+#define MXS_PHY_IMX6SL				BIT(5)
+
 /*
  * IC fix for MXS_PHY_ABNORAML_IN_SUSPEND, bit 17 is the effective bit
  * in HW_USBPHY_IP.
@@ -100,19 +116,23 @@ struct mxs_phy_platform_flag {
 };
 
 static const struct mxs_phy_platform_flag imx23_phy_data = {
-	.flags = MXS_PHY_ABNORAML_IN_SUSPEND | MXS_PHY_SENDING_SOF_TOO_FAST,
+	.flags = MXS_PHY_ABNORAML_IN_SUSPEND |
+		MXS_PHY_SENDING_SOF_TOO_FAST |
+		MXS_PHY_IMX23,
 };
 
 static const struct mxs_phy_platform_flag imx6q_phy_data = {
 	.flags = MXS_PHY_SENDING_SOF_TOO_FAST |
 		MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS |
-		MXS_PHY_FIX_ABNORAML_IN_SUSPEND,
+		MXS_PHY_FIX_ABNORAML_IN_SUSPEND |
+		MXS_PHY_IMX6Q,
 };
 
 static const struct mxs_phy_platform_flag imx6sl_phy_data = {
 	.flags = MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS |
 		MXS_PHY_FIX_ABNORAML_IN_SUSPEND |
-		MXS_PHY_FIX_SENDING_SOF_TOO_FAST,
+		MXS_PHY_FIX_SENDING_SOF_TOO_FAST |
+		MXS_PHY_IMX6SL,
 };
 
 static const struct of_device_id mxs_phy_dt_ids[] = {
@@ -210,6 +230,22 @@ static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 			? "disconnected" : "connected");
 }
 
+static void mxs_phy_enable_ldo_in_suspend(struct mxs_phy *mxs_phy, bool on)
+{
+	unsigned int reg = on ? ANADIG_ANA_MISC0_SET : ANADIG_ANA_MISC0_CLR;
+
+	/* If the SoCs don't have anatop, quit */
+	if (!mxs_phy->regmap_anatop)
+		return;
+
+	if (mxs_phy->flags & MXS_PHY_IMX6Q)
+		regmap_write(mxs_phy->regmap_anatop, reg,
+			BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG);
+	else if (mxs_phy->flags & MXS_PHY_IMX6SL)
+		regmap_write(mxs_phy->regmap_anatop,
+			reg, BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG_SL);
+}
+
 static int mxs_phy_init(struct usb_phy *phy)
 {
 	struct mxs_phy *mxs_phy = to_mxs_phy(phy);
@@ -395,6 +431,7 @@ static int mxs_phy_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, &mxs_phy->phy);
 
+	device_set_wakeup_capable(&pdev->dev, true);
 	ret = usb_add_phy_dev(&mxs_phy->phy);
 	if (ret)
 		return ret;
@@ -411,6 +448,28 @@ static int mxs_phy_remove(struct platform_device *pdev)
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
@@ -418,6 +477,7 @@ static struct platform_driver mxs_phy_driver = {
 		.name = DRIVER_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = mxs_phy_dt_ids,
+		.pm = &mxs_phy_pm,
 	 },
 };
 
-- 
1.7.1
