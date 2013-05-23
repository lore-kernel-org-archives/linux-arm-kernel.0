From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 23 May 2013 21:34:22 +0200
Subject: [GIT PULL] ux500 DMA40 device tree migration base
Message-ID: <CACRpkdZjr=48_GJxsoYgK7DFUqLs10x4o9yky3MzNR7vh24ogA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here is a patch set that Lee has been chiseling out recently. I've
accumulated it in my ux500 tree and piled ACKs on the first 36
patches of the patch set. Basically that includes ACKs from
subsystem maintainers Vinod Koul and Herbert Xu for affected
parts.

We need to get this into Linux-next to proceed with further
migration on top of it. All have been circulated on the lists for
a while.

Please pull this into an apropriate ARM SoC branch for v3.11!

If we can get ACKs for the rest of the patches in Lee's set these
will arrive on top of this base as soon as they are ready.

Yours,
Linus Walleij

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dma40-for-arm-soc

for you to fetch changes up to 95e4bf98520c9a92cd1b87d12c89e8c60c5fe2ca:

  ARM: ux500: Register Cryp and Hash platform drivers on Snowball
(2013-05-23 21:14:25 +0200)

----------------------------------------------------------------
This is a set of patches from Lee Jones to start converting
the ux500 to fetch DMA channels from the device tree:
- Full DT support and channel mapping in the DMA40 driver
- Dropping of platform data for migrated devices on the DT
  boot path.

----------------------------------------------------------------
Lee Jones (35):
      dmaengine: ste_dma40: Assign memcpy channels in the driver
      dmaengine: ste_dma40: Move default memcpy configs into the driver
      dmaengine: ste_dma40: Rectify incorrect configuration validation checking
      dmaengine: ste_dma40: Amalgamate DMA source and destination
channel numbers
      ARM: ux500: Strip out duplicate USB DMA configuration
      dmaengine: ste_dma40: Remove home-brew MAX() macro
      ARM: ux500: Remove unused 'data_width' attributes from SDI DMA configs
      ARM: ux500: Remove unused 'data_width' attributes from SSP DMA configs
      ARM: ux500: Remove unused 'data_width' attributes from UART DMA configs
      ARM: ux500: Remove superfluous 'psize' attribute from Audio platform data
      dmaengine: ste_dma40: Calculate number of logical channels from
physical ones
      dmaengine: ste_dma40: Remove 'always true' checking
      dmaengine: ste_dma40: Move rev error-check up to revision acquisition
      dmaengine: ste_dma40: Also report the number of logical channels
      dmaengine: ste_dma40: Allocate plat_data on declaration
      dmaengine: ste_dma40: Allow driver to be probe()able when DT is enabled
      dmaengine: ste_dma40: Supply full Device Tree parsing support
      ARM: ux500: Pass remnant platform data though to DMA40 driver
      dmaengine: ste_dma40: Separate Logical Global Interrupt Mask
(GIM) unmasking
      dmaengine: ste_dma40: Remove unnecessary call to d40_phy_cfg()
      dmaengine: ste_dma40: Don't configure runtime configurable setup
during allocate
      ARM: ux500: Stop passing UART's platform data for Device Tree boots
      dmaengine: ste_dma40: Only use addresses passed as configuration
information
      dmaengine: ste_dma40: Remove redundant address fetching function
      ARM: ux500: Remove DMA address look-up table
      dmaengine: ste_dma40: Correct copy/paste error
      ARM: ux500: Remove unnecessary attributes from DMA channel request pdata
      crypto: ux500/hash - Prepare clock before enabling it
      crypto: ux500/hash - Set DMA configuration though dma_slave_config()
      ARM: ux500: Stop passing Hash DMA channel config information though pdata
      crypto: ux500/cryp - Prepare clock before enabling it
      crypto: ux500/cryp - Set DMA configuration though dma_slave_config()
      ARM: ux500: Stop passing Cryp DMA channel config information though pdata
      crypto: ux500/[cryp|hash] - Show successful start-up in the bootlog
      ARM: ux500: Register Cryp and Hash platform drivers on Snowball

Linus Walleij (1):
      dmaengine: ste_dma40: Fix up static memcpy event lines

 .../devicetree/bindings/dma/ste-dma40.txt          |  62 ++++
 arch/arm/mach-ux500/board-mop500-audio.c           |  56 +---
 arch/arm/mach-ux500/board-mop500-sdi.c             |  40 +--
 arch/arm/mach-ux500/board-mop500.c                 |  63 +---
 arch/arm/mach-ux500/board-mop500.h                 |   1 +
 arch/arm/mach-ux500/cpu-db8500.c                   |  52 +--
 arch/arm/mach-ux500/devices-db8500.c               | 123 +------
 arch/arm/mach-ux500/ste-dma40-db8500.h             | 193 ++++-------
 arch/arm/mach-ux500/usb.c                          |  18 +-
 drivers/crypto/ux500/cryp/cryp.h                   |   7 +-
 drivers/crypto/ux500/cryp/cryp_core.c              |  31 +-
 drivers/crypto/ux500/hash/hash_alg.h               |   5 +-
 drivers/crypto/ux500/hash/hash_core.c              |  24 +-
 drivers/dma/ste_dma40.c                            | 366 ++++++++++++---------
 drivers/dma/ste_dma40_ll.c                         | 106 +++---
 drivers/dma/ste_dma40_ll.h                         |   3 +-
 include/linux/platform_data/dma-ste-dma40.h        |  20 +-
 17 files changed, 504 insertions(+), 666 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ste-dma40.txt
