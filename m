From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 21 Jan 2013 02:02:15 -0800
Subject: [PATCH v4 0/7] ARM: Exynos: Enable device tree support for MCT
 controller
Message-ID: <1358762542-19008-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3:
- Based on Stephen Warren's CONFIG_CLKSRC_OF patches (merged from arm-soc
  'timer/cleanup' branch).
- Moved the mct driver from mach-exynos to drivers/clocksource

Changes since v2:
- Rebased to linux 3.8-rc1

Changes since v1:
- Includes changes suggested by Sylwester Nawrocki <sylvester.nawrocki@gmail.com>

This patch series adds device tree support for Exynos4/5 MCT controller and
moves the MCT driver from mach-exynos to drivers/clocksource. These patches
are based on Stephen Warren's CONFIG_CLKSRC_OF patches which were merged from
the 'timer/cleanup' branch of the arm-soc tree. It also depends on the
following two patches.

- http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143084.html
- http://lists.infradead.org/pipermail/linux-arm-kernel/2013-January/143119.html

This patch series has been tested on Exynos4210 based Origen board, Exynos4412
based Origen board and Exynos5250 based SMDK board.

Thomas Abraham (7):
  ARM: Exynos: add a register base address variable in mct controller driver
  ARM: Exynos: prepare an array of MCT interrupt numbers and use it
  ARM: Exynos: add device tree support for MCT controller driver
  ARM: Exynos: allow dt based discovery of mct controller using clocksource_of_init
  ARM: dts: add mct device tree node for all supported Exynos SoC's
  ARM: Exynos: remove static io-remapping of mct registers for Exynos5
  ARM: Exynos: move mct driver to drivers/clocksource

 .../bindings/timer/samsung,exynos4210-mct.txt      |   68 +++++++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |    7 +
 arch/arm/boot/dts/exynos4212.dtsi                  |    9 +
 arch/arm/boot/dts/exynos4412.dtsi                  |    7 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   20 ++
 arch/arm/mach-exynos/Kconfig                       |    8 +-
 arch/arm/mach-exynos/Makefile                      |    2 -
 arch/arm/mach-exynos/common.c                      |    5 -
 arch/arm/mach-exynos/common.h                      |    2 +-
 arch/arm/mach-exynos/include/mach/irqs.h           |    6 -
 arch/arm/mach-exynos/include/mach/map.h            |    1 -
 arch/arm/mach-exynos/include/mach/regs-mct.h       |   53 ------
 arch/arm/mach-exynos/mach-armlex4210.c             |    2 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c             |    3 +-
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    3 +-
 arch/arm/mach-exynos/mach-nuri.c                   |    2 +-
 arch/arm/mach-exynos/mach-origen.c                 |    2 +-
 arch/arm/mach-exynos/mach-smdk4x12.c               |    4 +-
 arch/arm/mach-exynos/mach-smdkv310.c               |    4 +-
 drivers/clocksource/Kconfig                        |    5 +
 drivers/clocksource/Makefile                       |    1 +
 .../mct.c => drivers/clocksource/exynos_mct.c      |  197 +++++++++++++-------
 23 files changed, 264 insertions(+), 149 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.txt
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-mct.h
 rename arch/arm/mach-exynos/mct.c => drivers/clocksource/exynos_mct.c (67%)
