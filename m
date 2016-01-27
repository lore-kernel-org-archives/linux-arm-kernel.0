From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Jan 2016 17:10:59 +0100
Subject: [PATCH v4 00/13] ARM: at91: PMC driver rework
Message-ID: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch set is a cleanup that properly separate drivers needing to access the
PMC (PM and USB) from the clock driver by exposing the PMC as a syscon.

This also allows to implement a fix for preempt-rt. Currently, at91 platform are
crashing when using preempt-rt because the irq handler are transformed in
threaded irq handler but at the time the pmc registers its clocks, it is not
possible to creat threads, leading to a NULL pointer dereference in the kernel.

The new infrastructure uses polling only.

Note that there is an ugly global spinlock for the peripheral and generated
clocks. More infrastructure is needed in syscon to get rid of that one. We will
be working on that.

The two last patches may as well be applied later but they represent a good
cleanup. However, I'm not sure there is still any use in having pmc.c

Changes in v4:
 - completely removed the irq handling this solves more issues pointed by
   Sebastian and also handles one comment from Stephen (no more convoluted
   design ;))
 - pmc_pcr_lock is now in pmc.h
 - dropped clk: at91: only disable available IRQs,
   clk: at91: clk-main: factorize irq handling and
   clk: at91: make IRQ optional and register them later

Alexandre Belloni (11):
  clk: at91: remove IRQ handling and use polling
  clk: at91: pmc: merge at91_pmc_init in atmel_pmc_probe
  clk: at91: pmc: move pmc structures to C file
  ARM: at91: pm: simply call at91_pm_init
  ARM: at91: pm: find and remap the pmc
  ARM: at91: pm: move idle functions to pm.c
  ARM: at91: remove useless includes and function prototypes
  usb: gadget: atmel: access the PMC using regmap
  clk: at91: pmc: drop at91_pmc_base
  clk: at91: pmc: remove useless capacities handling
  clk: at91: remove useless includes

Boris Brezillon (2):
  clk: at91: make use of syscon to share PMC registers in several
    drivers
  clk: at91: make use of syscon/regmap internally

 arch/arm/mach-at91/Kconfig              |   1 +
 arch/arm/mach-at91/at91rm9200.c         |   2 -
 arch/arm/mach-at91/at91sam9.c           |   2 -
 arch/arm/mach-at91/generic.h            |  13 +-
 arch/arm/mach-at91/pm.c                 |  70 +++++-
 arch/arm/mach-at91/sama5.c              |   2 +-
 drivers/clk/at91/clk-generated.c        |  95 ++++---
 drivers/clk/at91/clk-h32mx.c            |  40 +--
 drivers/clk/at91/clk-main.c             | 324 +++++++++++-------------
 drivers/clk/at91/clk-master.c           |  94 +++----
 drivers/clk/at91/clk-peripheral.c       | 137 +++++-----
 drivers/clk/at91/clk-pll.c              | 150 +++++------
 drivers/clk/at91/clk-plldiv.c           |  44 ++--
 drivers/clk/at91/clk-programmable.c     |  96 +++----
 drivers/clk/at91/clk-slow.c             |  35 +--
 drivers/clk/at91/clk-smd.c              |  56 +++--
 drivers/clk/at91/clk-system.c           |  96 +++----
 drivers/clk/at91/clk-usb.c              | 123 ++++-----
 drivers/clk/at91/clk-utmi.c             |  80 ++----
 drivers/clk/at91/pmc.c                  | 426 +-------------------------------
 drivers/clk/at91/pmc.h                  |  98 +-------
 drivers/usb/gadget/udc/atmel_usba_udc.c |  20 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h |   2 +
 include/linux/clk/at91_pmc.h            |  12 -
 24 files changed, 724 insertions(+), 1294 deletions(-)

-- 
2.5.0
