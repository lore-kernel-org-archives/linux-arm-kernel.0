From: tchalamarla@caviumnetworks.com (tchalamarla at caviumnetworks.com)
Date: Tue, 16 Feb 2016 12:08:49 -0800
Subject: [PATCH V3] AHCI: Workaround for ThunderX Errata#22536
Message-ID: <1455653329-4934-1-git-send-email-tchalamarla@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>

Due to Errata in ThunderX, HOST_IRQ_STAT should be
cleared before leaving the interrupt handler.
The patch attempts to satisfy the need.

Changes from V2:
	- removed newfile
	- code is now under CONFIG_ARM64

Changes from V1:
	- Rebased on top of libata/for-4.6
        - Moved ThunderX intr handler to new file

Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
---
 drivers/ata/ahci.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 546a369..c8496fc 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1325,6 +1325,44 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif
 
+#ifdef CONFIG_ARM64
+/* Due to ERRATA#22536, ThunderX need to handle
+ * HOST_IRQ_STAT differently.
+ * Work around is to make sure all pending IRQs
+ * are served before leaving handler
+ */
+static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	struct ahci_host_priv *hpriv;
+	unsigned int rc = 0;
+	void __iomem *mmio;
+	u32 irq_stat, irq_masked;
+	unsigned int handled = 1;
+
+	VPRINTK("ENTER\n");
+	hpriv = host->private_data;
+	mmio = hpriv->mmio;
+	irq_stat = readl(mmio + HOST_IRQ_STAT);
+	if (!irq_stat)
+		return IRQ_NONE;
+
+	do {
+		irq_masked = irq_stat & hpriv->port_map;
+		spin_lock(&host->lock);
+		rc = ahci_handle_port_intr(host, irq_masked);
+		if (!rc)
+			handled = 0;
+		writel(irq_stat, mmio + HOST_IRQ_STAT);
+		irq_stat = readl(mmio + HOST_IRQ_STAT);
+		spin_unlock(&host->lock);
+	} while (irq_stat);
+	VPRINTK("EXIT\n");
+
+	return IRQ_RETVAL(handled);
+}
+#endif
+
 /*
  * ahci_init_msix() - optionally enable per-port MSI-X otherwise defer
  * to single msi.
@@ -1560,6 +1598,12 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_broken_devslp(pdev))
 		hpriv->flags |= AHCI_HFLAG_NO_DEVSLP;
 
+#ifdef CONFIG_ARM64
+	/* this should be done before save config*/
+	if (pdev->vendor == 0x177d && pdev->device == 0xa01c)
+		hpriv->irq_handler = ahci_thunderx_irq_handler;
+#endif
+
 	/* save initial config */
 	ahci_pci_save_initial_config(pdev, hpriv);
 
-- 
2.1.0
