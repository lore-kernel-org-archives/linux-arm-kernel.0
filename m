From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun,  1 May 2016 00:25:25 -0400
Subject: [PATCH V18 0/3] dmaengine: add Qualcomm Technologies HIDMA driver
Message-ID: <1462076728-14367-1-git-send-email-okaya@codeaurora.org>
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
- Get rid of hidma_ll_resume function
- Rename hidma_ll_pause to hidma_ll_disable
- Remove tx_status_list and attach the err_code and err_info to the TRE
- Create a hidma_handle_tre_completion function to make error path and
  success path common.
- More style corrections


Sinan Kaya (3):
  dmaengine: qcom_hidma: implement lower level hardware interface
  dmaengine: qcom_hidma: add debugfs hooks
  dmaengine: qcom_hidma: add support for object hierarchy

 Documentation/ABI/testing/sysfs-platform-hidma |   9 +
 drivers/dma/qcom/Makefile                      |   2 +
 drivers/dma/qcom/hidma.c                       |  52 +-
 drivers/dma/qcom/hidma.h                       |  40 +-
 drivers/dma/qcom/hidma_dbg.c                   | 217 ++++++
 drivers/dma/qcom/hidma_ll.c                    | 872 +++++++++++++++++++++++++
 drivers/dma/qcom/hidma_mgmt.c                  | 113 +++-
 7 files changed, 1274 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-hidma
 create mode 100644 drivers/dma/qcom/hidma_dbg.c
 create mode 100644 drivers/dma/qcom/hidma_ll.c

-- 
1.8.2.1
