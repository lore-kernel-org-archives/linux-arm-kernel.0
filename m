From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Fri, 20 Jan 2017 14:59:36 +0800
Subject: [PATCH 3/3 v2] ahci: qoriq: added ls2088a platforms support
In-Reply-To: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
References: <1484895576-40379-1-git-send-email-yuantian.tang@nxp.com>
Message-ID: <1484895576-40379-3-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Ls2088a is new introduced arm-based soc with sata support with
following features:
1. Complies with the serial ATA 3.0 specification and the AHCI 1.3.1
   specification
2. Contains a high-speed descriptor-based DMA controller
3. Supports the following:
   a. Speeds of 1.5 Gb/s (first-generation SATA), 3 Gb/s
      (second-generation SATA), and 6 Gb/s (third-generation SATA)
   b. FIS-based switching
   c. Native command queuing (NCQ) commands
   d. Port multiplier operation
   e. Asynchronous notification
   f. SATA BIST mode

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
v2:
  - no change

 drivers/ata/ahci_qoriq.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 137b1c7..85d8332 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -53,6 +53,7 @@ enum ahci_qoriq_type {
 	AHCI_LS1043A,
 	AHCI_LS2080A,
 	AHCI_LS1046A,
+	AHCI_LS2088A,
 };
 
 struct ahci_qoriq_priv {
@@ -67,6 +68,7 @@ static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
 	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
 	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
+	{ .compatible = "fsl,ls2088a-ahci", .data = (void *)AHCI_LS2088A},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
@@ -198,6 +200,13 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		if (qpriv->is_dmacoherent)
 			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
+
+	case AHCI_LS2088A:
+		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
+		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
+		if (qpriv->is_dmacoherent)
+			writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
+		break;
 	}
 
 	return 0;
-- 
2.1.0.27.g96db324
