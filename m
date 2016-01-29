From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 29 Jan 2016 17:35:03 -0500
Subject: [PATCH V13 00/10] dma: add Qualcomm Technologies HIDMA driver
Message-ID: <1454106914-15857-1-git-send-email-okaya@codeaurora.org>
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
- VFIO Reset driver
- More documentation in device-tree binding.
- Removed event-channel parameter

------------------------
Git repos
------------------------
QEMU Support
https://www.codeaurora.org/cgit/quic/qemu/qemu/log/?h=v2.5.0-sriov

------------------------
History of Changes
------------------------
Creating a QCOM directory for all QCOM DMA source files.
Changes from V12: (https://lkml.org/lkml/2016/1/11/525)
* none

dma: hidma: Add Device Tree Binding
Changes from V12: (https://lkml.org/lkml/2016/1/11/522)
* s/driver/binding/
* s/hypervisor/host/
* add iommu node required.
* removed the flexibility to choose event channel. Will use HW defaults
* instead.
  channel-index parameter is removed.

dma: add Qualcomm Technologies HIDMA management driver
Changes from V12: (https://lkml.org/lkml/2016/1/11/518)
* s/hypervisor/host/

dma: add Qualcomm Technologies HIDMA channel driver
Changes from V12: (https://lkml.org/lkml/2016/1/11/523)
* none

dma: qcom_hidma: implement lower level hardware interface
Changes from V12: (https://lkml.org/lkml/2016/1/11/519)
* none

dma: qcom_hidma: add debugfs hooks
Changes from V12: (https://lkml.org/lkml/2016/1/11/521)
* none

dma: qcom_hidma: add support for object hierarchy
Changes from V12: (https://lkml.org/lkml/2016/1/11/520)
* none

Sinan Kaya (10):
  dma: qcom_bam_dma: move to qcom directory
  dma: hidma: Add Device Tree binding
  dma: add Qualcomm Technologies HIDMA management driver
  dma: add Qualcomm Technologies HIDMA channel driver
  dma: qcom_hidma: implement lower level hardware interface
  dma: qcom_hidma: add debugfs hooks
  dma: qcom_hidma: add support for object hierarchy
  dma: qcom_hidma: read the channel id from HW
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
 drivers/dma/qcom/hidma.c                           | 747 +++++++++++++++++
 drivers/dma/qcom/hidma.h                           | 162 ++++
 drivers/dma/qcom/hidma_dbg.c                       | 219 +++++
 drivers/dma/qcom/hidma_ll.c                        | 927 +++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      | 400 +++++++++
 drivers/dma/qcom/hidma_mgmt.h                      |  39 +
 drivers/dma/qcom/hidma_mgmt_sys.c                  | 295 +++++++
 drivers/vfio/platform/reset/Kconfig                |   9 +
 drivers/vfio/platform/reset/Makefile               |   2 +
 .../vfio/platform/reset/vfio_platform_amdxgbe.c    |   3 +-
 .../platform/reset/vfio_platform_calxedaxgmac.c    |   3 +-
 .../vfio/platform/reset/vfio_platform_qcomhidma.c  |  99 +++
 drivers/vfio/platform/vfio_platform_common.c       |  80 +-
 drivers/vfio/platform/vfio_platform_private.h      |  41 +-
 22 files changed, 3229 insertions(+), 43 deletions(-)
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
