From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Fri, 24 Jul 2015 14:33:08 +0530
Subject: [RFC 0/2] VFIO: Add virtual MSI doorbell support.
Message-ID: <1437728590-23126-1-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In current VFIO MSI/MSI-X implementation, linux host kernel
allocates MSI/MSI-X vectors when userspace requests through vfio ioctls.
Vfio creates irqfd mappings to notify MSI/MSI-X interrupts
to the userspace when raised.
Guest OS will see emulated MSI/MSI-X controller and receives an interrupt
when kernel notifies the same via irqfd.

Host kernel allocates MSI/MSI-X using standard linux routines
like pci_enable_msix_range() and pci_enable_msi_range(). 
These routines along with requset_irq() in host kernel sets up 
MSI/MSI-X vectors with Physical MSI/MSI-X addresses provided by
interrupt controller driver in host kernel.

This means when a device is assigned with the guest OS, MSI/MSI-X addresses
present in PCIe EP are the PAs programmed by the host linux kernel.

In x86 MSI/MSI-X physical address range is reserved and iommu is aware
about these addreses and transalation is bypassed for these address range.

Unlike x86, ARM/ARM64 does not reserve MSI/MSI-X Physical address range and
all the transactions including MSI go through iommu/smmu without bypass.
This requires extending current vfio MSI layer with additional functionality
for ARM/ARM64 by
1. Programing IOVA (referred as a MSI virtual doorbell address)
   in device's MSI vector as a MSI address.
   This IOVA will be provided by the userspace based on the
   MSI/MSI-X addresses reserved for the guest.
2. Create an IOMMU mapping between this IOVA and
   Physical address (PA) assigned to the MSI vector.

This RFC is proposing a solution for MSI/MSI-X passthrough for ARM/ARM64.

Pranavkumar Sawargaonkar (2):
  drivers: vfio: iommu map and unmap device specific memory from
    kernel.
  drivers: vfio: pci: Add virtual MSI doorbell support.

 drivers/vfio/pci/vfio_pci.c         |   32 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_intrs.c   |   64 +++++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h |    3 ++
 drivers/vfio/vfio.c                 |   29 ++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c     |   60 ++++++++++++++++++++++++++++++++
 include/linux/vfio.h                |   11 +++++-
 include/uapi/linux/vfio.h           |   19 +++++++++++
 7 files changed, 217 insertions(+), 1 deletion(-)

-- 
1.7.9.5
