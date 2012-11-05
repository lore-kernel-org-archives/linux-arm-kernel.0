From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Nov 2012 10:25:41 +0100
Subject: [GIT PULL] kill plat-nomadik and convert Nomadik+Ux500 to SPARSE_IRQ
Message-ID: <CACRpkdY9ppMQ5UG5WRCJQSbme82HJACF8pz9v4SVbC6_CUt+2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

this pull request will move all headers away from plat-nomadik, move the
timer driver to drivers/clocksource, delete plat-nomadik and then convert
Nomadik and Ux500 to SPARSE_IRQ. I consider this a big piece of
cleanup that we need to move ahead with single zImage.

As discussed with Arnd in Copenhagen here is a pull request including a few
patches that are for obvious reasons also in the pinctrl tree. We will have
to fix this up in the merge window as the end result is the removal of the
plat-nomadik directory which means there will be massive collissions if we
try to pretend the changes are orthogonal.

The patches have all been circulated to relevant subsystem maintainers,
but I have not recieved an ACK from Samuel Ortiz, Mike Turquette yet,
nor from the clocksource maintainer.

However they have had time to review the patches and they're basically
only changing #include <> statements and so I think we should move ahead
with this anyway. I'm a bit uncertain about the clocksource though, it should
be straight-forward.

Waiting for weeks for ACKs before being able to merge to ARM SoC
will delay any linux-next testing which slows down everything :-(

Signed tag per below.

Yours,
Linus Walleij


The following changes since commit 8f0d8163b50e01f398b14bcd4dc039ac5ab18d64:

  Linux 3.7-rc3 (2012-10-28 12:24:48 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/kill-plat-sparse-irq

for you to fetch changes up to c3b9d1db23c4ebd4d8a0964ebcf5f27d4eb8fa3f:

  ARM: plat-nomadik: convert platforms to SPARSE_IRQ (2012-11-05 09:55:34 +0100)

----------------------------------------------------------------
This patchset will:
- Move all remaining headers out of arch/arm/plat-nomadik/include/plat
  out to e.g. include/linux/platform_data
- Delete arch/arm/plat-nomadik
- Convert Nomadik and Ux500 to SPARSE_IRQ

----------------------------------------------------------------
Linus Walleij (10):
      pinctrl/nomadik: move the platform data header
      pinctrl/nomadik: merge old pincfg header
      clk/ux500: explicitly include register header
      ARM: plat-nomadik: pass IRQ to timer driver
      ARM: plat-nomadik: use DIV_ROUND_CLOSEST()
      ARM: plat-nomadik: move DMA40 header to <linux/platform_data>
      ARM: plat-nomadik: move MTU, kill plat-nomadik
      mfd/ab8500-core: use irq_domain_add_simple()
      mfd/db8500-prcmu: use the irq_domain_add_simple()
      ARM: plat-nomadik: convert platforms to SPARSE_IRQ

Maxime Coquelin (1):
      ARM: plat-nomadik: Introduce new DB8540 GPIO registers

Patrice Chotard (1):
      ARM: plat-nomadik: move NMK_GPIO_PER_CHIP into gpio-nomadik.h

 arch/arm/Kconfig                                   |   3 +-
 arch/arm/Makefile                                  |   1 -
 arch/arm/mach-nomadik/Kconfig                      |   2 +-
 arch/arm/mach-nomadik/board-nhk8815.c              |  13 +--
 arch/arm/mach-nomadik/cpu-8815.c                   |   2 +-
 arch/arm/mach-nomadik/i2c-8815nhk.c                |   3 +-
 arch/arm/mach-nomadik/include/mach/irqs.h          |   2 +-
 arch/arm/mach-ux500/Kconfig                        |   2 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |   6 +-
 arch/arm/mach-ux500/board-mop500-pins.c            |   3 +-
 arch/arm/mach-ux500/board-mop500-sdi.c             |   2 +-
 arch/arm/mach-ux500/board-mop500.c                 |   6 +-
 arch/arm/mach-ux500/cpu-db8500.c                   |   5 +-
 arch/arm/mach-ux500/devices-common.c               |   4 +-
 arch/arm/mach-ux500/devices-db8500.c               |   4 +-
 arch/arm/mach-ux500/devices-db8500.h               |   1 +
 arch/arm/mach-ux500/include/mach/irqs.h            |   2 +-
 arch/arm/mach-ux500/include/mach/msp.h             |   2 +-
 arch/arm/mach-ux500/timer.c                        |   5 +-
 arch/arm/mach-ux500/usb.c                          |   4 +-
 arch/arm/plat-nomadik/Kconfig                      |  29 ------
 arch/arm/plat-nomadik/Makefile                     |   5 -
 arch/arm/plat-nomadik/include/plat/gpio-nomadik.h  | 102 -------------------
 drivers/char/hw_random/Kconfig                     |   2 +-
 drivers/clk/ux500/u8500_clk.c                      |   2 +-
 drivers/clocksource/Kconfig                        |  17 +++-
 drivers/clocksource/Makefile                       |   1 +
 .../timer.c => drivers/clocksource/nomadik-mtu.c   |  11 +-
 drivers/crypto/ux500/cryp/cryp_core.c              |   3 +-
 drivers/dma/ste_dma40.c                            |   3 +-
 drivers/dma/ste_dma40_ll.c                         |   2 +-
 drivers/input/keyboard/Kconfig                     |   2 +-
 drivers/mfd/ab8500-core.c                          |  13 +--
 drivers/mfd/db8500-prcmu.c                         |  12 ++-
 drivers/mtd/nand/Kconfig                           |   2 +-
 drivers/pinctrl/pinctrl-nomadik.c                  |  11 +-
 drivers/pinctrl/pinctrl-nomadik.h                  |   2 +-
 .../linux/platform_data/clocksource-nomadik-mtu.h  |   2 +-
 include/linux/platform_data/crypto-ux500.h         |   2 +-
 .../linux/platform_data/dma-ste-dma40.h            |   0
 .../linux/platform_data/pinctrl-nomadik.h          | 111 +++++++++++++++++++--
 sound/soc/ux500/ux500_pcm.c                        |   3 +-
 42 files changed, 184 insertions(+), 225 deletions(-)
 delete mode 100644 arch/arm/plat-nomadik/Kconfig
 delete mode 100644 arch/arm/plat-nomadik/Makefile
 delete mode 100644 arch/arm/plat-nomadik/include/plat/gpio-nomadik.h
 rename arch/arm/plat-nomadik/timer.c => drivers/clocksource/nomadik-mtu.c (95%)
 rename arch/arm/plat-nomadik/include/plat/mtu.h =>
include/linux/platform_data/clocksource-nomadik-mtu.h (71%)
 rename arch/arm/plat-nomadik/include/plat/ste_dma40.h =>
include/linux/platform_data/dma-ste-dma40.h (100%)
 rename arch/arm/plat-nomadik/include/plat/pincfg.h =>
include/linux/platform_data/pinctrl-nomadik.h (66%)
