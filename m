From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 18 Nov 2011 07:59:28 +0100
Subject: [PATCH 0/4] [orion] move *_mbus_dram_info out of platform_data
Message-ID: <1321599572-705-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As a step towords device tree support for orion based system, this
patchset removes the *_mbus_dram_info from platform_data for various
devices and replaces it with one instance of the strucutre in
plat-orion and a getter function to retreive it. In order that
none orion usage of these drivers still work, a dummy function is
also provided which returns NULL, indicating it is not necassary
to perform address map setup.

Boot tested on kirkwood, compile tested on other orion based systems.

Andrew Lunn (4):
  [orion] Consolidate the address map setup on Orion based platforms.
  [orion] Move the *_mbus_dram_info structure into the orion platform  
      and call it orion_mbus_dram_info everywhere.
  [orion] Get address map from plat-orion instead of via platform_data.
  [orion] Remove address map info from all platform data strucutures.

 arch/arm/mach-dove/addr-map.c                 |  121 +++++++----------
 arch/arm/mach-dove/common.c                   |   16 +--
 arch/arm/mach-dove/common.h                   |    1 -
 arch/arm/mach-dove/pcie.c                     |    4 +-
 arch/arm/mach-kirkwood/addr-map.c             |  137 +++++--------------
 arch/arm/mach-kirkwood/common.c               |   17 +--
 arch/arm/mach-kirkwood/common.h               |    1 -
 arch/arm/mach-kirkwood/mpp.c                  |    1 -
 arch/arm/mach-kirkwood/pcie.c                 |    4 +-
 arch/arm/mach-mv78xx0/addr-map.c              |  102 +++------------
 arch/arm/mach-mv78xx0/common.c                |   22 ++--
 arch/arm/mach-mv78xx0/common.h                |    1 -
 arch/arm/mach-mv78xx0/mpp.c                   |    1 -
 arch/arm/mach-mv78xx0/pcie.c                  |    4 +-
 arch/arm/mach-orion5x/addr-map.c              |  146 +++++++--------------
 arch/arm/mach-orion5x/common.c                |   23 +---
 arch/arm/mach-orion5x/common.h                |    3 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h  |    2 +-
 arch/arm/mach-orion5x/mpp.c                   |    1 -
 arch/arm/mach-orion5x/pci.c                   |    5 +-
 arch/arm/plat-orion/Makefile                  |    2 +-
 arch/arm/plat-orion/addr-map.c                |  174 +++++++++++++++++++++++++
 arch/arm/plat-orion/common.c                  |   43 ++-----
 arch/arm/plat-orion/include/plat/addr-map.h   |   53 ++++++++
 arch/arm/plat-orion/include/plat/audio.h      |    3 -
 arch/arm/plat-orion/include/plat/common.h     |   17 +--
 arch/arm/plat-orion/include/plat/ehci-orion.h |    1 -
 arch/arm/plat-orion/include/plat/mv_xor.h     |    6 -
 arch/arm/plat-orion/include/plat/mvsdio.h     |    1 -
 arch/arm/plat-orion/include/plat/pcie.h       |    3 +-
 arch/arm/plat-orion/pcie.c                    |    6 +-
 drivers/ata/sata_mv.c                         |   19 ++-
 drivers/dma/mv_xor.c                          |   11 +-
 drivers/mmc/host/mvsdio.c                     |   13 +-
 drivers/net/mv643xx_eth.c                     |   10 +-
 drivers/usb/host/ehci-orion.c                 |   10 +-
 include/linux/ata_platform.h                  |    3 -
 include/linux/mbus.h                          |   13 ++-
 sound/soc/kirkwood/kirkwood-dma.c             |   15 ++-
 39 files changed, 493 insertions(+), 522 deletions(-)
 create mode 100644 arch/arm/plat-orion/addr-map.c
 create mode 100644 arch/arm/plat-orion/include/plat/addr-map.h

-- 
1.7.2.5
