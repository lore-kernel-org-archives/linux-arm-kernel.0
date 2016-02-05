From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu,  4 Feb 2016 23:34:31 -0500
Subject: [PATCH V14 0/9] dma: add Qualcomm Technologies HIDMA driver
Message-ID: <1454646882-24369-1-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Qualcomm Technologies HIDMA device has been designed
to support virtualization technology. The driver has been
divided into two to follow the hardware design.

1. HIDMA Management driver
2. HIDMA Channel driver

Each HIDMA HW consists of multiple channels. These channels
share some set of common parameters. These parameters are
initialized by the management driver during power up.
Same management driver is used for monitoring the execution
of the channels. Management driver can change the performance
behavior dynamically such as bandwidth allocation and
prioritization in the future.

The management driver is executed in host context and
is the main management entity for all channels provided by
the device.

------------------------
What's new
------------------------
- Add back default number of descriptors.
- Fix compilation error in VFIO ACPI support.
- Merge the event-channel patch back to DTS and channel driver.

------------------------
Git repos
------------------------
QEMU Support
https://www.codeaurora.org/cgit/quic/qemu/qemu/log/?h=v2.5.0-sriov

------------------------
History of Changes
------------------------
dma: hidma: Add Device Tree Binding
Changes from V13: (https://lkml.org/lkml/2016/1/29/672)
* merged event-channel change.

dma: add Qualcomm Technologies HIDMA channel driver
Changes from V13: (https://lkml.org/lkml/2016/1/29/685)
* add back default descriptor count
* merged event-channel change.

dma: qcom_hidma: add support for object hierarchy
Changes from V13: (https://lkml.org/lkml/2016/1/29/680)
* initialize platform info data structure.
* configure DMA by calling of_dma_configure. DMA mask was not set when
* IOMMU driver is not present for the children devices.

vfio, platform: add support for ACPI while detecting the reset driver
Changes from V13: (https://lkml.org/lkml/2016/1/29/679)
* add forgotten pointer during merge
* clarify the driver loading rules in commit message

------------------------
FAQ
------------------------
- This doesn't seem to tie into KVM or VFIO, and as far as I can tell
  there's no mechanism for associating channels with a particular virtual
  address space (i.e. no configuration of an external or internal IOMMU),
  nor pinning of guest pages to allow for DMA to occur safely.

   I'm using VFIO platform driver for this purpose. VFIO platform driver is
   capable of assigning any platform device to a guest machine with this
   driver.

- Are there additional patches, or do you have some userspace that works
  with this in some limited configuration?

   No, these are the only patches. We have one patch for the QEMU but from
   kernel perspective this is it. I just rely on the platform VFIO driver
   to do the work.

- How do host and guest communicate, what is the infrastructure, how is
  HIDMA meant to be used?

   They don't. Guest machine uses HIDMA channel driver to offload DMA
   operations in isolation. The guest machine owns the HW registers for the
   channel. It doesn't need to trap to host for register read/writes etc.

   All guest machine pages used are assumed to be pinned similar to VFIO
   PCI. The reason is performance. The IOMMU takes care of the address
   translation for me.

- How do host and guest communicate?
   They don't.

- How is the integration performed in the hypervisor?

   Hypervisor has a bunch of channel resources. For each guest machine, the
   channel gets unbound from the hypervisor. Channels get bind to each VFIO
   platform device and then control is given to the guest machine.

   Once the guest machine is shutdown, VFIO driver still owns the channel
   device. It can assign the device to another guest machine.

- Does the HYP side requires any context switch (and how is that done)?

   No communication is needed.

- What makes it safe?
   No communication is needed.

- Does the HYP side requires any context switch (and how is that done)?

   I don't believe this requires any context-switch -- it's the same as
   assigning any other platform device other than additional proeprties
   being controlled in the managament interface.

- I'm concerned with how this is safe, and with the userspace interface.
  e.g. if the user wants to up the QoS for a VM, how to they find the
  right channel in sysfs  to alter?

   The HW supports changing the QoS values on the flight. In order to
   locate the object, I'm exporting a chid attribute in sysfs.

   Each management object has one priority and weight file per channel that
   is indexed by the channel id read from the DMA object.
   /sys/devices/platform/hidma-mgmt*/chanops/chan*/priority
   /sys/devices/platform/QCOM8060:*/chanops/chan*/priority

- So what is that hypervisor code used for? Is that your reset driver?

   The HIDMA "management" driver which runs at the hypervisor owns the
   management HW. Management driver serves two purposes.

   1. Common bus parameter configuration (could be called reset driver).
   2. Fine tuning the HW resources on the flight.

Sinan Kaya (9):
  dma: qcom_bam_dma: move to qcom directory
  dma: hidma: Add Device Tree binding
  dma: add Qualcomm Technologies HIDMA management driver
  dma: add Qualcomm Technologies HIDMA channel driver
  dma: qcom_hidma: implement lower level hardware interface
  dma: qcom_hidma: add debugfs hooks
  dma: qcom_hidma: add support for object hierarchy
  vfio, platform: add support for ACPI while detecting the reset driver
  vfio, platform: add QTI HIDMA reset driver

 Documentation/ABI/testing/sysfs-platform-hidma     |   9 +
 .../ABI/testing/sysfs-platform-hidma-mgmt          |  97 +++
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  89 ++
 drivers/dma/Kconfig                                |  11 +-
 drivers/dma/Makefile                               |   2 +-
 drivers/dma/qcom/Kconfig                           |  29 +
 drivers/dma/qcom/Makefile                          |   5 +
 drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c}     |   4 +-
 drivers/dma/qcom/hidma.c                           | 746 +++++++++++++++++
 drivers/dma/qcom/hidma.h                           | 162 ++++
 drivers/dma/qcom/hidma_dbg.c                       | 219 +++++
 drivers/dma/qcom/hidma_ll.c                        | 927 +++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      | 407 +++++++++
 drivers/dma/qcom/hidma_mgmt.h                      |  39 +
 drivers/dma/qcom/hidma_mgmt_sys.c                  | 295 +++++++
 drivers/vfio/platform/reset/Kconfig                |   9 +
 drivers/vfio/platform/reset/Makefile               |   2 +
 .../vfio/platform/reset/vfio_platform_amdxgbe.c    |   3 +-
 .../platform/reset/vfio_platform_calxedaxgmac.c    |   3 +-
 .../vfio/platform/reset/vfio_platform_qcomhidma.c  |  99 +++
 drivers/vfio/platform/vfio_platform_common.c       |  80 +-
 drivers/vfio/platform/vfio_platform_private.h      |  41 +-
 22 files changed, 3235 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma-mgmt
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
 create mode 100644 drivers/dma/qcom/Kconfig
 create mode 100644 drivers/dma/qcom/Makefile
 rename drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c} (99%)
 create mode 100644 drivers/dma/qcom/hidma.c
 create mode 100644 drivers/dma/qcom/hidma.h
 create mode 100644 drivers/dma/qcom/hidma_dbg.c
 create mode 100644 drivers/dma/qcom/hidma_ll.c
 create mode 100644 drivers/dma/qcom/hidma_mgmt.c
 create mode 100644 drivers/dma/qcom/hidma_mgmt.h
 create mode 100644 drivers/dma/qcom/hidma_mgmt_sys.c
 create mode 100644 drivers/vfio/platform/reset/vfio_platform_qcomhidma.c

-- 
1.8.2.1
