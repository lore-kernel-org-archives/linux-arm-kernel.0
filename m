From: bharat.bhushan@nxp.com (Bharat Bhushan)
Date: Fri, 18 Nov 2016 05:34:37 +0000
Subject: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and IOVA
 reserved regions
In-Reply-To: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
Message-ID: <HE1PR0401MB2556607F41972B84F8A48E869AB00@HE1PR0401MB2556.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Have you sent out QEMU side patches based on this new approach? In case I missed please point me the patches? 

Thanks
-Bharat

> -----Original Message-----
> From: iommu-bounces at lists.linux-foundation.org [mailto:iommu-
> bounces at lists.linux-foundation.org] On Behalf Of Eric Auger
> Sent: Tuesday, November 15, 2016 6:39 PM
> To: eric.auger at redhat.com; eric.auger.pro at gmail.com;
> christoffer.dall at linaro.org; marc.zyngier at arm.com;
> robin.murphy at arm.com; alex.williamson at redhat.com;
> will.deacon at arm.com; joro at 8bytes.org; tglx at linutronix.de;
> jason at lakedaemon.net; linux-arm-kernel at lists.infradead.org
> Cc: drjones at redhat.com; kvm at vger.kernel.org; punit.agrawal at arm.com;
> linux-kernel at vger.kernel.org; iommu at lists.linux-foundation.org;
> pranav.sawargaonkar at gmail.com
> Subject: [RFC v3 00/10] KVM PCIe/MSI passthrough on ARM/ARM64 and
> IOVA reserved regions
> 
> Following LPC discussions, we now report reserved regions through iommu-
> group sysfs reserved_regions attribute file.
> 
> Reserved regions are populated through the IOMMU get_resv_region
> callback (former get_dm_regions), now implemented by amd-iommu, intel-
> iommu and arm-smmu.
> 
> The intel-iommu reports the [FEE0_0000h - FEF0_000h] MSI window as an
> IOMMU_RESV_NOMAP reserved region.
> 
> arm-smmu reports the MSI window (arbitrarily located at 0x8000000 and 1MB
> large) and the PCI host bridge windows.
> 
> The series integrates a not officially posted patch from Robin:
> "iommu/dma: Allow MSI-only cookies".
> 
> This series currently does not address IRQ safety assessment.
> 
> Best Regards
> 
> Eric
> 
> Git: complete series available at
> https://github.com/eauger/linux/tree/v4.9-rc5-reserved-rfc-v3
> 
> History:
> RFC v2 -> v3:
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
> Eric Auger (10):
>   iommu/dma: Allow MSI-only cookies
>   iommu: Rename iommu_dm_regions into iommu_resv_regions
>   iommu: Add new reserved IOMMU attributes
>   iommu: iommu_alloc_resv_region
>   iommu: Do not map reserved regions
>   iommu: iommu_get_group_resv_regions
>   iommu: Implement reserved_regions iommu-group sysfs file
>   iommu/vt-d: Implement reserved region get/put callbacks
>   iommu/arm-smmu: Implement reserved region get/put callbacks
>   vfio/type1: Get MSI cookie
> 
>  drivers/iommu/amd_iommu.c       |  20 +++---
>  drivers/iommu/arm-smmu.c        |  52 +++++++++++++++
>  drivers/iommu/dma-iommu.c       | 116 ++++++++++++++++++++++++++----
> ---
>  drivers/iommu/intel-iommu.c     |  50 ++++++++++----
>  drivers/iommu/iommu.c           | 141
> ++++++++++++++++++++++++++++++++++++----
>  drivers/vfio/vfio_iommu_type1.c |  26 ++++++++
>  include/linux/dma-iommu.h       |   7 ++
>  include/linux/iommu.h           |  49 ++++++++++----
>  8 files changed, 391 insertions(+), 70 deletions(-)
> 
> --
> 1.9.1
> 
> _______________________________________________
> iommu mailing list
> iommu at lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
