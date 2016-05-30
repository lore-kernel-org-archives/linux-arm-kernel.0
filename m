From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 30 May 2016 17:14:21 +0200
Subject: [PATCH V8 8/9] arm64, pci,
 acpi: Provide ACPI-specific prerequisites for PCI bus enumeration.
In-Reply-To: <1464621262-26770-1-git-send-email-tn@semihalf.com>
References: <1464621262-26770-1-git-send-email-tn@semihalf.com>
Message-ID: <1464621262-26770-9-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI requires to run acpi_pci_{add|remove}_bus while new PCI bus is created.
This allows to do some ACPI-specific additional configuration, like
PCI hotplug slot enumeration. In order to fulfill these requirements,
we implement arch-specific pcibios_{add|remove}_bus calls
and call acpi_pci_{add|remove}_bus from there.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 arch/arm64/kernel/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 336deef..3663be1 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -17,6 +17,7 @@
 #include <linux/mm.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
+#include <linux/pci-acpi.h>
 #include <linux/slab.h>
 
 /*
@@ -96,4 +97,15 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	/* TODO: Should be revisited when implementing PCI on ACPI */
 	return NULL;
 }
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	acpi_pci_remove_bus(bus);
+}
+
 #endif
-- 
1.9.1
