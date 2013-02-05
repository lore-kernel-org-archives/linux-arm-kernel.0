From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 5 Feb 2013 20:48:21 +0100
Subject: [PATCH 00/14] reform the ABx500 IRQ handling
Message-ID: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The AB8500/ABx500 PMIC ASICs have a real interesting way
of handling GPIO interrupts. They can trigger both on rising
and falling edge but will fire two different physical hwirqs
for rising resp. falling edge.

The complexity was kept in the abx500 pinctrl driver by
heritage from the ab8500 GPIO driver. That one was however
severely broken and this was part of the brokenness.

This series tries to decrease the complexity by moving
the interrupt handling back into the AB8500 core and
letting the ABx500 pinctrl driver rely on the irqdomain
stored inside the mfd device.

The basic design problem with the old driver was that it
was modeling a *cascading* interrupt controller off the
AB8500 core, whereas what we want is actually a *merging*
interrupt controller, that will take two physical hwirqs
and associate them with *one* Linux IRQ.

The right place to handle this is in the AB8500 core.

Lee Jones (13):
  mfd: ab8500: prepare to handle AB8500 GPIO's IRQs correctly
  mfd: ab8500: provide a irq_set_type() function
  mfd: ab8500: ensure new AB8500 pinctrl driver is probed correctly
  mfd: ab8500: allow AB9540 based devices to use ABX500 pinctrl
  pinctrl/abx500: prevent error path from corrupting returning error
  pinctrl/abx500: align GPIO cluster boundaries
  pinctrl/abx500: move IRQ handling to ab8500-core
  pinctrl/abx500: replace IRQ offsets with table read-in values
  pinctrl/abx500: add Device Tree support
  ARM: ux500: remove irq_base property from platform_data
  ARM: ux500: use real AB8500 IRQ numbers instead of virtual ones
  ARM: ux500: enable AB8500 GPIO for HREF
  ARM: ux500: allow Snowball access to the AB8500 GPIO pins

Linus Walleij (1):
  pinctrl/abx500: use direct IRQ defines

 arch/arm/boot/dts/hrefprev60.dts                   |   8 +
 arch/arm/boot/dts/snowball.dts                     |   4 +
 arch/arm/mach-ux500/board-mop500.c                 |   1 -
 .../mach-ux500/include/mach/irqs-board-mop500.h    |  10 +-
 drivers/mfd/ab8500-core.c                          |  37 ++-
 drivers/pinctrl/pinctrl-ab8500.c                   |   6 +-
 drivers/pinctrl/pinctrl-ab8505.c                   |  10 +-
 drivers/pinctrl/pinctrl-ab8540.c                   |   5 +-
 drivers/pinctrl/pinctrl-ab9540.c                   |   8 +-
 drivers/pinctrl/pinctrl-abx500.c                   | 365 +++------------------
 drivers/pinctrl/pinctrl-abx500.h                   |  10 +-
 include/linux/mfd/abx500/ab8500-gpio.h             |   1 -
 12 files changed, 120 insertions(+), 345 deletions(-)

-- 
1.7.11.3
