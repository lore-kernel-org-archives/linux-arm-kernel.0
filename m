From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 17 Dec 2015 12:01:15 -0500
Subject: [PATCH V10 0/7] dma: add Qualcomm Technologies HIDMA driver
Message-ID: <1450371684-23415-1-git-send-email-okaya@codeaurora.org>
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

The management driver is executed in hypervisor context and
is the main management entity for all channels provided by
the device.

Changes from V9: (https://lkml.org/lkml/2015/12/11/584)
* none

Changes from V9: (https://lkml.org/lkml/2015/12/11/585)
* split device tree documentation from code
* correct syntax error in device tree documentation
* describe max value of the weight
* document that array and weight attributes are array
* add object hierarchy support
* move sysfs priority and weight files into chanops directory.

Changes from V9: (https://lkml.org/lkml/2015/12/11/588)
* add object hierarchy support
* rename event-channel to channel-index
* create a sysfs entry for channel-index
* add pm_runtime_get/sync around hidma_ll_isenabled

Changes from V9: (https://lkml.org/lkml/2015/12/11/586)
* rename TRE chidx to idx to not mix with the channel id.

Changes from V9: (https://lkml.org/lkml/2015/12/11/587)
* none

Sinan Kaya (7):
  dma: qcom_bam_dma: move to qcom directory
  dma: hidma: Add Device Tree support
  dma: add Qualcomm Technologies HIDMA management driver
  dma: add Qualcomm Technologies HIDMA channel driver
  dma: qcom_hidma: implement lower level hardware interface
  dma: qcom_hidma: add debugfs hooks
  dma: qcom_hidma: add support for object hierarchy

 Documentation/ABI/testing/sysfs-platform-hidma     |   9 +
 .../ABI/testing/sysfs-platform-hidma-mgmt          |  97 +++
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  79 ++
 drivers/dma/Kconfig                                |  11 +-
 drivers/dma/Makefile                               |   2 +-
 drivers/dma/qcom/Kconfig                           |  29 +
 drivers/dma/qcom/Makefile                          |   4 +
 drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c}     |   4 +-
 drivers/dma/qcom/hidma.c                           | 868 +++++++++++++++++++
 drivers/dma/qcom/hidma.h                           | 163 ++++
 drivers/dma/qcom/hidma_dbg.c                       | 219 +++++
 drivers/dma/qcom/hidma_ll.c                        | 927 +++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      | 317 +++++++
 drivers/dma/qcom/hidma_mgmt.h                      |  39 +
 drivers/dma/qcom/hidma_mgmt_sys.c                  | 295 +++++++
 15 files changed, 3051 insertions(+), 12 deletions(-)
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

-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
