From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 18 Oct 2012 19:18:15 +0200
Subject: [PATCH 0/8] Convert Ux500 to SPARSE_IRQ
Message-ID: <1350580695-8303-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This patch series fixes the prerequisites and then converts Ux500
to SPARSE_IRQ.

- Patch [1/8] "clk/ux500: explicitly include register header"
  can be applied as a fix to the -rc:s into Mikes clk tree.
  If I shall keep it in this series I request Mike to ACK it.

- Patch [6/8] and [7/8] needs to be tested with device tree
  boots to make sure they do not cause regressions, Lee can you
  help me with this? After that I'd prefer to get Sam's ACK
  and merge with this series so it becomes bisectable.

The rest is within my own Ux500/pinctrl domain.

However it is based off the nomadik branch in the pinctrl
tree and the dependency is hard to cut. Here is why:

- Earlier pinctrl patches (not in this series) alter the
  <plat/gpio-nomadik.h> file, merges <plat/pincfg.h> and
  finally move it down into
  <linux/platform_data/pinctrl-nomadik.h>

- Then this series further moves <plat/ste_dma40.h> out of
  the way and down into <linux/platform_data/dma-ste-dma40.h>

- Then there are some patches to the clocksource driver
  residng in plat-nomadik/timer.c

- Finally the clocksource driver in plat-nomadik/timer.c
  is moved out to drivers/clocksource/nomadik-mtu.c and
  it's header is simultaneously moved to
  <linux/platform_data/clocksource-nomadik-mtu.h>

- At this point, plat-nomadik is empty and must be deleted,
  because apart from looking ugly, the build system does not
  allow an empty Makefile.

So for this reason the final MTU patch will close the light
and delete plat-nomadik.

Imagine some of these files going through different trees...
(The alternative is of course to split the stuff across
two merge windows or something like that, but if all the
stuff shall go in at once this is the best I can think of.)

Therefore I will probably request that all the queued pinctrl
patches for Ux500 with this series on top be funneled into ARM
SoC for the next merge window once this series is deemed stable.

Alternatively I can carry all of it in the pinctrl tree with
proper ACKs.

After this series I tried turning on multiplatform for ux500
but there are still headers in <mach/*> creating problems
so we are still just halfway.

Linus Walleij (8):
  clk/ux500: explicitly include register header
  ARM: plat-nomadik: pass IRQ to timer driver
  ARM: plat-nomadik: use DIV_ROUND_CLOSEST()
  ARM: plat-nomadik: move DMA40 header to <linux/platform_data>
  ARM: plat-nomadik: move MTU, kill plat-nomadik
  mfd/ab8500-core: use irq_domain_add_simple()
  mfd/db8500-prcmu: use the irq_domain_add_simple()
  ARM: plat-nomadik: convert platforms to SPARSE_IRQ

 arch/arm/Kconfig                                   |   3 +-
 arch/arm/Makefile                                  |   1 -
 arch/arm/mach-nomadik/Kconfig                      |   2 +-
 arch/arm/mach-nomadik/board-nhk8815.c              |  10 +-
 arch/arm/mach-nomadik/include/mach/irqs.h          |   2 +-
 arch/arm/mach-ux500/Kconfig                        |   2 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |   3 +-
 arch/arm/mach-ux500/board-mop500-sdi.c             |   2 +-
 arch/arm/mach-ux500/board-mop500.c                 |   4 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |   1 +
 arch/arm/mach-ux500/devices-common.c               |   1 +
 arch/arm/mach-ux500/devices-db8500.c               |   4 +-
 arch/arm/mach-ux500/devices-db8500.h               |   1 +
 arch/arm/mach-ux500/include/mach/irqs.h            |   2 +-
 arch/arm/mach-ux500/include/mach/msp.h             |   2 +-
 arch/arm/mach-ux500/timer.c                        |   5 +-
 arch/arm/mach-ux500/usb.c                          |   4 +-
 arch/arm/plat-nomadik/Kconfig                      |  29 ---
 arch/arm/plat-nomadik/Makefile                     |   5 -
 arch/arm/plat-nomadik/include/plat/mtu.h           |   9 -
 arch/arm/plat-nomadik/include/plat/ste_dma40.h     | 223 --------------------
 arch/arm/plat-nomadik/timer.c                      | 223 --------------------
 drivers/char/hw_random/Kconfig                     |   2 +-
 drivers/clk/ux500/u8500_clk.c                      |   2 +-
 drivers/clocksource/Kconfig                        |  17 +-
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/nomadik-mtu.c                  | 224 +++++++++++++++++++++
 drivers/crypto/ux500/cryp/cryp_core.c              |   3 +-
 drivers/dma/ste_dma40.c                            |   3 +-
 drivers/dma/ste_dma40_ll.c                         |   2 +-
 drivers/input/keyboard/Kconfig                     |   2 +-
 drivers/mfd/ab8500-core.c                          |  13 +-
 drivers/mfd/db8500-prcmu.c                         |  12 +-
 drivers/mtd/nand/Kconfig                           |   2 +-
 drivers/pinctrl/pinctrl-nomadik.c                  |   3 +-
 .../linux/platform_data/clocksource-nomadik-mtu.h  |   9 +
 include/linux/platform_data/crypto-ux500.h         |   2 +-
 include/linux/platform_data/dma-ste-dma40.h        | 223 ++++++++++++++++++++
 sound/soc/ux500/ux500_pcm.c                        |   3 +-
 39 files changed, 519 insertions(+), 542 deletions(-)
 delete mode 100644 arch/arm/plat-nomadik/Kconfig
 delete mode 100644 arch/arm/plat-nomadik/Makefile
 delete mode 100644 arch/arm/plat-nomadik/include/plat/mtu.h
 delete mode 100644 arch/arm/plat-nomadik/include/plat/ste_dma40.h
 delete mode 100644 arch/arm/plat-nomadik/timer.c
 create mode 100644 drivers/clocksource/nomadik-mtu.c
 create mode 100644 include/linux/platform_data/clocksource-nomadik-mtu.h
 create mode 100644 include/linux/platform_data/dma-ste-dma40.h

-- 
1.7.11.3
