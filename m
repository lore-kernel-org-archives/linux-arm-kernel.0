From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 10 Jul 2015 14:34:58 +0100
Subject: [PATCH v3 00/15] Introducing per-device MSI domain
In-Reply-To: <559E8699.4010007@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
 <20150709135809.GA5223@red-moon> <559E8699.4010007@arm.com>
Message-ID: <20150710133458.GC11270@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 03:35:05PM +0100, Marc Zyngier wrote:

[...]

> > BTW, is there a reason why _all_ arm host bridges rely on
> > pcibios_msi_controller (so pci_sys_data) instead of initializing
> > the struct pci_bus.msi pointer to carry out the MSI controller look-up ?
> 
> Probably an ordering issue - the bus may not be there yet. But ensuring
> that the MSI domain is created early (before the bus is scanned) should
> solve that problem nicely enough.

Yes, I think the only reason is that, as sysdata, the msi controller
pointer is propagated (in pci_alloc_child_bus()), with a tiny difference:
sysdata can be passed to pci_scan_root_bus(), msi controller pointer
can't (explicitly) at present.

Since most of the ARM PCI host controllers have been converted to:

- pci_create_root_bus()

-> here we can init bus msi controller pointer

- pci_scan_child_bus()

we could get rid of pcibios_msi_controller on arm _now_ by just initializing
the msi controller pointer in the struct pci_bus before
pci_scan_child_bus() is called, unless I am missing something.

I converted pcie-designware.c to stacked domains (and pci-keystone that
relies on it, with its own quirks of course), I might take the step
above as an intermediate step to have a common arm/arm64 generic host
controller asap (ie for that getting rid of pcibios_msi_controller is
mandatory, which requires converting all ARM host controllers to stacked
domains, or taking the intermediate step above).

Thanks,
Lorenzo
