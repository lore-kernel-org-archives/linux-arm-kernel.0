From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Wed, 22 Feb 2017 16:54:59 +0800
Subject: [PATCH v3 2/8] phy: phy-mt65xx-usb3: increase LFPS filter threshold
In-Reply-To: <1487753705-6745-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1487753705-6745-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1487753705-6745-2-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase LFPS filter threshold to avoid some fake remote wakeup
signal which cause U3 link fail and link to U2 only at about
0.01% probability.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mt65xx-usb3.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/phy-mt65xx-usb3.c b/drivers/phy/phy-mt65xx-usb3.c
index fe2392a..4fd47d0 100644
--- a/drivers/phy/phy-mt65xx-usb3.c
+++ b/drivers/phy/phy-mt65xx-usb3.c
@@ -106,6 +106,10 @@
 #define P3A_RG_XTAL_EXT_EN_U3		GENMASK(11, 10)
 #define P3A_RG_XTAL_EXT_EN_U3_VAL(x)	((0x3 & (x)) << 10)
 
+#define U3P_U3_PHYD_LFPS1		(SSUSB_SIFSLV_U3PHYD_BASE + 0x000c)
+#define P3D_RG_FWAKE_TH		GENMASK(21, 16)
+#define P3D_RG_FWAKE_TH_VAL(x)	((0x3f & (x)) << 16)
+
 #define U3P_PHYD_CDR1		(SSUSB_SIFSLV_U3PHYD_BASE + 0x005c)
 #define P3D_RG_CDR_BIR_LTD1		GENMASK(28, 24)
 #define P3D_RG_CDR_BIR_LTD1_VAL(x)	((0x1f & (x)) << 24)
@@ -303,6 +307,11 @@ static void phy_instance_init(struct mt65xx_u3phy *u3phy,
 	tmp |= P3D_RG_CDR_BIR_LTD0_VAL(0xc) | P3D_RG_CDR_BIR_LTD1_VAL(0x3);
 	writel(tmp, port_base + U3P_PHYD_CDR1);
 
+	tmp = readl(port_base + U3P_U3_PHYD_LFPS1);
+	tmp &= ~P3D_RG_FWAKE_TH;
+	tmp |= P3D_RG_FWAKE_TH_VAL(0x34);
+	writel(tmp, port_base + U3P_U3_PHYD_LFPS1);
+
 	tmp = readl(port_base + U3P_U3_PHYD_RXDET1);
 	tmp &= ~P3D_RG_RXDET_STB2_SET;
 	tmp |= P3D_RG_RXDET_STB2_SET_VAL(0x10);
-- 
1.7.9.5
