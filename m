From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 28 Sep 2012 17:04:10 +0200
Subject: [PATCH] ATA: sata_mv: Fix warnings when no PCI
Message-ID: <1348844650-2957-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dove can be configured with PCI. We then get a number of warnings:

warning: 'msi' defined but not used
warning: 'mv5_sht' defined but not used
warning: 'mv_dump_pci_cfg' defined but not used.

Move around variables and add #ifdef as necassary to fix the warnings.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/ata/sata_mv.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 311be18..68f4fb5 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -79,8 +79,8 @@
  * module options
  */
 
-static int msi;
 #ifdef CONFIG_PCI
+static int msi;
 module_param(msi, int, S_IRUGO);
 MODULE_PARM_DESC(msi, "Enable use of PCI MSI (0=off, 1=on)");
 #endif
@@ -652,12 +652,13 @@ static u8 mv_sff_check_status(struct ata_port *ap);
  * because we have to allow room for worst case splitting of
  * PRDs for 64K boundaries in mv_fill_sg().
  */
+#ifdef CONFIG_PCI
 static struct scsi_host_template mv5_sht = {
 	ATA_BASE_SHT(DRV_NAME),
 	.sg_tablesize		= MV_MAX_SG_CT / 2,
 	.dma_boundary		= MV_DMA_BOUNDARY,
 };
-
+#endif
 static struct scsi_host_template mv6_sht = {
 	ATA_NCQ_SHT(DRV_NAME),
 	.can_queue		= MV_MAX_Q_DEPTH - 1,
@@ -1252,7 +1253,7 @@ static void mv_dump_mem(void __iomem *start, unsigned bytes)
 	}
 }
 #endif
-
+#if defined(ATA_DEBUG) || defined(CONFIG_PCI)
 static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
 {
 #ifdef ATA_DEBUG
@@ -1269,6 +1270,7 @@ static void mv_dump_pci_cfg(struct pci_dev *pdev, unsigned bytes)
 	}
 #endif
 }
+#endif
 static void mv_dump_all_regs(void __iomem *mmio_base, int port,
 			     struct pci_dev *pdev)
 {
-- 
1.7.10.4
