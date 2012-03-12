From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 13 Mar 2012 09:48:11 +1100
Subject: [PATCH v4 00/11] ep93xx: Move SoC private bits to core
Message-ID: <1331592502-9083-1-git-send-email-rmallon@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is an effort to move the ep93xx SoC specific code out
of drivers and include/mach into arch/arm/mach-ep93xx. This work
involves the following changes:

 - Create a new private header called soc.h to replace most of 
   mach/include/ep93xx-regs.h
 - Move the Maverick crunch code from arch/arm/kernel to mach-ep93xx
 - Convert the ep93xx backlight and watchdog drivers to properly
   ioremap memory.
 - Move all system controller access to the ep93xx core code

The only defines left in ep93xx-regs.h are for the APB UARTS which
are also needed in include/mach/uncompress.h and
include/mach/debug-macro.S.

Patch 2 has already been merged to the ASoC tree and patch 5 has
already been merged to the watchdog tree. Neither patch has been
modified since they were applied, and are included here for
completeness and to avoid build errors. 

All of the patches are against v3.3-rc7 and  now have reviewed-by
and/or acked-by tags except for patch 4 which has been changed
since the last version. Arnd, once I get an ack for the final patch
I can prepare a git branch for you to pull. I understand if this is
now too late for v3.4.

Changes since v3:
 - Removed the request_mem_region calls from both the backlight
   and framebuffer drivers since it causes problems due to the
   fact that the two drivers sharing parts of the same register
   space. This needs to be fixed properly in future.

Changes since v2:
 - Added Hartley's patch to convert watchdog driver to a
   proper platform driver
 - Fix the backlight driver to pass a proper memory
   resource, and ioremap, but not request it.

Changes since v1:
 - Moved syscon access functions to the bottom of soc.h
 - Don't include soc.h in crunch in the same patch as moving it
 - Removed unnecessary whitespace
 - Added commit message to gpio define move patch
 - Remove the arch_reset change since this is already done by
   the reset rework

H Hartley Sweeten (1):
  ep93xx: Convert the watchdog driver into a platform device.

Ryan Mallon (10):
  ep93xx: Move PHYS_BASE defines to local SoC header file
  ep93xx: Don't use system controller defines in audio drivers
  ep93xx: Move GPIO defines to gpio-ep93xx.h
  ep93xx: Use ioremap for backlight driver
  ep93xx: Move peripheral defines to local SoC header
  ep93xx: Configure GPIO ports in core code
  ep93xx: Make syscon access functions private to SoC
  ep93xx: Move crunch code to mach-ep93xx directory
  ep93xx: Move EP93XX_SYSCON defines to SoC private header
  ep93xx: Remove unnecessary includes of ep93xx-regs.h

 arch/arm/kernel/Makefile                        |    3 -
 arch/arm/kernel/crunch-bits.S                   |  305 -----------------------
 arch/arm/kernel/crunch.c                        |   88 -------
 arch/arm/mach-ep93xx/Makefile                   |    3 +
 arch/arm/mach-ep93xx/adssphere.c                |    1 +
 arch/arm/mach-ep93xx/clock.c                    |    1 +
 arch/arm/mach-ep93xx/core.c                     |   54 +++--
 arch/arm/mach-ep93xx/crunch-bits.S              |  305 +++++++++++++++++++++++
 arch/arm/mach-ep93xx/crunch.c                   |   90 +++++++
 arch/arm/mach-ep93xx/dma.c                      |    2 +
 arch/arm/mach-ep93xx/edb93xx.c                  |    1 +
 arch/arm/mach-ep93xx/gesbc9312.c                |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |  191 +--------------
 arch/arm/mach-ep93xx/include/mach/gpio-ep93xx.h |   10 +
 arch/arm/mach-ep93xx/include/mach/hardware.h    |    1 -
 arch/arm/mach-ep93xx/include/mach/platform.h    |   16 +--
 arch/arm/mach-ep93xx/micro9.c                   |    1 +
 arch/arm/mach-ep93xx/simone.c                   |    2 +
 arch/arm/mach-ep93xx/snappercl15.c              |    2 +
 arch/arm/mach-ep93xx/soc.h                      |  213 ++++++++++++++++
 arch/arm/mach-ep93xx/ts72xx.c                   |    1 +
 arch/arm/mach-ep93xx/vision_ep9307.c            |    2 +
 drivers/gpio/gpio-ep93xx.c                      |    7 -
 drivers/video/backlight/ep93xx_bl.c             |   25 +-
 drivers/video/ep93xx-fb.c                       |   15 +-
 drivers/watchdog/ep93xx_wdt.c                   |   51 +++-
 sound/soc/ep93xx/edb93xx.c                      |    4 +-
 sound/soc/ep93xx/snappercl15.c                  |    4 +-
 28 files changed, 736 insertions(+), 663 deletions(-)
 delete mode 100644 arch/arm/kernel/crunch-bits.S
 delete mode 100644 arch/arm/kernel/crunch.c
 create mode 100644 arch/arm/mach-ep93xx/crunch-bits.S
 create mode 100644 arch/arm/mach-ep93xx/crunch.c
 create mode 100644 arch/arm/mach-ep93xx/soc.h
