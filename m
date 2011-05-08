From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  8 May 2011 16:15:27 +0200
Subject: [PATCH 00/14] Consolidate orion platform data code
Message-ID: <1304864141-1121-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset consolidates some of the code used for creating
platform data for various orion based SoC, namely Dove, Loki, Kirkwood,
mv78xx0 and Orion5x. Where possible, this code has been put into the
orion platform, with the mach-*/common.c calling the common platform
code.

Additionally the setup of the multi purpose pins has been consolidated.
The Dove MPP code is not used, so has been removed. Kirkwood and mv78xx0
had identical code, which has been generalized and put into the platform.
Orion5x mpp code has been re-written to use the consolidated method.

Tested on a Kirkwood device, otherwise compile tested.

    Andrew Lunn


Andrew Lunn (14):
  [Orion] Rename some constants to macros to make code more identical
  [orion] Consolidate the creation of the uart platform data.
  [orion] Consolidate the creation of the RTC platform data.
  [orion] Consolidate ethernet platform data
  [orion] Consolidate I2C initialization.
  [orion] Consolidate SPI initialization.
  [orion] Consolidate the platform data setup for the watchdog.
  [orion] Consolidate the XOR platform setup code.
  [orion] Consolidate USB platform setup code.
  [orion] Consolidate SATA platform setup.
  [orion] Consolidate setup of the crypto engine.
  [orion] Refactor the MPP code. Common code in the orion platform.
  [dove] Remove mpp.[ch]. They are not used.
  [orion5x] Refactor mpp code to use common orion platform mpp.

 arch/arm/mach-dove/Makefile                    |    2 +-
 arch/arm/mach-dove/common.c                    |  616 +--------------
 arch/arm/mach-dove/mpp.c                       |  209 -----
 arch/arm/mach-dove/mpp.h                       |  220 ------
 arch/arm/mach-kirkwood/common.c                |  601 +--------------
 arch/arm/mach-kirkwood/include/mach/irqs.h     |    1 +
 arch/arm/mach-kirkwood/mpp.c                   |   58 +--
 arch/arm/mach-kirkwood/mpp.h                   |    6 -
 arch/arm/mach-loki/common.c                    |  190 +-----
 arch/arm/mach-mv78xx0/common.c                 |  570 +-------------
 arch/arm/mach-mv78xx0/mpp.c                    |   58 +--
 arch/arm/mach-mv78xx0/mpp.h                    |    6 -
 arch/arm/mach-orion5x/common.c                 |  474 +-----------
 arch/arm/mach-orion5x/d2net-setup.c            |   44 +-
 arch/arm/mach-orion5x/db88f5281-setup.c        |   44 +-
 arch/arm/mach-orion5x/dns323-setup.c           |  132 ++--
 arch/arm/mach-orion5x/edmini_v2-setup.c        |   44 +-
 arch/arm/mach-orion5x/kurobox_pro-setup.c      |   44 +-
 arch/arm/mach-orion5x/ls-chl-setup.c           |   44 +-
 arch/arm/mach-orion5x/ls_hgl-setup.c           |   44 +-
 arch/arm/mach-orion5x/lsmini-setup.c           |   44 +-
 arch/arm/mach-orion5x/mpp.c                    |  150 +----
 arch/arm/mach-orion5x/mpp.h                    |  191 +++--
 arch/arm/mach-orion5x/mss2-setup.c             |   44 +-
 arch/arm/mach-orion5x/mv2120-setup.c           |   44 +-
 arch/arm/mach-orion5x/net2big-setup.c          |   44 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c   |   44 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c    |   44 +-
 arch/arm/mach-orion5x/rd88f5182-setup.c        |   44 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c   |    1 -
 arch/arm/mach-orion5x/terastation_pro2-setup.c |   44 +-
 arch/arm/mach-orion5x/ts209-setup.c            |   44 +-
 arch/arm/mach-orion5x/ts409-setup.c            |   44 +-
 arch/arm/mach-orion5x/ts78xx-setup.c           |   44 +-
 arch/arm/mach-orion5x/wnr854t-setup.c          |   44 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c       |   44 +-
 arch/arm/plat-orion/Makefile                   |    2 +-
 arch/arm/plat-orion/common.c                   |  961 ++++++++++++++++++++++++
 arch/arm/plat-orion/include/plat/common.h      |  121 +++
 arch/arm/plat-orion/include/plat/mpp.h         |   34 +
 arch/arm/plat-orion/mpp.c                      |   81 ++
 41 files changed, 1972 insertions(+), 3548 deletions(-)
 delete mode 100644 arch/arm/mach-dove/mpp.c
 delete mode 100644 arch/arm/mach-dove/mpp.h
 create mode 100644 arch/arm/plat-orion/common.c
 create mode 100644 arch/arm/plat-orion/include/plat/common.h
 create mode 100644 arch/arm/plat-orion/include/plat/mpp.h
 create mode 100644 arch/arm/plat-orion/mpp.c

-- 
1.7.4.4
