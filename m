From: eric.auger@redhat.com (Eric Auger)
Date: Tue, 27 Sep 2016 20:48:27 +0000
Subject: [RFC 00/11] KVM PCIe/MSI passthrough on ARM/ARM64: re-design with
 transparent MSI mapping
Message-ID: <1475009318-2617-1-git-send-email-eric.auger@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following Robin's series [1] addressing MSI IOMMU mapping for devices
attached to a DMA ops domain, my previous 3 part series (v12) lost most
of its consistency. msi-iommu API role now is handled at dma-iommu level
while MSI doorbell registration API only is used for security assessment.
Also MSI layer part is not needed anymore since mapping directly is
done in the compose callback.

Here I propose an alternative approach, based on [1]. This approach
was discussed at the KVM forum with Christoffer Dall and Marc Zyngier,
and was suggested by Christoffer. The idea is we could let the iommu
layer transparently allocate MSI frame IOVAs in the holes left between
UNMANAGED iova slots, set by the iommu-api user.

This series introduces a new IOMMU domain type that allows mixing of
unmanaged and managed IOVA slots. We define an IOVA domain whose
aperture covers the GPA address range. Each time the IOMMU-API
user maps iova/pa, we reserve the IOVA range to prevent the iova
allocator from using it for MSI mapping.

This simplifies the user part which does not need anymore to provide an
IOVA aperture anymore.

The current series does not address the interrupt safety assessment,
which may be considered as a separate issue. Currently the assignemnt
is considered as unsafe, on ARM (even with a GICv3 ITS).

Please let me know what is your feeling wrt this alternative approach.

dependency:
[1] [PATCH v7 00/22] Generic DT bindings for PCI IOMMUs and ARM SMMU
http://www.spinics.net/lists/arm-kernel/msg531110.html

Best Regards

Eric

Testing:
- functional on ARM64 AMD Overdrive HW (single GICv2m frame). Lack of contexts
  prevents me from testing multiple assignment.

Git: complete series available at
https://github.com/eauger/linux/tree/generic-v7-pcie-passthru-redesign-rfc
previous: https://github.com/eauger/linux/tree/v4.7-rc7-passthrough-v12

the above branch includes a temporary patch to work around a ThunderX pci
bus reset crash (which I think unrelated to this series):
"vfio: pci: HACK! workaround thunderx pci_try_reset_bus crash"
Do not take this one for other platforms.


Eric Auger (10):
  iommu: Add iommu_domain_msi_geometry and DOMAIN_ATTR_MSI_GEOMETRY
  iommu: Introduce IOMMU_CAP_TRANSLATE_MSI capability
  iommu: Introduce IOMMU_DOMAIN_MIXED
  iommu/dma: iommu_dma_(un)map_mixed
  iommu/arm-smmu: Allow IOMMU_DOMAIN_MIXED domain allocation
  iommu: Use IOMMU_DOMAIN_MIXED typed domain when IOMMU translates MSI
  vfio/type1: Sets the IOVA window in case MSI IOVA need to be allocated
  vfio/type1: Reserve IOVAs for IOMMU_DOMAIN_MIXED domains
  iommu/arm-smmu: Do not advertise IOMMU_CAP_INTR_REMAP
  iommu/arm-smmu: Advertise IOMMU_CAP_TRANSLATE_MSI

Robin Murphy (1):
  iommu/dma: Allow MSI-only cookies

 drivers/iommu/arm-smmu-v3.c     |  8 +++-
 drivers/iommu/arm-smmu.c        |  8 +++-
 drivers/iommu/dma-iommu.c       | 91 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c           | 10 ++++-
 drivers/vfio/vfio_iommu_type1.c | 48 ++++++++++++++++++----
 include/linux/dma-iommu.h       | 27 ++++++++++++
 include/linux/iommu.h           | 23 +++++++++++
 7 files changed, 203 insertions(+), 12 deletions(-)

-- 
1.9.1
