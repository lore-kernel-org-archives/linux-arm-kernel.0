From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 24 May 2017 18:22:18 +0100
Subject: [PATCH v3 0/1] ARM64/PCI: ACPI NUMA node set-up
Message-ID: <20170524172219.5689-1-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is v3 of a previous posting:

v2 -> v3

- Dropped generic approach
  # It was not consistent between ACPI and DT and not reusable on x86/IA64
- Trimmed the series to one patch ARM64 specific, three-line patch fixes
  the issue
- Rebased against v4.12-rc2
- Dropped RFC/RFT tag

v2: https://lkml.org/lkml/2017/5/15/433

v1 -> v2:

- Added missing call to acpi_pci_bus_find_numa_node()
- Rebased against v4.12-rc1

v1: https://lkml.org/lkml/2017/4/26/211

--- Original Cover Letter --

On the ARM64 architecture, the arch specific PCI pcibus_to_node() callback
can be triggered on struct pci_bus.sysdata structures that carry host
bridge specific data through different structures layout (ie sysdata
pointer points at different structs for different host bridges), therefore
it is not possible to have a unified pcibus_to_node() implementation.

Given that the device NUMA node is a property of the struct pci_bus (and
its associated struct device), move the struct pci_bus node assignment to
generic PCI code, where according to the platform firmware the NUMA node
for the device backing the struct pci_bus is retrieved and propagated
through the PCI bus hierarchy.

Lorenzo Pieralisi (1):
  ARM64/PCI: Set root bus NUMA node on ACPI systems

 arch/arm64/kernel/pci.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.10.0
