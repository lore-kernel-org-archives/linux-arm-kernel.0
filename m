From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Feb 2016 14:28:46 +0100
Subject: [PATCH] i.MX SPI DMA cleanup
Message-ID: <1455715739-25161-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This picks up a series sent by Anton Bondarenko last year. It
contains the remaining not yet upstreamed patches from Antons series
plus some more DMA related cleanup patches.

My mission was to hunt a bug in the DMA code path sometimes causing
an additional word in the RX FIFO which locked up the driver in the
next transfer. It turned out that this was no bug in the driver but
instead in the device tree: We used the wrong SDMA script for i.MX6.
The ECSPI cores are connected through the SPBA, so according to the
reference manual we need the shp/mcu scripts rather than the app/mcu
scripts.

Shawn, please pick up the last patch. The rest can go through the SPI
tree. The last patch has no dependency on the remaining patches.

Sascha

----------------------------------------------------------------
Anton Bondarenko (3):
      spi: imx: allow only WML aligned transfers to use DMA
      spi: imx: replace fixed timeout with calculated
      spi: imx: add support for all SPI word width for DMA

Sascha Hauer (10):
      spi: imx: use proper dev_* functions for driver messages
      spi: imx: drop fallback to PIO
      spi: imx: initialize usedma earlier
      spi: imx: drop unnecessary read/modify/write
      spi: imx: drop unncessary dma_is_inited variable
      spi: imx: remove unnecessary bit clearing in mx51_ecspi_config
      spi: imx: make some register defines simpler
      spi: imx: set MX51_ECSPI_CTRL_SMC bit in setup function
      spi: imx: drop bogus tests for rx/tx bufs in DMA transfer
      ARM: dts: imx6: Use correct SDMA script for SPI cores

 arch/arm/boot/dts/imx6qdl.dtsi |   8 +-
 drivers/spi/spi-imx.c          | 350 +++++++++++++++++++++--------------------
 2 files changed, 185 insertions(+), 173 deletions(-)
