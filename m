From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri, 23 Aug 2013 19:12:13 -0300
Subject: [PATCH v2 0/9] Orion watchdog DT changes to support more SoCs
Message-ID: <1377295942-5955-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of my work to add watchdog support to Armada 370/XP SoCs,
here's the second version of the early patches that make the orion_wdt
driver multiplatform-friendly.

This patchset allows to build the orion_wdt driver in any Orion
platforms, without any ugly mach-dependencies.

This is done by splitting the single memory resource into two memory
resources: timer control, watchdog counter. These resources are then handled
as independent memory resources (as they actually are semantically different).

The only drawback with this approach is the breakage of devicetree backwards
compatibility such change produces. Of course, this is an important issue,
and it's only acceptable given the DT for these platforms is still considered
partially in transition.

Changes from v1:

* Instead of having RSTOUT as a third orion-wdt resource, and thus
  enable/disable the watchdog reset from the driver, simply enable
  it on board-initialization time.

  This must be done with care, because the orion_wdt is used by
  all the Orion machines (except mvebu) in their DT and legacy variants.

Thanks!

Ezequiel Garcia (9):
  watchdog: orion: Remove unneeded BRIDGE_CAUSE clear
  watchdog: orion: Make counter register a separate resource
  ARM: orion: Assert watchdog RSTOUT enable bit
  watchdog: orion: Remove RSTOUT bit enable/disable
  watchdog: orion: Allow to build in any Orion platform
  watchdog: orion: Rename device-tree binding documentation
  watchdog: orion: Update device-tree binding documentation
  ARM: kirkwood: Update watchdog 'reg' property
  ARM: orion5x: Update orion-wdt DT node

 .../watchdog/{marvel.txt => orion-wdt.txt}         |  7 +++--
 arch/arm/boot/dts/kirkwood.dtsi                    |  3 +-
 arch/arm/boot/dts/orion5x.dtsi                     |  3 +-
 arch/arm/mach-dove/board-dt.c                      |  2 ++
 arch/arm/mach-dove/common.c                        |  2 ++
 arch/arm/mach-dove/include/mach/bridge-regs.h      |  2 ++
 arch/arm/mach-kirkwood/board-dt.c                  |  2 ++
 arch/arm/mach-kirkwood/common.c                    |  2 ++
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h  |  2 ++
 arch/arm/mach-mv78xx0/common.c                     |  2 ++
 arch/arm/mach-mv78xx0/include/mach/bridge-regs.h   |  2 ++
 arch/arm/mach-orion5x/board-dt.c                   |  4 +++
 arch/arm/mach-orion5x/common.c                     |  2 ++
 arch/arm/mach-orion5x/include/mach/bridge-regs.h   |  2 ++
 arch/arm/plat-orion/common.c                       | 15 +++++++---
 arch/arm/plat-orion/include/plat/common.h          |  1 +
 drivers/watchdog/Kconfig                           |  2 +-
 drivers/watchdog/orion_wdt.c                       | 32 ++++++++--------------
 18 files changed, 57 insertions(+), 30 deletions(-)
 rename Documentation/devicetree/bindings/watchdog/{marvel.txt => orion-wdt.txt} (58%)

-- 
1.8.1.5
