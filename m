From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 4 May 2016 13:29:25 +0200
Subject: [PATCH v8 0/7] KVM PCIe/MSI passthrough on ARM/ARM64: kernel part
 3/3: vfio changes
In-Reply-To: <43c26d74c99f40d4b85347c71aa37b1d@IL-EXCH02.marvell.com>
References: <1461832118-5668-1-git-send-email-eric.auger@linaro.org>
 <43c26d74c99f40d4b85347c71aa37b1d@IL-EXCH02.marvell.com>
Message-ID: <5729DD15.1010509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yehuda,
On 05/04/2016 01:17 PM, Yehuda Yitschak wrote:
> 
> Tested-by: Yehuda Yitschak <yehuday@marvell.com>
Many thanks for the T-b!

I'am about to submit a small update on part I & III today (v9), taking
into account Alex' last comments. MSI layer part (II) is left unchanged
(v8).

The way I am going to report the need for MSI mapping on user-side
changes and I will respin the QEMU part accordingly. Besides, this info
was not yet used in the QEMU integration.

Best Regards

Eric
> 
> Tested on Armada-7040 using an intel IXGBE (82599ES). 
> 
>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>> bounces at lists.infradead.org] On Behalf Of Eric Auger
>> Sent: Thursday, April 28, 2016 11:29
>> To: eric.auger at st.com; eric.auger at linaro.org; robin.murphy at arm.com;
>> alex.williamson at redhat.com; will.deacon at arm.com; joro at 8bytes.org;
>> tglx at linutronix.de; jason at lakedaemon.net; marc.zyngier at arm.com;
>> christoffer.dall at linaro.org; linux-arm-kernel at lists.infradead.org
>> Cc: julien.grall at arm.com; patches at linaro.org; Jean-
>> Philippe.Brucker at arm.com; p.fedin at samsung.com; linux-
>> kernel at vger.kernel.org; Bharat.Bhushan at freescale.com;
>> iommu at lists.linux-foundation.org; pranav.sawargaonkar at gmail.com
>> Subject: [PATCH v8 0/7] KVM PCIe/MSI passthrough on ARM/ARM64: kernel
>> part 3/3: vfio changes
>>
>> This series allows the user-space to register a reserved IOVA domain.
>> This completes the kernel integration of the whole functionality on top of
>> part 1 & 2.
>>
>> It also depends on [PATCH 1/3] iommu: Add MMIO mapping type series,
>> http://comments.gmane.org/gmane.linux.kernel.iommu/12869
>>
>> We reuse the VFIO DMA MAP ioctl with a new flag to bridge to the msi-
>> iommu API. The need for provisioning such MSI IOVA range is reported
>> through the VFIO_IOMMU_GET_INFO iotcl.
>>
>> vfio_iommu_type1 checks if the MSI mapping is safe when attaching the vfio
>> group to the container (allow_unsafe_interrupts modality).
>>
>> On ARM/ARM64, the IOMMU does not astract IRQ remapping. the modality
>> is abstracted on MSI controller side. The GICv3 ITS is the first controller
>> advertising the modality.
>>
>> More details & context can be found at:
>> http://www.linaro.org/blog/core-dump/kvm-pciemsi-passthrough-
>> armarm64/
>>
>> Best Regards
>>
>> Eric
>>
>> Testing:
>> - functional on ARM64 AMD Overdrive HW (single GICv2m frame) with
>>   Intel X540-T2 (SR-IOV capable)
>> - Not tested: ARM GICv3 ITS
>>
>> References:
>> [1] [RFC 0/2] VFIO: Add virtual MSI doorbell support
>>     (https://lkml.org/lkml/2015/7/24/135)
>> [2] [RFC PATCH 0/6] vfio: Add interface to map MSI pages
>>     (https://lists.cs.columbia.edu/pipermail/kvmarm/2015-
>> September/016607.html)
>> [3] [PATCH v2 0/3] Introduce MSI hardware mapping for VFIO
>>
>> (http://permalink.gmane.org/gmane.comp.emulators.kvm.arm.devel/3858)
>>
>> Git: complete series available at
>> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.6-
>> rc5-pcie-passthrough-v8
>>
>> previous version at
>> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.6-
>> rc4-pcie-passthrough-v7
>>
>> QEMU Integration:
>> [RFC v2 0/8] KVM PCI/MSI passthrough with mach-virt
>> (http://lists.gnu.org/archive/html/qemu-arm/2016-01/msg00444.html)
>> https://git.linaro.org/people/eric.auger/qemu.git/shortlog/refs/heads/v2.5.
>> 0-pci-passthrough-rfc-v2
>>
>> History:
>> v7 -> v8:
>> - use renamed msi-iommu API
>> - VFIO only responsible for setting the IOVA aperture
>> - use new DOMAIN_ATTR_MSI_GEOMETRY iommu domain attribute
>>
>> v6 -> v7:
>> - vfio_find_dma now accepts a dma_type argument.
>> - should have recovered the capability to unmap the whole user IOVA range
>> - remove computation of nb IOVA pages -> will post a separate RFC for that
>>   while respinning the QEMU part
>>
>> RFC v5 -> patch v6:
>> - split to ease the review process
>>
>> RFC v4 -> RFC v5:
>> - take into account Thomas' comments on MSI related patches
>>   - split "msi: IOMMU map the doorbell address when needed"
>>   - increase readability and add comments
>>   - fix style issues
>>  - split "iommu: Add DOMAIN_ATTR_MSI_MAPPING attribute"
>>  - platform ITS now advertises IOMMU_CAP_INTR_REMAP
>>  - fix compilation issue with CONFIG_IOMMU API unset
>>  - arm-smmu-v3 now advertises DOMAIN_ATTR_MSI_MAPPING
>>
>> RFC v3 -> v4:
>> - Move doorbell mapping/unmapping in msi.c
>> - fix ref count issue on set_affinity: in case of a change in the address
>>   the previous address is decremented
>> - doorbell map/unmap now is done on msi composition. Should allow the use
>>   case for platform MSI controllers
>> - create dma-reserved-iommu.h/c exposing/implementing a new API
>> dedicated
>>   to reserved IOVA management (looking like dma-iommu glue)
>> - series reordering to ease the review:
>>   - first part is related to IOMMU
>>   - second related to MSI sub-system
>>   - third related to VFIO (except arm-smmu IOMMU_CAP_INTR_REMAP
>> removal)
>> - expose the number of requested IOVA pages through
>> VFIO_IOMMU_GET_INFO
>>   [this partially addresses Marc's comments on
>> iommu_get/put_single_reserved
>>    size/alignment problematic - which I did not ignore - but I don't know
>>    how much I can do at the moment]
>>
>> RFC v2 -> RFC v3:
>> - should fix wrong handling of some CONFIG combinations:
>>   CONFIG_IOVA, CONFIG_IOMMU_API, CONFIG_PCI_MSI_IRQ_DOMAIN
>> - fix MSI_FLAG_IRQ_REMAPPING setting in GICv3 ITS (although not tested)
>>
>> PATCH v1 -> RFC v2:
>> - reverted to RFC since it looks more reasonable ;-) the code is split
>>   between VFIO, IOMMU, MSI controller and I am not sure I did the right
>>   choices. Also API need to be further discussed.
>> - iova API usage in arm-smmu.c.
>> - MSI controller natively programs the MSI addr with either the PA or IOVA.
>>   This is not done anymore in vfio-pci driver as suggested by Alex.
>> - check irq remapping capability of the group
>>
>> RFC v1 [2] -> PATCH v1:
>> - use the existing dma map/unmap ioctl interface with a flag to register a
>>   reserved IOVA range. Use the legacy Rb to store this special vfio_dma.
>> - a single reserved IOVA contiguous region now is allowed
>> - use of an RB tree indexed by PA to store allocated reserved slots
>> - use of a vfio_domain iova_domain to manage iova allocation within the
>>   window provided by the userspace
>> - vfio alloc_map/unmap_free take a vfio_group handle
>> - vfio_group handle is cached in vfio_pci_device
>> - add ref counting to bindings
>> - user modality enabled at the end of the series
>>
>>
>> Eric Auger (7):
>>   vfio: introduce a vfio_dma type field
>>   vfio/type1: vfio_find_dma accepting a type argument
>>   vfio/type1: bypass unmap/unpin and replay for VFIO_IOVA_RESERVED slots
>>   vfio: allow reserved msi iova registration
>>   vfio/type1: also check IRQ remapping capability at msi domain
>>   iommu/arm-smmu: do not advertise IOMMU_CAP_INTR_REMAP
>>   vfio/type1: return MSI mapping requirements with
>> VFIO_IOMMU_GET_INFO
>>
>>  drivers/iommu/arm-smmu-v3.c     |   3 +-
>>  drivers/iommu/arm-smmu.c        |   3 +-
>>  drivers/vfio/vfio_iommu_type1.c | 227
>> +++++++++++++++++++++++++++++++++++++---
>>  include/uapi/linux/vfio.h       |  14 ++-
>>  4 files changed, 230 insertions(+), 17 deletions(-)
>>
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
