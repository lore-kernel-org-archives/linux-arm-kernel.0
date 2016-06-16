From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Jun 2016 14:28:32 +0200
Subject: [PATCH v4 0/4] dmaengine driver for Marvell XOR v2 engine
Message-ID: <1466080116-26777-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is the fourth version of the mv_xor_v2 driver, which allows to
use the XOR engines available on the Marvell Armada 7K/8K ARM64 SoCs.

Changes v3 -> v4:

 - As requested by Vinod Koul, do not ask the engine to start
   processing the new descriptors in ->tx_submit(). Instead, only tell
   the engine to start processing the new descriptors in
   ->issue_pending().

Changes v2 -> v3:

 - Add a SoC-specific compatible string to the DT binding,
   "marvell,armada-7k-xor". Suggested by Rob Herring.

 - Rename the original compatible string from "marvell,mv-xor-v2" to
   "marvell,xor-v2", since the "marvell" and "mv" are
   redondant. Suggested by Rob Herring.

 - Move the DT binding documentation in a separate patch, as requested
   by Vinod Koul and Rob Herring.

 - Replace BUG_ON(src_cnt > MV_XOR_V2_CMD_LINE_NUM_MAX_D_BUF ||
   src_cnt < 1); in mv_xor_v2_prep_dma_xor() by a non-crashing test,
   i.e. we simply return NULL. Suggested by Vinod Koul.

 - Add support for an optional clock to the Device Tree binding and
   the driver. This is needed since there are two XOR units in the CP
   part of the Armada 7K/8K that use a gatable clock.

 - Fix the mv_xor_v2_prep_sw_desc() function to not crash when the
   list of available descriptors is empty.

 - Add MV_XOR_V2_ as the prefix of all register offset/bits
   definitions, as requested by Vinod Koul.

 - Clearly indicate what MV_XOR_V2_DESC_NUM is, after a question from
   Vinod Koul.

 - Switch from three spinlocks to only one spinlock, as suggested by
   Vinod Koul.

 - Remove the CONFIG_ARCH_DMA_ADDR_T_64BIT conditionals, since the
   driver depends on ARM64, and CONFIG_ARCH_DMA_ADDR_T_64BIT is always
   enabled on ARM64. Follows a discussion with Vinod Koul.

 - Remove useless empty mv_xor_v2_alloc_chan_resources() and
   mv_xor_v2_free_chan_resources() functions, as noticed by Vinod
   Koul.

 - Add a check in mv_xor_v2_interrupt_handler() to make sure we really
   have something to do. Suggested by Vinod Koul.

 - Simplify:

     dest_hw_desc = ((void *)xor_dev->hw_desq_virt +
                     (xor_dev->desc_size * desq_ptr));

   into just:

     dest_hw_desc = xor_dev->hw_desq_virt + desq_ptr;

   After adding a BUILD_BUG_ON() that makes sure that the size of
   "struct mv_xor_v2_descriptor" is equal to MV_XOR_V2_EXT_DESC_SIZE.

   Follows a question from Vinod Koul.

 - Remove mv_xor_v2_tx_status() and use dma_cookie_status()
   directly. Suggested by Vinod Koul.

Changes v1 -> v2:

 - Add a "depends on ARM64" since the MSI infrastructure doesn't build
   on all architectures for the moment.

 - Remove the useless .owner assignment.

Thanks!

Thomas

Thomas Petazzoni (4):
  dt-bindings: dma: add binding for the Marvell XOR v2 engine
  dma: mv_xor_v2: new driver
  arm64: dts: marvell: adjust to the latest mv-xor-v2 DT binding
  arm64: dts: marvell: add XOR engine description for Armada 7K/8K CP

 .../devicetree/bindings/dma/mv-xor-v2.txt          |  24 +
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |   8 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi      |  18 +
 drivers/dma/Kconfig                                |  14 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/mv_xor_v2.c                            | 879 +++++++++++++++++++++
 6 files changed, 940 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/mv-xor-v2.txt
 create mode 100644 drivers/dma/mv_xor_v2.c

-- 
2.7.4
