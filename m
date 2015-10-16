From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Fri, 16 Oct 2015 15:59:12 +0200
Subject: [PATCH v4 0/4] Add support for STM32 DMA
Message-ID: <1445003956-9150-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 DMA controller.
This controller provides 8 channels dedicated to managing memory access
request from one or more peripherals.
Each stream can have up to 8 requests in total.

Changes since v3:
 - Fix regression introduced in v3 during request channel
 - Fix regression introduced in v3 for cyclic mode dma transfer
 - update interrupt description in DT
 - remove half transfer interrupt management as client callback as to be
   called only for complete transfer

Changes since v2:
 - remove interrupt configuration management from DT (Mark)
 - remove FIFO configuration management from DT except threshold as it is very
   hard to handle it in the driver due to many possible combinations according
   to burst and bus width (Mark)
 - update DMA client message in DT documentation file
 - specify the order to be used to set per-channel DMA interrupts in the DT
   (Mark)
 - remove unused enumerations for channel and request ids (Daniel)
 - keep as soon as possible 80 lines char for more readability (Vinod)
 - replace unsigned int by u32 (Vinod)
 - use GFP_NOWAIT instead of GFP_ATOMIC during dma descriptors allocation
   (Vinod)
 - return error if burst is not supported in stm32_dma_get_burst() (Vinod)
 - return error if bus_width is not supported in stm32_dma_get_width() (Vinod)
 - add FIFO configuration management inside the driver except for threshold
 - add interrupt configuration management inside the driver (Mark)
 - rework stm32_dma_chan_irq() to handle error interrupt in one way (Vinod)
 - rework stm32_dma_set_xfer_param() to be easier to read
 - update stm32_dma_tx_status() to always return status from dma_cookie_status() (Vinod)
 - disable clk if we don't manage to stop the DMA channel during channel
   resources allocation (Daniel)
 - set driver as built-in as DMA will be required by other built-in driver

 Changes since v1:
  - remove dmamux boolean as it is not needed
  - replace dma by DMA in Kconfig (Maxime)
  - add default return value in stm32_dma_get_width()
  - add defalut return value in stm32_dma_get_burst()
  - use lower case for constant hexadecimal values (Maxime)

M'boumba Cedric Madianga (4):
  dt-bindings: Document the STM32 DMA bindings
  dmaengine: Add STM32 DMA driver
  ARM: dts: Add STM32 DMA support for STM32F429 MCU
  ARM: configs: Add STM32 DMA support in STM32 defconfig

 .../devicetree/bindings/dma/stm32-dma.txt          |   82 ++
 arch/arm/boot/dts/stm32f429.dtsi                   |   31 +
 arch/arm/configs/stm32_defconfig                   |    2 +
 drivers/dma/Kconfig                                |   12 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/stm32-dma.c                            | 1141 ++++++++++++++++++++
 6 files changed, 1269 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-dma.txt
 create mode 100644 drivers/dma/stm32-dma.c

-- 
1.9.1
