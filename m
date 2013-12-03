From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 15:37:10 +0800
Subject: [PATCH v4 16/17] usb: phy-mxs: fix the problem by only using 1st
 controller's register
In-Reply-To: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1386056231-17258-17-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We fix the problem that we only use the 1st controller's related
registers at mxs_phy_disconnect_line, but in fact, it needs to
access registers according to different PHYs.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   89 +++++++++++++++++++++++++++++------------
 1 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 4c2dfcd..542b6ec 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -62,17 +62,23 @@
 #define ANADIG_ANA_MISC0_CLR			0x158
 
 #define ANADIG_USB1_VBUS_DET_STAT		0x1c0
+#define ANADIG_USB2_VBUS_DET_STAT		0x220
 
 #define ANADIG_USB1_LOOPBACK_SET		0x1e4
 #define ANADIG_USB1_LOOPBACK_CLR		0x1e8
+#define ANADIG_USB2_LOOPBACK_SET		0x244
+#define ANADIG_USB2_LOOPBACK_CLR		0x248
 
 #define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	BIT(12)
 #define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG_SL BIT(11)
 
 #define BM_ANADIG_USB1_VBUS_DET_STAT_VBUS_VALID	BIT(3)
+#define BM_ANADIG_USB2_VBUS_DET_STAT_VBUS_VALID	BIT(3)
 
 #define BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1	BIT(2)
 #define BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN	BIT(5)
+#define BM_ANADIG_USB2_LOOPBACK_UTMI_DIG_TST1	BIT(2)
+#define BM_ANADIG_USB2_LOOPBACK_TSTI_TX_EN	BIT(5)
 
 #define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
 
@@ -182,12 +188,61 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 	return 0;
 }
 
-static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
+/* Return true if the vbus is there */
+static bool mxs_phy_get_vbus_status(struct mxs_phy *mxs_phy)
+{
+	unsigned int vbus_value;
+
+	if (mxs_phy->port_id == 0)
+		regmap_read(mxs_phy->regmap_anatop,
+			ANADIG_USB1_VBUS_DET_STAT,
+			&vbus_value);
+	else if (mxs_phy->port_id == 1)
+		regmap_read(mxs_phy->regmap_anatop,
+			ANADIG_USB2_VBUS_DET_STAT,
+			&vbus_value);
+
+	if (vbus_value & BM_ANADIG_USB1_VBUS_DET_STAT_VBUS_VALID)
+		return true;
+	else
+		return false;
+}
+
+static void __mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool disconnect)
 {
 	void __iomem *base = mxs_phy->phy.io_priv;
+	u32 reg;
+
+	if (disconnect)
+		writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
+			base + HW_USBPHY_DEBUG_CLR);
+
+	if (mxs_phy->port_id == 0) {
+		reg = disconnect ? ANADIG_USB1_LOOPBACK_SET
+			: ANADIG_USB1_LOOPBACK_CLR;
+		regmap_write(mxs_phy->regmap_anatop, reg,
+			BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1 |
+			BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN);
+	} else if (mxs_phy->port_id == 1) {
+		reg = disconnect ? ANADIG_USB2_LOOPBACK_SET
+			: ANADIG_USB2_LOOPBACK_CLR;
+		regmap_write(mxs_phy->regmap_anatop, reg,
+			BM_ANADIG_USB2_LOOPBACK_UTMI_DIG_TST1 |
+			BM_ANADIG_USB2_LOOPBACK_TSTI_TX_EN);
+	}
+
+	if (!disconnect)
+		writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
+			base + HW_USBPHY_DEBUG_SET);
+
+	/* Delay some time, and let Linestate be SE0 for controller */
+	if (disconnect)
+		usleep_range(500, 1000);
+}
+
+static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
+{
 	bool vbus_is_on = false;
-	static bool line_is_disconnected;
-	unsigned int vbus_value = 0;
 
 	/* If the SoCs don't need to disconnect line without vbus, quit */
 	if (!(mxs_phy->data->flags & MXS_PHY_DISCONNECT_LINE_WITHOUT_VBUS))
@@ -197,31 +252,13 @@ static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
 	if (!mxs_phy->regmap_anatop)
 		return;
 
-	regmap_read(mxs_phy->regmap_anatop, ANADIG_USB1_VBUS_DET_STAT,
-			&vbus_value);
-	if (vbus_value & BM_ANADIG_USB1_VBUS_DET_STAT_VBUS_VALID)
-		vbus_is_on = true;
+	vbus_is_on = mxs_phy_get_vbus_status(mxs_phy);
 
-	if (on && !vbus_is_on) {
-		writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
-			base + HW_USBPHY_DEBUG_CLR);
-		regmap_write(mxs_phy->regmap_anatop, ANADIG_USB1_LOOPBACK_SET,
-				BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1 |
-				BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN);
-		/* Delay some time, and let Linestate be SE0 for controller */
-		usleep_range(500, 1000);
-		line_is_disconnected = true;
-	} else if (line_is_disconnected) {
-		regmap_write(mxs_phy->regmap_anatop, ANADIG_USB1_LOOPBACK_CLR,
-				BM_ANADIG_USB1_LOOPBACK_UTMI_DIG_TST1 |
-				BM_ANADIG_USB1_LOOPBACK_TSTI_TX_EN);
-		writel_relaxed(BM_USBPHY_DEBUG_CLKGATE,
-				base + HW_USBPHY_DEBUG_SET);
-		line_is_disconnected = false;
-	}
+	if (on && !vbus_is_on)
+		__mxs_phy_disconnect_line(mxs_phy, true);
+	else
+		__mxs_phy_disconnect_line(mxs_phy, false);
 
-	dev_dbg(mxs_phy->phy.dev, "line is %s\n", line_is_disconnected
-			? "disconnected" : "connected");
 }
 
 static void mxs_phy_enable_ldo_in_suspend(struct mxs_phy *mxs_phy, bool on)
-- 
1.7.8
