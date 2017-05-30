From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 May 2017 11:47:26 +0100
Subject: [PATCH v3 1/1] ARM64/PCI: Set root bus NUMA node on ACPI systems
In-Reply-To: <20170524172219.5689-2-lorenzo.pieralisi@arm.com>
References: <20170524172219.5689-1-lorenzo.pieralisi@arm.com>
 <20170524172219.5689-2-lorenzo.pieralisi@arm.com>
Message-ID: <20170530104725.GB32289@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 24, 2017 at 06:22:19PM +0100, Lorenzo Pieralisi wrote:
> PCI core requires the NUMA node for the struct pci_host_bridge.dev to
> be set by using the pcibus_to_node(struct pci_bus*) API, that on ARM64
> systems relies on the struct pci_host_bridge->bus.dev NUMA node.
> 
> The struct pci_host_bridge.dev NUMA node is then propagated through
> the PCI device hierarchy as PCI devices (and bridges) are enumerated
> under it.
> 
> Therefore, in order to set-up the PCI NUMA hierarchy appropriately, the
> struct pci_host_bridge->bus.dev NUMA node must be set before core
> code calls pcibus_to_node(struct pci_bus*) on it so that PCI core can
> retrieve the NUMA node for the struct pci_host_bridge.dev device and can
> propagate it through the PCI bus tree.
> 
> On ARM64 ACPI based systems the struct pci_host_bridge->bus.dev NUMA
> node can be set-up in pcibios_root_bridge_prepare() by parsing the root
> bridge ACPI device firmware binding.
> 
> Add code to the pcibios_root_bridge_prepare() that, when booting with
> ACPI, parse the root bridge ACPI device companion NUMA binding and set
> the corresponding struct pci_host_bridge->bus.dev NUMA node
> appropriately.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/kernel/pci.c | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, I'll queue this with Robert's tags.

Will
