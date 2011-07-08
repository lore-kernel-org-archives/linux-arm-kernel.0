From: bs14@csr.com (Barry Song)
Date: Fri, 8 Jul 2011 02:40:11 -0700
Subject: [PATCH v5 0/3] ARM: CSR: Adding CSR SiRFprimaII platform
Message-ID: <1310118014-24509-1-git-send-email-bs14@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelogs:
-v5:
add lost "Reviewed-by: Arnd Bergmann <arnd@arndb.de>" in git log
add UL suffix to VMALLOC_END

-v4:
v3 got "Reviewed-by: Arnd Bergmann <arnd@arndb.de>"
stopping the 0xffffffff madness for IO_SPACE_LIMIT
fix .map_io compiling issue in the 1st patch
fix set_next_event in timer.c
rename GPU, USB, multimedia and SATA nodes in DTS
delete redundant 0x in DTS

-v3:
full DT file
delete all static mapping table in common.c
rename common.c to prima2.c
delete board file board_dt.c
split DEBUG_LL and L2 cache to seperate patch

-v2:
 1. clock: use dev_id instead of con_id
 2. Kconfig: delete ISA_DMA
 3. irq: implement int controller based on DT
        move to GENERIC_IRQ_CHIP framework
 4. timer: implement timer based on DT
 5. entry-macro.S: use get_irqnr_preamble to load the base address only once
   per IRQ exception.
 6. others:
       use readl_relaxed instead of __raw_readl
       adjust Kconfig order for PRIMA2
       use clk_get_sys instead of clk_get for system level clock
       use BUG_ON(IS_ERR(clk)) instead of BUG_ON(IS_ERR_OR_NULL(clk));
       fix typo for CLOCK_TICK_RATE
       ("sirf,xxx", "sirf,prima2-xxx")  instead of ("sirf,xxx") in dts

Note:
   For L2 cache, if Rob's patch is merged, the whole file can be deleted

Barry Song (1):
  ARM: CSR: mapping early DEBUG_LL uart

Binghua Duan (1):
  ARM: CSR: Adding CSR SiRFprimaII board support

Rongjun Ying (1):
  ARM: CSR: initializing L2 cache

 Documentation/devicetree/bindings/arm/sirf.txt  |    3 +
 arch/arm/Kconfig                                |   14 +
 arch/arm/Makefile                               |    1 +
 arch/arm/boot/dts/prima2-cb.dts                 |  416 ++++++++++++++++++
 arch/arm/mach-prima2/Makefile                   |    7 +
 arch/arm/mach-prima2/Makefile.boot              |    3 +
 arch/arm/mach-prima2/clock.c                    |  509 +++++++++++++++++++++++
 arch/arm/mach-prima2/common.h                   |   26 ++
 arch/arm/mach-prima2/include/mach/clkdev.h      |   15 +
 arch/arm/mach-prima2/include/mach/debug-macro.S |   29 ++
 arch/arm/mach-prima2/include/mach/entry-macro.S |   29 ++
 arch/arm/mach-prima2/include/mach/hardware.h    |   15 +
 arch/arm/mach-prima2/include/mach/io.h          |   16 +
 arch/arm/mach-prima2/include/mach/irqs.h        |   17 +
 arch/arm/mach-prima2/include/mach/map.h         |   16 +
 arch/arm/mach-prima2/include/mach/memory.h      |   21 +
 arch/arm/mach-prima2/include/mach/system.h      |   29 ++
 arch/arm/mach-prima2/include/mach/timex.h       |   14 +
 arch/arm/mach-prima2/include/mach/uart.h        |   23 +
 arch/arm/mach-prima2/include/mach/uncompress.h  |   40 ++
 arch/arm/mach-prima2/include/mach/vmalloc.h     |   16 +
 arch/arm/mach-prima2/irq.c                      |   71 ++++
 arch/arm/mach-prima2/l2x0.c                     |   59 +++
 arch/arm/mach-prima2/lluart.c                   |   25 ++
 arch/arm/mach-prima2/prima2.c                   |   41 ++
 arch/arm/mach-prima2/rstc.c                     |   69 +++
 arch/arm/mach-prima2/timer.c                    |  217 ++++++++++
 arch/arm/mm/Kconfig                             |    2 +-
 28 files changed, 1742 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 arch/arm/boot/dts/prima2-cb.dts
 create mode 100644 arch/arm/mach-prima2/Makefile
 create mode 100644 arch/arm/mach-prima2/Makefile.boot
 create mode 100644 arch/arm/mach-prima2/clock.c
 create mode 100644 arch/arm/mach-prima2/common.h
 create mode 100644 arch/arm/mach-prima2/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-prima2/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-prima2/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-prima2/include/mach/hardware.h
 create mode 100644 arch/arm/mach-prima2/include/mach/io.h
 create mode 100644 arch/arm/mach-prima2/include/mach/irqs.h
 create mode 100644 arch/arm/mach-prima2/include/mach/map.h
 create mode 100644 arch/arm/mach-prima2/include/mach/memory.h
 create mode 100644 arch/arm/mach-prima2/include/mach/system.h
 create mode 100644 arch/arm/mach-prima2/include/mach/timex.h
 create mode 100644 arch/arm/mach-prima2/include/mach/uart.h
 create mode 100644 arch/arm/mach-prima2/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-prima2/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-prima2/irq.c
 create mode 100644 arch/arm/mach-prima2/l2x0.c
 create mode 100644 arch/arm/mach-prima2/lluart.c
 create mode 100644 arch/arm/mach-prima2/prima2.c
 create mode 100644 arch/arm/mach-prima2/rstc.c
 create mode 100644 arch/arm/mach-prima2/timer.c



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
