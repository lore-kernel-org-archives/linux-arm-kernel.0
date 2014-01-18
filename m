From: ta.omasab@gmail.com (Thomas Abraham)
Date: Sat, 18 Jan 2014 17:40:50 +0530
Subject: [PATCH v2 0/7] cpufreq: use cpufreq-cpu0 driver for exynos based
 platforms
Message-ID: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Removes Exynos4x12 and Exynos5250 cpufreq driver also.
- Device tree based clock configuration lookup as suggested by Lukasz
  Majewski and Tomasz Figa.
- safe operating point binding reworked as suggested by Shawn Guo.

The patch series removes the use of Exynos specific cpufreq driver and enables
the use of cpufreq-cpu0 driver for Exynos4210, Exynos4x12 and Exynos5250 based
platforms. This is being done for few reasons.

(a) The Exynos cpufreq driver reads/writes clock controller registers
    bypassing the Exynos CCF driver which is sort of problematic.
(b) Removes the need for having clock controller register definitions
    in the cpufreq driver and also removes the need for statically
    io-remapping clock controller address space (helps in moving towards
    multiplatform kernel).

In order to use cpufreq-cpu0 driver and provide fast cpu clock switching
during dvfs operations, the following apporach has been used.

(a) A new CPU clock provider type has been introduced in Samsung's CCF
    support. This clock provider type can be a compostion of multiple
    clock blocks such as mux, dividers and gates. Typically, in Exynos
    platforms, there are multiple clock blocks in between the output
    of the APLL and the CPU clock domain output. Representing these
    mutiple clock blocks within a opaque CPU clock provider type helps
    in reducing the time taken to perform a CPU clock frequency change
    operation, which is generally required during DVFS operations.
    This approach was suggested by Arnd Bergmann <arnd@arndb.de> during
    LCE-2013.

(b) A new optional safe operating point property has been introduced
    in the cpufreq-cpu0 driver binding. On some platforms such as the
    Samsung Exynos, a change in CPU frequency requires a change in the
    PLL output that drives the CPU clock. A change in PLL output
    requires the PLL output be turned off, which implies that the CPU
    (and other components in the CPU clock domain) be supplied with
    an alternate clock source during the time the PLL output is changed.

    The clock speed of this alternate clock source could be higher
    than the clock speed of the PLL at the time of switching over to
    the alternate clock source. This temporary increase in clock speed
    of the CPU clock domain implies that the blocks within the CPU
    clock domain should also be supplied with an appropriate voltage
    supply level as required to drive the CPU clock domain components
    at the speed of the alternative clock source. This temporary
    voltage level required during switching of CPU clock speed is
    called safe voltage level. And the cpufreq-cpu0 driver has been
    modified to setup the safe voltage levels during the changes
    in CPU clock speed.

(c) The CPU clock supply as been restructured as
    [ Output of APLL -> Opaque CPU clock provider -> CPU clock output ]
    And with the changes in (a) and (b) above, the cpufreq-cpu0 driver
    can now be used and can remove the use of Exynos specific
    cpufreq driver.

This patch series is tested on the following platforms.
  - Exynos4210 based Insignal Origen board.
  - Exynos4412 based Insignal Origen Quad board.
  - Exynos5250 based Samsung SMDK board.

This patch series is based on linux-next master branch.

Thomas Abraham (7):
  cpufreq: cpufreq-cpu0: allow optional safe voltage during frequency transitions
  clk: samsung: add infrastructure to register cpu clocks
  devicetree: bindings: add cpu clock configuration data binding for Exynos4/5
  ARM: dts: Exynos: add cpu nodes, opp and cpu clock frequency table
  clk: exynos: use cpu-clock provider type to represent arm clock
  ARM: Exynos: switch to using generic cpufreq-cpu0 driver
  cpufreq: exynos: remove all exynos specific cpufreq driver support

 .../devicetree/bindings/clock/exynos4-clock.txt    |   30 ++
 .../devicetree/bindings/clock/exynos5250-clock.txt |   22 ++
 .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    7 +
 arch/arm/boot/dts/exynos4210-origen.dts            |    6 +
 arch/arm/boot/dts/exynos4210-trats.dts             |    6 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |    6 +
 arch/arm/boot/dts/exynos4210.dtsi                  |   35 ++
 arch/arm/boot/dts/exynos4212.dtsi                  |   17 +
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    6 +
 arch/arm/boot/dts/exynos4412-origen.dts            |    6 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |    6 +
 arch/arm/boot/dts/exynos4412.dtsi                  |   30 ++
 arch/arm/boot/dts/exynos4x12.dtsi                  |   35 ++
 arch/arm/boot/dts/exynos5250-arndale.dts           |    6 +
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |    6 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    6 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   43 +++-
 arch/arm/mach-exynos/common.c                      |    5 -
 arch/arm/mach-exynos/common.h                      |    1 -
 arch/arm/mach-exynos/mach-exynos4-dt.c             |    2 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +-
 drivers/clk/samsung/Makefile                       |    2 +-
 drivers/clk/samsung/clk-cpu.c                      |  345 ++++++++++++++++++++
 drivers/clk/samsung/clk-exynos4.c                  |   11 +-
 drivers/clk/samsung/clk-exynos5250.c               |    8 +-
 drivers/clk/samsung/clk.h                          |    3 +
 drivers/cpufreq/Kconfig.arm                        |   36 --
 drivers/cpufreq/Makefile                           |    4 -
 drivers/cpufreq/cpufreq-cpu0.c                     |   37 ++-
 drivers/cpufreq/exynos-cpufreq.c                   |  292 -----------------
 drivers/cpufreq/exynos-cpufreq.h                   |   91 -----
 drivers/cpufreq/exynos4210-cpufreq.c               |  157 ---------
 drivers/cpufreq/exynos4x12-cpufreq.c               |  211 ------------
 drivers/cpufreq/exynos5250-cpufreq.c               |  183 -----------
 include/dt-bindings/clock/exynos5250.h             |    1 +
 35 files changed, 666 insertions(+), 998 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-cpu.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c
