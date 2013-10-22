From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 13:58:43 +0800
Subject: [Patch v2 09/14] usb: phy-mxs: Enable IC fixes for mx6 SoC serial
In-Reply-To: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382421528-17897-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adding IC fixes bits, some PHY bugs are fixed by
IC logic.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 4416ed6..af2a9cf 100644
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
 
 enum imx_phy_type {
@@ -121,6 +127,10 @@ static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
 		BM_USBPHY_CTRL_ENUTMILEVEL3,
 	       base + HW_USBPHY_CTRL_SET);
 
+	/* Enable IC solution */
+	if (is_mx6q_phy(mxs_phy) || is_mx6sl_phy(mxs_phy))
+		writel(BM_USBPHY_IP_FIX, base + HW_USBPHY_IP_SET);
+
 	return 0;
 }
 
-- 
1.7.1
