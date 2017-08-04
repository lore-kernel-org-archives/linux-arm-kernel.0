From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  4 Aug 2017 14:00:27 +0200
Subject: [PATCH 5/5] edac: synopsys: Enable CE and UE interrupts for ZynqMP
 DDRC
In-Reply-To: <60ff19f90adfd252cf296fe8988c614c4c3e43fd.1501848023.git.michal.simek@xilinx.com>
References: <60ff19f90adfd252cf296fe8988c614c4c3e43fd.1501848023.git.michal.simek@xilinx.com>
Message-ID: <52a6d49d3daf5de37a41c4a3b2e84072dc84ca2e.1501848023.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

This patch enables Corrected and Uncorrected Error
interrupts for ZynqMP DDRC controller

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
Reviewed-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/edac/synopsys_edac.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 501ef447df37..6ce2f4c4cb3d 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -165,6 +165,8 @@
 #define DDR_QOSUE_MASK		0x4
 #define	DDR_QOSCE_MASK		0x2
 #define	ECC_CE_UE_INTR_MASK	0x6
+#define DDR_QOS_IRQ_EN_OFST     0x20208
+#define DDR_QOS_IRQ_DB_OFST	0x2020C
 
 /* ECC Corrected Error Register Mask and Shifts*/
 #define ECC_CEADDR0_RW_MASK	0x3FFFF
@@ -1115,6 +1117,10 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
 			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");
 			goto free_edac_mc;
 		}
+
+		/* Enable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 	}
 
 	rc = edac_mc_add_mc(mci);
@@ -1157,6 +1163,10 @@ static int synps_edac_mc_remove(struct platform_device *pdev)
 	struct synps_edac_priv *priv;
 
 	priv = mci->pvt_info;
+	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
+		/* Disable UE/CE Interrupts */
+		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
+			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 	edac_mc_del_mc(&pdev->dev);
 	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
 		synps_edac_remove_sysfs_attributes(mci);
-- 
1.9.1
