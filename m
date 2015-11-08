From: okaya@codeaurora.org (Sinan Kaya)
Date: Sat,  7 Nov 2015 23:52:56 -0500
Subject: [PATCH V3 0/4] *ma: add Qualcomm Technologies HIDMA driver
Message-ID: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
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

Changes from V2: (https://lkml.org/lkml/2015/11/2/43)
* compatible = "qcom,hidma-mgmt-1.1", "qcom,hidma-mgmt-1.0", "qcom,hidma-mgmt";
* change channel-reset-timeout-cycles
* more description for the HW operation and driver organization
* consolidate devm_ioremap_resource
* make print message more meaningfule.
* remove print at uninstall
* remove debugfs for now, create simple sysfs entries instead
* Move code to qcom directory.

Changes from V2: (https://lkml.org/lkml/2015/11/2/44)
* none

Changes from V2: (https://lkml.org/lkml/2015/11/2/45)
* Clarify the relaxed accessor usage in ISR.
* Replace all non-performance critical accessors with safe
versions.
* Correct multiline comment syntax.
* Remove name variable.
* Eliminate redundant list_empty checks.
* Remove locks in hidma_tx_status.
* Document why hidma_issue_pending is empty.
* Fix the return code to 0 for hidma_ll_request.
* Consolidate devm_ioremap_resource functions in probe.
* Move PM calls inside the paused conditional.
* One tasklet for all completions rather than one tasklet
per completion. Completions are queued into kfifo and consumed
by a single tasklet.
* Move start of actual transfer to issue_pending
* Simplify return path when DMA mask set fails.
* Move code to qcom directory.

Sinan Kaya (4):
  dma: qcom_bam_dma: move to qcom directory
  dma: add Qualcomm Technologies HIDMA management driver
  dmaselftest: add memcpy selftest support functions
  dma: add Qualcomm Technologies HIDMA channel driver

 .../devicetree/bindings/dma/qcom_hidma.txt         |   18 +
 .../devicetree/bindings/dma/qcom_hidma_mgmt.txt    |   62 +
 drivers/dma/Kconfig                                |   13 +-
 drivers/dma/Makefile                               |    2 +-
 drivers/dma/dmaengine.h                            |    2 +
 drivers/dma/dmaselftest.c                          |  669 +++++++++++
 drivers/dma/qcom/Kconfig                           |   29 +
 drivers/dma/qcom/Makefile                          |    4 +
 drivers/dma/qcom/bam_dma.c                         | 1259 ++++++++++++++++++++
 drivers/dma/qcom/hidma.c                           |  743 ++++++++++++
 drivers/dma/qcom/hidma.h                           |  157 +++
 drivers/dma/qcom/hidma_dbg.c                       |  225 ++++
 drivers/dma/qcom/hidma_ll.c                        |  944 +++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                      |  315 +++++
 drivers/dma/qcom/hidma_mgmt.h                      |   38 +
 drivers/dma/qcom/hidma_mgmt_sys.c                  |  232 ++++
 drivers/dma/qcom_bam_dma.c                         | 1259 --------------------
 17 files changed, 4701 insertions(+), 1270 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
 create mode 100644 drivers/dma/dmaselftest.c
 create mode 100644 drivers/dma/qcom/Kconfig
 create mode 100644 drivers/dma/qcom/Makefile
 create mode 100644 drivers/dma/qcom/bam_dma.c
 create mode 100644 drivers/dma/qcom/hidma.c
 create mode 100644 drivers/dma/qcom/hidma.h
 create mode 100644 drivers/dma/qcom/hidma_dbg.c
 create mode 100644 drivers/dma/qcom/hidma_ll.c
 create mode 100644 drivers/dma/qcom/hidma_mgmt.c
 create mode 100644 drivers/dma/qcom/hidma_mgmt.h
 create mode 100644 drivers/dma/qcom/hidma_mgmt_sys.c
 delete mode 100644 drivers/dma/qcom_bam_dma.c

-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
