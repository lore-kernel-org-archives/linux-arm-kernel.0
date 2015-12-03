From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu,  3 Dec 2015 01:12:32 -0500
Subject: [PATCH V8 0/5] dma: add Qualcomm Technologies HIDMA driver
Message-ID: <1449123159-28261-1-git-send-email-okaya@codeaurora.org>
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

Changes from V7: (https://lkml.org/lkml/2015/11/22/221)
* none

Changes from V7: (https://lkml.org/lkml/2015/11/22/222)
* remove done goto labels
* remove extra space in device tree documentation
* correct spelling mistake
* prefix constants with HIDMA

Changes from V7: (https://lkml.org/lkml/2015/11/22/223)
* Split debugs from the patchset.
* Remove potential sleeps in PM functions.
* Seperate the lower level into its own patch.
* Remove redundant DMA_CTRL_ACK assignment.
* tx_status changes to handle completed transactions right before the
  pause.
* terminate the running transactions in channel free.

Sinan Kaya (5):
  dma: qcom_bam_dma: move to qcom directory
  dma: add Qualcomm Technologies HIDMA management driver
  dma: add Qualcomm Technologies HIDMA channel driver
  dma: qcom_hidma: implement lower level hardware interface
  dma: qcom_hidma: add debugfs hooks

 .../ABI/testing/sysfs-platform-hidma-mgmt          |  97 +++
 .../devicetree/bindings/dma/qcom_hidma.txt         |  18 +
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  61 ++
 drivers/dma/Kconfig                                |  11 +-
 drivers/dma/Makefile                               |   2 +-
 drivers/dma/qcom/Kconfig                           |  29 +
 drivers/dma/qcom/Makefile                          |   4 +
 drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c}     |   4 +-
 drivers/dma/qcom/hidma.c                           | 716 ++++++++++++++++
 drivers/dma/qcom/hidma.h                           | 161 ++++
 drivers/dma/qcom/hidma_dbg.c                       | 219 +++++
 drivers/dma/qcom/hidma_ll.c                        | 927 +++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      | 318 +++++++
 drivers/dma/qcom/hidma_mgmt.h                      |  39 +
 drivers/dma/qcom/hidma_mgmt_sys.c                  | 292 +++++++
 15 files changed, 2886 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma-mgmt
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma.txt
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
