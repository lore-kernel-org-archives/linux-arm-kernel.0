From: mporter@ti.com (Matt Porter)
Date: Thu, 16 Aug 2012 17:44:28 -0400
Subject: [PATCH 0/3] DaVinci DMA engine conversion
Message-ID: <1345153471-22757-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series begins the conversion of the DaVinci private
EDMA API implementation to a DMA engine driver and
converts two of the three in-kernel users of the private
EDMA API to DMA engine.

The approach taken is similar to the recent OMAP DMA
Engine conversion. The EDMA DMA Engine driver is a
wrapper around the existing private EDMA implementation
and registers the platform device within the driver.
This allows the conversion series to stand alone with
just the drivers and no changes to platform code. It
also allows peripheral drivers to continue to use the
private EDMA implementation until they are converted.

The EDMA DMA Engine driver supports slave transfers only
at this time. It is planned to add cyclic transfers in
support of audio peripherals.

There are three users of the private EDMA API in the
kernel now: davinci_mmc, spi-davinci, and davinci-mcasp.
This series provides DMA Engine conversions for the
davinci_mmc and spi-davinci drivers which use the
supported slave transfers.

This series has been tested on an AM18x EVM and
performance is comparable with the private EDMA
API implementations. I do not have a Wifi module
for the AM18x EVM to test the MMC1 instance which
has DMA channels on the second EDMA channel controller
instance. Testing is needed on all DaVinci platforms
including DM355/365, DM644x/6x, DA830/OMAP-L137/AM17x,
and DA850/OMAP-L138/AM18x.

After this series, the current plan is to complete
the mcasp driver conversion which includes adding
cyclic dma support. This will then enable the
removal and refactoring of the private EDMA API
functionality into the EDMA DMA Engine driver.
Since EDMA is also used on the AM33xx family of
parts in mach-omap2/, the plan is to enable this
driver on that platform as well.

Matt Porter (3):
  dmaengine: add TI EDMA DMA engine driver
  mmc: davinci_mmc: convert to DMA engine API
  spi: spi-davinci: convert to DMA engine API

 drivers/dma/Kconfig            |    9 +
 drivers/dma/Makefile           |    1 +
 drivers/dma/edma.c             |  729 ++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/davinci_mmc.c |  271 +++++----------
 drivers/spi/spi-davinci.c      |  292 +++++++---------
 include/linux/edma.h           |   29 ++
 6 files changed, 980 insertions(+), 351 deletions(-)
 create mode 100644 drivers/dma/edma.c
 create mode 100644 include/linux/edma.h

-- 
1.7.9.5
