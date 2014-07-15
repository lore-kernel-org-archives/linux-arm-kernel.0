From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 15 Jul 2014 17:50:57 +0530
Subject: [PATCH 0/3] spi: s3c64xx: fix the driver to use "cs-gpios" property
Message-ID: <1405426860-18404-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current SPI core has generic implementation for configuring
the Chip select gpios during .setup() & .cleanup(). By modifying
the spi-s3c64xx.c driver to expect the "cs-gpios" property in SPI
device node instead of the subnode "controller-data".

This way we can avoid parsing the "cs-gpios" in the driver.

This patch set also does the following
1. Validate the "struct s3c64xx_spi_csinfo *cs" object and the
   CS gpio for both DT and NON-DT before using them.
2. Correct the dt-bindings for exynos4210-smdkv310.dts, exynos4412-trats2.dts
   and exynos5250-smdk5250.dts
3. Updates the DT bindings.

Note: 
This patchset is a rework of the changes under review @
http://www.mail-archive.com/devicetree at vger.kernel.org/msg34501.html

Tested on Exynos5420 and Exynos5250 based Peach PIT, PI and Snow boards
respectively using the flashrom utility to access SPI flash.

This patchset is needed by the changes
http://www.gossamer-threads.com/lists/linux/kernel/1951607

Tested-by on boards based on Exynos4, S5P, S3C series SoCs
would be appreciated.

Naveen Krishna Chatradhi (3):
  spi: s3c64xx: move property "cs-gpio" from controller_data subnode   
      to SPI DT node
  spi: s3c64xx: validate s3c64xx_spi_csinfo before using
  ARM: DTS: fix the chip select gpios definition in the SPI nodes

 .../devicetree/bindings/spi/spi-samsung.txt        |   10 ++++----
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    2 +-
 drivers/spi/spi-s3c64xx.c                          |   27 +++++++-------------
 5 files changed, 17 insertions(+), 26 deletions(-)

-- 
1.7.9.5
