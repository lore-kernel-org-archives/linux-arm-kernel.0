From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:17:09 +0000
Subject: [PATCH 00/19] ARM SA11x0 / PXA / SoC-common PCMCIA cleanups
Message-ID: <20120120101709.GE1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

What follows is a series of 19 patches cleaning up the SA11xx and PXA
PCMCIA support, which uses the soc-common infrastructure.

Now that we have proper gpiolib support in the kernel for these platforms,
with properly implemented gpio_to_irq() functionality, we can move some
things that the individual platform socket drivers were doing into the
soc-common core.

This significantly reduces the code in the platform socket drivers -
a reduction of around 550 lines, for the net addition of about 50 lines
to soc-common.

The final set of five patches in this set contain some minor bug fixes
(which are really low priority) and cleanup the handling of the SA1111
build between PXA and SA11x0 platforms.

Please supply acks; I have other work which touches the header files
in arch/arm which would conflict, and it would help to keep it together
rather than have SFR carry those resolutions.

 arch/arm/mach-pxa/include/mach/balloon3.h          |    1 -
 arch/arm/mach-sa1100/include/mach/assabet.h        |   15 +-
 arch/arm/mach-sa1100/include/mach/cerf.h           |   15 +-
 arch/arm/mach-sa1100/include/mach/nanoengine.h     |   12 +-
 arch/arm/mach-sa1100/include/mach/shannon.h        |   12 +-
 arch/arm/mach-sa1100/include/mach/simpad.h         |    6 +-
 drivers/pcmcia/Kconfig                             |    8 +-
 drivers/pcmcia/Makefile                            |   14 +-
 drivers/pcmcia/pxa2xx_balloon3.c                   |   22 +--
 drivers/pcmcia/pxa2xx_base.c                       |    5 +-
 drivers/pcmcia/pxa2xx_cm_x255.c                    |   39 ++---
 drivers/pcmcia/pxa2xx_cm_x270.c                    |   23 +--
 drivers/pcmcia/pxa2xx_colibri.c                    |   21 +--
 drivers/pcmcia/pxa2xx_e740.c                       |   71 ++------
 drivers/pcmcia/pxa2xx_mainstone.c                  |   31 ++--
 drivers/pcmcia/pxa2xx_palmld.c                     |    8 +-
 drivers/pcmcia/pxa2xx_palmtc.c                     |    8 +-
 drivers/pcmcia/pxa2xx_palmtx.c                     |    8 +-
 drivers/pcmcia/pxa2xx_sharpsl.c                    |   30 +---
 drivers/pcmcia/pxa2xx_stargate2.c                  |   34 +---
 drivers/pcmcia/pxa2xx_trizeps4.c                   |   63 +------
 drivers/pcmcia/pxa2xx_viper.c                      |   39 +----
 drivers/pcmcia/pxa2xx_vpac270.c                    |   54 +-----
 drivers/pcmcia/sa1100_assabet.c                    |   65 ++-----
 drivers/pcmcia/sa1100_cerf.c                       |   52 ++----
 drivers/pcmcia/sa1100_h3600.c                      |   94 ++--------
 drivers/pcmcia/sa1100_nanoengine.c                 |  132 +++-----------
 drivers/pcmcia/sa1100_shannon.c                    |   52 ++----
 drivers/pcmcia/sa1100_simpad.c                     |   27 +--
 .../pcmcia/{sa1100_badge4.c => sa1111_badge4.c}    |    3 +-
 drivers/pcmcia/sa1111_generic.c                    |   56 ++-----
 drivers/pcmcia/sa1111_generic.h                    |    1 -
 .../{sa1100_jornada720.c => sa1111_jornada720.c}   |    8 +-
 .../pcmcia/{pxa2xx_lubbock.c => sa1111_lubbock.c}  |    1 -
 .../{sa1100_neponset.c => sa1111_neponset.c}       |   11 +-
 drivers/pcmcia/sa11xx_base.c                       |    5 +-
 drivers/pcmcia/soc_common.c                        |  193 +++++++++++++-------
 drivers/pcmcia/soc_common.h                        |   23 ++-
 38 files changed, 372 insertions(+), 890 deletions(-)
 rename drivers/pcmcia/{sa1100_badge4.c => sa1111_badge4.c} (98%)
 rename drivers/pcmcia/{sa1100_jornada720.c => sa1111_jornada720.c} (94%)
 rename drivers/pcmcia/{pxa2xx_lubbock.c => sa1111_lubbock.c} (99%)
 rename drivers/pcmcia/{sa1100_neponset.c => sa1111_neponset.c} (93%)
