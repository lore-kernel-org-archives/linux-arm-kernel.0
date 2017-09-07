From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Thu, 7 Sep 2017 13:52:44 +0200
Subject: [PATCH v4 0/4] Add STM32 DMAMUX support
Message-ID: <1504785168-26572-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the STM32 DMA multiplexer.
It allows to map any peripheral DMA request to any channel of the product
DMAs.
This IP has been introduced with STM32H7 SoC.

---
 Version history:
    v4:
        * Add multi-master ability for STM32 DMAMUX
        * Get rid of st,dmamux property and custom API between STM32
          DMAMUX and DMA. Bindings has changed.
          DMAMUX will read DMA masters from Device Tree from now on.
          Merely one DMAMUX node is needed now.
        * Only STM32 DMA are allowed to be connected onto DMAMUX
        * channelID is computed locally within the driver and crafted in
          dma_psec to be passed toward DMA master.
          DMAMUX router sorts out which DMA master will serve the
          request automatically.
        * This version forbids the use of DMA in standalone and DMAMUX at
          the same time : all clients need to be connected either on DMA
          or DMAMUX ; no mix up
    v3:
        * change compatible to st,stm32h7-dmamux to be mode Soc specific
        * add verbosity in dma-cells
---

Pierre-Yves MORDRET (4):
  dt-bindings: Document the STM32 DMAMUX bindings
  dmaengine: Add STM32 DMAMUX driver
  dt-bindings: stm32-dma: add a property to handle STM32 DMAMUX
  ARM: configs: stm32: Add MDMA support in STM32 defconfig

 .../devicetree/bindings/dma/stm32-dma.txt          |   4 +-
 .../devicetree/bindings/dma/stm32-dmamux.txt       |  84 ++++++
 arch/arm/configs/stm32_defconfig                   |   1 +
 drivers/dma/Kconfig                                |   9 +
 drivers/dma/Makefile                               |   1 +
 drivers/dma/stm32-dmamux.c                         | 321 +++++++++++++++++++++
 6 files changed, 419 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/dma/stm32-dmamux.txt
 create mode 100644 drivers/dma/stm32-dmamux.c

-- 
2.7.4
