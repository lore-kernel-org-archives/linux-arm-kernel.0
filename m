From: roger.pau@citrix.com (Roger Pau =?iso-8859-1?Q?Monn=E9?=)
Date: Thu, 19 Jan 2017 15:41:29 +0000
Subject: [Xen-devel] [RFC] Device memory mappings for Dom0 on ARM64 ACPI
 systems
In-Reply-To: <20c89f12-cb0c-1145-99d0-320b2080b503@arm.com>
References: <alpine.DEB.2.10.1701171309040.2347@sstabellini-ThinkPad-X260>
 <20170118110243.ctqpperggim5k7dw@dhcp-3-221.uk.xensource.com>
 <alpine.DEB.2.10.1701181058110.10192@sstabellini-ThinkPad-X260>
 <20c89f12-cb0c-1145-99d0-320b2080b503@arm.com>
Message-ID: <20170119154129.7dnjzvq23jop7oye@dhcp-3-221.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 07:13:23PM +0000, Julien Grall wrote:
> Hi,
> 
> On 18/01/17 19:05, Stefano Stabellini wrote:
> > On Wed, 18 Jan 2017, Roger Pau Monn? wrote:
> > > On Tue, Jan 17, 2017 at 02:20:54PM -0800, Stefano Stabellini wrote:
> > > > a) One option is to provide a Xen specific implementation of
> > > > acpi_os_ioremap in Linux. I think this is the cleanest approach, but
> > > > unfortunately, it doesn't cover cases where ioremap is used directly. (2)
> > > > is one of such cases, see
> > > > arch/arm64/kernel/pci.c:pci_acpi_setup_ecam_mapping and
> > > > drivers/pci/ecam.c:pci_ecam_create. (3) is another one of these cases,
> > > > see drivers/acpi/apei/bert.c:bert_init.
> > > 
> > > This is basically the same as b) from Xen's PoV, the only difference is where
> > > you would call the hypercall from Dom0 to establish stage-2 mappings.
> > 
> > Right, but it is important from the Linux point of view, this is why I
> > am asking the Linux maintainers.
> > 
> > 
> > > > b) Otherwise, we could write an alternative implementation of ioremap
> > > > on arm64. The Xen specific ioremap would request a stage-2 mapping
> > > > first, then create the stage-1 mapping as usual. However, this means
> > > > issuing an hypercall for every ioremap call.
> > > 
> > > This seems fine to me, and at present is the only way to get something working.
> > > As you said not being able to discover OperationRegions from Xen means that
> > > there's a chance some MMIO might not be added to the stage-2 mappings.
> > > 
> > > Then what's the initial memory map state when Dom0 is booted? There are no MMIO
> > > mappings at all, and Dom0 must request mappings for everything?
> > 
> > Yes
> 
> To give more context here, the UEFI memory map does not report all the MMIO
> regions. So there is no possibility to map MMIO at boot.

I've been able to get a Dom0 booting on x86 by mapping all the regions marked
as ACPI in the memory map, plus the BARs of PCI devices and the MCFG areas. But
this is not really optimal, since as Stefano says:

 1. If there are new tables that contain memory regions that should be mapped to
   Dom0, Xen will need to be updated in order to work on those systems.
 2. ATM it's not possible for Xen to know all the OperationRegions described in
   the ACPI DSDT/SSDT tables.

I'm not that worried about 1, since the user will also need a newish Dom0
kernel in order to access those devices, and it doesn't seem like new ACPI
tables appear out of the blue everyday. It however puts more pressure on Xen in
order to aggressively track ACPI changes.

In order to fix 2 an AML parser would need to be added to Xen.

> > 
> > 
> > > What happens to ACPI tables crafted for Dom0 that reside in RAM? That would
> > > apply to the STAO and to the other tables that are crafted for Dom0 at build
> > > time. Should Dom0 also request stage-2 mappings for them, and Xen simply ignore
> > > those calls?
> > 
> > The ACPI (and UEFI) tables are mapped by Xen
> 
> I think Royger's point is DOM0 cannot tell whether a region has been mapped
> by Xen or not.
> 
> The function ioremap will be used to map anything (it is the leaf of all
> mapping functions), and will call Xen no matter the address passed. It could
> be a RAM region, HW device region, emulated device region.

Exactly, from a guest OS PoV it would request those mappings for all device
memory regions. But from Xen's perspective, those request might be made against
at least 3 different types of p2m regions:

 - Regions trapped by emulated devices inside of Xen: no direct MMIO mapping
   should be established in this case.
 - RAM regions that belong to Xen-crafted ACPI tables (STAO, MADT...).
 - Real MMIO regions that should be passed through.

Right now AFAIK Xen doesn't track any of this information, so we would need
additional non-trivial logic in order to account for all this inside the
hypervisor.

Roger.
