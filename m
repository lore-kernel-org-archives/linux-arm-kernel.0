From: david@lechnology.com (David Lechner)
Date: Sun,  7 Jan 2018 20:16:59 -0600
Subject: =?UTF-8?q?=5BPATCH=20v5=2000/44=5D=20ARM=3A=20davinci=3A=20convert=20to=20common=20clock=20framework=E2=80=8B?=
Message-ID: <1515377863-20358-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series converts mach-davinci to use the common clock framework.

The series works like this, the first 21 patches create new clock drivers
using the common clock framework. There are basically 3 groups of clocks -
PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
unique init data, which is the reason for so many patches.

Then, starting with "ARM: davinci: move davinci_clk_init() to init_time",
we get the mach code ready for the switch by adding the code needed for
the new clock drivers and adding #ifndef CONFIG_COMMON_CLK around the
legacy clocks so that we can switch easily between the old and the new.

"ARM: davinci: switch to common clock framework" actually flips the switch
to start using the new clock drivers. Then the next 8 patches remove all
of the old clock code.

The final three patches add device tree support to the one SoC that
supports it.

v5 changes:
- Basically, this is an entirely new series
- Patches are broken up into bite-sized pieces
- Converted PSC clock driver to use regmap
- Restored "force" flag for certain DA850 clocks
- Added device tree bindings
- Moved more of the clock init to drivers/clk
- Fixed frequency scaling (maybe*)

* I have frequency scaling using cpufreq-dt, so I know the clocks are doing
  what they need to do to make this work, but I haven't figured out how to
  test davinci-cpufreq driver yet. (Patches to make cpufreq-dt work will be
  sent separately after this series has landed.)

Dependencies:

This series applies on top of linux-davinci/master plus the following patches:
- [1] clk: fix reentrancy of clk_enable() on UP systems
- [2] clk: add helper functions for managing clk_onecell_data
- [3] clk: divider: fix clk_round_rate() when CLK_DIVIDER_READ_ONLY &&
	CLK_RATE_SET_PARENT
- [4] watchdog: davinci_wdt: add restart function
- [5] ARM: davinci: remove watchdog reset
- [6] USB: musb: da8xx: remove clock con_id
- [7] USB: ohci: da8xx: remove clk con_id
- [8] ARM: da8xx: remove con_id from USB clocks

You can find a working branch with everything included in the "common-clk-v5"
branch of https://github.com/dlech/ev3dev-kernel.git.

[1]: https://patchwork.kernel.org/patch/10145933/
[2]: https://patchwork.kernel.org/patch/10145873/
[3]: https://patchwork.kernel.org/patch/10147983/
[4]: https://patchwork.kernel.org/patch/10148097/
[5]: https://patchwork.kernel.org/patch/10148099/
[6]: https://patchwork.kernel.org/patch/10148111/
[7]: https://patchwork.kernel.org/patch/10148107/
[8]: https://patchwork.kernel.org/patch/10148109/


Testing/debugging for the uninitiated:

I only have one device to test with, which is based on da850, so I will
have to rely on others to do some testing here. Since we are dealing with
clocks, if something isn't working, you most likely won't see output on
the serial port. To figure out what is going on, you need to enable...

	CONFIG_DEBUG_LL=y
	CONFIG_EARLY_PRINTK=y

and add "earlyprintk clk_ignore_unused" to the kernel command line options.
You may need to select a different UART for this depending on your board. I
think UART1 is the default in the kernel configuration.

On da850 devices comment out the lines:

	else
		clk_set_parent(clk, parent->clk);

in da850.c or, if using device tree, comment out the lines:

	assigned-clocks = <&async3_clk>;
	assigned-clock-parents = <&pll1_sysclk 2>;

in da850.dtsi when doing earlyprintk, otherwise the UART1 and UART2 clock
source will change during boot and cause garbled output after a point. 


