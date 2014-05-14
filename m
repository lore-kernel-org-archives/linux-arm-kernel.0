From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 14 May 2014 06:41:08 +0530
Subject: [PATCH v4 0/8] cpufreq: use cpufreq-cpu0 driver for exynos based
 platforms
Message-ID: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3:
- Addressed comments from Tomasz Figa <t.figa@samsung.com>
  [http://www.spinics.net/lists/cpufreq/msg09290.html]
- Rebased to v3.15-rc4

Changes since v2:
- Safe operating voltage is not required while switching APLL frequency
  since the temporary parent's clock is divided down to keep armclk within
  permissible limits. Thanks to Heiko St?bner <heiko@sntech.de> for this
  suggesting this.
- Rob had suggested to use max frequency for each of the divider clock
  outputs instead of divider values. But due to certain SoC specific
  characteristics, the divider values corresponding to the input clock
  frequency for the CMU_CPU clock blocks have to be used.

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

Thomas Abraham (8):
  cpufreq: cpufreq-cpu0: allow use of optional boost mode frequencies
  clk: samsung: change scope of samsung clock lock to global
  clk: samsung: add infrastructure to register cpu clocks
  Documentation: devicetree: add cpu clock configuration data binding for Exynos4/5
  clk: exynos: use cpu-clock provider type to represent arm clock
  ARM: dts: Exynos: add cpu nodes, opp and cpu clock configuration data
  ARM: Exynos: switch to using generic cpufreq-cpu0 driver
  cpufreq: exynos: remove all exynos specific cpufreq driver support


 .../devicetree/bindings/clock/exynos4-clock.txt    |   37 ++
 .../devicetree/bindings/clock/exynos5250-clock.txt |   36 ++
 .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    2 +
 arch/arm/boot/dts/exynos4210-origen.dts            |    6 +
 arch/arm/boot/dts/exynos4210-trats.dts             |    6 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |    6 +
 arch/arm/boot/dts/exynos4210.dtsi                  |   35 ++
 arch/arm/boot/dts/exynos4212.dtsi                  |   18 +
 arch/arm/boot/dts/exynos4412-odroidx.dts           |    6 +
 arch/arm/boot/dts/exynos4412-origen.dts            |    6 +
 arch/arm/boot/dts/exynos4412-trats2.dts            |    6 +
 arch/arm/boot/dts/exynos4412.dtsi                  |   31 ++
 arch/arm/boot/dts/exynos4x12.dtsi                  |   36 ++
 arch/arm/boot/dts/exynos5250-arndale.dts           |    6 +
 arch/arm/boot/dts/exynos5250-cros-common.dtsi      |    6 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    6 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   41 ++
 arch/arm/mach-exynos/exynos.c                      |    4 +-
 drivers/clk/samsung/Makefile                       |    2 +-
 drivers/clk/samsung/clk-cpu.c                      |  458 ++++++++++++++++++++
 drivers/clk/samsung/clk-exynos4.c                  |   25 +-
 drivers/clk/samsung/clk-exynos5250.c               |   12 +-
 drivers/clk/samsung/clk.c                          |   13 +-
 drivers/clk/samsung/clk.h                          |    7 +
 drivers/cpufreq/Kconfig                            |   11 +
 drivers/cpufreq/Kconfig.arm                        |   52 ---
 drivers/cpufreq/Makefile                           |    4 -
 drivers/cpufreq/cpufreq-cpu0.c                     |    5 +
 drivers/cpufreq/exynos-cpufreq.c                   |  209 ---------
 drivers/cpufreq/exynos-cpufreq.h                   |   91 ----
 drivers/cpufreq/exynos4210-cpufreq.c               |  157 -------
 drivers/cpufreq/exynos4x12-cpufreq.c               |  211 ---------
 drivers/cpufreq/exynos5250-cpufreq.c               |  183 --------
 include/dt-bindings/clock/exynos5250.h             |    1 +
 34 files changed, 799 insertions(+), 936 deletions(-)
 create mode 100644 drivers/clk/samsung/clk-cpu.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
 delete mode 100644 drivers/cpufreq/exynos4210-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos4x12-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

-- 
1.7.4.4
