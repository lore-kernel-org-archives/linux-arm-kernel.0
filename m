From: tn@semihalf.com (Tomasz Nowicki)
Date: Tue, 10 May 2016 17:19:57 +0200
Subject: [PATCH V7 07/11] pci, acpi: Handle ACPI companion assignment.
In-Reply-To: <1462893601-8937-1-git-send-email-tn@semihalf.com>
References: <1462893601-8937-1-git-send-email-tn@semihalf.com>
Message-ID: <1462893601-8937-8-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provides a way to set the ACPI companion in PCI code.
We define acpi_pci_set_companion() to set the ACPI companion pointer and
call it from PCI core code. The function is stub for now.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/pci/probe.c      | 2 ++
 include/linux/pci-acpi.h | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8004f67..fb0b752 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/cpumask.h>
+#include <linux/pci-acpi.h>
 #include <linux/pci-aspm.h>
 #include <linux/aer.h>
 #include <linux/acpi.h>
@@ -2141,6 +2142,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
 	bridge->dev.parent = parent;
 	bridge->dev.release = pci_release_host_bridge_dev;
 	dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b), bus);
+	acpi_pci_set_companion(bridge);
 	error = pcibios_root_bridge_prepare(bridge);
 	if (error) {
 		kfree(bridge);
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 09f9f02..1baa515 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -111,6 +111,10 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
+static inline void acpi_pci_set_companion(struct pci_host_bridge *bridge)
+{
+}
+
 static inline int acpi_pci_bus_domain_nr(struct pci_bus *bus)
 {
 	return 0;
-- 
1.9.1
