From: okaya@codeaurora.org (Sinan Kaya)
Date: Thu, 12 Nov 2015 01:41:15 -0500
Subject: [PATCH V4 0/4] dma: add Qualcomm Technologies HIDMA driver
Message-ID: <1447310481-25463-1-git-send-email-okaya@codeaurora.org>
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

Changes from V3: (https://lkml.org/lkml/2015/11/7/256)
* use git format-patch -M to reduce the difference

Changes from V3: (https://lkml.org/lkml/2015/11/7/257)
* add missing EXPORT_SYMBOL_GPL for hidma_mgmt_init_sys and
hidma_mgmt_setup
* simplify bitwise set and clear statements

Changes from V3: (https://lkml.org/lkml/2015/11/7/258)
* none

Changes from V3: (https://lkml.org/lkml/2015/11/7/259)
* remove return code on hidma_ll_start and hidma_ll_queue_request
* remove the checks after platform_get_resource.
* reorder the pm calls in failure path.
* simplify bit clear and set operations.
* correct device tree documentation compatible string
* clean unnecessary initializations and use unsigned int for
iterator types

Sinan Kaya (4):
  dma: qcom_bam_dma: move to qcom directory
  dma: add Qualcomm Technologies HIDMA management driver
  dmaselftest: add memcpy selftest support functions
  dma: add Qualcomm Technologies HIDMA channel driver

 .../devicetree/bindings/dma/qcom_hidma.txt         |  18 +
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |  61 ++
 drivers/dma/Kconfig                                |  11 +-
 drivers/dma/Makefile                               |   2 +-
 drivers/dma/dmaengine.h                            |   2 +
 drivers/dma/dmaselftest.c                          | 638 ++++++++++++++
 drivers/dma/qcom/Kconfig                           |  29 +
 drivers/dma/qcom/Makefile                          |   4 +
 drivers/dma/{qcom_bam_dma.c => qcom/bam_dma.c}     |   6 +-
 drivers/dma/qcom/hidma.c                           | 736 ++++++++++++++++
 drivers/dma/qcom/hidma.h                           | 157 ++++
 drivers/dma/qcom/hidma_dbg.c                       | 225 +++++
 drivers/dma/qcom/hidma_ll.c                        | 939 +++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      | 312 +++++++
 drivers/dma/qcom/hidma_mgmt.h                      |  38 +
 drivers/dma/qcom/hidma_mgmt_sys.c                  | 231 +++++
 16 files changed, 3396 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
 create mode 100644 drivers/dma/dmaselftest.c
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
