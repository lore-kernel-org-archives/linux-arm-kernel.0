From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed,  7 Aug 2013 20:52:31 -0300
Subject: [PATCH 0/5] Armada 370/XP clocksource fixes
Message-ID: <1375919556-24104-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small patchset fixes a somewhat minor issue found in the clocksource
driver for Armada 370/XP SoC.

The Armada 370 SoC has no 25 MHz fixed timer, while the Armada XP SoC cannot
work properly without such 25 MHz fixed timer selected.

Therefore, it makes no sense to have a DT property to select the 25 MHz fixed
timer, and instead it's better to declare two different compatible strings:
one for each SoC.
The previous compatible and its behavior has been maintained to preserve
backwards compatibility.

In addition, CLOCKSOURCE_OF_DECLARE is used to simplify the initialization.

Any testing and feedback is highly appreciated!

Ezequiel Garcia (5):
  clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE
  clocksource: armada-370-xp: Simplify TIMER_CTRL register access
  clocksource: armada-370-xp: Introduce new compatibles
  clocksource: armada-370-xp: Fix device-tree binding
  ARM: mvebu: Fix the Armada 370/XP timer compatible strings

 .../bindings/timer/marvell,armada-370-xp-timer.txt |  29 ++++-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   1 -
 arch/arm/boot/dts/armada-370.dtsi                  |   4 +
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 arch/arm/mach-mvebu/armada-370-xp.c                |   4 +-
 drivers/clocksource/time-armada-370-xp.c           | 129 ++++++++++++---------
 include/linux/time-armada-370-xp.h                 |  18 ---
 7 files changed, 109 insertions(+), 78 deletions(-)
 delete mode 100644 include/linux/time-armada-370-xp.h

-- 
1.8.1.5
