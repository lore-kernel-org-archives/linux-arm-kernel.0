From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 14:42:37 -0500
Subject: [PATCH v2 0/6] Make mach/gpio.h optional
Message-ID: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This is series makes mach/gpio.h optional like we have done for other
mach headers in preparation for multi-platform kernel images.

This version does not add any includes of mach/gpio.h. For orion and
shmobile, the mach/gpio.h headers are renamed to platform specific names.
I've dropped pxa, omap and at91 from this series until better clean-up
is done. omap and at91 have clean-ups in the works. I included some of
the pxa clean-ups I did, but this series is not dependent on them.

This is build tested on all ARM defconfigs.

The series plus multi-platform support is available here:

git://sources.calxeda.com/kernel/linux.git multi-plat

Rob

Rob Herring (6):
  usb: pxa27x_udc: remove IRQ_USB define
  net: pxaficp_ir: add irq resources
  ARM: pxa: use gpio_to_irq for sharppm_sl
  ARM: shmobile: move custom gpio functions to sh-gpio.h
  ARM: orion: move custom gpio functions to orion-gpio.h
  ARM: make mach/gpio.h headers optional

 arch/arm/Kconfig                               |   21 ++++++++
 arch/arm/include/asm/gpio.h                    |    2 +
 arch/arm/mach-dove/include/mach/gpio.h         |    9 ----
 arch/arm/mach-dove/irq.c                       |    1 +
 arch/arm/mach-dove/mpp.c                       |    1 +
 arch/arm/mach-ep93xx/include/mach/gpio.h       |    1 -
 arch/arm/mach-highbank/include/mach/gpio.h     |    1 -
 arch/arm/mach-ixp4xx/include/mach/gpio.h       |    2 -
 arch/arm/mach-kirkwood/include/mach/gpio.h     |    9 ----
 arch/arm/mach-kirkwood/irq.c                   |    1 +
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c   |    1 +
 arch/arm/mach-msm/include/mach/gpio.h          |    1 -
 arch/arm/mach-mv78xx0/irq.c                    |    1 +
 arch/arm/mach-mxs/include/mach/gpio.h          |    1 -
 arch/arm/mach-nomadik/include/mach/gpio.h      |    4 --
 arch/arm/mach-orion5x/d2net-setup.c            |    1 +
 arch/arm/mach-orion5x/dns323-setup.c           |    1 +
 arch/arm/mach-orion5x/include/mach/gpio.h      |    9 ----
 arch/arm/mach-orion5x/irq.c                    |    1 +
 arch/arm/mach-orion5x/net2big-setup.c          |    1 +
 arch/arm/mach-picoxcell/include/mach/gpio.h    |    1 -
 arch/arm/mach-pxa/devices.c                    |   15 ++++++
 arch/arm/mach-pxa/sharpsl_pm.c                 |   30 +++++++-----
 arch/arm/mach-realview/include/mach/gpio.h     |    1 -
 arch/arm/mach-shmobile/board-ap4evb.c          |    2 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +
 arch/arm/mach-shmobile/board-g4evm.c           |    2 +
 arch/arm/mach-shmobile/board-mackerel.c        |    2 +
 arch/arm/mach-shmobile/include/mach/gpio.h     |   62 ------------------------
 arch/arm/mach-shmobile/pfc-r8a7740.c           |    2 +-
 arch/arm/mach-shmobile/pfc-r8a7779.c           |    2 +-
 arch/arm/mach-shmobile/pfc-sh7367.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh7372.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh7377.c            |    2 +-
 arch/arm/mach-shmobile/pfc-sh73a0.c            |    2 +-
 arch/arm/mach-shmobile/sh-gpio.h               |   48 ++++++++++++++++++
 arch/arm/mach-spear13xx/include/mach/gpio.h    |   19 --------
 arch/arm/mach-spear3xx/include/mach/gpio.h     |   19 --------
 arch/arm/mach-spear6xx/include/mach/gpio.h     |   19 --------
 arch/arm/mach-tegra/include/mach/gpio.h        |    1 -
 arch/arm/mach-u300/include/mach/gpio.h         |    1 -
 arch/arm/mach-ux500/include/mach/gpio.h        |    5 --
 arch/arm/mach-versatile/include/mach/gpio.h    |    1 -
 arch/arm/mach-vexpress/include/mach/gpio.h     |    1 -
 arch/arm/mach-vt8500/include/mach/gpio.h       |    1 -
 arch/arm/plat-mxc/include/mach/gpio.h          |    1 -
 arch/arm/plat-orion/include/plat/gpio.h        |   37 --------------
 arch/arm/plat-orion/include/plat/orion-gpio.h  |   37 ++++++++++++++
 arch/arm/plat-orion/mpp.c                      |    1 +
 arch/arm/plat-spear/include/plat/gpio.h        |    1 -
 drivers/net/irda/pxaficp_ir.c                  |   28 ++++++-----
 drivers/sh/pfc/gpio.c                          |    1 +
 drivers/usb/gadget/pxa27x_udc.c                |    2 +-
 53 files changed, 183 insertions(+), 238 deletions(-)
 delete mode 100644 arch/arm/mach-dove/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-kirkwood/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-msm/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-orion5x/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-realview/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-shmobile/include/mach/gpio.h
 create mode 100644 arch/arm/mach-shmobile/sh-gpio.h
 delete mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear3xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-spear6xx/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-u300/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-versatile/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-vexpress/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-vt8500/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-mxc/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-orion/include/plat/gpio.h
 create mode 100644 arch/arm/plat-orion/include/plat/orion-gpio.h
 delete mode 100644 arch/arm/plat-spear/include/plat/gpio.h

-- 
1.7.9.5
