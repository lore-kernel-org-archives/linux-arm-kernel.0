From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Jun 2013 14:37:50 +0200
Subject: [GIT PULL 4/5]: ux500 DMA40 changes for v3.11
Message-ID: <CACRpkdZhrQDDTUAngE75Errz7v1gGGD7_zm7kjo0ksA=GDhzFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

these are the ux500 DMA40 changes for v3.11. See the signed
tag for details.

This pull request includes the stuff already pulled into your branch
named "ux500/dma40", and this is meant to be pulled on top.
Relative to the previous pull request this contains an additional
19 patches. But all are included here to give an overview of the stuff
here. (Tell me if you prefer the consensed view...)

All but the odd single patch are ACKed but I'm sure that Vinod is
OK with the end result.

I'll take this opportunity to THANK Vinod for his huge effort in
reviewing and ACKing this, as well as thanks to Felipe Balbi
and Herbert Xu for their reviewing.

Yours,
Linus Walleij

The following changes since commit f722406faae2d073cc1d01063d1123c35425939e:

  Linux 3.10-rc1 (2013-05-11 17:14:08 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/ux500-dma40-for-arm-soc-2

for you to fetch changes up to 499c2bc3cc89dcbbf08aa526cd4a984b92a4d2a8:

  dmaengine: ste_dma40: Fetch disabled channels from DT (2013-06-04
11:12:12 +0200)

----------------------------------------------------------------
Second set of DMA40 changes: refactorings and device tree
support for the DMA40. Now with MUSB and some platform
data removal.

----------------------------------------------------------------
Lee Jones (54):
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
      usb: musb: ux500: move channel number knowledge into the driver
      usb: musb: ux500: move the MUSB HDRC configuration into the driver
      usb: musb: ux500: take the dma_mask from coherent_dma_mask
      usb: musb: ux500: harden checks for platform data
      usb: musb: ux500: attempt to find channels by name before using pdata
      usb: musb: ux500: add device tree probing support
      ARM: ux500: Remove ux500-musb platform registation when booting with DT
      ARM: ux500: Remove empty function u8500_of_init_devices()
      dmaengine: ste_dma40: Use the BIT macro to replace ugly '(1 << x)'s
      ARM: ux500: Replace ST-E's home-brew DMA direction definition
with the generic one
      dmaengine: ste_dma40: Replace ST-E's home-brew DMA direction
defs with generic ones
      ARM: ux500: Remove recently unused stedma40_xfer_dir enums
      dmaengine: ste_dma40_ll: Use the BIT macro to replace ugly '(1 << x)'s
      dmaengine: ste_dma40: Convert data_width from register bit format to value
      dmaengine: ste_dma40_ll: Replace meaningless register set with comment
      dmaengine: ste_dma40: Allow memcpy channels to be configured from DT
      ARM: ux500: Stop passing DMA platform data though AUXDATA
      dmaengine: ste_dma40: Fetch the number of physical channels from DT
      dmaengine: ste_dma40: Fetch disabled channels from DT

Linus Walleij (1):
      dmaengine: ste_dma40: Fix up static memcpy event lines

 .../devicetree/bindings/dma/ste-dma40.txt          |  66 +++
 .../devicetree/bindings/usb/ux500-usb.txt          |  50 ++
 arch/arm/mach-ux500/board-mop500-audio.c           |  68 +--
 arch/arm/mach-ux500/board-mop500-sdi.c             |  56 +--
 arch/arm/mach-ux500/board-mop500.c                 |  85 +---
 arch/arm/mach-ux500/board-mop500.h                 |   1 +
 arch/arm/mach-ux500/cpu-db8500.c                   |  65 +--
 arch/arm/mach-ux500/devices-db8500.c               | 123 +----
 arch/arm/mach-ux500/ste-dma40-db8500.h             | 193 +++-----
 arch/arm/mach-ux500/usb.c                          |  47 +-
 drivers/crypto/ux500/cryp/cryp.h                   |   7 +-
 drivers/crypto/ux500/cryp/cryp_core.c              |  31 +-
 drivers/crypto/ux500/hash/hash_alg.h               |   5 +-
 drivers/crypto/ux500/hash/hash_core.c              |  24 +-
 drivers/dma/ste_dma40.c                            | 523 ++++++++++++---------
 drivers/dma/ste_dma40_ll.c                         | 189 ++++----
 drivers/dma/ste_dma40_ll.h                         |   3 +-
 drivers/usb/musb/ux500.c                           |  61 ++-
 drivers/usb/musb/ux500_dma.c                       |  59 ++-
 include/linux/platform_data/dma-ste-dma40.h        |  41 +-
 include/linux/platform_data/usb-musb-ux500.h       |   5 +-
 sound/soc/ux500/ux500_pcm.c                        |  10 +-
 22 files changed, 837 insertions(+), 875 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/ste-dma40.txt
 create mode 100644 Documentation/devicetree/bindings/usb/ux500-usb.txt
