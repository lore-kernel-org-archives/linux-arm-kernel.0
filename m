From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 May 2017 18:22:19 +0100
Subject: [PATCH v3 1/1] ARM64/PCI: Set root bus NUMA node on ACPI systems
In-Reply-To: <20170524172219.5689-1-lorenzo.pieralisi@arm.com>
References: <20170524172219.5689-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170524172219.5689-2-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCI core requires the NUMA node for the struct pci_host_bridge.dev to
be set by using the pcibus_to_node(struct pci_bus*) API, that on ARM64
systems relies on the struct pci_host_bridge->bus.dev NUMA node.

The struct pci_host_bridge.dev NUMA node is then propagated through
the PCI device hierarchy as PCI devices (and bridges) are enumerated
under it.

Therefore, in order to set-up the PCI NUMA hierarchy appropriately, the
struct pci_host_bridge->bus.dev NUMA node must be set before core
code calls pcibus_to_node(struct pci_bus*) on it so that PCI core can
retrieve the NUMA node for the struct pci_host_bridge.dev device and can
propagate it through the PCI bus tree.

On ARM64 ACPI based systems the struct pci_host_bridge->bus.dev NUMA
node can be set-up in pcibios_root_bridge_prepare() by parsing the root
bridge ACPI device firmware binding.

Add code to the pcibios_root_bridge_prepare() that, when booting with
ACPI, parse the root bridge ACPI device companion NUMA binding and set
the corresponding struct pci_host_bridge->bus.dev NUMA node
appropriately.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4f0e3eb..1082834 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -108,7 +108,10 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
 	if (!acpi_disabled) {
 		struct pci_config_window *cfg = bridge->bus->sysdata;
 		struct acpi_device *adev = to_acpi_device(cfg->parent);
+		struct device *bus_dev = &bridge->bus->dev;
+
 		ACPI_COMPANION_SET(&bridge->dev, adev);
+		set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
 	}
 
 	return 0;
-- 
2.10.0
