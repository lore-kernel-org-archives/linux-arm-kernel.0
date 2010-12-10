From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:11 +0000
Subject: [PATCH v3 00/14] ARM: add initial support for Picochip picoXcell SoC
Message-ID: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the Picochip picoXcell series of
femtocell SoC's. There are currently two device families - PC3X2 and
PC3X3. Both include an ARM1176JZ-S, 100Mb Ethernet controller, 2xDMA
controllers, eFuses, crypto offload engines and Picochip's array
processor the picoArray. This patch series adds support for the base
chip support including timers, gpio, pin muxing, clocks and pm and also
the PC7302 development board that can take either PC3X2 or PC3X3 devices.

This patch series is based off of RMK's devel branch to get the CLKDEV_LOOKUP
changes and also requires the following patches:

    - 8250: add a UPIO_DWAPB32 for 32 bit accesses (v2):
    http://marc.info/?l=linux-serial&m=129043658715199&w=2
    - debug-8250: add a 32 bit mode:
    http://marc.info/?l=linux-arm-kernel&m=129044061221371&w=2

This series is sent as v3 as I sent some individual follow up patches as v2.
I'll repost as a whole series for subsequent reviews. I've taken on board
Russell's comments and added support for the onchip SRAM (based on the DaVinci
SRAM allocator). Individual changelogs are in the patches themselves.

Jamie Iles (14):
  picoxcell: add support for picoXcell
  picoxcell: add support for AXI bus snoopers
  picoxcell: add support for the system timers
  picoxcell: add a pin muxing infrastructure
  picoxcell: add gpio infrastructure
  picoxcell: add support for system clks
  picoxcell: add common SoC devices
  picoxcell: add cpufreq support
  picoxcell: add support for pm
  picoxcell: add chained GPIO IRQ handlers
  picoxcell: add support for pc3x2 devices
  picoxcell: add support for pc3x3 devices
  picoxcell: add support for the onchip SRAM
  picoxcell: add support for the PC7302 development board

 arch/arm/Kconfig                                   |   17 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/configs/picoxcell_defconfig               |  103 ++
 arch/arm/mach-picoxcell/Kconfig                    |   47 +
 arch/arm/mach-picoxcell/Makefile                   |   12 +
 arch/arm/mach-picoxcell/Makefile.boot              |    3 +
 arch/arm/mach-picoxcell/axi2cfg.c                  |  167 +++
 arch/arm/mach-picoxcell/board_pc7302.c             |  206 +++
 arch/arm/mach-picoxcell/clk.c                      |  134 ++
 arch/arm/mach-picoxcell/cpufreq.c                  |  145 +++
 arch/arm/mach-picoxcell/devices.c                  |  118 ++
 arch/arm/mach-picoxcell/gpio.c                     |  712 +++++++++++
 arch/arm/mach-picoxcell/include/mach/clkdev.h      |   71 +
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   18 +
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 +
 arch/arm/mach-picoxcell/include/mach/gpio.h        |  189 +++
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   29 +
 arch/arm/mach-picoxcell/include/mach/io.h          |   38 +
 arch/arm/mach-picoxcell/include/mach/irqs.h        |   89 ++
 arch/arm/mach-picoxcell/include/mach/memory.h      |   27 +
 .../include/mach/picoxcell/axi2cfg.h               |  169 +++
 .../mach-picoxcell/include/mach/picoxcell/gpio.h   |   48 +
 .../include/mach/picoxcell/picoxcell.h             |   62 +
 .../mach-picoxcell/include/mach/picoxcell/timer.h  |   37 +
 .../mach-picoxcell/include/mach/picoxcell/wdog.h   |   43 +
 arch/arm/mach-picoxcell/include/mach/platform.h    |   27 +
 arch/arm/mach-picoxcell/include/mach/sram.h        |   28 +
 arch/arm/mach-picoxcell/include/mach/system.h      |   51 +
 arch/arm/mach-picoxcell/include/mach/timex.h       |   26 +
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   60 +
 arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-picoxcell/io.c                       |   57 +
 arch/arm/mach-picoxcell/mux.c                      |  402 ++++++
 arch/arm/mach-picoxcell/mux.h                      |  110 ++
 arch/arm/mach-picoxcell/pc3x2.c                    |  437 +++++++
 arch/arm/mach-picoxcell/pc3x3.c                    | 1336 ++++++++++++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c           |  343 +++++
 arch/arm/mach-picoxcell/picoxcell_core.h           |   42 +
 arch/arm/mach-picoxcell/pm.c                       |  146 +++
 arch/arm/mach-picoxcell/soc.h                      |   61 +
 arch/arm/mach-picoxcell/sram.c                     |   66 +
 arch/arm/mach-picoxcell/time.c                     |  255 ++++
 42 files changed, 5969 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/configs/picoxcell_defconfig
 create mode 100644 arch/arm/mach-picoxcell/Kconfig
 create mode 100644 arch/arm/mach-picoxcell/Makefile
 create mode 100644 arch/arm/mach-picoxcell/Makefile.boot
 create mode 100644 arch/arm/mach-picoxcell/axi2cfg.c
 create mode 100644 arch/arm/mach-picoxcell/board_pc7302.c
 create mode 100644 arch/arm/mach-picoxcell/clk.c
 create mode 100644 arch/arm/mach-picoxcell/cpufreq.c
 create mode 100644 arch/arm/mach-picoxcell/devices.c
 create mode 100644 arch/arm/mach-picoxcell/gpio.c
 create mode 100644 arch/arm/mach-picoxcell/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/axi2cfg.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/gpio.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/picoxcell.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/timer.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/wdog.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/platform.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/sram.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-picoxcell/io.c
 create mode 100644 arch/arm/mach-picoxcell/mux.c
 create mode 100644 arch/arm/mach-picoxcell/mux.h
 create mode 100644 arch/arm/mach-picoxcell/pc3x2.c
 create mode 100644 arch/arm/mach-picoxcell/pc3x3.c
 create mode 100644 arch/arm/mach-picoxcell/picoxcell_core.c
 create mode 100644 arch/arm/mach-picoxcell/picoxcell_core.h
 create mode 100644 arch/arm/mach-picoxcell/pm.c
 create mode 100644 arch/arm/mach-picoxcell/soc.h
 create mode 100644 arch/arm/mach-picoxcell/sram.c
 create mode 100644 arch/arm/mach-picoxcell/time.c

-- 
1.7.2.3
