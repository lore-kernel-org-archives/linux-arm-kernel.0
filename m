From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun, 22 May 2011 20:03:03 +0300
Subject: [PATCH 0/5] ep93xx DMA patches
Message-ID: <cover.1306082097.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

Motivation of this series was to add DMA support for the ep93xx SPI driver.
However, current platform DMA code didn't support the M2M channels which were
required for SPI (and IDE) peripherals.

Ryan Mallon suggested that maybe we should integrate both M2M and M2P code
under the dmaengine API. The purpose of this series is to do just that and
convert all the existing users to use that new API.

Patches 1-4 add dmaengine driver and convert the existing users to dmaengine
API. The last patch adds DMA support for the SPI driver.

I've been testing these on TS-7260 (ep9302) connected to SPI EEPROM, and
Sim.One (ep9307) with mmc_spi and AC'97 audio.

memcpy() testing has been done by running drivers/dma/dmatest.ko.

Regards,
MW

Mika Westerberg (5):
  dmaengine: add ep93xx DMA support
  ep93xx: add dmaengine platform code
  ASoC: ep93xx: convert to use the DMA engine API
  ep93xx: remove the old M2P DMA code
  spi/ep93xx: add DMA support

 Documentation/spi/ep93xx_spi                   |   10 +
 arch/arm/mach-ep93xx/Makefile                  |    2 +-
 arch/arm/mach-ep93xx/core.c                    |    6 +-
 arch/arm/mach-ep93xx/dma-m2p.c                 |  411 -------
 arch/arm/mach-ep93xx/dma.c                     |  108 ++
 arch/arm/mach-ep93xx/include/mach/dma.h        |  190 ++---
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h |    2 +
 drivers/dma/Kconfig                            |    7 +
 drivers/dma/Makefile                           |    1 +
 drivers/dma/ep93xx_dma.c                       | 1356 ++++++++++++++++++++++++
 drivers/spi/ep93xx_spi.c                       |  303 +++++-
 sound/soc/ep93xx/ep93xx-ac97.c                 |    4 +-
 sound/soc/ep93xx/ep93xx-i2s.c                  |    4 +-
 sound/soc/ep93xx/ep93xx-pcm.c                  |  137 ++--
 14 files changed, 1929 insertions(+), 612 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/dma-m2p.c
 create mode 100644 arch/arm/mach-ep93xx/dma.c
 create mode 100644 drivers/dma/ep93xx_dma.c

-- 
1.7.4.4
