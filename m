From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 29 Jun 2015 21:04:26 +0800
Subject: [PATCH v2 0/4] Add Mediatek SPI bus driver 
Message-ID: <1435583070-9600-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek SPI BUS controller has 3 hardware restrictions:
1. Hw has the restriction that in one transfer, length must be a multiple of
   1024, when it's greater than 1024bytes.
2. Hw tx/rx have 4bytes aligned restriction.
3. For MT8173 IC: RX must enable TX, then TX transfer dummy data; TX don't need
   to enable RX.
Some workarounds are done in SPI driver code base on v4.1-rc1.

Change in v2:
1. Remove spi bitbang framwork, use can_dma() and transfer_one().
2. Add PM functions.
3. Fix Mark Brown review comment.

Leilk Liu (4):
  spi: support spi without dma channel to use can_dma()
  dt-bindings: ARM: Mediatek: Document devicetree bindings for spi bus
  spi: mediatek: Add spi bus for Mediatek MT8173
  arm64: dts: Add spi bus dts

 .../devicetree/bindings/spi/spi-mt65xx.txt         |  32 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   9 +
 drivers/spi/Kconfig                                |   9 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mt65xx.c                           | 656 +++++++++++++++++++++
 drivers/spi/spi.c                                  |  22 +-
 6 files changed, 725 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
 create mode 100644 drivers/spi/spi-mt65xx.c

--
1.8.1.1.dirty
