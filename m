From: ludovic.Barre@st.com (Ludovic Barre)
Date: Fri, 21 Sep 2018 11:45:54 +0200
Subject: [PATCH V2 00/27] mmc: mmci: add sdmmc variant for stm32
Message-ID: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

The goal of this serie is to add support of sdmmc for stm32.
Be to able to add this new variant it is needed to do some changes in
mmci core:
-Internalize specific needs of legacy dmaengine.
-Create and setup dma_priv pointer
-Create generic callbacks which share some features (like cookie...)
 and call specific needs

change v3:
-remove __dma_inprogress rename
-remove bad space at end of "st,use-ckin"

change v2:
-rename to mmci_prep/unprep_data
-rename specific dma engine structure to mmci_dmae_next/priv
-follow "_" recommandation
-remove dma prefixe of mmci_dmae_priv fields

Ludovic Barre (27):
  mmc: mmci: internalize dma map/unmap into mmci dma functions
  mmc: mmci: internalize dma_inprogress into mmci dma functions
  mmc: mmci: convert dma_setup callback to return an int
  mmc: mmci: introduce dma_priv pointer to mmci_host
  mmc: mmci: move mmci next cookie to mci host
  mmc: mmci: merge prepare data functions
  mmc: mmci: add prepare/unprepare_data callbacks
  mmc: mmci: add get_next_data callback
  mmc: mmci: modify dma_setup callback
  mmc: mmci: add dma_release callback
  mmc: mmci: add dma_start callback
  mmc: mmci: add dma_finalize callback
  mmc: mmci: add dma_error callback
  mmc: mmci: add validate_data callback
  mmc: mmci: add set_clk/pwrreg callbacks
  mmc: mmci: add datactrl block size variant property
  mmc: mmci: expand startbiterr to irqmask and error check
  mmc: mmci: add variant properties to define cpsm & cmdresp bits
  mmc: mmci: add variant property to define dpsm bit
  mmc: mmci: add variant property to define irq pio mask
  mmc: mmci: add variant property to write datactrl before command
  mmc: mmci: add variant property to not read datacnt
  mmc: mmci: add variant property to request a reset
  mmc: mmci: add clock divider for stm32 sdmmc
  mmc: mmci: add stm32 sdmmc registers
  mmc: mmci: add DT bindings for STM32 sdmmc
  mmc: mmci: add stm32 sdmmc variant

 Documentation/devicetree/bindings/mmc/mmci.txt |  11 +
 drivers/mmc/host/Kconfig                       |  10 +
 drivers/mmc/host/Makefile                      |   1 +
 drivers/mmc/host/mmci.c                        | 646 +++++++++++++++++--------
 drivers/mmc/host/mmci.h                        | 147 +++++-
 drivers/mmc/host/mmci_qcom_dml.c               |  15 +-
 drivers/mmc/host/mmci_stm32_sdmmc.c            | 282 +++++++++++
 7 files changed, 880 insertions(+), 232 deletions(-)
 create mode 100644 drivers/mmc/host/mmci_stm32_sdmmc.c

-- 
2.7.4
