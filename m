From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 15:46:06 +0200
Subject: [PATCH 0/7] Ux500 timer patches for 3.2
Message-ID: <1316699166-21226-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This patch series improves the Ux500/Nomadik timers to the point
where we can actually use them in a power-constrained system
which also tend to power off some of them from time to time.

Patches 1 & 2 has been floated before:
http://marc.info/?l=linux-arm-kernel&m=130700730707168&w=2

I'm not gonna claim this solves any issue of lost
sched_clock or so. What it does is to add the PRCMU timer
as an alternative clock source and sched_clock, nothing
more, nothing less.

If sched_clock() can be made to retain its value across
suspend/resume cycles as proposed by Russell here is
a really good question:
http://marc.info/?l=linux-arm-kernel&m=130700801907853&w=2

We would *still* need to be able to use the PRCMU as
clock source, since it's the only truly continous thing
we have in the system, and IIRC from my discussions with
tglx it's really not a good idea to have clock sources
that come and go.

On top of this it merely adds the optional possibility to
also use the PRCMU timer as sched_clock, if the MTU
(Nomadik) timer is not used for this. If this selectable
sched_clock base is frowned upon (there can be only one!)
I can delete those hunks of the patch.

Apart from this we have an update of the MTU (Nomadik)
timer to support periodic mode and some reset calls.

Jonas Aaberg (4):
  ARM: ux500: Move timer code to separate file
  ARM: plat-nomadik: timer: Add support for periodic timers
  ARM: plat-nomadik: timer: Export reset functions
  ARM: ux500: Reprogram timers upon resume

Mattias Wallin (3):
  ARM: plat-nomadik: MTU sched_clock as an option
  clocksource: add DBX500 PRCMU Timer support
  ARM: ux500: add support for clocksource DBX500 PRCMU

 arch/arm/mach-ux500/Makefile                   |    2 +-
 arch/arm/mach-ux500/cpu.c                      |   29 +-----
 arch/arm/mach-ux500/include/mach/db5500-regs.h |    2 +
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    3 +
 arch/arm/mach-ux500/timer.c                    |   65 +++++++++++
 arch/arm/plat-nomadik/Kconfig                  |    8 ++-
 arch/arm/plat-nomadik/include/plat/mtu.h       |   47 +--------
 arch/arm/plat-nomadik/timer.c                  |  138 ++++++++++++++++++------
 drivers/clocksource/Kconfig                    |   15 +++
 drivers/clocksource/Makefile                   |    1 +
 drivers/clocksource/clksrc-dbx500-prcmu.c      |  104 ++++++++++++++++++
 include/linux/clksrc-dbx500-prcmu.h            |   22 ++++
 12 files changed, 330 insertions(+), 106 deletions(-)
 create mode 100644 arch/arm/mach-ux500/timer.c
 create mode 100644 drivers/clocksource/clksrc-dbx500-prcmu.c
 create mode 100644 include/linux/clksrc-dbx500-prcmu.h

-- 
1.7.3.2
