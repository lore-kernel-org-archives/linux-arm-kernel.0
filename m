From: viresh.kumar@st.com (Viresh KUMAR)
Date: Fri,  1 Oct 2010 17:25:20 +0530
Subject: [PATCH V2 00/69] Updating SPEAr Support
Message-ID: <cover.1285933331.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following set of patches:
- updates SPEAr3xx, 6xx support
- Adds support for SPEAr13xx
- Removes Multiple defconfigs per machine family

Changes since V1:
- sev definitions moved to system.h and removed from spear and omap archs
- bug fix added in system controller file sp810.h
- Review Comments incorporated
- Driver and machine support are divided into separate patches
- Nand Driver is removed from patch list as it is already floated by Linus
  Walleij.
- Few later patches of SPEAr13xx Patches are merged with initial patches of
  SPEAr13xx
- Smaller Defconfigs are used instead of large.
- Clock renaming & minor corrections are moved to clock specific patches from
  peripheral machine support patches.
- Removed Commented code related to SPI
- [PATCH] Incrementing the ecc_pos array to contain 128 char - is removed from
  list
- Board specific code is moved to *evb.c files from machine files for EMI NOR
- replaced readl with __raw_readl in uncompress.h in plat-spear/include/plat/

P.S.: This patch must be applied once Linus's patch
"[PATCH 1/2] MTD: generic FSMC NAND MTD driver" is applied.

Bhupesh Sharma (1):
  ST SPEAr 13xx : Adding support for SPEAr1310

Deepak Sikri (7):
  USB host: Adding USB ehci & ohci support for spear platform
  ST SPEAr: Adding machine support for USB host
  SPEAr Clock Framework: Adding support for PLL frequency change
  SPEAr Power Management: Added the support for Standby mode.
  GIC: Added dummy handlers for Power Management Suspend Resume
  SPEAr CPU freq: Adding support for CPU Freq framework
  ST SPEAr13xx: Adding CPU hotplug support added for SMP platforms

Pratyush Anand (3):
  ST SPEAr: Added PCIE host controller base driver support.
  ST SPEAr: PCIE gadget suppport
  ST SPEAr13xx: Adding machine support for pci gadget

Rajeev Kumar (5):
  rtc: Adding support for spear rtc
  ST SPEAr: Adding machine support for rtc-spear
  ST SPEAr: adding support for synopsis i2c designware
  Keyboard: Adding support for spear-keyboard
  ST SPEAr: Adding machine support for keyboard

Ryan Mallon (5):
  SPEAr3xx: Make local structres static
  SPEAR3xx: Rename register/irq defines to remove naming conflicts
  SPEAr3xx: Rework pmx_dev code to remove conflicts
  SPEAr3xx: Rework KConfig to allow all boards to be compiled in
  SPEAr3xx: Replace defconfigs with single unfied defconfig

Shiraz Hashim (16):
  ARM: move sev definition to common system.h include file
  sp810 Fix: Switch to slow mode before sysctl_soft_reset
  ST SPEAr: Formalized timer support
  ST SPEAr13XX: Adding machine specific header files
  ST SPEAr13XX: Adding machine specific src files
  ST SPEAr: Adding support for SPEAr13xx SoC in spear generic plat/
  ST SPEAr13XX: Added compilation support in arch/arm/
  ST SPEAr1300: Adding default config file
  ST SPEAr: Adding Debugfs support on clock framework
  ST SPEAr: Add smi driver for serial NOR flash
  ST SPEAr: Adding support for serial nor flash in all spear platforms
  ST SPEAr: Replacing SIZE macro's with actual required size
  SPEAr: removing size based macros except those necessary
  ST SPEAr13xx: add l2 cache support
  ST SPEAr13xx: Modified static mappings
  ST SPEAr: Adding information in Documentation/ and MAINTAINERS

