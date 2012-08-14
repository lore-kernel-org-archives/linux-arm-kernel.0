From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 14 Aug 2012 12:07:55 +0300
Subject: [PATCH v2 0/4] ASoC machine driver for simple SoC with twl4030
Message-ID: <1344935279-32364-1-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Changes since v1:
- Card name for cm-t35 is "cm-t3x"
- Added Ack from Tony for the OMAP patch
- Codec sysclock no longer needed by the machine driver
  The codec itself must know the mclk since it needs it for initial
  configuration and also in case only the vibra functionality is used.
  The codec driver ignores the machine driver provided clock, it always uses the
  mclk freq it got from the MFD core driver.

Intro mail from v1:

Create new unified ASoC machine driver (with DT support) for boards using simple
configuration for audio and using the twl4030 codec.
This driver will replace the following machine drivers (since they are basically
the same):
igep0020, omap3beagle, omap3evm and overo.

This series will switch the boards I can identify to use the new unified ASoC
machine driver.

Changes under arch/arm/mach-omap2/ are trivial, I don't expect merge issues
later. If it is OK for the maintainers I would like this to go via audio tree
(with the McBSP and the twl4030-audio stack DT support).

The series has been tested on BeagleBoard (with the McBSP and twl4030-audio DT
support).

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: omap-twl4030: Simple machine driver for TI SoC with twl4030
    codec
  ARM: OMAP: twl-common: Add helper function to register the
    omap-twl4030 audio driver
  ARM: OMAP3: Switch to use the unified audio driver (omap-twl4030) for
    selected boards
  ASoC: Remove obsolete OMAP3 machine drivers

 .../devicetree/bindings/sound/omap-twl4030.txt     |   17 ++
 arch/arm/mach-omap2/board-cm-t35.c                 |    1 +
 arch/arm/mach-omap2/board-devkit8000.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c               |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c            |    1 +
 arch/arm/mach-omap2/board-omap3evm.c               |    1 +
 arch/arm/mach-omap2/board-overo.c                  |    1 +
 arch/arm/mach-omap2/twl-common.c                   |   27 +++
 arch/arm/mach-omap2/twl-common.h                   |    2 +
 include/linux/platform_data/omap-twl4030.h         |   32 ++++
 sound/soc/omap/Kconfig                             |   48 ++----
 sound/soc/omap/Makefile                            |   10 +-
 sound/soc/omap/igep0020.c                          |  120 -------------
 sound/soc/omap/omap-twl4030.c                      |  188 ++++++++++++++++++++
 sound/soc/omap/omap3beagle.c                       |  150 ----------------
 sound/soc/omap/omap3evm.c                          |  118 ------------
 sound/soc/omap/overo.c                             |  122 -------------
 17 files changed, 287 insertions(+), 553 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
 create mode 100644 include/linux/platform_data/omap-twl4030.h
 delete mode 100644 sound/soc/omap/igep0020.c
 create mode 100644 sound/soc/omap/omap-twl4030.c
 delete mode 100644 sound/soc/omap/omap3beagle.c
 delete mode 100644 sound/soc/omap/omap3evm.c
 delete mode 100644 sound/soc/omap/overo.c

-- 
1.7.8.6
