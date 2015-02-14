From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Sat, 14 Feb 2015 19:45:52 +0000
Subject: [PATCH v2 00/30] Refine PCI scan interfaces and make generic pci
 host bridge
In-Reply-To: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
References: <1421800225-26230-1-git-send-email-wangyijing@huawei.com>
Message-ID: <20150214194552.GA3932@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yijing,

On Wed, Jan 21, 2015 at 12:29:55AM +0000, Yijing Wang wrote:
> v1->v2:
> 	Split pci_host_bridge_list into a new patch, remove .phb_probe_mode
> 	and rework powerpc .phb_of_scan_bus() for simpilicty suggested by
> 	Arnd. Refresh some patch description log, and add a new patch to fix
> 	build warning in ia64.
> 
> This series is based on Bjorn's pci-next branch.
> 
> Patch 1-4 ripped out pci_bus_add_devices() from pci scan interfaces
> for better pci scan flow.
> 
> Patch 5-11 make a generic pci_host_bridge to hold pci_host_bridge
> related informations, and introduce a pci_host_bridge_ops to 
> support platform host drivers provide its own pci_host_bridge 
> related operations to setup pci_host_bridge during pci enumeration.
> 
> Patch 12-28 apply the new pci scan interfaces to platform pci host
> bridge drivers.
> 
> Now in kernel, we scan pci bus use the following ways:
> 1. pci_scan_bus. 
> 	parent = NULL, default io/mem/bus resources
> 	call pci_bus_add_devices()
> 
> 2. pci_scan_bus_parented() + pci_bus_add_devices()
> 	default io/mem/bus resources, only used by xen
> 
> 3. pci_scan_root_bus() + pci_bus_add_devices()
> 
> 4. pci_create_root_bus() + pci_scan_child_bus() + pci_bus_add_devices()
> 
> 5. pci_create_root_bus() + xx_of_scan_bus()  +  pci_bus_add_devices()
> 
> And we have a lot of arch specific pci_domain_nr() and other platform
> specific weak function like pcibios_root_bridge_prepare().
> 
> After applied this series, we have following scan interfaces:
> 
> 1. pci_scan_bus_legacy() 
> 	parent = NULL, default io/mem/bus resources.
> 	for legacy pci scan
> 
> 2. pci_scan_root_bus()
> 	for callers provide its own parent and io/mem/bus resources
> 	but no platform specific pci_host_bridge operations
> 
> 3. pci_scan_root_bridge()
> 	for callers provide its own parent and io/mem/bus resources
> 	and pci_host_bridge_ops.
> 
> Besides, above pci scan interfaces all need addtionally call pci_bus_add_devices()
> to set match_driver true and try to attach drivers.
> 
> Also we could eliminate all arch specific pci_domain_nr() after applied this series.
> 
> I tested this series on x86 (with or without ACPI).
> Comments and tests are warmly welcome!

Can you push a public branch out rebased against mainline for us to pull
and test please ?

Thanks !
Lorenzo