Vipin Kumar (7):
  ST SPEAr: Adding machine support for nand
  Newly erased page read workaround
  ST SPEAr : EMI (Extrenal Memory Interface) controller driver
  ST SPEAr : FSMC (Flexible Static Memory Controller) NOR interface
    driver
  SPEAr : Pad multiplexing handling modified
  SPEAr13xx : Fixed part devices in SPEAr13xx addded to the generic
    implementation
  SPEAr : Updating pad multiplexing support

Vipul-kumar Samar (1):
  ST SPEAr: Adding support for CLCD on SPEAr3xx/6xx

Viresh Kumar (24):
  ST SPEAr: Padmux code Updated
  ST SPEAr: Making clock functions more generic
  ST SPEAr: Updating Clock Support
  ST SPEAr: Correcting SOC Config base address for spear320
  ST SPEAr: Adding PLGPIO driver for spear platform
  ST SPEAr: Added ARM PL061 GPIO Support on SPEAr13xx and modified
    resource size
  ST SPEAr: Adding support for ST's PWM IP
  ST SPEAr: Adding Watchdog support
  ST SPEAr: Adding support for SSP PL022
  ST SPEAr: Adding support for SDHCI (SDIO)
  ST SPEAr: Changing resource size of amba devices to SZ_4K
  ST SPEAr: Adding miscellaneous devices
  ST SPEAr: Adding support for DDR in clock framework
  ST SPEAr: replace readl, writel with __raw_readl, __raw_writel in
    uncompress.h
  SPEAr: Adding and Updating Clock definitions
  ST SPEAr3xx: Passing pmx devices address from machine *.c files
  ST SPEAr Clock Framework: Updating for single image solution
  ST SPEAr: Appending spear3** with global structures
  ST SPEAr3xx: Updating plgpio and emi source to make it compliant with
    single image strategy
  SPEAr6xx: Rework Kconfig for single image solution
  ST SPEAR6xx: renaming spear600_defconfig as spear6xx_defconfig
  ST SPEAr13xx: Pass default padmux settings as parameter to
    spear13**_init routine
  ST SPEAr: Adding devices & clocks
  ST SPEAr: Updating defconfigs

 Documentation/arm/SPEAr/overview.txt               |   34 +-
 MAINTAINERS                                        |    6 +
 arch/arm/Kconfig                                   |   17 +-
 arch/arm/Makefile                                  |    2 +
 arch/arm/common/gic.c                              |   13 +
 arch/arm/configs/spear13xx_defconfig               |  127 ++
 arch/arm/configs/spear300_defconfig                |   51 -
 arch/arm/configs/spear310_defconfig                |   52 -
 arch/arm/configs/spear320_defconfig                |   52 -
 arch/arm/configs/spear3xx_defconfig                |  119 ++
 arch/arm/configs/spear600_defconfig                |   49 -
 arch/arm/configs/spear6xx_defconfig                |  109 ++
 arch/arm/include/asm/hardware/sp810.h              |    3 +
 arch/arm/include/asm/system.h                      |    7 +
 arch/arm/mach-omap2/omap-smp.c                     |    1 +
 arch/arm/mach-spear13xx/Kconfig                    |   32 +
 arch/arm/mach-spear13xx/Makefile                   |   23 +
 arch/arm/mach-spear13xx/Makefile.boot              |    3 +
 arch/arm/mach-spear13xx/clock.c                    | 1204 ++++++++++++++++++++
 arch/arm/mach-spear13xx/fsmc-nor.c                 |   85 ++
 arch/arm/mach-spear13xx/headsmp.S                  |   95 ++
 arch/arm/mach-spear13xx/hotplug.c                  |  135 +++
 arch/arm/mach-spear13xx/include/mach/clkdev.h      |   19 +
 arch/arm/mach-spear13xx/include/mach/debug-macro.S |   14 +
 arch/arm/mach-spear13xx/include/mach/entry-macro.S |   88 ++
 arch/arm/mach-spear13xx/include/mach/generic.h     |  280 +++++
 arch/arm/mach-spear13xx/include/mach/gpio.h        |   37 +
 arch/arm/mach-spear13xx/include/mach/hardware.h    |   37 +
 arch/arm/mach-spear13xx/include/mach/io.h          |   19 +
 arch/arm/mach-spear13xx/include/mach/irqs.h        |  153 +++
 arch/arm/mach-spear13xx/include/mach/memory.h      |   19 +
 arch/arm/mach-spear13xx/include/mach/misc_regs.h   |  386 +++++++
 arch/arm/mach-spear13xx/include/mach/pcie.h        |  170 +++
 arch/arm/mach-spear13xx/include/mach/smp.h         |   33 +
 arch/arm/mach-spear13xx/include/mach/spear.h       |   95 ++
 arch/arm/mach-spear13xx/include/mach/spear1300.h   |   21 +
 arch/arm/mach-spear13xx/include/mach/spear1310.h   |   65 ++
 arch/arm/mach-spear13xx/include/mach/suspend.h     |   47 +
 arch/arm/mach-spear13xx/include/mach/system.h      |   39 +
 arch/arm/mach-spear13xx/include/mach/timex.h       |   19 +
 arch/arm/mach-spear13xx/include/mach/uncompress.h  |   19 +
 arch/arm/mach-spear13xx/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-spear13xx/localtimer.c               |   25 +
 arch/arm/mach-spear13xx/pcie.c                     |  861 ++++++++++++++
 arch/arm/mach-spear13xx/platsmp.c                  |  200 ++++
 arch/arm/mach-spear13xx/pm.c                       |  107 ++
 arch/arm/mach-spear13xx/sleep.S                    |  435 +++++++
 arch/arm/mach-spear13xx/spear1300.c                |   38 +
 arch/arm/mach-spear13xx/spear1300_evb.c            |  171 +++
 arch/arm/mach-spear13xx/spear1310.c                |  519 +++++++++
 arch/arm/mach-spear13xx/spear1310_evb.c            |  215 ++++
 arch/arm/mach-spear13xx/spear13xx.c                | 1198 +++++++++++++++++++
 arch/arm/mach-spear3xx/Kconfig                     |   30 +-
 arch/arm/mach-spear3xx/Kconfig300                  |   17 -
 arch/arm/mach-spear3xx/Kconfig310                  |   17 -
 arch/arm/mach-spear3xx/Kconfig320                  |   17 -
 arch/arm/mach-spear3xx/Makefile                    |    4 +
 arch/arm/mach-spear3xx/clock.c                     |  576 ++++++++--
 arch/arm/mach-spear3xx/emi.c                       |  117 ++
 arch/arm/mach-spear3xx/include/mach/emi.h          |   65 ++
 arch/arm/mach-spear3xx/include/mach/generic.h      |  281 +++--
 arch/arm/mach-spear3xx/include/mach/gpio.h         |  143 +++
 arch/arm/mach-spear3xx/include/mach/irqs.h         |  206 ++--
 arch/arm/mach-spear3xx/include/mach/misc_regs.h    |   12 +-
 arch/arm/mach-spear3xx/include/mach/spear.h        |  134 +--
 arch/arm/mach-spear3xx/include/mach/spear300.h     |   86 +-
 arch/arm/mach-spear3xx/include/mach/spear310.h     |   85 +-
 arch/arm/mach-spear3xx/include/mach/spear320.h     |  121 +--
 arch/arm/mach-spear3xx/include/mach/suspend.h      |   44 +
 arch/arm/mach-spear3xx/spear300.c                  |  640 ++++++++---
 arch/arm/mach-spear3xx/spear300_evb.c              |  116 ++-
 arch/arm/mach-spear3xx/spear310.c                  |  423 ++++++--
 arch/arm/mach-spear3xx/spear310_evb.c              |  145 ++-
 arch/arm/mach-spear3xx/spear320.c                  |  844 +++++++++++----
 arch/arm/mach-spear3xx/spear320_evb.c              |  130 ++-
 arch/arm/mach-spear3xx/spear3xx.c                  |  760 ++++++++++---
 arch/arm/mach-spear6xx/Kconfig                     |   15 +-
 arch/arm/mach-spear6xx/Kconfig600                  |   17 -
 arch/arm/mach-spear6xx/clock.c                     |  438 ++++++--
 arch/arm/mach-spear6xx/include/mach/generic.h      |   20 +-
 arch/arm/mach-spear6xx/include/mach/gpio.h         |   27 +
 arch/arm/mach-spear6xx/include/mach/misc_regs.h    |   12 +-
 arch/arm/mach-spear6xx/include/mach/spear.h        |  174 +---
 arch/arm/mach-spear6xx/include/mach/suspend.h      |   44 +
 arch/arm/mach-spear6xx/spear600_evb.c              |   45 +-
 arch/arm/mach-spear6xx/spear6xx.c                  |  363 ++++++-
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-spear/Kconfig                        |   16 +
 arch/arm/plat-spear/Makefile                       |   21 +-
 arch/arm/plat-spear/clcd.c                         |  114 ++
 arch/arm/plat-spear/clock.c                        |  905 +++++++++++++---
 arch/arm/plat-spear/cpufreq.c                      |  159 +++
 arch/arm/plat-spear/i2c_eval_board.c               |   29 +
 arch/arm/plat-spear/include/plat/clock.h           |  189 +++-
 arch/arm/plat-spear/include/plat/fsmc.h            |   51 +
 arch/arm/plat-spear/include/plat/gpio.h            |   35 +
 arch/arm/plat-spear/include/plat/keyboard.h        |  144 +++
 arch/arm/plat-spear/include/plat/padmux.h          |   34 +-
 arch/arm/plat-spear/include/plat/smi.h             |   71 ++
 arch/arm/plat-spear/include/plat/spi.h             |   77 ++
 arch/arm/plat-spear/include/plat/system.h          |    2 +-
 arch/arm/plat-spear/include/plat/uncompress.h      |    4 +-
 arch/arm/plat-spear/padmux.c                       |   54 +-
 arch/arm/plat-spear/plgpio.c                       |  474 ++++++++
 arch/arm/plat-spear/pll_clk.S                      |  187 +++
 arch/arm/plat-spear/pm.c                           |  104 ++
 arch/arm/plat-spear/pwm.c                          |  484 ++++++++
 arch/arm/plat-spear/sleep.S                        |  288 +++++
 arch/arm/plat-spear/smi.c                          |   63 +
 arch/arm/plat-spear/time.c                         |   21 +-
 drivers/input/keyboard/Kconfig                     |    9 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/spear-keyboard.c            |  362 ++++++
 drivers/misc/Kconfig                               |   10 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/spear13xx_pcie_gadget.c               |  888 +++++++++++++++
 drivers/mtd/devices/Kconfig                        |    7 +
 drivers/mtd/devices/Makefile                       |    1 +
 drivers/mtd/devices/spear_smi.c                    | 1122 ++++++++++++++++++
 drivers/mtd/nand/fsmc_nand.c                       |   28 +-
 drivers/rtc/Kconfig                                |    8 +
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-spear.c                            |  594 ++++++++++
 drivers/usb/Kconfig                                |    2 +
 drivers/usb/host/ehci-hcd.c                        |    5 +
 drivers/usb/host/ehci-spear.c                      |  211 ++++
 drivers/usb/host/ohci-hcd.c                        |    5 +
 drivers/usb/host/ohci-spear.c                      |  240 ++++
 drivers/video/Kconfig                              |   14 +-
 include/mtd/fsmc.h                                 |    2 +
 130 files changed, 18777 insertions(+), 1996 deletions(-)
 create mode 100644 arch/arm/configs/spear13xx_defconfig
 delete mode 100644 arch/arm/configs/spear300_defconfig
 delete mode 100644 arch/arm/configs/spear310_defconfig
 delete mode 100644 arch/arm/configs/spear320_defconfig
 create mode 100644 arch/arm/configs/spear3xx_defconfig
 delete mode 100644 arch/arm/configs/spear600_defconfig
 create mode 100644 arch/arm/configs/spear6xx_defconfig
 create mode 100644 arch/arm/mach-spear13xx/Kconfig
 create mode 100644 arch/arm/mach-spear13xx/Makefile
 create mode 100644 arch/arm/mach-spear13xx/Makefile.boot
 create mode 100644 arch/arm/mach-spear13xx/clock.c
 create mode 100644 arch/arm/mach-spear13xx/fsmc-nor.c
 create mode 100644 arch/arm/mach-spear13xx/headsmp.S
 create mode 100644 arch/arm/mach-spear13xx/hotplug.c
 create mode 100644 arch/arm/mach-spear13xx/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-spear13xx/include/mach/generic.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/gpio.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/hardware.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/io.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/irqs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/memory.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/misc_regs.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/pcie.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/smp.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1300.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/spear1310.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/suspend.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/system.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/timex.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-spear13xx/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-spear13xx/localtimer.c
 create mode 100644 arch/arm/mach-spear13xx/pcie.c
 create mode 100644 arch/arm/mach-spear13xx/platsmp.c
 create mode 100644 arch/arm/mach-spear13xx/pm.c
 create mode 100644 arch/arm/mach-spear13xx/sleep.S
 create mode 100644 arch/arm/mach-spear13xx/spear1300.c
 create mode 100644 arch/arm/mach-spear13xx/spear1300_evb.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310.c
 create mode 100644 arch/arm/mach-spear13xx/spear1310_evb.c
 create mode 100644 arch/arm/mach-spear13xx/spear13xx.c
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig300
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig310
 delete mode 100644 arch/arm/mach-spear3xx/Kconfig320
 create mode 100644 arch/arm/mach-spear3xx/emi.c
 create mode 100644 arch/arm/mach-spear3xx/include/mach/emi.h
 create mode 100644 arch/arm/mach-spear3xx/include/mach/suspend.h
 delete mode 100644 arch/arm/mach-spear6xx/Kconfig600
 create mode 100644 arch/arm/mach-spear6xx/include/mach/suspend.h
 create mode 100644 arch/arm/plat-spear/clcd.c
 create mode 100644 arch/arm/plat-spear/cpufreq.c
 create mode 100644 arch/arm/plat-spear/i2c_eval_board.c
 create mode 100644 arch/arm/plat-spear/include/plat/fsmc.h
 create mode 100644 arch/arm/plat-spear/include/plat/keyboard.h
 create mode 100644 arch/arm/plat-spear/include/plat/smi.h
 create mode 100644 arch/arm/plat-spear/include/plat/spi.h
 create mode 100644 arch/arm/plat-spear/plgpio.c
 create mode 100644 arch/arm/plat-spear/pll_clk.S
 create mode 100644 arch/arm/plat-spear/pm.c
 create mode 100644 arch/arm/plat-spear/pwm.c
 create mode 100644 arch/arm/plat-spear/sleep.S
 create mode 100644 arch/arm/plat-spear/smi.c
 create mode 100644 drivers/input/keyboard/spear-keyboard.c
 create mode 100644 drivers/misc/spear13xx_pcie_gadget.c
 create mode 100644 drivers/mtd/devices/spear_smi.c
 create mode 100644 drivers/rtc/rtc-spear.c
 create mode 100644 drivers/usb/host/ehci-spear.c
 create mode 100644 drivers/usb/host/ohci-spear.c

-- 
1.7.2.2
