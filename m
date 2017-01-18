From: sstabellini@kernel.org (Stefano Stabellini)
Date: Wed, 18 Jan 2017 11:05:39 -0800 (PST)
Subject: [Xen-devel] [RFC] Device memory mappings for Dom0 on ARM64 ACPI
 systems
In-Reply-To: <20170118110243.ctqpperggim5k7dw@dhcp-3-221.uk.xensource.com>
References: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
 <20170118110243.ctqpperggim5k7dw@dhcp-3-221.uk.xensource.com>
Message-ID: <alpine.DEB.2.10.1701181058110.10192@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Jan 2017, Roger Pau Monn? wrote:
> On Tue, Jan 17, 2017 at 02:20:54PM -0800, Stefano Stabellini wrote:
> > a) One option is to provide a Xen specific implementation of
> > acpi_os_ioremap in Linux. I think this is the cleanest approach, but
> > unfortunately, it doesn't cover cases where ioremap is used directly. (2)
> > is one of such cases, see
> > arch/arm64/kernel/pci.c:pci_acpi_setup_ecam_mapping and
> > drivers/pci/ecam.c:pci_ecam_create. (3) is another one of these cases,
> > see drivers/acpi/apei/bert.c:bert_init.
> 
> This is basically the same as b) from Xen's PoV, the only difference is where
> you would call the hypercall from Dom0 to establish stage-2 mappings.

Right, but it is important from the Linux point of view, this is why I
am asking the Linux maintainers.


> > b) Otherwise, we could write an alternative implementation of ioremap
> > on arm64. The Xen specific ioremap would request a stage-2 mapping
> > first, then create the stage-1 mapping as usual. However, this means
> > issuing an hypercall for every ioremap call.
> 
> This seems fine to me, and at present is the only way to get something working.
> As you said not being able to discover OperationRegions from Xen means that
> there's a chance some MMIO might not be added to the stage-2 mappings.
> 
> Then what's the initial memory map state when Dom0 is booted? There are no MMIO
> mappings at all, and Dom0 must request mappings for everything?

Yes


> What happens to ACPI tables crafted for Dom0 that reside in RAM? That would
> apply to the STAO and to the other tables that are crafted for Dom0 at build
> time. Should Dom0 also request stage-2 mappings for them, and Xen simply ignore
> those calls?

The ACPI (and UEFI) tables are mapped by Xen


> > c) Finally, a third option is to create the stage-2 mappings seamlessly
> > in Xen upon Dom0 memory faults. Keeping in mind that SMMU and guest
> > pagetables are shared in the Xen hypervisor, this approach does not work
> > if one of the pages that need a stage-2 mapping is used as DMA target
> > before Dom0 accesses it. No SMMU mappings would be available for the
> > page yet, so the DMA transaction would fail. After Dom0 touches the
> > page, the DMA transaction would succeed. I don't know how likely is this
> > scenario to happen, but it seems fragile to rely on it.
> 
> Don't you get faults on SMMU failures? But I guess those are not synchronous,
> so there's no way you can add mappings on fault, like you can for processor
> accesses.

Right
