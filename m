From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 21:10:51 +0200
Subject: [PATCH v2 0/8] ARM: s3c64xx: Let amba-pl08x driver handle DMA
Message-ID: <1381950659-12703-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the patches extending support of amba-pl08x DMA engine driver to
PL080S DMA engine (PL080 modified by Samsung) found in Samsung S3C64xx
SoCs got merged into Linux 3.12, it is a good time to migrate the
platform to use this driver and drop the legacy DMA code.

Due to changes scattered across different areas of kernel, patches are
based on merged 4 branches:
 - for-next of Kukjin Kim's Samsung tree,
 - clk-next of Mike Turquette's clock tree,
 - for-next of Mark Brown's SPI tree,
 - for-next of Mark Brown's ASoC tree.

To ease testing I have prepared a branch in my private tree for anyone
willing to check the patches out:
	git://github.com/tom3q/linux.git s3c64xx-pl08x-patches

On S3C64xx-based Mini6410 and SMDK6410 boards, with I2S audio
playback and capture (including full duplex operation) and also SPI
using spidev:

Tested-by: Tomasz Figa <tomasz.figa@gmail.com>

Changes since v1:
 - Dropped the now merged patches adding PL080s support amba-pl08x driver,
 - Rebased onto current for-next branches of respective trees.
 - Stopped hijacking pl330_filter() symbol to plug pl08_filter_id()
   as channel filtering callback on S3C64xx.

Changes since RFC v2:
 - Added clkdev lookups to old clock driver.
 - Added patches removing the old DMA driver and any remaining code
   needed by it.
 - Fixed DMA support for SPI.
 - Added a word about PL080S to amba-pl08x.c file header.
 - Changed definition of LLI words from enums to macros.
 - Extended debugging messages to handle PL080S variant as well.
 - Little cleanup of LLI dumping code.
 - Added check for peripheral flow control, which is unsupported by
   PL080S to dma_set_runtime_config.
 - Corrected transfer size mask of PL080S.

Changes since RFC v1:
 - Returned to original way of storing quirks as booleans, as suggested
   by Russell, Linus and Arnd.
 - Added reg_config field to pl08x_phy_chan struct, which stores
   variant-specific address of channel config register, as suggested
   by Russell.
 - Simplified handling of extended maximum transfer size of PL080S
   (no more conditional passing of 0 as length to pl08x_cctl_bits()).
 - Reworked LLI handling in the driver to stop casting arbitrary memory
   to a struct and allow different word count of LLI entry, as suggested
   by Linus.
 - Removed AMBA ID override from S3C64xx PL080 initialization code.
 - Fixed brokenness of Samsung DMA wrapper API, which caused cyclic buffers
   to be queued multiple times when DMA engine is used.
 - Included patch adding clock aliases for DMA engines (depends on
   Common Clock Framework driver for S3C64xx).
 - Fixed several minor stylistic issues.

Tomasz Figa (8):
  spi: s3c64xx: Do not require legacy DMA API in case of S3C64XX
  ASoC: Samsung: Do not require legacy DMA API in case of S3C64XX
  ARM: s3c64xx: Add support for DMA using generic amba-pl08x driver
  clk: samsung: s3c64xx: Add aliases for DMA clocks
  ARM: s3c64xx: Remove legacy DMA driver
  clk: samsung: s3c64xx: Remove clock aliases of old DMA driver
  spi: s3c64xx: Always select S3C64XX_PL080 when ARCH_S3C64XX is enabled
  ASoC: Samsung: Always select S3C64XX_PL080 when ARCH_S3C64XX is
    enabled

 arch/arm/Kconfig                         |   1 +
 arch/arm/mach-s3c64xx/Kconfig            |   7 +-
 arch/arm/mach-s3c64xx/Makefile           |   2 +-
 arch/arm/mach-s3c64xx/common.h           |   5 +
 arch/arm/mach-s3c64xx/dma.c              | 762 -------------------------------
 arch/arm/mach-s3c64xx/include/mach/dma.h | 144 ++----
 arch/arm/mach-s3c64xx/pl080.c            | 244 ++++++++++
 arch/arm/plat-samsung/devs.c             |  10 +-
 arch/arm/plat-samsung/dma-ops.c          |   8 +-
 drivers/clk/samsung/clk-s3c64xx.c        |   4 +-
 drivers/spi/Kconfig                      |   2 +-
 sound/soc/samsung/Kconfig                |   2 +-
 12 files changed, 316 insertions(+), 875 deletions(-)
 delete mode 100644 arch/arm/mach-s3c64xx/dma.c
 create mode 100644 arch/arm/mach-s3c64xx/pl080.c

-- 
1.8.3.2
