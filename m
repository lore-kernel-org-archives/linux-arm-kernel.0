From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 22 Aug 2017 14:02:22 +0800
Subject: [PATCH next 1/2] phy: phy-mtk-tphy: fix NULL point of chip bank
Message-ID: <a36fbe3171bc71cb91a7aa3ffaa97837d209a4d4.1503381432.git.chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chip bank of version-1 is initialized as NULL, but it's used
by pcie_phy_instance_power_on/off(), so assign it a right
address.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/mediatek/phy-mtk-tphy.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 1ca7fe3..a440de9 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -28,6 +28,7 @@
 /* banks shared by multiple phys */
 #define SSUSB_SIFSLV_V1_SPLLC		0x000	/* shared by u3 phys */
 #define SSUSB_SIFSLV_V1_U2FREQ		0x100	/* shared by u2 phys */
+#define SSUSB_SIFSLV_V1_CHIP		0x300	/* shared by u3 phys */
 /* u2 phy bank */
 #define SSUSB_SIFSLV_V1_U2PHY_COM	0x000
 /* u3/pcie/sata phy banks */
@@ -763,7 +764,7 @@ static void phy_v1_banks_init(struct mtk_tphy *tphy,
 	case PHY_TYPE_USB3:
 	case PHY_TYPE_PCIE:
 		u3_banks->spllc = tphy->sif_base + SSUSB_SIFSLV_V1_SPLLC;
-		u3_banks->chip = NULL;
+		u3_banks->chip = tphy->sif_base + SSUSB_SIFSLV_V1_CHIP;
 		u3_banks->phyd = instance->port_base + SSUSB_SIFSLV_V1_U3PHYD;
 		u3_banks->phya = instance->port_base + SSUSB_SIFSLV_V1_U3PHYA;
 		break;
-- 
1.7.9.5
