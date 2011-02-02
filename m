From: jamie@jamieiles.com (Jamie Iles)
Date: Wed,  2 Feb 2011 12:03:19 +0000
Subject: [PATCHv4 00/13] ARM: add initial support for Picochip picoXcell SoC
Message-ID: <1296648212-5284-1-git-send-email-jamie@jamieiles.com>
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

    - debug-8250: add a 32 bit mode:
    http://marc.info/?l=linux-arm-kernel&m=129044061221371&w=2

Changes since v3 include:

	- Move to fixed sched_clock() implementation.
	- Remove excessive use of __init directives.
	- Simplify pm to allow drivers to manage all clks.

This also picks up on the CPU_V6K and PLAT_PHYS_OFFSET changes.  I've
also removed the SRAM patch to try and just get the core support in and
make it simpler for review.

Jamie Iles (13):
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
  picoxcell: add support for the PC7302 development board

 arch/arm/Kconfig                                   |   16 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-picoxcell/Kconfig                    |   38 +
 arch/arm/mach-picoxcell/Makefile                   |   11 +
 arch/arm/mach-picoxcell/Makefile.boot              |    3 +
 arch/arm/mach-picoxcell/axi2cfg.c                  |  162 +++
 arch/arm/mach-picoxcell/board_pc7302.c             |  206 +++
 arch/arm/mach-picoxcell/clk.c                      |  134 ++
 arch/arm/mach-picoxcell/cpufreq.c                  |  146 +++
 arch/arm/mach-picoxcell/devices.c                  |  126 ++
 arch/arm/mach-picoxcell/gpio.c                     |  712 +++++++++++
 arch/arm/mach-picoxcell/include/mach/clkdev.h      |   71 +
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   18 +
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 +
 arch/arm/mach-picoxcell/include/mach/gpio.h        |  188 +++
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
 arch/arm/mach-picoxcell/include/mach/system.h      |   51 +
 arch/arm/mach-picoxcell/include/mach/timex.h       |   26 +
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   60 +
 arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-picoxcell/io.c                       |   49 +
 arch/arm/mach-picoxcell/mux.c                      |  402 ++++++
 arch/arm/mach-picoxcell/mux.h                      |  110 ++
 arch/arm/mach-picoxcell/pc3x2.c                    |  442 +++++++
 arch/arm/mach-picoxcell/pc3x3.c                    | 1341 ++++++++++++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c           |  339 +++++
 arch/arm/mach-picoxcell/picoxcell_core.h           |   25 +
 arch/arm/mach-picoxcell/pm.c                       |  112 ++
 arch/arm/mach-picoxcell/soc.h                      |   62 +
 arch/arm/mach-picoxcell/time.c                     |  222 ++++
 39 files changed, 5679 insertions(+), 0 deletions(-)
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
 create mode 100644 arch/arm/mach-picoxcell/time.c

-- 
1.7.3.4
