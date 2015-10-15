From: cedric.madianga@gmail.com (M'boumba Cedric Madianga)
Date: Thu, 15 Oct 2015 14:14:16 +0200
Subject: [PATCH v3 0/4] Add support for STM32 DMA
Message-ID: <1444911260-31993-1-git-send-email-cedric.madianga@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 DMA controller.
This controller provides 8 channels dedicated to managing memory access
request from one or more peripherals.
Each stream can have up to 8 requests in total.

Changes since v2:
- remove interrupt configuration management from DT
- remove FIFO configuration management from DT except threshold as it is very
  hard to handle it in the driver due to many possible combinations according
  to burst and bus width
- update DMA client message in DT documentation file
- specify the order to be used to set per-channel DMA interrupts in the DT
- remove unused enumerations for channel and request ids
- keep as soon as possible 80 lines char for more readability
- replace unsigned int by u32
- return error if burst is not supported in stm32_dma_get_burst()
- return error if bus_width is not supported in stm32_dma_get_width()
- add FIFO configuration management inside the driver except for threshold
- add interrupt configuration management inside the driver
- rework stm32_dma_chan_irq() to handle error interrupt in one way
- rework stm32_dma_set_xfer_param() to be easier to read
- update stm32_dma_tx_status() to always return status from dma_cookie_status()
- disable clk if we don't manage to stop the DMA channel during channel
  resources allocation
- set driver as built-in as DMA will be required by other built-in driver

Changes since v1:
 - remove dmamux boolean as it is not needed
 - replace dma by DMA in Kconfig
 - add default return value in stm32_dma_get_width()
 - add defalut return value in stm32_dma_get_burst()
 - use lower case for constant hexadecimal values


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
 drivers/dma/stm32-dma.c                            | 1148 ++++++++++++++++++++
 6 files changed, 1276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-dma.txt
 create mode 100644 drivers/dma/stm32-dma.c

-- 
1.9.1