David Lechner (44):
  dt-bindings: clock: Add new bindings for TI Davinci PLL clocks
  clk: davinci: New driver for davinci PLL clocks
  clk: davinci: Add platform information for TI DA830 PLL
  clk: davinci: Add platform information for TI DA850 PLL
  clk: davinci: Add platform information for TI DM355 PLL
  clk: davinci: Add platform information for TI DM365 PLL
  clk: davinci: Add platform information for TI DM644x PLL
  clk: davinci: Add platform information for TI DM646x PLL
  dt-bindings: clock: New bindings for TI Davinci PSC
  clk: davinci: New driver for davinci PSC clocks
  clk: davinci: Add platform information for TI DA830 PSC
  clk: davinci: Add platform information for TI DA850 PSC
  clk: davinci: Add platform information for TI DM355 PSC
  clk: davinci: Add platform information for TI DM365 PSC
  clk: davinci: Add platform information for TI DM644x PSC
  clk: davinci: Add platform information for TI DM646x PSC
  dt-bindings: clock: Add bindings for DA8XX CFGCHIP gate clocks
  dt-bindings: clock: Add binding for TI DA8XX CFGCHIP mux clocks
  clk: davinci: New driver for TI DA8XX CFGCHIP clocks
  dt-bindings: clock: Add bindings for TI DA8XX USB PHY clocks
  clk: davinci: New driver for TI DA8XX USB PHY clocks
  ARM: davinci: move davinci_clk_init() to init_time
  ARM: da830: add new clock init using common clock framework
  ARM: da850: add new clock init using common clock framework
  ARM: dm355: add new clock init using common clock framework
  ARM: dm365: add new clock init using common clock framework
  ARM: dm644x: add new clock init using common clock framework
  ARM: dm646x: add new clock init using common clock framework
  ARM: da8xx: add new USB PHY clock init using common clock framework
  ARM: da8xx: add new sata_refclk init using common clock frmework
  ARM: davinci: remove CONFIG_DAVINCI_RESET_CLOCKS
  ARM: davinci_all_defconfig: remove CONFIG_DAVINCI_RESET_CLOCKS
  ARM: davinci: switch to common clock framework
  ARM: da830: Remove legacy clock init
  ARM: da850: Remove legacy clock init
  ARM: dm355: Remove legacy clock init
  ARM: dm365: Remove legacy clock init
  ARM: dm644x: Remove legacy clock init
  ARM: dm646x: Remove legacy clock init
  ARM: da8xx: Remove legacy clock init
  ARM: davinci: remove legacy clocks
  ARM: davinci: add device tree support to timer
  ARM: da8xx-dt: switch to device tree clocks
  ARM: dts: da850: Add clocks

 .../clock/ti/davinci/da8xx-cfgchip-gate.txt        |  38 ++
 .../clock/ti/davinci/da8xx-cfgchip-mux.txt         |  42 ++
 .../clock/ti/davinci/da8xx-cfgchip-usb-phy.txt     |  55 ++
 .../devicetree/bindings/clock/ti/davinci/pll.txt   |  47 ++
 .../devicetree/bindings/clock/ti/davinci/psc.txt   |  47 ++
 MAINTAINERS                                        |   6 +
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/boot/dts/da850.dtsi                       | 167 +++++
 arch/arm/configs/davinci_all_defconfig             |   1 -
 arch/arm/mach-davinci/Kconfig                      |  13 +-
 arch/arm/mach-davinci/Makefile                     |   2 +-
 arch/arm/mach-davinci/board-da830-evm.c            |   2 +-
 arch/arm/mach-davinci/board-da850-evm.c            |   2 +-
 arch/arm/mach-davinci/board-dm355-evm.c            |   2 +-
 arch/arm/mach-davinci/board-dm355-leopard.c        |   2 +-
 arch/arm/mach-davinci/board-dm365-evm.c            |   2 +-
 arch/arm/mach-davinci/board-dm644x-evm.c           |   2 +-
 arch/arm/mach-davinci/board-dm646x-evm.c           |  19 +-
 arch/arm/mach-davinci/board-mityomapl138.c         |   2 +-
 arch/arm/mach-davinci/board-neuros-osd2.c          |   2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c        |   2 +-
 arch/arm/mach-davinci/board-sffsdr.c               |   2 +-
 arch/arm/mach-davinci/clock.c                      | 745 ---------------------
 arch/arm/mach-davinci/clock.h                      |  76 ---
 arch/arm/mach-davinci/common.c                     |   3 -
 arch/arm/mach-davinci/da830.c                      | 438 +-----------
 arch/arm/mach-davinci/da850.c                      | 689 ++-----------------
 arch/arm/mach-davinci/da8xx-dt.c                   |  61 +-
 arch/arm/mach-davinci/davinci.h                    |   8 +
 arch/arm/mach-davinci/devices-da8xx.c              |  43 +-
 arch/arm/mach-davinci/devices.c                    |   1 -
 arch/arm/mach-davinci/dm355.c                      | 390 +----------
 arch/arm/mach-davinci/dm365.c                      | 476 +------------
 arch/arm/mach-davinci/dm644x.c                     | 322 +--------
 arch/arm/mach-davinci/dm646x.c                     | 362 +---------
 arch/arm/mach-davinci/include/mach/clock.h         |   3 -
 arch/arm/mach-davinci/include/mach/common.h        |   9 -
 arch/arm/mach-davinci/include/mach/da8xx.h         |   3 +
 arch/arm/mach-davinci/psc.c                        | 137 ----
 arch/arm/mach-davinci/psc.h                        |  12 -
 arch/arm/mach-davinci/time.c                       |  19 +-
 arch/arm/mach-davinci/usb-da8xx.c                  | 262 ++------
 drivers/clk/Makefile                               |   1 +
 drivers/clk/davinci/Makefile                       |  22 +
 drivers/clk/davinci/da8xx-cfgchip.c                | 203 ++++++
 drivers/clk/davinci/da8xx-usb-phy-clk.c            | 425 ++++++++++++
 drivers/clk/davinci/pll-da830.c                    |  38 ++
 drivers/clk/davinci/pll-da850.c                    |  67 ++
 drivers/clk/davinci/pll-dm355.c                    |  40 ++
 drivers/clk/davinci/pll-dm365.c                    |  64 ++
 drivers/clk/davinci/pll-dm644x.c                   |  41 ++
 drivers/clk/davinci/pll-dm646x.c                   |  44 ++
 drivers/clk/davinci/pll.c                          | 564 ++++++++++++++++
 drivers/clk/davinci/pll.h                          |  61 ++
 drivers/clk/davinci/psc-da830.c                    |  96 +++
 drivers/clk/davinci/psc-da850.c                    | 117 ++++
 drivers/clk/davinci/psc-dm355.c                    |  78 +++
 drivers/clk/davinci/psc-dm365.c                    |  83 +++
 drivers/clk/davinci/psc-dm644x.c                   |  73 ++
 drivers/clk/davinci/psc-dm646x.c                   |  68 ++
 drivers/clk/davinci/psc.c                          | 282 ++++++++
 drivers/clk/davinci/psc.h                          |  49 ++
 include/linux/clk/davinci.h                        |  39 ++
 63 files changed, 3172 insertions(+), 3801 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-gate.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-mux.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/pll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/psc.txt
 delete mode 100644 arch/arm/mach-davinci/clock.c
 delete mode 100644 arch/arm/mach-davinci/psc.c
 create mode 100644 drivers/clk/davinci/Makefile
 create mode 100644 drivers/clk/davinci/da8xx-cfgchip.c
 create mode 100644 drivers/clk/davinci/da8xx-usb-phy-clk.c
 create mode 100644 drivers/clk/davinci/pll-da830.c
 create mode 100644 drivers/clk/davinci/pll-da850.c
 create mode 100644 drivers/clk/davinci/pll-dm355.c
 create mode 100644 drivers/clk/davinci/pll-dm365.c
 create mode 100644 drivers/clk/davinci/pll-dm644x.c
 create mode 100644 drivers/clk/davinci/pll-dm646x.c
 create mode 100644 drivers/clk/davinci/pll.c
 create mode 100644 drivers/clk/davinci/pll.h
 create mode 100644 drivers/clk/davinci/psc-da830.c
 create mode 100644 drivers/clk/davinci/psc-da850.c
 create mode 100644 drivers/clk/davinci/psc-dm355.c
 create mode 100644 drivers/clk/davinci/psc-dm365.c
 create mode 100644 drivers/clk/davinci/psc-dm644x.c
 create mode 100644 drivers/clk/davinci/psc-dm646x.c
 create mode 100644 drivers/clk/davinci/psc.c
 create mode 100644 drivers/clk/davinci/psc.h
 create mode 100644 include/linux/clk/davinci.h

-- 
2.7.4
