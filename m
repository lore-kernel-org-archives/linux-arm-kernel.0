From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 15:37:03 +0800
Subject: [PATCH v4 09/17] usb: phy-mxs: Enable IC fixes for related SoCs
In-Reply-To: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1386056231-17258-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some PHY bugs are fixed by IC logic, but these bits are not
enabled by default, so we enable them at driver.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 8738890..0908d74 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -31,6 +31,10 @@
 #define HW_USBPHY_CTRL_SET			0x34
 #define HW_USBPHY_CTRL_CLR			0x38
 
+#define HW_USBPHY_IP				0x90
+#define HW_USBPHY_IP_SET			0x94
+#define HW_USBPHY_IP_CLR			0x98
+
 #define BM_USBPHY_CTRL_SFTRST			BIT(31)
 #define BM_USBPHY_CTRL_CLKGATE			BIT(30)
 #define BM_USBPHY_CTRL_ENAUTOSET_USBCLKS	BIT(26)
@@ -42,6 +46,8 @@
 #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
 #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
 
+#define BM_USBPHY_IP_FIX                       (BIT(17) | BIT(18))
+
 #define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
 
 /* Do disconnection between PHY and controller without vbus */
@@ -97,6 +103,16 @@ struct mxs_phy {
 	struct regmap *regmap_anatop;
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
@@ -123,6 +139,10 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 		BM_USBPHY_CTRL_ENUTMILEVEL3,
 	       base + HW_USBPHY_CTRL_SET);
 
+	/* Enable IC solution */
+	if (is_imx6q_phy(mxs_phy) || is_imx6sl_phy(mxs_phy))
+		writel(BM_USBPHY_IP_FIX, base + HW_USBPHY_IP_SET);
+
 	return 0;
 }
 
-- 
1.7.8
