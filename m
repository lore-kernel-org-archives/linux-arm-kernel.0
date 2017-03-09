From: andy.tang@nxp.com (Yuantian Tang)
Date: Thu, 9 Mar 2017 17:13:29 +0800
Subject: [PATCH] ahci: qoriq: correct the sata ecc setting error
Message-ID: <1489050809-15265-1-git-send-email-andy.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sata ecc is controlled by only 1 bit which is 24bit in big-endian
in ecc register. So only setting 24bit to disable sata ecc prevents
other bits from being overwritten in ecc register.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 85d8332..4c96f3a 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -177,7 +177,8 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 	case AHCI_LS1043A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
-		writel(ECC_DIS_ARMV8_CH2, qpriv->ecc_addr);
+		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
+				qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
@@ -194,7 +195,8 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 	case AHCI_LS1046A:
 		if (!qpriv->ecc_addr)
 			return -EINVAL;
-		writel(ECC_DIS_ARMV8_CH2, qpriv->ecc_addr);
+		writel(readl(qpriv->ecc_addr) | ECC_DIS_ARMV8_CH2,
+				qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		if (qpriv->is_dmacoherent)
-- 
2.1.0.27.g96db324
