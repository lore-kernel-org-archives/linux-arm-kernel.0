From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Sun, 9 Oct 2016 16:57:40 +0800
Subject: [PATCH] ahci: qoriq: added ls1046a platform support
Message-ID: <1476003460-1005-1-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Ls1046a is a new introduced soc which supports ATA3.0.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
 drivers/ata/ahci_qoriq.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 1eba8df..9884c8c 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -46,11 +46,13 @@
 #define LS1021A_AXICC_ADDR	0xC0
 
 #define SATA_ECC_DISABLE	0x00020000
+#define LS1046A_SATA_ECC_DIS	0x80000000
 
 enum ahci_qoriq_type {
 	AHCI_LS1021A,
 	AHCI_LS1043A,
 	AHCI_LS2080A,
+	AHCI_LS1046A,
 };
 
 struct ahci_qoriq_priv {
@@ -63,6 +65,7 @@ static const struct of_device_id ahci_qoriq_of_match[] = {
 	{ .compatible = "fsl,ls1021a-ahci", .data = (void *)AHCI_LS1021A},
 	{ .compatible = "fsl,ls1043a-ahci", .data = (void *)AHCI_LS1043A},
 	{ .compatible = "fsl,ls2080a-ahci", .data = (void *)AHCI_LS2080A},
+	{ .compatible = "fsl,ls1046a-ahci", .data = (void *)AHCI_LS1046A},
 	{},
 };
 MODULE_DEVICE_TABLE(of, ahci_qoriq_of_match);
@@ -175,6 +178,13 @@ static int ahci_qoriq_phy_init(struct ahci_host_priv *hpriv)
 		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
 		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
 		break;
+
+	case AHCI_LS1046A:
+		writel(LS1046A_SATA_ECC_DIS, qpriv->ecc_addr);
+		writel(AHCI_PORT_PHY_1_CFG, reg_base + PORT_PHY1);
+		writel(AHCI_PORT_TRANS_CFG, reg_base + PORT_TRANS);
+		writel(AHCI_PORT_AXICC_CFG, reg_base + PORT_AXICC);
+		break;
 	}
 
 	return 0;
@@ -204,9 +214,9 @@ static int ahci_qoriq_probe(struct platform_device *pdev)
 
 	qoriq_priv->type = (enum ahci_qoriq_type)of_id->data;
 
-	if (qoriq_priv->type == AHCI_LS1021A) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-				"sata-ecc");
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+			"sata-ecc");
+	if (res) {
 		qoriq_priv->ecc_addr = devm_ioremap_resource(dev, res);
 		if (IS_ERR(qoriq_priv->ecc_addr))
 			return PTR_ERR(qoriq_priv->ecc_addr);
-- 
2.1.0.27.g96db324
