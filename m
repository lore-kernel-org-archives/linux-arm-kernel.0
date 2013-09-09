From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon,  9 Sep 2013 17:39:58 +0200
Subject: [PATCH 0/8] IOP GPIO refactoring
Message-ID: <1378741198-12847-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series refactor the IOP GPIO driver to move down to the
GPIO subsystem, instatiate as a platform device, remap its
I/O address, and kills off the <mach/gpio.h> dependency.

This is done to get rid of <mach/gpio.h> and the complex
local GPIO implementation.

Please do not report the checkpatch warning in patch 5,
I am only copy/pasting code from one place to another and
the warning is removed later in the series.

Linus Walleij (8):
  ARM: plat-iop: move the GPIO driver to drivers/gpio
  ARM: iop32x: request and issue reset using gpio
  ARM: iop32x: read N2100 power key using gpiolib
  gpio: decouple the IOP GPIO driver from platform
  ARM: plat-iop: remove custom complex GPIO implementation
  ARM: plat-iop: instantiate GPIO from platform device
  gpio: iop: use readl/writel accessors
  ARM: plat-iop: pass physical base for GPIO

 arch/arm/Kconfig                            |   4 +-
 arch/arm/include/asm/hardware/iop3xx-gpio.h |  75 ----------------
 arch/arm/include/asm/hardware/iop3xx.h      |  12 ---
 arch/arm/mach-iop32x/include/mach/gpio.h    |   6 --
 arch/arm/mach-iop32x/include/mach/iop32x.h  |   1 -
 arch/arm/mach-iop32x/iq31244.c              |   7 ++
 arch/arm/mach-iop32x/iq80321.c              |   7 ++
 arch/arm/mach-iop32x/n2100.c                |  27 +++++-
 arch/arm/mach-iop33x/include/mach/gpio.h    |   6 --
 arch/arm/mach-iop33x/include/mach/iop33x.h  |   1 -
 arch/arm/mach-iop33x/iq80331.c              |   7 ++
 arch/arm/mach-iop33x/iq80332.c              |   7 ++
 arch/arm/plat-iop/Makefile                  |   2 -
 arch/arm/plat-iop/gpio.c                    |  93 --------------------
 drivers/gpio/Kconfig                        |   9 ++
 drivers/gpio/Makefile                       |   1 +
 drivers/gpio/gpio-iop.c                     | 130 ++++++++++++++++++++++++++++
 17 files changed, 194 insertions(+), 201 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/iop3xx-gpio.h
 delete mode 100644 arch/arm/mach-iop32x/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-iop33x/include/mach/gpio.h
 delete mode 100644 arch/arm/plat-iop/gpio.c
 create mode 100644 drivers/gpio/gpio-iop.c

-- 
1.8.3.1
