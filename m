From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 19 Dec 2017 00:37:41 -0500
Subject: [PATCH V4 05/26] agp: nvidia: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1513661883-28662-6-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Getting ready to remove pci_get_bus_and_slot() function in favor of
pci_get_domain_bus_and_slot().

Replace pci_get_bus_and_slot() with pci_get_domain_bus_and_slot()
and extract the domain number from struct pci_dev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/char/agp/nvidia-agp.c | 12 +++++++++---
 drivers/char/agp/sworks-agp.c |  3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
index 828b344..623205b 100644
--- a/drivers/char/agp/nvidia-agp.c
+++ b/drivers/char/agp/nvidia-agp.c
@@ -340,11 +340,17 @@ static int agp_nvidia_probe(struct pci_dev *pdev,
 	u8 cap_ptr;
 
 	nvidia_private.dev_1 =
-		pci_get_bus_and_slot((unsigned int)pdev->bus->number, PCI_DEVFN(0, 1));
+		pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					    (unsigned int)pdev->bus->number,
+					    PCI_DEVFN(0, 1));
 	nvidia_private.dev_2 =
-		pci_get_bus_and_slot((unsigned int)pdev->bus->number, PCI_DEVFN(0, 2));
+		pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					    (unsigned int)pdev->bus->number,
+					    PCI_DEVFN(0, 2));
 	nvidia_private.dev_3 =
-		pci_get_bus_and_slot((unsigned int)pdev->bus->number, PCI_DEVFN(30, 0));
+		pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					    (unsigned int)pdev->bus->number,
+					    PCI_DEVFN(30, 0));
 
 	if (!nvidia_private.dev_1 || !nvidia_private.dev_2 || !nvidia_private.dev_3) {
 		printk(KERN_INFO PFX "Detected an NVIDIA nForce/nForce2 "
diff --git a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
index 03be4ac..4dbdd3b 100644
--- a/drivers/char/agp/sworks-agp.c
+++ b/drivers/char/agp/sworks-agp.c
@@ -474,7 +474,8 @@ static int agp_serverworks_probe(struct pci_dev *pdev,
 	}
 
 	/* Everything is on func 1 here so we are hardcoding function one */
-	bridge_dev = pci_get_bus_and_slot((unsigned int)pdev->bus->number,
+	bridge_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+			(unsigned int)pdev->bus->number,
 			PCI_DEVFN(0, 1));
 	if (!bridge_dev) {
 		dev_info(&pdev->dev, "can't find secondary device\n");
-- 
1.9.1
