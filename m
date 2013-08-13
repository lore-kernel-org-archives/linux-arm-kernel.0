From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 13 Aug 2013 11:43:09 -0300
Subject: [PATCH v4 0/6] Armada 370/XP clocksource fixes
Message-ID: <1376404995-24548-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small patchset fixes a somewhat minor issue found in the clocksource
driver for Armada 370/XP SoC.

On one side the Armada 370 SoC has no 25 MHz fixed timer.
On the other side the Armada XP SoC cannot work properly without such 25 MHz
fixed timer selected, because otherwise the base clock frequency would vary
when doing cpufreq frequency changes.

Therefore we can consider the SoCs as not being compatible, being better to
have two compatible strings, one for each SoC. The previous compatible and
its behavior has been removed, considering there are no DT-enabled boards
in use in the field.

In addition, CLOCKSOURCE_OF_DECLARE is used to simplify the initialization.

This patchset is based on tip/timers/core.

Changes from v3:

  * Rebased on tip/timers/core.

Changes from v2:

  * As suggested by Jason Cooper, and given there are no DT-enabled
    boards in the field, the previous compatible string is *removed*
    instead of being retained and changes in documentation and .dts
    files are added as needed.

Changes from v1:

  * Declare TIMER_CTRL register access helpers as static,
    as reported by Andrew Lunn.

  * Add some documentation about the deprecated compatible string
    in the clocksource driver, as suggested by Andrew Lunn.

  * Add to the series a cosmetic patch to use BIT()

  * Rebased on top of two patches for the armada-370-xp clocksource
    driver, that are already in linux-next.

  * Reordered the patches: bare cleanup first, improvements later.

Ezequiel Garcia (6):
  clocksource: armada-370-xp: Use BIT()
  clocksource: armada-370-xp: Simplify TIMER_CTRL register access
  clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
  clocksource: armada-370-xp: Introduce new compatibles
  clocksource: armada-370-xp: Fix device-tree binding
  ARM: mvebu: Fix the Armada 370/XP timer compatible strings

 .../bindings/timer/marvell,armada-370-xp-timer.txt |  27 ++++-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   2 -
 arch/arm/boot/dts/armada-370.dtsi                  |   5 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |   4 +-
 drivers/clocksource/time-armada-370-xp.c           | 133 ++++++++++++---------
 include/linux/time-armada-370-xp.h                 |  18 ---
 7 files changed, 104 insertions(+), 87 deletions(-)
 delete mode 100644 include/linux/time-armada-370-xp.h

-- 
1.8.1.5
