From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 06:53:28 +0200
Subject: [PATCH v3 00/19] ARM: at91: move to common clk framework
Message-ID: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series is the 3rd version of the new at91 clock implementation
(using common clk framework).

Most of the clock provided by the PMC (Power Management Controller) are
implemented :
- main clock (main oscillator)
- pll clocks
- master clock
- programmable clocks
- utmi clock
- peripheral clocks
- system clocks

This implementation is only compatible with device tree definition.
The goal is to define the whole clock tree in the device tree.

Please feel free to comment the dt bindinds.

This patch series is based on linux-next and has been tested on sama5d31ek
board using device tree. It compiles for other SoCs and both with and
but it has not been tested (Richard, I did not add your Tested-by because
a lot of things have changed since v2).

BTW could other people test it on other boards (I only have a kizbox and
a sama5d31ek dev kit).

Best Regards,
Boris

Changes since v2:
 - fix several bugs in clk implementations
 - drop non-dt boards support
 - split the series to ease review and tests:
   * 1 patch series for new clk implementations (this series)
   * 1 patch series to move each at91 SoC to common clk framework (coming soon)
 - modify dt-bindings (add atmel,clk- prefix to atmel specific properties)
 - add clk macros for dt-bindings
 - add pmc framework (helper function to access pmc registers)
 - add interrupt support to enable passive wait in clk_prepare functions

Changes since v1:
 - fix bugs in pll, programmable and system clock implementations
   (wrong bit position).
 - add usb clock configuration support (ohci and udc drivers +
   clk_lookup for non dt boards)
 - rework of the system clock interfaces (no need to define a parent clock,
   system clock is a gate with no rate info)
 - change system, peripheral and programmable clk dt bindings (1 master node
   and multiple child nodes each defining a system/peripheral or prog clock)
 - fix bugs in sama5 dt definition

Boris BREZILLON (19):
  ARM: at91: move at91_pmc.h to include/linux/clk/at91_pmc.h
  ARM: at91: add Kconfig options for common clk support
  clk: at91: add PMC base support
  clk: at91: add PMC macro file for dt definitions
  clk: at91: add PMC main clock
  clk: at91: add PMC pll clocks
  clk: at91: add pll id macros for pll dt bindings
  clk: at91: add PMC master clock
  clk: at91: add PMC system clocks
  ARM: at91/dt: add system clk id definitions in dt-bindings include
    dir
  clk: at91: add PMC peripheral clocks
  clk: at91: add peripheral clk macros for peripheral clk dt bindings
  clk: at91: add PMC programmable clocks
  clk: at91: add PMC utmi clock
  clk: at91: add PMC usb clock
  clk: at91: add PMC smd clock
  clk: at91: add PMC clk device tree binding doc.
  ARM: at91: move pit timer to common clk framework
  ARM: at91: add new compatible strings for pmc driver

 .../devicetree/bindings/clock/at91-clock.txt       |  312 ++++++++++++
 arch/arm/mach-at91/Kconfig                         |   44 ++
 arch/arm/mach-at91/Kconfig.non_dt                  |    6 +
 arch/arm/mach-at91/Makefile                        |    2 +-
 arch/arm/mach-at91/at91rm9200.c                    |    2 +-
 arch/arm/mach-at91/at91sam9260.c                   |    2 +-
 arch/arm/mach-at91/at91sam9261.c                   |    2 +-
 arch/arm/mach-at91/at91sam9263.c                   |    2 +-
 arch/arm/mach-at91/at91sam926x_time.c              |   14 +-
 arch/arm/mach-at91/at91sam9g45.c                   |    2 +-
 arch/arm/mach-at91/at91sam9n12.c                   |    2 +-
 arch/arm/mach-at91/at91sam9rl.c                    |    2 +-
 arch/arm/mach-at91/at91sam9x5.c                    |    2 +-
 arch/arm/mach-at91/clock.c                         |    8 +-
 arch/arm/mach-at91/generic.h                       |    3 +-
 arch/arm/mach-at91/pm.c                            |    2 +-
 arch/arm/mach-at91/pm_slowclock.S                  |    2 +-
 arch/arm/mach-at91/sama5d3.c                       |    2 +-
 arch/arm/mach-at91/setup.c                         |    8 +-
 drivers/clk/Makefile                               |    1 +
 drivers/clk/at91/Makefile                          |   12 +
 drivers/clk/at91/clk-main.c                        |  171 +++++++
 drivers/clk/at91/clk-master.c                      |  386 +++++++++++++++
 drivers/clk/at91/clk-peripheral.c                  |  401 ++++++++++++++++
 drivers/clk/at91/clk-pll.c                         |  506 ++++++++++++++++++++
 drivers/clk/at91/clk-plldiv.c                      |  137 ++++++
 drivers/clk/at91/clk-programmable.c                |  419 ++++++++++++++++
 drivers/clk/at91/clk-smd.c                         |  171 +++++++
 drivers/clk/at91/clk-system.c                      |  191 ++++++++
 drivers/clk/at91/clk-usb.c                         |  323 +++++++++++++
 drivers/clk/at91/clk-utmi.c                        |  161 +++++++
 drivers/clk/at91/pmc.c                             |  387 +++++++++++++++
 drivers/clk/at91/pmc.h                             |  111 +++++
 drivers/usb/gadget/atmel_usba_udc.c                |    2 +-
 .../dt-bindings/clk/at91/at91rm9200/clk-system.h   |   16 +
 .../dt-bindings/clk/at91/at91sam9261/clk-system.h  |   15 +
 .../clk/at91/at91sam9x5/clk-peripheral.h           |   15 +
 include/dt-bindings/clk/at91/common/clk-pll.h      |   13 +
 include/dt-bindings/clk/at91/common/clk-system.h   |   21 +
 include/dt-bindings/clk/at91/common/pmc.h          |   20 +
 .../include/mach => include/linux/clk}/at91_pmc.h  |    4 +-
 41 files changed, 3882 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/at91-clock.txt
 create mode 100644 drivers/clk/at91/Makefile
 create mode 100644 drivers/clk/at91/clk-main.c
 create mode 100644 drivers/clk/at91/clk-master.c
 create mode 100644 drivers/clk/at91/clk-peripheral.c
 create mode 100644 drivers/clk/at91/clk-pll.c
 create mode 100644 drivers/clk/at91/clk-plldiv.c
 create mode 100644 drivers/clk/at91/clk-programmable.c
 create mode 100644 drivers/clk/at91/clk-smd.c
 create mode 100644 drivers/clk/at91/clk-system.c
 create mode 100644 drivers/clk/at91/clk-usb.c
 create mode 100644 drivers/clk/at91/clk-utmi.c
 create mode 100644 drivers/clk/at91/pmc.c
 create mode 100644 drivers/clk/at91/pmc.h
 create mode 100644 include/dt-bindings/clk/at91/at91rm9200/clk-system.h
 create mode 100644 include/dt-bindings/clk/at91/at91sam9261/clk-system.h
 create mode 100644 include/dt-bindings/clk/at91/at91sam9x5/clk-peripheral.h
 create mode 100644 include/dt-bindings/clk/at91/common/clk-pll.h
 create mode 100644 include/dt-bindings/clk/at91/common/clk-system.h
 create mode 100644 include/dt-bindings/clk/at91/common/pmc.h
 rename {arch/arm/mach-at91/include/mach => include/linux/clk}/at91_pmc.h (98%)

-- 
1.7.9.5
