From: bharat.bhushan@nxp.com (Bharat Bhushan)
Date: Tue, 20 Dec 2016 04:45:57 +0000
Subject: [RFC v4 00/16] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
In-Reply-To: <1481661034-3088-1-git-send-email-eric.auger@redhat.com>
References: <1481661034-3088-1-git-send-email-eric.auger@redhat.com>
Message-ID: <AM5PR0401MB254576C4F2C2DA54368144E39A900@AM5PR0401MB2545.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Tested this series on NXP ARMv8 platform.

Thanks
-Bharat

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger at redhat.com]
> Sent: Wednesday, December 14, 2016 2:00 AM
> To: eric.auger at redhat.com; eric.auger.pro at gmail.com;
> christoffer.dall at linaro.org; marc.zyngier at arm.com;
> robin.murphy at arm.com; alex.williamson at redhat.com;
> will.deacon at arm.com; joro at 8bytes.org; tglx at linutronix.de;
> jason at lakedaemon.net; linux-arm-kernel at lists.infradead.org
> Cc: kvm at vger.kernel.org; drjones at redhat.com; linux-
> kernel at vger.kernel.org; pranav.sawargaonkar at gmail.com;
> iommu at lists.linux-foundation.org; punit.agrawal at arm.com; Diana Madalina
> Craciun <diana.craciun@nxp.com>; gpkulkarni at gmail.com;
> shankerd at codeaurora.org; Bharat Bhushan <bharat.bhushan@nxp.com>
> Subject: [RFC v4 00/16] KVM PCIe/MSI passthrough on ARM/ARM64 and
> IOVA reserved regions
> 
> Following LPC discussions, we now report reserved regions through iommu-
> group sysfs reserved_regions attribute file.
> 
> Reserved regions are populated through the IOMMU get_resv_region
> callback (former get_dm_regions), now implemented by amd-iommu, intel-
> iommu and arm-smmu:
> - the amd-iommu reports device direct mapped regions.
> - the intel-iommu reports the [0xfee00000 - 0xfeefffff] MSI window
>   as an IOMMU_RESV_NOMAP reserved region.
> - the arm-smmu reports the MSI window (arbitrarily located at
>   0x8000000 and 1MB large).
> 
> Unsafe interrupt assignment is tested by enumerating all MSI irq domains
> and checking they support MSI remapping. This check is done in case we
> detect the iommu translates MSI (an IOMMU_RESV_MSI window exists).
> Otherwise the IRQ remapping capability is checked at IOMMU level.
> Obviously this is a defensive IRQ safety assessment.
> Assuming there are several MSI controllers in the system and at least one
> does not implement IRQ remapping, the assignment will be considered as
> unsafe (even if this controller is not acessible from the assigned devices).
> 
> The series integrates a not officially posted patch from Robin:
> "iommu/dma: Allow MSI-only cookies".
> 
> Best Regards
> 
> Eric
> 
> Git: complete series available at
> https://github.com/eauger/linux/tree/v4.9-reserved-v4
> 
> History:
> 
> RFCv3 -> RFCv4:
> - arm-smmu driver does not register PCI host bridge windows as
>   reserved regions anymore
> - Implement reserved region get/put callbacks also in arm-smmuv3
> - take the iommu_group lock on iommu_get_group_resv_regions
> - add a type field in iommu_resv_region instead of using prot
> - init the region list_head in iommu_alloc_resv_region, also
>   add type parameter
> - iommu_insert_resv_region manage overlaps and sort reserved
>   windows
> - address IRQ safety assessment by enumerating all the MSI irq
>   domains and checking the MSI_REMAP flag
> - update Documentation/ABI/testing/sysfs-kernel-iommu_groups
> - Did not add T-b since the code has significantly changed
> 
> RFCv2 -> RFCv3:
> - switch to an iommu-group sysfs API
> - use new dummy allocator provided by Robin
> - dummy allocator initialized by vfio-iommu-type1 after enumerating
>   the reserved regions
> - at the moment ARM MSI base address/size is left unchanged compared
>   to v2
> - we currently report reserved regions and not usable IOVA regions as
>   requested by Alex
> 
> RFC v1 -> v2:
> - fix intel_add_reserved_regions
> - add mutex lock/unlock in vfio_iommu_type1
> 
> 
> Eric Auger (16):
>   iommu/dma: Allow MSI-only cookies
>   iommu: Rename iommu_dm_regions into iommu_resv_regions
>   iommu: Add a new type field in iommu_resv_region
>   iommu: iommu_alloc_resv_region
>   iommu: Only map direct mapped regions
>   iommu: iommu_get_group_resv_regions
>   iommu: Implement reserved_regions iommu-group sysfs file
>   iommu/vt-d: Implement reserved region get/put callbacks
>   iommu/arm-smmu: Implement reserved region get/put callbacks
>   iommu/arm-smmu-v3: Implement reserved region get/put callbacks
>   irqdomain: Add IRQ_DOMAIN_FLAG_MSI_REMAP value
>   irqdomain: irq_domain_check_msi_remap
>   irqchip/gicv3-its: Sets IRQ_DOMAIN_FLAG_MSI_REMAP
>   vfio/type1: Allow transparent MSI IOVA allocation
>   vfio/type1: Check MSI remapping at irq domain level
>   iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP anymore
> 
>  .../ABI/testing/sysfs-kernel-iommu_groups          |   9 ++
>  drivers/iommu/amd_iommu.c                          |  21 +--
>  drivers/iommu/arm-smmu-v3.c                        |  30 +++-
>  drivers/iommu/arm-smmu.c                           |  30 +++-
>  drivers/iommu/dma-iommu.c                          | 116 +++++++++++++---
>  drivers/iommu/intel-iommu.c                        |  50 +++++--
>  drivers/iommu/iommu.c                              | 152 +++++++++++++++++++--
>  drivers/irqchip/irq-gic-v3-its.c                   |   1 +
>  drivers/vfio/vfio_iommu_type1.c                    |  37 ++++-
>  include/linux/dma-iommu.h                          |   7 +
>  include/linux/iommu.h                              |  46 +++++--
>  include/linux/irqdomain.h                          |   8 ++
>  kernel/irq/irqdomain.c                             |  24 ++++
>  13 files changed, 455 insertions(+), 76 deletions(-)
> 
> --
> 1.9.1
