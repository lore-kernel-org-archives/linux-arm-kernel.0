From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 23 Nov 2010 10:06:01 +0000
Subject: ARM: add initial support for Picochip picoXcell SoC
Message-ID: <1290506774-17895-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the Picochip picoXcell series of
femotcell SoC's. There are currently two device families - PC3X2 and
PC3X3. Both include an ARM1176JZ-S, 100Mb Ethernet controller, 2xDMA
controllers, eFuses, crypto offload engines and Picochip's array
processor the picoArray. This patch series adds support for the base
chip support including timers, gpio, pin muxing, clocks and pm and also
the PC7302 development board that can take either PC3X2 or PC3X3 devices.

This patch series is based off of linux-next (next-20101122) and also requires
the following patches:

    - 8250: add a UPIO_DWAPB32 for 32 bit accesses (v2):
    http://marc.info/?l=linux-serial&m=129043658715199&w=2
    - debug-8250: add a 32 bit mode:
    http://marc.info/?l=linux-arm-kernel&m=129044061221371&w=2

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

 arch/arm/Kconfig                                   |   17 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/configs/pc7302_defconfig                  |  102 ++
 arch/arm/mach-picoxcell/Kconfig                    |   38 +
 arch/arm/mach-picoxcell/Makefile                   |   11 +
 arch/arm/mach-picoxcell/Makefile.boot              |    3 +
 arch/arm/mach-picoxcell/axi2cfg.c                  |  168 +++
 arch/arm/mach-picoxcell/board_pc7302.c             |  184 +++
 arch/arm/mach-picoxcell/clk.c                      |  140 +++
 arch/arm/mach-picoxcell/cpufreq.c                  |  145 +++
 arch/arm/mach-picoxcell/devices.c                  |   77 ++
 arch/arm/mach-picoxcell/gpio.c                     |  726 +++++++++++
 arch/arm/mach-picoxcell/include/mach/clkdev.h      |   69 ++
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   18 +
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 +
 arch/arm/mach-picoxcell/include/mach/gpio.h        |  189 +++
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   29 +
 arch/arm/mach-picoxcell/include/mach/io.h          |   32 +
 arch/arm/mach-picoxcell/include/mach/irqs.h        |   89 ++
 arch/arm/mach-picoxcell/include/mach/memory.h      |   27 +
 .../include/mach/picoxcell/axi2cfg.h               |  171 +++
 .../mach-picoxcell/include/mach/picoxcell/gpio.h   |   48 +
 .../include/mach/picoxcell/picoxcell.h             |   61 +
 .../mach-picoxcell/include/mach/picoxcell/timer.h  |   36 +
 .../mach-picoxcell/include/mach/picoxcell/wdog.h   |   43 +
 arch/arm/mach-picoxcell/include/mach/platform.h    |   32 +
 arch/arm/mach-picoxcell/include/mach/system.h      |   51 +
 arch/arm/mach-picoxcell/include/mach/timex.h       |   26 +
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   56 +
 arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-picoxcell/mux.c                      |  302 +++++
 arch/arm/mach-picoxcell/mux.h                      |   97 ++
 arch/arm/mach-picoxcell/pc3x2.c                    |  453 +++++++
 arch/arm/mach-picoxcell/pc3x3.c                    | 1256 ++++++++++++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.c           |  371 ++++++
 arch/arm/mach-picoxcell/picoxcell_core.h           |   42 +
 arch/arm/mach-picoxcell/pm.c                       |  146 +++
 arch/arm/mach-picoxcell/soc.h                      |   62 +
 arch/arm/mach-picoxcell/time.c                     |  206 ++++
 39 files changed, 5561 insertions(+), 0 deletions(-)
