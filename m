From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 22 Aug 2013 23:54:07 +0800
Subject: [GIT PULL v2 2/5] ARM: imx: soc changes for 3.12
Message-ID: <20130822155404.GA8111@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 * Drop patch 'ARM: imx: add low-level debug for vybrid'

The following changes since commit 5ae90d8e467e625e447000cb4335c4db973b1095:

  Linux 3.11-rc3 (2013-07-28 20:53:33 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.12

for you to fetch changes up to dc76a1adfa12ad11957bdeec565dbccf37205d04:

  phy: micrel: Add definitions for common Micrel PHY registers (2013-08-22 23:20:54 +0800)

----------------------------------------------------------------
It contains a bunch of imx soc updates for 3.12.

- Add more ethernet phy fixups for imx6 boards
- Add some missing imx6q clocks into clock driver
- Add new clock types fixup mux and div to work around some ugly
  hardware defect
- Consolidate L2 cache initialization function, so that it can be used
  on more i.MX SoCs
- Replace magic numbers in mach-imx6q.c with well defined macros
- Small fixes for imx6q and pllv3 clock drivers
- Some random updates on imx defconfig files

----------------------------------------------------------------
Dinh Nguyen (1):
      phy: micrel: Add definitions for common Micrel PHY registers

Fabio Estevam (14):
      ARM: imx_v6_v7_defconfig: Select CONFIG_NOP_USB_XCEIV by default
      ARM: imx_v6_v7_defconfig: Enable FSL_LPUART support
      ARM: imx_v6_v7_defconfig: Enable LVDS Display Bridge
      ARM: imx_v6_v7_defconfig: Enable VPU driver
      ARM: imx_v4_v5_defconfig: Select CONFIG_MACH_IMX25_DT
      ARM: imx: Select MIGHT_HAVE_CACHE_L2X0
      ARM: imx_v6_v7_defconfig: Select CONFIG_TOUCHSCREEN_EGALAX
      ARM: mach-imx: Select ARM_CPU_SUSPEND at ARCH_MXC level
      ARM: mx53: Allow suspend/resume
      ARM: imx_v6_v7_defconfig: Cleanup imx_v6_v7_defconfig
      ARM: imx_v6_v7_defconfig: Add SATA support
      ARM: imx_v4_v5_defconfig: Cleanup imx_v4_v5_defconfig
      ARM: imx_v6_v7_defconfig: Enable wireless support
      ARM: imx: Re-select CONFIG_SND_SOC_IMX_MC13783 option

Huang Shijie (1):
      ARM: imx_v6_v7_defconfig: enable WEIM driver

Liu Ying (3):
      ARM: imx: add common clock support for fixup div
      ARM: imx: add common clock support for fixup mux
      ARM: imx6: change some clocks to fixup clocks

Peter Chen (2):
      ARM: imx: clk-pllv3: improve the timeout waiting method
      ARM: imx: Move anatop related from board file to anatop driver

Philipp Zabel (2):
      ARM i.MX6Q: Use ENET_CLK_SEL defines in imx6q_1588_init
      ARM i.MX6DL: parent LDB DI clocks to PLL5 on i.MX6S/DL

Sascha Hauer (3):
      ARM: i.MX6: call ksz9021 phy fixup for all i.MX6 boards
      ARM: i.MX6: add ethernet phy fixup for AR8031
      ARM: i.MX6: add ethernet phy fixup for KSZ9031

Shawn Guo (6):
      ARM: imx: let L2 initialization be a common function
      ARM: imx: use imx specific L2 init function on imx6sl
      ARM: imx6q: add spdif gate clock
      ARM: imx6q: add cko2 clocks
      ARM: imx6q: add the missing cko output selection
      ARM: imx6q: add vdoa gate clock

Vincent Stehl? (1):
      ARM: imx: fix imx_init_l2cache storage class

 .../devicetree/bindings/clock/imx6q-clock.txt      |    6 +
 arch/arm/configs/imx_v4_v5_defconfig               |   19 ++-
 arch/arm/configs/imx_v6_v7_defconfig               |   51 ++++----
 arch/arm/mach-at91/board-dt-sama5.c                |   17 +--
 arch/arm/mach-imx/Kconfig                          |    3 +-
 arch/arm/mach-imx/Makefile                         |    3 +-
 arch/arm/mach-imx/anatop.c                         |    4 +-
 arch/arm/mach-imx/clk-fixup-div.c                  |  129 ++++++++++++++++++++
 arch/arm/mach-imx/clk-fixup-mux.c                  |  107 ++++++++++++++++
 arch/arm/mach-imx/clk-imx6q.c                      |   46 ++++---
 arch/arm/mach-imx/clk-imx6sl.c                     |   20 +--
 arch/arm/mach-imx/clk-pllv3.c                      |   15 ++-
 arch/arm/mach-imx/clk.c                            |   26 ++++
 arch/arm/mach-imx/clk.h                            |   10 ++
 arch/arm/mach-imx/common.h                         |   13 +-
 arch/arm/mach-imx/mach-imx6q.c                     |  120 ++++++++++--------
 arch/arm/mach-imx/mach-imx6sl.c                    |    3 +-
 arch/arm/mach-imx/mm-imx5.c                        |    4 +-
 arch/arm/mach-imx/pm-imx5.c                        |    7 +-
 arch/arm/mach-imx/system.c                         |   33 +++++
 include/linux/micrel_phy.h                         |    6 +
 21 files changed, 499 insertions(+), 143 deletions(-)
 create mode 100644 arch/arm/mach-imx/clk-fixup-div.c
 create mode 100644 arch/arm/mach-imx/clk-fixup-mux.c
