From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Wed, 16 Nov 2016 11:11:19 +0800
Subject: [PATCH 2/2] ahci: qoriq: report warning when ecc register is missing
In-Reply-To: <1479265879-48840-1-git-send-email-yuantian.tang@nxp.com>
References: <1479265879-48840-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <1479265879-48840-2-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

For ls1021a and ls1046a socs, sata ecc must be disabled.
If ecc register is not found in sata node in dts, report
a warning.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 45c88de..66eb4b5 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -158,6 +158,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 
 	switch (qpriv->type) {
 	case AHCI_LS1021A:
+		WARN_ON(!qpriv->ecc_addr);
 		writel(SATA_ECC_DISABLE, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(LS1021A_PORT_PHY2, reg_base + PORT_PHY2);
@@ -185,6 +186,7 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_LS1046A:
+		WARN_ON(!qpriv->ecc_addr);
 		writel(LS1046A_SATA_ECC_DIS, qpriv->ecc_addr);
 		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
-- 
2.1.0.27.g96db324
