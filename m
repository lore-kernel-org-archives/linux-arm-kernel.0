From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 28 May 2014 13:14:53 -0400
Subject: [PATCH v1] ARM: pci: add call to pcie_bus_configure_settings()
Message-ID: <1401297293-3950-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call pcie_bus_configure_settings on ARM, like for other platforms.
pcie_bus_configure_settings makes sure the MPS across the bus is
uniform and provides the ability to tune the MRSS and MPS to higher
performance values. This is particularly important for embedded where
there is no firmware to program these PCI-E settings for the OS.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

CC: Russell King <linux@arm.linux.org.uk>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 - Fixed comments against initial version
 arch/arm/kernel/bios32.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 16d43cd..17a26c1 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -545,6 +545,18 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
 		 */
 		pci_bus_add_devices(bus);
 	}
+
+	list_for_each_entry(sys, &head, node) {
+		struct pci_bus *bus = sys->bus;
+
+		/* Configure PCI Express settings */
+		if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
+			struct pci_bus *child;
+
+			list_for_each_entry(child, &bus->children, node)
+				pcie_bus_configure_settings(child);
+		}
+	}
 }
 
 #ifndef CONFIG_PCI_HOST_ITE8152
-- 
1.7.9.5
