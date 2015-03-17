From: agross@codeaurora.org (Andy Gross)
Date: Tue, 17 Mar 2015 00:46:10 -0500
Subject: [Patch v6 0/2] Add Qualcomm ADM dmaengine driver
Message-ID: <1426571172-9711-1-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set introduces the dmaengine driver for the Qualcomm Application
Data Mover (ADM) DMA controller present on MSM8x60, APQ8064, and IPQ8064
devices.

The initial version of this driver will only support slave DMA operations
between system memory and peripherals.  Flow control via the CRCI (client rate
control interface) is supported and can be configured via device tree
configuration.  Flow control usage is required for some peripheral devices.

Changes from v5:
  - Fix erroneous adm_get_blksize for values of 192 and 256.

Changes from v4:
  - Fixed copyright date
  - Fixed error in EE offsets and usage
  - Changed namespace for registers and fields to ADM specific naming
  - Removed alloc_chan function
  - Removed control function and fixed up terminate_all and slave_config
  - Reworked descriptor processing code to make it more clean
  - Moved to use of_dma_xlate_by_chan_id
  - Fixed other small review comments

Changes from v3:
  - Remove .owner field

Changes from v2:
  - Removed extraneous achan variable from xlate function
  - Reworked crci check in slave_sg function
  - Added mux field to async_desc structure.
  - Reworked dma start function to use crci and mux values directly from
    structure.
  - Added disable of clocks in probe error paths.
  - Changed to use #define for fixed number of channels.

Changes since v1:
  - Fixed various review comments
  - Fixed some descriptor programming issues.
  - Added single descriptors to support sub burst length transactions.
    Selection of single or box descriptors depends on the sg length and burst
    size.
  - Removed use of crci in the dmas property.  CRCI is now designated via the
    slave_config structure and will be stored in slave_id.

Andy Gross (2):
  dt/bindings: qcom_adm: Fix channel specifiers
  dmaengine: Add ADM driver

 Documentation/devicetree/bindings/dma/qcom_adm.txt |   16 +-
 drivers/dma/Kconfig                                |   10 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/qcom_adm.c                             |  900 ++++++++++++++++++++
 4 files changed, 917 insertions(+), 10 deletions(-)
 create mode 100644 drivers/dma/qcom_adm.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
