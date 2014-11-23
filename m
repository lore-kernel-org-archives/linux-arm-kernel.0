From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 23 Nov 2014 16:36:59 +0800
Subject: [GIT PULL v2] ARM: imx: soc updates for 3.19
Message-ID: <20141123083658.GF11253@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 - Rebase the change set on 3.18-rc3
 - Merge tag imx-fixes-3.18-2 to into the base for resolving one
   conflict on VF610 clock driver

The following changes since commit 035d0d7830b180215f0779d1b6dfb210f33a49fe:

  Merge tag 'imx-fixes-3.18-2' into imx/soc (2014-11-23 14:55:14 +0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-3.19

for you to fetch changes up to 3db47dc0ae4d370ec3c86fc357608132ca695c27:

  power: reset: imx-snvs-poweroff: add power off driver for i.mx6 (2014-11-23 14:57:11 +0800)

----------------------------------------------------------------
The i.MX SoC update for 3.19:
 - Update i.MX6 suspend code to check DDR instead of CPU type, as the
   difference we need to handle is between LPDDR2 and DDR3, not SoCs.
 - Set anatop properly for LPDDR2 in DSM mode
 - Add support for new SoC LS1021A which integrates dual Cortex-A7
 - Add ENET initialization for i.MX6SX platform
 - Add cpufreq support for i.MX53 platform
 - Add a SNVS based poweroff driver for i.MX6 platforms
 - Use ARM  Global Timer as clocksource on VF610

Note: the change set is built on top of tag imx-fixes-3.18-2 to resolve
a conflict on file arch/arm/mach-imx/clk-vf610.c.

----------------------------------------------------------------
Anson Huang (2):
      ARM: imx: replace cpu type check with ddr type check
      ARM: imx: add anatop settings for LPDDR2 when enter DSM mode

Arnd Bergmann (1):
      ARM: imx: temporarily remove CONFIG_SOC_FSL from LS1021A

Fugang Duan (2):
      ARM: imx6sx: add imx6sx iomux-gpr field define
      ARM: imx: add enet init for i.mx6sx

Jingchang Lu (2):
      ARM: imx: Add initial support for Freescale LS1021A
      ARM: imx: Add Freescale LS1021A SMP support

Lucas Stach (4):
      ARM: imx5: add step clock, used when reprogramming PLL1
      ARM: imx: add CPU clock type
      ARM: imx53: clk: add ARM clock
      ARM: imx53: add cpufreq support

Robin Gong (1):
      power: reset: imx-snvs-poweroff: add power off driver for i.mx6

Stefan Agner (2):
      ARM: vf610: Add ARM Global Timer clocksource option
      ARM: imx: clk-vf610: get input clocks from assigned clocks

 .../bindings/power_supply/imx-snvs-poweroff.txt    |  23 +++++
 arch/arm/mach-imx/Kconfig                          |  31 +++++-
 arch/arm/mach-imx/Makefile                         |   6 +-
 arch/arm/mach-imx/anatop.c                         |  34 ++++++-
 arch/arm/mach-imx/clk-cpu.c                        | 107 +++++++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c                |  14 ++-
 arch/arm/mach-imx/clk-vf610.c                      |  21 +++-
 arch/arm/mach-imx/clk.h                            |   4 +
 arch/arm/mach-imx/common.h                         |   2 +
 arch/arm/mach-imx/mach-imx53.c                     |   2 +
 arch/arm/mach-imx/mach-imx6sx.c                    |  51 ++++++++++
 arch/arm/mach-imx/mach-ls1021a.c                   |  22 +++++
 arch/arm/mach-imx/mmdc.c                           |  17 ++++
 arch/arm/mach-imx/mxc.h                            |   2 +
 arch/arm/mach-imx/platsmp.c                        |  33 +++++++
 arch/arm/mach-imx/pm-imx6.c                        |  10 +-
 arch/arm/mach-imx/suspend-imx6.S                   |  14 +--
 drivers/power/reset/Kconfig                        |   9 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/imx-snvs-poweroff.c            |  66 +++++++++++++
 include/dt-bindings/clock/imx5-clock.h             |   5 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |  39 ++++++++
 22 files changed, 487 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/imx-snvs-poweroff.txt
 create mode 100644 arch/arm/mach-imx/clk-cpu.c
 create mode 100644 arch/arm/mach-imx/mach-ls1021a.c
 create mode 100644 drivers/power/reset/imx-snvs-poweroff.c
