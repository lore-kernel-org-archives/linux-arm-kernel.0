From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri,  4 Dec 2015 18:03:35 +0100
Subject: [PATCH v3 00/13] ARM: at91: PMC driver rework
Message-ID: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set is a cleanup that properly separate drivers needing to access the
PMC (PM and USB) from the clock driver by exposing the PMC as a syscon.

This also allows to implement a fix for preempt-rt. Currently, at91 platform are
crashing when using preempt-rt because the irq handler are transformed in
threaded irq handler but at the time the pmc registers its clocks, it is not
possible to creat threads, leading to a NULL pointer dereference in the kernel.

The new infrastructure uses polling until it is late enough to register threaded
irqs.

Note that there is an ugly global spinlock for the peripheral and generated
clocks. More infrastructure is needed in syscon to get rid of that one. We will
be working on that.

Changes in v3:
 - rebased on v4.4-rc1 and so included the sama5d2 and the generated clocks
 - fixed comments from Wenyou

Alexandre Belloni (10):
  clk: at91: clk-main: factorize irq handling
  clk: at91: make IRQ optional and register them later
  clk: at91: pmc: merge at91_pmc_init in atmel_pmc_probe
  clk: at91: pmc: move pmc structures to C file
  ARM: at91: pm: simply call at91_pm_init
  ARM: at91: pm: find and remap the pmc
  ARM: at91: pm: move idle functions to pm.c
  ARM: at91: remove useless includes and function prototypes
  usb: gadget: atmel: access the PMC using regmap
  clk: at91: pmc: drop at91_pmc_base

Boris Brezillon (3):
  clk: at91: make use of syscon to share PMC registers in several
    drivers
  clk: at91: make use of syscon/regmap internally
  clk: at91: only disable available IRQs

 arch/arm/mach-at91/Kconfig              |   1 +
 arch/arm/mach-at91/at91rm9200.c         |   2 -
 arch/arm/mach-at91/at91sam9.c           |   2 -
 arch/arm/mach-at91/generic.h            |  13 +-
 arch/arm/mach-at91/pm.c                 |  70 +++++-
 arch/arm/mach-at91/sama5.c              |   2 +-
 drivers/clk/at91/clk-generated.c        |  95 ++++---
 drivers/clk/at91/clk-h32mx.c            |  32 ++-
 drivers/clk/at91/clk-main.c             | 430 ++++++++++++++++++--------------
 drivers/clk/at91/clk-master.c           | 134 ++++++----
 drivers/clk/at91/clk-peripheral.c       | 135 +++++-----
 drivers/clk/at91/clk-pll.c              | 190 +++++++++-----
 drivers/clk/at91/clk-plldiv.c           |  42 ++--
 drivers/clk/at91/clk-programmable.c     |  92 ++++---
 drivers/clk/at91/clk-slow.c             |  27 +-
 drivers/clk/at91/clk-smd.c              |  54 ++--
 drivers/clk/at91/clk-system.c           | 129 +++++++---
 drivers/clk/at91/clk-usb.c              | 121 +++++----
 drivers/clk/at91/clk-utmi.c             | 116 ++++++---
 drivers/clk/at91/pmc.c                  | 314 +++++------------------
 drivers/clk/at91/pmc.h                  |  96 +------
 drivers/usb/gadget/udc/atmel_usba_udc.c |  20 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h |   2 +
 include/linux/clk/at91_pmc.h            |  12 -
 24 files changed, 1111 insertions(+), 1020 deletions(-)

-- 
2.5.0
