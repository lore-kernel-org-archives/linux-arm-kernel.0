From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Oct 2016 18:32:24 +0100
Subject: [PATCH v14 00/16] KVM PCIe/MSI passthrough on ARM/ARM64
In-Reply-To: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
References: <1476278544-3397-1-git-send-email-eric.auger@redhat.com>
Message-ID: <20161020173224.GA32544@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Thanks for posting this.

On Wed, Oct 12, 2016 at 01:22:08PM +0000, Eric Auger wrote:
> This is the second respin on top of Robin's series [1], addressing Alex' comments.
> 
> Major changes are:
> - MSI-doorbell API now is moved to DMA IOMMU API following Alex suggestion
>   to put all API pieces at the same place (so eventually in the IOMMU
>   subsystem)
> - new iommu_domain_msi_resv struct and accessor through DOMAIN_ATTR_MSI_RESV
>   domain with mirror VFIO capability
> - more robustness I think in the VFIO layer
> - added "iommu/iova: fix __alloc_and_insert_iova_range" since with the current
>   code I failed allocating an IOVA page in a single page domain with upper part
>   reserved
> 
> IOVA range exclusion will be handled in a separate series
> 
> The priority really is to discuss and freeze the API and especially the MSI
> doorbell's handling. Do we agree to put that in DMA IOMMU?
> 
> Note: the size computation does not take into account possible page overlaps
> between doorbells but it would add quite a lot of complexity i think.
> 
> Tested on AMD Overdrive (single GICv2m frame) with I350 VF assignment.

Marc, Robin and I sat down and had a look at the series and, whilst it's
certainly addressing a problem that we desperately want to see fixed, we
think that it's slightly over-engineering in places and could probably
be simplified in the interest of getting something upstream that can be
used as a base, on which the ABI can be extended as concrete use-cases
become clear.

Stepping back a minute, we're trying to reserve some of the VFIO virtual
address space so that it can be used by devices to map their MSI doorbells
using the SMMU. With your patches, this requires that (a) the kernel
tells userspace about the size and alignment of the doorbell region
(MSI_RESV) and (b) userspace tells the kernel the VA-range that can be
used (RESERVED_MSI_IOVA).

However, this is all special-cased for MSI doorbells and there are
potentially other regions of the VFIO address space that are reserved
and need to be communicated to userspace as well. We already know of
hardware where the PCI RC intercepts p2p accesses before they make it
to the SMMU, and other hardware where the MSI doorbell is at a fixed
address. This means that we need a mechanism to communicate *fixed*
regions of virtual address space that are reserved by VFIO. I don't
even particularly care if VFIO_MAP_DMA enforces that, but we do need
a way to tell userspace "hey, you don't want to put memory here because
it won't work well with devices".

In that case, we end up with something like your MSI_RESV capability,
but actually specifying a virtual address range that is simply not to
be used by MAP_DMA -- we don't say anything about MSIs. Now, taking this
to its logical conclusion, we no longer need to distinguish between
remappable reserved regions and fixed reserved regions in the ABI.
Instead, we can have the kernel allocate the virtual address space for
the remappable reserved regions (probably somewhere in the bottom 4GB)
and expose them via the capability. This simplifies things in the
following ways:

  * You don't need to keep track of MSI vs DMA addresses in the VFIO rbtree
  * You don't need to try collapsing doorbells into a single region
  * You don't need a special MAP flavour to map MSI doorbells
  * The ABI is reusable for PCI p2p and fixed doorbells

I really think it would make your patch series both generally useful and
an awful lot smaller, whilst leaving the door open to ABI extension on
a case-by-case basis when we determine that it's really needed.

Thoughts?

Will
