From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 12 Nov 2011 21:00:02 +0100
Subject: [PATCH 0/5] Move mbus setup code out of drivers and into platform
Message-ID: <1321128007-3520-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches move memory bus setup out of mach-* and drivers
and into the orion platform. The aim is to remove the *_mbus_dram_info
structure which is currently passed as platform_data, thus allowing
device tree to be used for these drivers. The change also allowed a
bit of consolidation of code scattered over the drivers.

Boot tested on kirkwood, compiled on dove, orion5x and mv78xx0.

Andrew Lunn (5):
  [orion] Consolidate the address map setup on Orion based platforms.
  [orion] Move the *_mbus_dram_info structure into the orion platform  
      and call it orion_mbus_dram_info everywhere.
  [orion] Move address map setup out of the drivers and into platform.
  [orion] Remove address map info from all platform data strucutures.
  [orion] Consolidate the address map setup code.

 arch/arm/mach-dove/addr-map.c                 |  121 ++++------
 arch/arm/mach-dove/common.c                   |   16 +-
 arch/arm/mach-dove/common.h                   |    1 -
 arch/arm/mach-dove/pcie.c                     |    4 +-
 arch/arm/mach-kirkwood/addr-map.c             |  137 +++--------
 arch/arm/mach-kirkwood/common.c               |   17 +-
 arch/arm/mach-kirkwood/common.h               |    1 -
 arch/arm/mach-kirkwood/mpp.c                  |    1 -
 arch/arm/mach-kirkwood/pcie.c                 |    4 +-
 arch/arm/mach-mv78xx0/addr-map.c              |  102 ++------
 arch/arm/mach-mv78xx0/common.c                |   22 +-
 arch/arm/mach-mv78xx0/common.h                |    1 -
 arch/arm/mach-mv78xx0/mpp.c                   |    1 -
 arch/arm/mach-mv78xx0/pcie.c                  |    4 +-
 arch/arm/mach-orion5x/addr-map.c              |  146 ++++-------
 arch/arm/mach-orion5x/common.c                |   23 +--
 arch/arm/mach-orion5x/common.h                |    3 +-
 arch/arm/mach-orion5x/include/mach/orion5x.h  |    2 +-
 arch/arm/mach-orion5x/mpp.c                   |    1 -
 arch/arm/mach-orion5x/pci.c                   |    5 +-
 arch/arm/plat-orion/Makefile                  |    2 +-
 arch/arm/plat-orion/addr-map.c                |  338 +++++++++++++++++++++++++
 arch/arm/plat-orion/common.c                  |   43 +---
 arch/arm/plat-orion/include/plat/addr-map.h   |   61 +++++
 arch/arm/plat-orion/include/plat/audio.h      |    3 -
 arch/arm/plat-orion/include/plat/common.h     |   17 +-
 arch/arm/plat-orion/include/plat/ehci-orion.h |    1 -
 arch/arm/plat-orion/include/plat/mv_xor.h     |    6 -
 arch/arm/plat-orion/include/plat/mvsdio.h     |    1 -
 arch/arm/plat-orion/include/plat/pcie.h       |    3 +-
 arch/arm/plat-orion/pcie.c                    |    6 +-
 drivers/ata/sata_mv.c                         |   38 +---
 drivers/dma/mv_xor.c                          |   38 +---
 drivers/dma/mv_xor.h                          |    5 -
 drivers/mmc/host/mvsdio.c                     |   28 +--
 drivers/mmc/host/mvsdio.h                     |    4 -
 drivers/net/mv643xx_eth.c                     |   45 +---
 drivers/usb/host/ehci-orion.c                 |   30 +--
 include/linux/ata_platform.h                  |    3 -
 sound/soc/kirkwood/kirkwood-dma.c             |   30 +--
 sound/soc/kirkwood/kirkwood.h                 |    4 -
 41 files changed, 627 insertions(+), 691 deletions(-)
 create mode 100644 arch/arm/plat-orion/addr-map.c
 create mode 100644 arch/arm/plat-orion/include/plat/addr-map.h

-- 
1.7.7.1
