From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 15 Jan 2010 08:16:02 +0000
Subject: Pull request for bjdooks' next-samsung tree
Message-ID: <20100115081602.GA14598@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This tree has changes for arch/arm due to adding S5P6440 support, and
so it needs to go to RMK. Note, the head is based on for-linus/samsung
which has only just been sent to Linus.

The following changes since commit 3ce2f76f5dfeeacd128db9e5cd6945bac0ea0b2a:
  Ben Dooks (1):
        ARM: MINI2440: Fixup __initdata usage

are available in the git repository at:

  git://git.fluff.org/bjdooks/linux.git next-samsung

Ben Dooks (24):
      ARM: SAMSUNG: Move <plat/clock.h> to plat-samsung
      ARM: S3C64XX: Cleanup common init code in s3c6400-clock.c
      ARM: S3C64XX: Compress s3c6400-clock.c code
      ARM: S3C64XX: Use new clock-clksrc.c code for clocks.
      ARM: SAMSUNG: Reduce size of struct clk.
      ARM: S3C64XX: Fixup .reg_src and .reg_div with named initialisers
      ARM: S3C64XX: Avoid announcing clksrc clocks twice
      ARM: SAMSUNG: Move clock.c to arch/arm/plat-samsung
      ARM: SAMSUNG: Do not allow get/set/round rate calls with no divider
      ARM: SAMSUNG: Add call to register array of clocks
      ARM: SAMSUNG: Do not register set_parent call if no source
      ARM: SAMSUNG: Move pwm-clock code into plat-samsung
      ARM: SAMSUNG: Move device definitions in plat-samsung
      ARM: SAMSUNG: Move gpio-config.c into plat-samsung
      ARM: SAMSUNG: Move IRQ VIC timer handling out to common header files
      ARM: SAMSUNG: Move IRQ UART handling for newer devices to plat-samsung
      ARM: Add common entry code for system with two VICs
      ARM: S5PC1XX: Move to using generic clksrc_clk for clock code
      ARM: S5PC1XX: Move clock definitions around ready to turn into clksrc arrays
      ARM: S5PC1XX: Change clksrc_clks to use array of clocks
      ARM: SAMSUNG: Add script to change old clksrc_clk to new register defs
      ARM: S5PC1XX: Remove definitions deleted by previous clksrc changes
      ARM: S5PC1XX: Move to using standard timer IRQ handling code
      ARM: S5PC1XX: Use common UART IRQ handling code

Harald Welte (2):
      ARM: SAMSUNG: Add core clock implementation for clksrc based clocks
      ARM: S3C64XX: Remove unused clock definitions from clock header

