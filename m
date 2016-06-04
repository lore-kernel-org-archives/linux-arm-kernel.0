From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  4 Jun 2016 10:09:52 +0300
Subject: [PATCH 00/22] ARM: clps711x: Switch to DT and Multiplatform
Message-ID: <1465024214-22120-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cirrus Logic company announced EOL on May 20 this year for the
ARMv4 processors, so the company where I work ceases the use of the CPU
for our devices and switches our boards to use with another type of CPU.
I can not continue develop for this platform, so I gathered all the
existing patches/solutions for the final series. Of course, we keep
support our existing products with this CPU, so I remain able to check
any third-party patches.
This series of patches switches CLPS711X platform for use with device
tree and adds multiplatform support.
The series contain various subsystem changes but designed for applying
directly in the ARM-SOC tree.

Alexander Shiyan (22):
  ARM: clps711x: Reduce static map size
  clk: clps711x: Changing the compatibility string to match with the
    smallest supported chip
  clocksource: clps711x: Changing the compatibility string to match with
    the smallest supported chip
  irqchip: clps711x: Changing the compatibility string to match with the
    smallest supported chip
  serial: clps711x: Changing the compatibility string to match with the
    smallest supported chip
  pwm: clps711x: Changing the compatibility string to match with the
    smallest supported chip
  gpio: clps711x: Changing the compatibility string to match with the
    smallest supported chip
  gpio: syscon: Changing the compatibility string to match with the
    smallest supported chip
  input: clps711x-keypad: Changing the compatibility string to match
    with the smallest supported chip
  video: clps711x-fb: Changing the compatibility string to match with
    the smallest supported chip
  ARM: clps711x: Add basic DT support
  ARM: dts: clps711x: Add DT Cirrus Logic EDB7211 Development board
  spi: clps711x: Driver refactor
  ARM: clps711x: Remove board support
  video: clps711x: Remove old driver
  clk: clps711x: Remove board support
  clocksource: clps711x: Remove board support
  irqchip: clps711x: Remove board support
  serial: clps711x: Remove board support
  gpio: clps711x: Remove board support
  ARM: clps711x: Switch to MULTIPLATFORM
  ARM: config: Add a multi_v4t_defconfig

 .../devicetree/bindings/clock/clps711x-clock.txt   |   4 +-
 .../bindings/display/cirrus,clps711x-fb.txt        |   4 +-
 .../bindings/gpio/cirrus,clps711x-mctrl-gpio.txt   |   4 +-
 .../devicetree/bindings/gpio/gpio-clps711x.txt     |   4 +-
 .../devicetree/bindings/input/clps711x-keypad.txt  |   4 +-
 .../interrupt-controller/cirrus,clps711x-intc.txt  |   4 +-
 .../bindings/pwm/cirrus,clps711x-pwm.txt           |   5 +-
 .../bindings/serial/cirrus,clps711x-uart.txt       |   4 +-
 .../bindings/timer/cirrus,clps711x-timer.txt       |   6 +-
 arch/arm/Kconfig                                   |  14 -
 arch/arm/Makefile                                  |   1 -
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/ep7209.dtsi                      | 191 +++++++++++
 arch/arm/boot/dts/ep7211-edb7211.dts               | 100 ++++++
 arch/arm/boot/dts/ep7211.dtsi                      |  12 +
 arch/arm/configs/clps711x_defconfig                |  91 -----
 arch/arm/configs/multi_v4t_defconfig               | 106 ++++++
 arch/arm/include/debug/clps711x.S                  |   4 +-
 arch/arm/mach-clps711x/Kconfig                     |  53 +--
 arch/arm/mach-clps711x/Makefile                    |  14 +-
 arch/arm/mach-clps711x/Makefile.boot               |   5 -
 arch/arm/mach-clps711x/board-autcpu12.c            | 275 ---------------
 arch/arm/mach-clps711x/board-cdb89712.c            | 147 --------
 arch/arm/mach-clps711x/board-clep7312.c            |  45 ---
 arch/arm/mach-clps711x/board-dt.c                  |  82 +++++
 arch/arm/mach-clps711x/board-edb7211.c             | 188 -----------
 arch/arm/mach-clps711x/board-p720t.c               | 373 ---------------------
 arch/arm/mach-clps711x/common.c                    |  65 ----
 arch/arm/mach-clps711x/common.h                    |  23 --
 arch/arm/mach-clps711x/devices.c                   | 149 --------
 arch/arm/mach-clps711x/devices.h                   |  12 -
 arch/arm/mach-clps711x/include/mach/clps711x.h     | 204 -----------
 arch/arm/mach-clps711x/include/mach/hardware.h     |  53 ---
 arch/arm/mach-clps711x/include/mach/uncompress.h   |  55 ---
 drivers/clk/clk-clps711x.c                         |  27 +-
 drivers/clocksource/clps711x-timer.c               |  14 +-
 drivers/gpio/gpio-clps711x.c                       |  10 +-
 drivers/gpio/gpio-syscon.c                         |   4 +-
 drivers/input/keyboard/clps711x-keypad.c           |   4 +-
 drivers/irqchip/irq-clps711x.c                     |   9 +-
 drivers/pwm/pwm-clps711x.c                         |   2 +-
 drivers/spi/spi-clps711x.c                         |  69 ++--
 drivers/tty/serial/clps711x.c                      |  24 +-
 drivers/video/fbdev/Kconfig                        |   7 -
 drivers/video/fbdev/Makefile                       |   1 -
 drivers/video/fbdev/clps711x-fb.c                  |   4 +-
 drivers/video/fbdev/clps711xfb.c                   | 314 -----------------
 include/linux/platform_data/spi-clps711x.h         |  21 --
 48 files changed, 582 insertions(+), 2231 deletions(-)
 create mode 100644 arch/arm/boot/dts/ep7209.dtsi
 create mode 100644 arch/arm/boot/dts/ep7211-edb7211.dts
 create mode 100644 arch/arm/boot/dts/ep7211.dtsi
 delete mode 100644 arch/arm/configs/clps711x_defconfig
 create mode 100644 arch/arm/configs/multi_v4t_defconfig
 delete mode 100644 arch/arm/mach-clps711x/board-autcpu12.c
 delete mode 100644 arch/arm/mach-clps711x/board-cdb89712.c
 delete mode 100644 arch/arm/mach-clps711x/board-clep7312.c
 create mode 100644 arch/arm/mach-clps711x/board-dt.c
 delete mode 100644 arch/arm/mach-clps711x/board-edb7211.c
 delete mode 100644 arch/arm/mach-clps711x/board-p720t.c
 delete mode 100644 arch/arm/mach-clps711x/common.c
 delete mode 100644 arch/arm/mach-clps711x/common.h
 delete mode 100644 arch/arm/mach-clps711x/devices.c
 delete mode 100644 arch/arm/mach-clps711x/devices.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/clps711x.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-clps711x/include/mach/uncompress.h
 delete mode 100644 drivers/video/fbdev/clps711xfb.c
 delete mode 100644 include/linux/platform_data/spi-clps711x.h

-- 
2.4.9
