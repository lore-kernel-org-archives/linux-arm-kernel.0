From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 16 Dec 2015 16:16:21 +0100
Subject: [PATCH V2 11/23] arm64,
 pci: Remove useless boot time IRQ assignment when booting with DT.
In-Reply-To: <1450278993-12664-1-git-send-email-tn@semihalf.com>
References: <1450278993-12664-1-git-send-email-tn@semihalf.com>
Message-ID: <1450278993-12664-12-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to probe PCIe host controller when booting with DT,
ARM64 is using drivers which defer IRQ assignment to device
enable time. It means that boot time DT specific irq map initialization
is always overridden, so lets remove that code.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 023b983..f7948f5 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -51,16 +51,6 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 	return pci_enable_resources(dev, mask);
 }
 
-/*
- * Try to assign the IRQ number from DT when adding a new device
- */
-int pcibios_add_device(struct pci_dev *dev)
-{
-	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
-
-	return 0;
-}
-
 #ifdef CONFIG_ACPI
 /* Root bridge scanning */
 struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-- 
1.9.1