Kukjin Kim (10):
      ARM: SAMSUNG: Make clk_default_setrate and clk_ops_def_setrate visible
      ARM: SAMSUNG: Add config option for number of additional GPIO pins.
      ARM: S5P6440: Add new CPU initialization support
      ARM: S5P6440: Add Clock and PLL support
      ARM: S5P6440: Add IRQ support
      ARM: S5P6440: Add Timer support
      ARM: S5P6440: Add new Kconfig and Makefiles
      ARM: S5P6440: Add Board support file
      ARM: S5P6440: Add configuration file
      ARM: S5P6440: Add serial port support

 .../arm/Samsung/clksrc-change-registers.awk        |  167 ++++
 arch/arm/Kconfig                                   |   13 +-
 arch/arm/Makefile                                  |    2 +
 arch/arm/configs/s5p6440_defconfig                 |  969 ++++++++++++++++++++
 arch/arm/include/asm/entry-macro-vic2.S            |   57 ++
 arch/arm/mach-s3c2412/clock.c                      |   52 +-
 arch/arm/mach-s3c2440/clock.c                      |    6 +-
 arch/arm/mach-s3c2442/clock.c                      |    6 +-
 arch/arm/mach-s3c2443/clock.c                      |   97 ++-
 arch/arm/mach-s3c6400/include/mach/entry-macro.S   |   28 +-
 arch/arm/mach-s3c6400/include/mach/map.h           |    4 +-
 arch/arm/mach-s3c6400/include/mach/tick.h          |    2 +-
 arch/arm/mach-s5p6440/Kconfig                      |   23 +
 arch/arm/mach-s5p6440/Makefile                     |   19 +
 arch/arm/mach-s5p6440/Makefile.boot                |    2 +
 arch/arm/mach-s5p6440/cpu.c                        |  114 +++
 arch/arm/mach-s5p6440/include/mach/debug-macro.S   |   37 +
 arch/arm/mach-s5p6440/include/mach/entry-macro.S   |   16 +
 arch/arm/mach-s5p6440/include/mach/gpio-core.h     |   19 +
 arch/arm/mach-s5p6440/include/mach/gpio.h          |   80 ++
 arch/arm/mach-s5p6440/include/mach/hardware.h      |   18 +
 arch/arm/mach-s5p6440/include/mach/irqs.h          |  111 +++
 arch/arm/mach-s5p6440/include/mach/map.h           |   94 ++
 arch/arm/mach-s5p6440/include/mach/memory.h        |   19 +
 arch/arm/mach-s5p6440/include/mach/pwm-clock.h     |   62 ++
 arch/arm/mach-s5p6440/include/mach/regs-clock.h    |  130 +++
 arch/arm/mach-s5p6440/include/mach/regs-irq.h      |   19 +
 arch/arm/mach-s5p6440/include/mach/system.h        |   26 +
 arch/arm/mach-s5p6440/include/mach/tick.h          |   24 +
 arch/arm/mach-s5p6440/include/mach/uncompress.h    |   24 +
 arch/arm/mach-s5p6440/mach-smdk6440.c              |  111 +++
 arch/arm/mach-s5pc100/include/mach/tick.h          |    2 +-
 arch/arm/plat-s3c/Kconfig                          |   75 --
 arch/arm/plat-s3c/Makefile                         |   17 +-
 arch/arm/plat-s3c/include/plat/cpu.h               |    3 +
 arch/arm/plat-s3c/include/plat/devs.h              |    1 +
 arch/arm/plat-s3c24xx/clock-dclk.c                 |   22 +-
 arch/arm/plat-s3c24xx/s3c244x-clock.c              |    4 +-
 arch/arm/plat-s3c64xx/Kconfig                      |    3 +
 arch/arm/plat-s3c64xx/clock.c                      |   10 +-
 arch/arm/plat-s3c64xx/cpu.c                        |    4 +-
 arch/arm/plat-s3c64xx/include/plat/irqs.h          |    8 +-
 arch/arm/plat-s3c64xx/include/plat/regs-clock.h    |   71 +--
 arch/arm/plat-s3c64xx/irq.c                        |  209 +----
 arch/arm/plat-s3c64xx/s3c6400-clock.c              |  510 +++--------
 arch/arm/plat-s5p/Kconfig                          |   38 +
 arch/arm/plat-s5p/Makefile                         |   24 +
 arch/arm/plat-s5p/clock.c                          |  136 +++
 arch/arm/plat-s5p/cpu.c                            |   90 ++
 arch/arm/plat-s5p/dev-uart.c                       |  165 ++++
 arch/arm/plat-s5p/include/plat/irqs.h              |   83 ++
 arch/arm/plat-s5p/include/plat/pll.h               |   83 ++
 arch/arm/plat-s5p/include/plat/s5p-clock.h         |   38 +
 arch/arm/plat-s5p/include/plat/s5p6440.h           |   37 +
 arch/arm/plat-s5p/irq.c                            |   73 ++
 arch/arm/plat-s5p/s5p6440-clock.c                  |  698 ++++++++++++++
 arch/arm/plat-s5p/s5p6440-init.c                   |   50 +
 arch/arm/plat-s5p/setup-i2c0.c                     |   25 +
 arch/arm/plat-s5pc1xx/Kconfig                      |    3 +
 arch/arm/plat-s5pc1xx/clock.c                      |   22 +-
 arch/arm/plat-s5pc1xx/include/plat/irqs.h          |   19 +-
 arch/arm/plat-s5pc1xx/include/plat/regs-clock.h    |  119 +---
 arch/arm/plat-s5pc1xx/irq.c                        |  202 +----
 arch/arm/plat-s5pc1xx/s5pc100-clock.c              |  770 +++++-----------
 arch/arm/plat-samsung/Kconfig                      |  102 ++
 arch/arm/plat-samsung/Makefile                     |   22 +
 arch/arm/plat-samsung/clock-clksrc.c               |  203 ++++
 arch/arm/{plat-s3c => plat-samsung}/clock.c        |   55 +-
 arch/arm/{plat-s3c => plat-samsung}/dev-fb.c       |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc.c    |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc1.c   |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc2.c   |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-i2c0.c     |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-i2c1.c     |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-nand.c     |    0
 .../arm/{plat-s3c => plat-samsung}/dev-usb-hsotg.c |    0
 arch/arm/{plat-s3c => plat-samsung}/dev-usb.c      |    0
 arch/arm/{plat-s3c => plat-samsung}/gpio-config.c  |    0
 arch/arm/plat-samsung/include/plat/clock-clksrc.h  |   83 ++
 .../include/plat/clock.h                           |   35 +-
 arch/arm/plat-samsung/include/plat/irq-uart.h      |   20 +
 arch/arm/plat-samsung/include/plat/irq-vic-timer.h |   13 +
 arch/arm/plat-samsung/irq-uart.c                   |  143 +++
 arch/arm/plat-samsung/irq-vic-timer.c              |   86 ++
 arch/arm/{plat-s3c => plat-samsung}/pwm-clock.c    |  112 ++--
 drivers/serial/Kconfig                             |    8 +-
 86 files changed, 5074 insertions(+), 1773 deletions(-)
 create mode 100755 Documentation/arm/Samsung/clksrc-change-registers.awk
 create mode 100644 arch/arm/configs/s5p6440_defconfig
 create mode 100644 arch/arm/include/asm/entry-macro-vic2.S
 create mode 100644 arch/arm/mach-s5p6440/Kconfig
 create mode 100644 arch/arm/mach-s5p6440/Makefile
 create mode 100644 arch/arm/mach-s5p6440/Makefile.boot
 create mode 100644 arch/arm/mach-s5p6440/cpu.c
 create mode 100644 arch/arm/mach-s5p6440/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-s5p6440/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-s5p6440/include/mach/gpio-core.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/gpio.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/hardware.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/irqs.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/map.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/memory.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/pwm-clock.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/regs-clock.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/regs-irq.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/system.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/tick.h
 create mode 100644 arch/arm/mach-s5p6440/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-s5p6440/mach-smdk6440.c
 create mode 100644 arch/arm/plat-s5p/Kconfig
 create mode 100644 arch/arm/plat-s5p/Makefile
 create mode 100644 arch/arm/plat-s5p/clock.c
 create mode 100644 arch/arm/plat-s5p/cpu.c
 create mode 100644 arch/arm/plat-s5p/dev-uart.c
 create mode 100644 arch/arm/plat-s5p/include/plat/irqs.h
 create mode 100644 arch/arm/plat-s5p/include/plat/pll.h
 create mode 100644 arch/arm/plat-s5p/include/plat/s5p-clock.h
 create mode 100644 arch/arm/plat-s5p/include/plat/s5p6440.h
 create mode 100644 arch/arm/plat-s5p/irq.c
 create mode 100644 arch/arm/plat-s5p/s5p6440-clock.c
 create mode 100644 arch/arm/plat-s5p/s5p6440-init.c
 create mode 100644 arch/arm/plat-s5p/setup-i2c0.c
 create mode 100644 arch/arm/plat-samsung/clock-clksrc.c
 rename arch/arm/{plat-s3c => plat-samsung}/clock.c (84%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-fb.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc1.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-hsmmc2.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-i2c0.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-i2c1.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-nand.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-usb-hsotg.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/dev-usb.c (100%)
 rename arch/arm/{plat-s3c => plat-samsung}/gpio-config.c (100%)
 create mode 100644 arch/arm/plat-samsung/include/plat/clock-clksrc.h
 rename arch/arm/{plat-s3c => plat-samsung}/include/plat/clock.h (72%)
 create mode 100644 arch/arm/plat-samsung/include/plat/irq-uart.h
 create mode 100644 arch/arm/plat-samsung/include/plat/irq-vic-timer.h
 create mode 100644 arch/arm/plat-samsung/irq-uart.c
 create mode 100644 arch/arm/plat-samsung/irq-vic-timer.c
 rename arch/arm/{plat-s3c => plat-samsung}/pwm-clock.c (82%)



-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
