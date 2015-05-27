From: rric@kernel.org (Robert Richter)
Date: Wed, 27 May 2015 10:01:31 +0200
Subject: [PATCH v3 1/3] ahci: Move interrupt enablement code to separate
 functions
In-Reply-To: <1432713693-4282-1-git-send-email-rric@kernel.org>
References: <1432713693-4282-1-git-send-email-rric@kernel.org>
Message-ID: <1432713693-4282-2-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch refactors ahci_init_interrupts() and moves code to separate
functions for msi and intx. Needed since we add msix initialization in
a later patch. The initialization for msix is done after msi but
before intx.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/ata/ahci.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 33bb06e006c9..c8aedd836dc9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1201,17 +1201,17 @@ static inline void ahci_gtf_filter_workaround(struct ata_host *host)
 {}
 #endif
 
-static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
-				struct ahci_host_priv *hpriv)
+static int ahci_init_msi(struct pci_dev *pdev, unsigned int n_ports,
+			struct ahci_host_priv *hpriv)
 {
 	int rc, nvec;
 
 	if (hpriv->flags & AHCI_HFLAG_NO_MSI)
-		goto intx;
+		return -ENODEV;
 
 	nvec = pci_msi_vec_count(pdev);
 	if (nvec < 0)
-		goto intx;
+		return nvec;
 
 	/*
 	 * If number of MSIs is less than number of ports then Sharing Last
@@ -1224,8 +1224,8 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	rc = pci_enable_msi_exact(pdev, nvec);
 	if (rc == -ENOSPC)
 		goto single_msi;
-	else if (rc < 0)
-		goto intx;
+	if (rc < 0)
+		return rc;
 
 	/* fallback to single MSI mode if the controller enforced MRSM mode */
 	if (readl(hpriv->mmio + HOST_CTL) & HOST_MRSM) {
@@ -1240,15 +1240,33 @@ static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
 	return nvec;
 
 single_msi:
-	if (pci_enable_msi(pdev))
-		goto intx;
+	rc = pci_enable_msi(pdev);
+	if (rc < 0)
+		return rc;
+
 	return 1;
+}
 
-intx:
+static int ahci_init_intx(struct pci_dev *pdev, unsigned int n_ports,
+			struct ahci_host_priv *hpriv)
+{
 	pci_intx(pdev, 1);
+
 	return 0;
 }
 
+static int ahci_init_interrupts(struct pci_dev *pdev, unsigned int n_ports,
+				struct ahci_host_priv *hpriv)
+{
+	int nvec;
+
+	nvec = ahci_init_msi(pdev, n_ports, hpriv);
+	if (nvec >= 0)
+		return nvec;
+
+	return ahci_init_intx(pdev, n_ports, hpriv);
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
-- 
2.1.1
