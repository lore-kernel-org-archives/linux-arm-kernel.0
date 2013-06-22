From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 22 Jun 2013 22:42:32 +0200
Subject: [RFC PATCH v2 00/12] ARM: s3c64xx: Let amba-pl08x driver handle DMA
Message-ID: <1371933764-24875-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is another version of my patches extending support of amba-pl08x
DMA engine driver to PL080S DMA engine (PL080 modified by Samsung) found
in Samsung S3C64xx SoCs.

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
 
For reference, here is the original description of the series:

One of the biggest roadblocks on the way of S3C64xx to DeviceTree support
is its DMA driver, which is completely platform-specific and provides
private API (s3c-dma), not even saying that its design is completely
against multiplatform-awareness.

The DMA controller present on this SoC series is a custom variant
of ARM PrimeCell PL080 modified by Samsung to add some extra features.
It is mostly compatible with original PL080, except:
 - CH_CONTROL2 register is added between CH_CONTROL and CH_CONFIG,
 - offset of CH_CONFIG register is different,
 - transfer size field is moved from CH_CONTROL to CH_CONTROL2,
 - transfer size field is extended to 24 bits, allowing much bigger
     single transfer,
 - LLI consists of one more word, to account for CH_CONTROL2 register.

Since all the rest is fully compatible with standard PL080 there is no
point in having separate driver just for this single variant, so I decided
to look into adding support for it to the amba-pl08x driver.

There was already some attempt to achieve this before, but this was before
Russel's big rework of the driver to use virtual channels, making the old
patches being not much of use.

This RFC series is a proof of concept that I managed to make during last
days of hacking. Except one patch adding clkdev lookup to clock driver
(which is being replaced with a CCF-compliant driver ATM), this is enough
to get memcpy and slave transfers to work on S3C64xx.

I have tested this on Mini6410 and SMDK6410 boards using dmatest for
memcpy and Samsung I2S with madplay/aplay for slave transfers.
Unfortunately I do not have access to other platforms with PL08x so
I could not test for any regressions introduced on them.

Credits for two patches go to Alban Bedel, who made a series fixing this
driver to make it usable with audio drivers. I rebased his patches on top
of mine and corrected coding style a bit.

OK, that's all. Any comments are welcome. Feel free to start throwing eggs
and tomatoes if you find this awful, but I won't be upset if I get some
Tested-by or Acked-by as well. ;)

Alban Bedel (2):
  dmaengine: PL08x: Fix reading the byte count in cctl
  dmaengine: PL08x: Add cyclic transfer support

Tomasz Figa (10):
  dmaengine: PL08x: Refactor pl08x_getbytes_chan() to lower indentation
  dmaengine: PL08x: Add support for different offset of CONFIG register
  dmaengine: PL08x: Rework LLI handling to be less fragile
  dmaengine: PL08x: Add support for PL080S variant
  dmaengine: PL08x: Add support for different maximum transfer size
  ASoC: Samsung: Do not queue cyclic buffers multiple times
  clk: samsung: s3c64xx: Add aliases for DMA clocks
  spi: s3c64xx: Do not require legacy DMA API in case of S3C64XX
  ASoC: Samsung: Do not require legacy DMA API in case of S3C64XX
  ARM: s3c64xx: Add support for DMA using generic amba-pl08x driver

 arch/arm/Kconfig                         |   1 +
 arch/arm/mach-s3c64xx/Kconfig            |   8 +-
 arch/arm/mach-s3c64xx/Makefile           |   1 +
 arch/arm/mach-s3c64xx/common.h           |   5 +
 arch/arm/mach-s3c64xx/include/mach/dma.h |  65 +++++
 arch/arm/mach-s3c64xx/pl080.c            | 244 ++++++++++++++++++
 arch/arm/plat-samsung/s3c-dma-ops.c      |  13 +-
 drivers/clk/samsung/clk-s3c64xx.c        |   2 +
 drivers/dma/amba-pl08x.c                 | 426 ++++++++++++++++++++++---------
 drivers/spi/Kconfig                      |   2 +-
 include/linux/amba/pl080.h               |   1 +
 sound/soc/samsung/Kconfig                |   2 +-
 sound/soc/samsung/dma.c                  |   7 +
 13 files changed, 651 insertions(+), 126 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/pl080.c

-- 
1.8.2.1
