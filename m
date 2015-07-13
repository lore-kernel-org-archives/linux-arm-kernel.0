From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 13 Jul 2015 16:14:24 +0700
Subject: [RFCv2 PATCH 8/8] pci: acpi: Bind GICv2m MSI frame to PCI host bridge
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1436778864-17645-9-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces pci_set_phb_acpi_msi_domain(), which looks for
GIC MSI frame and bind the corresponded GICv2m irq_domain to the
PCI host-bridge.

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/pci/pci-acpi.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c      |  2 ++
 include/linux/pci-acpi.h |  1 +
 3 files changed, 38 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 314a625..0da6b90 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -9,6 +9,7 @@
 
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/irqdomain.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
@@ -18,6 +19,10 @@
 #include <linux/pm_qos.h>
 #include "pci.h"
 
+#ifdef CONFIG_ARM_GIC_ACPI
+#include <linux/irqchip/arm-gic-acpi.h>
+#endif
+
 /*
  * The UUID is defined in the PCI Firmware Specification available here:
  * https://www.pcisig.com/members/downloads/pcifw_r3_1_13Dec10.pdf
@@ -681,6 +686,36 @@ static bool pci_acpi_bus_match(struct device *dev)
 	return dev_is_pci(dev);
 }
 
+#ifdef CONFIG_PCI_MSI
+void pci_set_phb_acpi_msi_domain(struct pci_bus *bus)
+{
+	int err;
+	struct irq_domain *d;
+	struct acpi_madt_generic_msi_frame *msi_frame;
+
+	/**
+	* Since ACPI 5.1 currently does not define
+	* a way to associate MSI frame ID to a device,
+	* we can only support single MSI frame (index 0)
+	* at the moment.
+	*/
+	err = acpi_get_msi_frame(0, &msi_frame);
+	if (err)
+		return;
+
+#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
+	d = irq_find_matching_host((struct device_node *)msi_frame,
+					DOMAIN_BUS_PCI_MSI);
+	if (!d) {
+		pr_debug("Fail to find domain for MSI\n");
+		return;
+	}
+
+	dev_set_msi_domain(&bus->dev, d);
+#endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
+}
+#endif /* CONFIG_PCI_MSI */
+
 static struct acpi_bus_type acpi_pci_bus = {
 	.name = "PCI",
 	.match = pci_acpi_bus_match,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f305b78..c93474f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/cpumask.h>
 #include <linux/pci-aspm.h>
+#include <linux/pci-acpi.h>
 #include <linux/acpi.h>
 #include <linux/property.h>
 #include <asm-generic/pci-bridge.h>
@@ -683,6 +684,7 @@ static void pci_set_bus_speed(struct pci_bus *bus)
 void __weak pcibios_set_host_bridge_msi_domain(struct pci_bus *bus)
 {
 	pci_set_phb_of_msi_domain(bus);
+	pci_set_phb_acpi_msi_domain(bus);
 }
 
 static void pci_set_bus_msi_domain(struct pci_bus *bus)
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index a76cb6f..96a19c7 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -99,6 +99,7 @@ static inline void acpiphp_enumerate_slots(struct pci_bus *bus) { }
 static inline void acpiphp_remove_slots(struct pci_bus *bus) { }
 static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 #endif
+void pci_set_phb_acpi_msi_domain(struct pci_bus *bus);
 
 extern const u8 pci_acpi_dsm_uuid[];
 #define DEVICE_LABEL_DSM	0x07
-- 
2.1.0
