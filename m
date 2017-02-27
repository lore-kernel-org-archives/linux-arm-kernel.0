From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Feb 2017 15:14:12 +0000
Subject: [PATCH 01/20] PCI: remove __weak tag from pci_remap_iospace()
In-Reply-To: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
References: <20170227151436.18698-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170227151436.18698-2-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_remap_iospace() is marked as a weak symbol even though
no architecture is currently overriding it; given that its
implementation internals have already code paths that are
arch specific (ie PCI_IOBASE and ioremap_page_range() attributes)
there is no need to leave the weak symbol in the kernel since the
same functionality can be achieved by customizing per-arch the
corresponding functionality.

Remove the __weak symbol from pci_remap_iospace().

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7904d02..bd98674 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3363,7 +3363,7 @@ unsigned long __weak pci_address_to_pio(phys_addr_t address)
  *	Only architectures that have memory mapped IO functions defined
  *	(and the PCI_IOBASE value defined) should call this function.
  */
-int __weak pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
+int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 {
 #if defined(PCI_IOBASE) && defined(CONFIG_MMU)
 	unsigned long vaddr = (unsigned long)PCI_IOBASE + res->start;
-- 
2.10.0
