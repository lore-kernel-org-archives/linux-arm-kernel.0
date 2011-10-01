From: arnd@arndb.de (Arnd Bergmann)
Date: Sat,  1 Oct 2011 22:03:32 +0200
Subject: [PATCH 00/26] ARM: pxa specific randconfig fixes
Message-ID: <1317499438-14058-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric (and others),

Here are lots of tiny bug fixes (and a few bigger ones)
for the pxa platform that I found by running 'make randconfig'.

Could you take a look at these and see if they make sense to
you? The majority is just for corner cases that we are not
generally interested in, except for making sure that
randconfig works, but some are regressions from a previously
working state or are for relevant configurations.

It would be nice if you could either give me an ok to put
all off them into the arm-soc tree for the coming merge window
or cherry-pick the ones that are good and send them back
to me in a pull request.

The series is also available in git at
 git pull git://git.linaro.org/people/arnd/arm-soc.git randconfig/pxa

but I haven't added it to the for-next branch for now.

	Arnd

Arnd Bergmann (26): 
  usb/gadget/pxa25x: is_vbus_present is gone
  sound/pxa-zylonite: use a valid device for dev_err()
  scsi/mvsas: use proper namespace for IRQ_* symbols
  net/pxa168_eth: add missing include of interrupt.h
  ARM: pxa: make zylonite_pxa*_init declaration match code
  ARM: pxa: add missing header inclusions
  ARM: pxa: mbxfb: disable broken debugfs code
  ARM: pxa: move z2 to generic cpu_suspend
  ARM: pxa: export symbols from pxa3xx-ulpi
  ARM: pxa: allow selecting just one of TREO680/CENTRO
  ARM: pxa: allow building palm27x without pxafb
  ARM: pxa: pxa95x/saarb depends on pxa3xx code
  ARM: pxa: use correct __iomem annotations
  mtd: nand_h1900 never worked
  irda/ficp: only works on some pxa models
  ARM: pxa: CPU_PJ4 requires IWMMXT
  ARM: pxa: pxa95x is incompatible with earlier pxa
  ARM: pxa: MTD_XIP is not actually working any more
  ARM: pxa: CPU_FREQ_TABLE is needed for CPU_FREQ
  ARM: pxa: select FB_PXA on saar and tevorevb
  ARM: pxa: select POWER_SUPPLY on raumfeld
  ARM: pxa: only select SMC91x on xcep when networking is enabled
  ARM: pxa: viper: select I2C_GPIO only when I2C is on
  ARM: pxa: centro and treo680 need palm27x
  ARM: pxa: eseries does not require FB
  ARM: pxa: sharpsl pm needs SPI

 arch/arm/Kconfig                          |    4 +-
 arch/arm/include/asm/hardware/it8152.h    |    2 +-
 arch/arm/mach-mmp/clock.h                 |    8 ++--
 arch/arm/mach-mmp/common.c                |    4 +-
 arch/arm/mach-mmp/include/mach/addr-map.h |   10 ++++-
 arch/arm/mach-mmp/mmp2.c                  |    3 +-
 arch/arm/mach-pxa/Kconfig                 |   48 ++++++++++++++++++------
 arch/arm/mach-pxa/Makefile                |    2 +-
 arch/arm/mach-pxa/balloon3.c              |   10 ++--
 arch/arm/mach-pxa/cm-x2xx-pci.c           |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c               |    4 +-
 arch/arm/mach-pxa/include/mach/addr-map.h |    8 ++--
 arch/arm/mach-pxa/include/mach/balloon3.h |    2 +-
 arch/arm/mach-pxa/include/mach/hardware.h |    9 ++--
 arch/arm/mach-pxa/include/mach/lpd270.h   |    4 +-
 arch/arm/mach-pxa/include/mach/mtd-xip.h  |    1 -
 arch/arm/mach-pxa/include/mach/palm27x.h  |    2 +-
 arch/arm/mach-pxa/include/mach/palmtx.h   |    6 +-
 arch/arm/mach-pxa/include/mach/smemc.h    |    2 +-
 arch/arm/mach-pxa/include/mach/zeus.h     |    4 +-
 arch/arm/mach-pxa/include/mach/zylonite.h |    4 +-
 arch/arm/mach-pxa/irq.c                   |    5 +-
 arch/arm/mach-pxa/lpd270.c                |    2 +-
 arch/arm/mach-pxa/palmtreo.c              |    8 ++++
 arch/arm/mach-pxa/palmtx.c                |    8 ++--
 arch/arm/mach-pxa/pxa25x.c                |    2 +-
 arch/arm/mach-pxa/pxa27x.c                |    2 +-
 arch/arm/mach-pxa/pxa3xx-ulpi.c           |    2 +
 arch/arm/mach-pxa/pxa3xx.c                |    2 +-
 arch/arm/mach-pxa/saarb.c                 |    2 +
 arch/arm/mach-pxa/z2.c                    |    3 +-
 arch/arm/mach-pxa/zeus.c                  |    8 ++--
 arch/arm/plat-pxa/gpio.c                  |    2 +-
 arch/arm/plat-pxa/include/plat/mfp.h      |    2 +-
 arch/arm/plat-pxa/mfp.c                   |    4 +-
 drivers/mtd/nand/Kconfig                  |    2 +-
 drivers/net/irda/Kconfig                  |    2 +-
 drivers/net/pxa168_eth.c                  |    1 +
 drivers/pcmcia/pxa2xx_balloon3.c          |    2 +-
 drivers/scsi/mvsas/mv_94xx.c              |   10 ++--
 drivers/scsi/mvsas/mv_94xx.h              |   58 ++++++++++++++--------------
 drivers/usb/gadget/pxa25x_udc.h           |    8 +---
 drivers/video/Kconfig                     |    2 +-
 drivers/video/mbx/Makefile                |    2 +-
 drivers/video/mbx/mbxfb.c                 |    6 +-
 sound/soc/pxa/zylonite.c                  |    8 ++--
 46 files changed, 166 insertions(+), 126 deletions(-)

-- 
1.7.5.4
