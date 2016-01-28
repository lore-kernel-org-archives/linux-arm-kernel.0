From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 28 Jan 2016 14:51:39 -0700
Subject: [PATCH 00/10] KVM PCIe/MSI passthrough on ARM/ARM64
In-Reply-To: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
Message-ID: <1454017899.23148.0.camel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-26 at 13:12 +0000, Eric Auger wrote:
> This series addresses KVM PCIe passthrough with MSI enabled on ARM/ARM64.
> It pursues the efforts done on [1], [2], [3]. It also aims at covering the
> same need on some PowerPC platforms.
>?
> On x86 all accesses to the 1MB PA region [FEE0_0000h - FEF0_000h] are directed
> as interrupt messages: accesses to this special PA window directly target the
> APIC configuration space and not DRAM, meaning the downstream IOMMU is bypassed.
>?
> This is not the case on above mentionned platforms where MSI messages emitted
> by devices are conveyed through the IOMMU. This means an IOVA/host PA mapping
> must exist for the MSI to reach the MSI controller. Normal way to create
> IOVA bindings consists in using VFIO DMA MAP API. However in this case
> the MSI IOVA is not mapped onto guest RAM but on host physical page (the MSI
> controller frame).
>?
> Following first comments, the spirit of [2] is kept: the guest registers
> an IOVA range reserved for MSI mapping. When the VFIO-PCIe driver allocates
> its MSI vectors, it overwrites the MSI controller physical address with an IOVA,
> allocated within the window provided by the userspace. This IOVA is mapped
> onto the MSI controller frame physical page.
>?
> The series does not address yet the problematic of telling the userspace how
> much IOVA he should provision.

I'm sort of on a think-different approach today, so bear with me; how is
it that x86 can make interrupt remapping so transparent to drivers like
vfio-pci while for ARM and ppc we seem to be stuck with doing these
fixups of the physical vector ourselves, implying ugly (no offense)
paths bouncing through vfio to connect the driver and iommu backends?

We know that x86 handles MSI vectors specially, so there is some
hardware that helps the situation.??It's not just that x86 has a fixed
range for MSI, it's how it manages that range when interrupt remapping
hardware is enabled.??A device table indexed by source-ID references a
per device table indexed by data from the MSI write itself.??So we get
much, much finer granularity, but there's still effectively an interrupt
domain per device that's being transparently managed under the covers
whenever we request an MSI vector for a device.

So why can't we do something more like that here???There's no predefined
MSI vector range, so defining an interface for the user to specify that
is unavoidable.??But why shouldn't everything else be transparent???We
could add an interface to the IOMMU API that allows us to register that
reserved range for the IOMMU domain.??IOMMU-core (or maybe interrupt
remapping) code might allocate an IOVA domain for this just as you've
done in the type1 code here.??But rather than having any interaction
with vfio-pci, why not do this at lower levels such that the platform
interrupt vector allocation code automatically uses one of those IOVA
ranges and returns the IOVA rather than the physical address for the PCI
code to program into the device???I think we know what needs to be done,
but we're taking the approach of managing the space ourselves and doing
a fixup of the device after the core code has done its job when we
really ought to be letting the core code manage a space that we define
and programming the device so that it doesn't need a fixup in the
vfio-pci code.??Wouldn't it be nicer if pci_enable_msix_range() returned
with the device properly programmed or generate an error if there's not
enough reserved mapping space in IOMMU domain?  Can it be done???Thanks,

Alex
