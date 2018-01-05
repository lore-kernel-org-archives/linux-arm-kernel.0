From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  5 Jan 2018 15:30:00 +0100
Subject: [PATCH v2 0/6] clocksource: rework Atmel TCB timer driver
Message-ID: <20180105143006.5369-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series gets back on the TCB drivers rework. It introduces a new driver to
handle the clocksource and clockevent devices.

As a reminder, this is necessary because:
 - the current tcb_clksrc driver is probed too late to be able to be used at
   boot and we now have SoCs that don't have a PIT. They currently are not able
   to boot a mainline kernel.
 - using the PIT doesn't work well with preempt-rt because its interrupt is
   shared (in particular with the UART and their interrupt flags are
   incompatible)
 - the current solution is wasting some TCB channels

The plan is to get this driver upstream, then convert the TCB PWM driver to be
able to get rid of the tcb_clksrc driver along with atmel_tclib.

I decided to leave out the clocksource/clockevent selection for now as it seems
the discussion is going nowhere. We can get back to that later

Main changes in v2:
 - use direct IO instead of regmap when accessing channel specific registers to
   avoid the regmap locking
 - implement suspend/resume

Alexandre Belloni (6):
  ARM: at91: add TCB registers definitions
  clocksource/drivers: Add a new driver for the Atmel ARM TC blocks
  clocksource/drivers: atmel-pit: allow unselecting ATMEL_PIT
  ARM: configs: at91: use new TCB timer driver
  ARM: configs: at91: sama5: unselect ATMEL_PIT
  ARM: configs: at91: at91_dt unselect ATMEL_PIT

 arch/arm/configs/at91_dt_defconfig    |   2 +-
 arch/arm/configs/sama5_defconfig      |   2 +-
 drivers/clocksource/Kconfig           |  23 +-
 drivers/clocksource/Makefile          |   3 +-
 drivers/clocksource/timer-atmel-tcb.c | 608 ++++++++++++++++++++++++++++++++++
 include/soc/at91/atmel_tcb.h          | 229 +++++++++++++
 6 files changed, 863 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clocksource/timer-atmel-tcb.c
 create mode 100644 include/soc/at91/atmel_tcb.h

-- 
2.15.1
