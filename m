From: pawelo@king.net.pl (Paul Osmialowski)
Date: Tue, 30 Jun 2015 14:27:21 +0200
Subject: [PATCH v2 0/9] [New BSP] Add initial support for Freescale Kinetis
 TWR-K70F120M development kit
Message-ID: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the second iteration of the patchset that adds a basic initial
support to TWR-K70F120M development kit which is based on ARM Cortex-M4
Freescale Kinetis K70 SoC.

Previous iteration met with a broad response for which I would like
to thank everyone involved.

Following is the change list:

1. First three ('controversial') patches are removed.

   As long as it doesn't hit platform stability, I don't use these Cortex-M
   compiler flags, it should not stop the whole of the patchset.

   The idle quirks issue is now addressed by adding idle.c which provides
   callback for arm_pm_idle.

   The infamous zlib patch was not needed at all - I didn't really check
   what it was protecting against.

2. include/mach/idle.h file removed.

3. kinetis_platform.c renamed to kinetis.c, obj-$(CONFIG_MACH_KINETIS)
   changed to obj-y, CONFIG_MACH_KINETIS not needed anymore, removed with
   the whole of the Kconfig file in mach-kinetis directory.

4. Assuming that fsl-edma and fsl-lpuart drivers handle big-endian properly,
   pinctrl, clk and timer drivers now support big-endian the same way
   ("big-endian" option in .dts).

5. All addresses based on KINETIS_AIPS0PERIPH_BASE and
   KINETIS_AIPS1PERIPH_BASE are moved to DT. The struct kinetis_sim_regs
   is moved to clk-kinetis.c. As a result whole include/mach/kinetis.h is
   now removed.

6. Removed kinetis_map_io() from kinetis.c (formerly kinetis_platform.c).

7. Removed kinetis_init() function along with a call to
   of_platform_populate().

8. Removed MACH_KINETIS from arch/arm/tools/mach-types, removed inclusion
   of asm/mach-types.h in kinetis.c (formerly kinetis_platform.c).

9. Removed inclusion of linux/clk.h from clk-kinetis.c.

10. Clock and timer drivers are in separate patches now.

11. '&& ARM' removed from drivers/clocksource/Kconfig.

12. s/clk/evt/ in timer-kinetis.c (actually, the affected *_set_mode()
    function is replaced by a set of *_set_state_*() functions).

13. Removed pointless raw_local_irq_save/restore() from timer-kinetis.c.

14. Removed overhead () from each of the &(.....) from timer-kinetis.c.

15. Removed unused KINETIS_PITn_IRQ definitions from timer-kinetis.c.

16. Replaced use of IRQ actions with request_irq() in timer-kinetis.c.

17. Removed all uses of KINETIS_MKCG() macro and whole include/mach/power.h
    - now all clock gate details are specified directly in the DT.
    For each clock gate #clock-cells = <2> where the first part of the gate
    address is zero-based gate register number, the second part is the bit
    index.

18. Shortened long timer names in timer-kinetis.c.

19. Ensured module friendliness of pinctrl driver (tristate
    CONFIG_PINCTRL_KINETIS)

20. Removed txirq_names[] array from fsl-edma.c - sprinft()-generated
    strings used instead.

21. fsl-lpuart and fsl-edma related patches are both split into two:
    1) changes in the driver and 2) use in platform.

22. Removed all occurences of CONFIG_ARCH_KINETIS from fsl-edma.c - now it
    looks more like fsl-lpuart driver (boolean 'kinetis' field in the main
    driver structure).

Paul Osmialowski (9):
  arm: allow copying of vector table to internal SRAM memory
  arm: twr-k70f120m: basic support for Kinetis TWR-K70F120M
  arm: twr-k70f120m: clock driver for Kinetis SoC
  arm: twr-k70f120m: timer driver for Kinetis SoC
  arm: twr-k70f120m: IOMUX driver for Kinetis SoC
  arm: twr-k70f120m: extend Freescale eDMA driver with the ability to
    support Kinetis SoC
  arm: twr-k70f120m: use Freescale eDMA driver with Kinetis SoC
  arm: twr-k70f120m: extend Freescale lpuart driver with ability to
    support Kinetis SoC
  arm: twr-k70f120m: use Freescale lpuart driver with Kinetis SoC

 Documentation/devicetree/bindings/arm/fsl.txt      |   6 +
 .../devicetree/bindings/clock/kinetis-clock.txt    |  63 +++
 Documentation/devicetree/bindings/dma/fsl-edma.txt |  38 +-
 .../bindings/pinctrl/fsl,kinetis-pinctrl.txt       |  31 ++
 .../devicetree/bindings/serial/fsl-lpuart.txt      |   6 +-
 .../bindings/timer/fsl,kinetis-pit-timer.txt       |  50 ++
 arch/arm/Kconfig                                   |  16 +-
 arch/arm/Kconfig-nommu                             |  12 +
 arch/arm/Makefile                                  |   1 +
 arch/arm/boot/dts/kinetis-twr-k70f120m.dts         |  43 ++
 arch/arm/boot/dts/kinetis.dtsi                     | 241 +++++++++
 arch/arm/kernel/entry-v7m.S                        |   3 +
 arch/arm/mach-kinetis/Makefile                     |   5 +
 arch/arm/mach-kinetis/Makefile.boot                |   3 +
 arch/arm/mach-kinetis/idle.c                       |  27 +
 arch/arm/mach-kinetis/include/mach/memory.h        |  61 +++
 arch/arm/mach-kinetis/kinetis.c                    |  34 ++
 arch/arm/mm/Kconfig                                |   1 +
 arch/arm/mm/proc-v7m.S                             |  11 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-kinetis.c                          | 463 ++++++++++++++++++
 drivers/clocksource/Kconfig                        |   5 +
 drivers/clocksource/Makefile                       |   1 +
 drivers/clocksource/timer-kinetis.c                | 321 ++++++++++++
 drivers/dma/fsl-edma.c                             | 114 ++++-
 drivers/pinctrl/freescale/Kconfig                  |   8 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-kinetis.c        | 541 +++++++++++++++++++++
 drivers/tty/serial/fsl_lpuart.c                    |  90 +++-
 29 files changed, 2153 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/kinetis-clock.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,kinetis-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,kinetis-pit-timer.txt
 create mode 100644 arch/arm/boot/dts/kinetis-twr-k70f120m.dts
 create mode 100644 arch/arm/boot/dts/kinetis.dtsi
 create mode 100644 arch/arm/mach-kinetis/Makefile
 create mode 100644 arch/arm/mach-kinetis/Makefile.boot
 create mode 100644 arch/arm/mach-kinetis/idle.c
 create mode 100644 arch/arm/mach-kinetis/include/mach/memory.h
 create mode 100644 arch/arm/mach-kinetis/kinetis.c
 create mode 100644 drivers/clk/clk-kinetis.c
 create mode 100644 drivers/clocksource/timer-kinetis.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-kinetis.c

-- 
2.3.6
