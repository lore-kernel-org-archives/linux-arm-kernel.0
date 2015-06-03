From: hramrach@gmail.com (Michal Suchanek)
Date: 3 Jun 2015 21:26:39 -0000
Subject: [PATCH 00/11] Enable access to SPI NOR flash on Samsung Snow board
Message-ID: <cover.1433364398.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch series makes it possible to access the SPI NOR flash in the Samsung
XE303 'Snow' Chromebook.

Unfortunately not all issues are resolved. To work around an issue with the
pl330 dma engine I respun the patch for limiting transfer size in m25p80
driver.

As the flash does not contain any sane filesystem and is only likely to be
accessed with mtd_debug or similar tool the limit of the dma engine is easily
reached. Filesystems using shorter data transfers are less likely to be
affected.

Thanks

Michal



Michal Suchanek (11):
  ARM: dt: Add SPI CS on Samsung Snow board.
  mtd: spi-nor: Add GD25LQ32C 1.8V SPI NOR flash ID
  mtd: add debug prints to mtdpart partition parser.
  mtd: ofpart: do not fail probe when no partitions exist
  mtd: mtdpart: Do not fail mtd probe when parsing partitions fails.
  mtd: spi-nor: rework spi nor read and write.
  mtd: spi-nor: rework write loop
  MTD: m25p80: Add option to limit SPI transfer size.
  dma: pl330: fix wording in mcbufsz message
  spi: add more debug prints in s3c64xx
  dt: Exynos: add Snow SPI NOR node.

 .../devicetree/bindings/mtd/jedec,spi-nor.txt      |  6 ++
 arch/arm/boot/dts/exynos5250-snow.dts              | 15 +++-
 drivers/dma/pl330.c                                |  4 +-
 drivers/mtd/devices/m25p80.c                       | 57 +++++++++++----
 drivers/mtd/mtdpart.c                              |  9 ++-
 drivers/mtd/ofpart.c                               |  4 +-
 drivers/mtd/spi-nor/fsl-quadspi.c                  | 29 ++++----
 drivers/mtd/spi-nor/spi-nor.c                      | 80 ++++++++++++----------
 drivers/spi/spi-s3c64xx.c                          | 30 ++++++++
 include/linux/mtd/spi-nor.h                        |  8 +--
 10 files changed, 166 insertions(+), 76 deletions(-)

-- 
2.1.4
