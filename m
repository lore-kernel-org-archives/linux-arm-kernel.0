From: david@lechnology.com (David Lechner)
Date: Fri, 19 Jan 2018 21:20:18 -0600
Subject: [PATCH 0/6] ARM: davinci: common clock prep work
Message-ID: <1516418424-28686-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains some changes needed for the conversion of arch/arm/mach-
davinci to the common clock framework.

Most of the boards in mach-davinci do not have device tree support. However,
CFGCHIP, which is a syscon regmap, is needed during clock init in early boot.
Using a platform device for the syscon at this point is not an option. So,
this series introduces a new way to register a syscon regmap on non-DT systems.

The DA8XX USB PHY driver is a consumer of the CFGCHIP syscon regmap, so some
changes are needed in that driver as well since we are removing the syscon
platform devices. The patch "phy: da8xx-usb: rename clock con_ids" doesn't
have anything to do with syscon, but I included in this series because we are
touching PHY code here anyway and it is also a dependency for the upcoming
common clock framework conversion changes.

Maintainers, please coordinate with Sekhar before committing. We will probably
want everything to go through the linux-davinci tree if possible.

David Lechner (6):
  mfd: syscon: Add syscon_register() function
  phy: da8xx-usb: Always check for syscon compatible
  phy: da8xx-usb: rename clock con_ids
  ARM: davinci: move davinci_clk_init() to init_time
  ARM: da8xx: Move CFGCHIP registration to init_time
  phy: da8xx-usb: drop use of syscon_regmap_lookup_by_pdevname()

 arch/arm/mach-davinci/board-da830-evm.c     |  6 +--
 arch/arm/mach-davinci/board-da850-evm.c     |  6 +--
 arch/arm/mach-davinci/board-dm355-evm.c     |  2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c |  2 +-
 arch/arm/mach-davinci/board-dm365-evm.c     |  2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c    |  2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c    | 19 +++++---
 arch/arm/mach-davinci/board-mityomapl138.c  |  6 +--
 arch/arm/mach-davinci/board-neuros-osd2.c   |  2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c |  6 +--
 arch/arm/mach-davinci/board-sffsdr.c        |  2 +-
 arch/arm/mach-davinci/da830.c               |  8 +++-
 arch/arm/mach-davinci/da850.c               | 31 ++++++-------
 arch/arm/mach-davinci/da8xx-dt.c            |  2 +-
 arch/arm/mach-davinci/davinci.h             |  4 ++
 arch/arm/mach-davinci/devices-da8xx.c       | 29 ++----------
 arch/arm/mach-davinci/dm355.c               |  8 +++-
 arch/arm/mach-davinci/dm365.c               |  8 +++-
 arch/arm/mach-davinci/dm644x.c              |  8 +++-
 arch/arm/mach-davinci/dm646x.c              | 22 ++++-----
 arch/arm/mach-davinci/include/mach/common.h |  1 -
 arch/arm/mach-davinci/include/mach/da8xx.h  |  6 ++-
 arch/arm/mach-davinci/usb-da8xx.c           | 12 ++---
 drivers/mfd/syscon.c                        | 71 +++++++++++++++++++++++++++++
 drivers/phy/ti/phy-da8xx-usb.c              | 14 ++----
 include/linux/mfd/syscon.h                  |  9 ++++
 26 files changed, 178 insertions(+), 110 deletions(-)

-- 
2.7.4
