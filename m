From: pierre-yves.mordret@st.com (Pierre-Yves MORDRET)
Date: Fri, 28 Sep 2018 15:01:48 +0200
Subject: [PATCH v3 0/7] Add-DMA-MDMA-chaining-support
Message-ID: <1538139715-24406-1-git-send-email-pierre-yves.mordret@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds support for M2M transfer triggered by STM32 DMA in order to
transfer data from/to SRAM to/from DDR.

Normally, this mode should not be needed as transferring data from/to DDR
is supported by the STM32 DMA.
However, the STM32 DMA don't have the ability to generate burst transfer
on the DDR as it only embeds only a 4-word FIFO although the minimal burst
length on the DDR is 8 words.
Due to this constraint, the STM32 DMA transfers data from/to DDR in a
single way and could lead to pollute the DDR.
To avoid this, we have to use SRAM for all transfers where STM32 DMA is
involved.

An Hw design has been specially put in place to allow this chaining where DMA
interrupt is connected on GIC and MDMA request line as well. This grants the
possibility to trigger an MDMA transfer from the completion of DMA.
At the same time MDMA has the ability to acknowlege DMA. The aim is to have an
self refreching mechanism to transfer from/to device to/from DDR with minimal
sw support.
For instance the DMA is set in cyclic double buffering to feed SRAM and MDMA
transfer to DDR thanks to LLI.

---
  Version history:
    v3:
       * Solve KBuild warnings
    v2:
       * Rework binding content
    v1:
       * Initial
---

Pierre-Yves MORDRET (3):
  dt-bindings: stm32-dma: Add DMA/MDMA chaining support bindings
  dt-bindings: stm32-dmamux: Add one cell to support DMA/MDMA chain
  dt-bindings: stm32-mdma: Add DMA/MDMA chaining support bindings
  dmaengine: stm32-dma: Add DMA/MDMA chaining support
  dmaengine: stm32-mdma: Add DMA/MDMA chaining support
  dmaengine: stm32-dma: enable descriptor_reuse
  dmaengine: stm32-mdma: enable descriptor_reuse

 .../devicetree/bindings/dma/stm32-dma.txt          |  27 +-
 .../devicetree/bindings/dma/stm32-dmamux.txt       |   6 +-
 .../devicetree/bindings/dma/stm32-mdma.txt         |  12 +-
 drivers/dma/stm32-dma.c                            | 903 ++++++++++++++++++---
 drivers/dma/stm32-mdma.c                           | 133 ++-
 5 files changed, 949 insertions(+), 132 deletions(-)

-- 
2.7.4
