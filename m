From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 23:19:34 +0800
Subject: [GIT PULL 3/4] ARM: imx: soc changes for 3.10
In-Reply-To: <1365520775-28478-1-git-send-email-shawn.guo@linaro.org>
References: <1365520775-28478-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1365520775-28478-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

It's based on imx-cleanup-3.10 and Philipp Zabel's "Reset controller
API" pull request to resolve dependency and conflicts.

There will still be one trivial conflict with your clksrc/cleanup
branch.  My for-next branch contains the resolution.

Shawn

The following changes since commit a86a36ef05484eea7144bbf06e2194c831c325de:

  Merge remote-tracking branch 'pza/reset/for_v3.10' into imx/soc (2013-04-09 21:50:50 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.10

for you to fetch changes up to 723bf2b0844f1d2435b8ffa4e706962a6a852179:

  ARM i.MX53: set CLK_SET_RATE_PARENT flag on the tve_ext_sel clock (2013-04-09 21:52:14 +0800)

----------------------------------------------------------------
The imx soc changes for 3.10:

* Enable anatop, well bisa and RBC for suspend to optimize the power
  consumption a little bit
* Clock changes for TVE, LDB, PATA, SRTC support
* Add System Reset Controller (SRC) support for imx5 and imx6
* Add initial imx6dl support based on imx6q code
* Kconfig for cpufreq-cpu0, defconfig updates and few other changes

----------------------------------------------------------------
Anson Huang (3):
      ARM: imx: enable anatop suspend/resume
      ARM: imx: enable periphery well bias for suspend
      ARM: imx: enable RBC to support anatop LPM mode

Fabio Estevam (3):
      ARM: mach-imx: anatop: Include "common.h"
      ARM: imx_v6_v7_defconfig: Select CONFIG_PERF_EVENTS
      ARM: imx_v4_v5_defconfig: Add CONFIG_GPIO_SYSFS

Gwenhael Goavec-Merou (1):
      ARM: imx1: mm: add call to mxc_device_init

Markus Pargmann (1):
      ARM: imx27, imx5: Add kconfig selects for cpufreq-cpu0

Martin Fuzzey (1):
      ARM: i.MX53 Add the cko1, cko2 clock outputs.

Philipp Zabel (14):
      ARM i.MX53: Add GPU clocks to clock tree
      ARM i.MX6q: export imx6q_revision
      ARM i.MX: Add imx_clk_divider_flags and imx_clk_mux_flags
      ARM i.MX53: fix ldb di divider and selector clocks
      ARM i.MX6q: fix ldb di divider and selector clocks
      ARM i.MX6q: Add audio/video PLL post dividers for i.MX6q rev 1.1
      ARM i.MX6q: set the LDB serial clock parent to the video PLL
      ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets to System Reset Controller (SRC)
      staging: drm/imx: Use SRC to reset IPU
      ARM i.MX5: Remove tve_sel clock from i.MX53 clock tree
      ARM i.MX53: Remove unused tve_gate clkdev entry
      ARM i.MX53: make tve_ext_sel propagate rate change to PLL
      ARM i.MX53: tve_di clock is not part of the CCM, but of TVE
      ARM i.MX53: set CLK_SET_RATE_PARENT flag on the tve_ext_sel clock

Sascha Hauer (1):
      ARM: i.MX5: Add PATA and SRTC clocks

Shawn Guo (3):
      ARM: imx: do not use regmap_read for ANADIG_DIGPROG
      ARM: imx: add initial imx6dl support
      ARM: imx: do not bring up unavailable cores

 .../devicetree/bindings/clock/imx5-clock.txt       |   14 ++-
 .../devicetree/bindings/clock/imx6q-clock.txt      |    3 +
 .../devicetree/bindings/reset/fsl,imx-src.txt      |   49 ++++++++
 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    3 +
 arch/arm/Kconfig.debug                             |    4 +-
 arch/arm/configs/imx_v4_v5_defconfig               |    1 +
 arch/arm/configs/imx_v6_v7_defconfig               |    1 +
 arch/arm/mach-imx/Kconfig                          |   10 +-
 arch/arm/mach-imx/Makefile                         |    1 +
 arch/arm/mach-imx/anatop.c                         |  103 ++++++++++++++++
 arch/arm/mach-imx/clk-imx51-imx53.c                |   75 +++++++++---
 arch/arm/mach-imx/clk-imx6q.c                      |  128 ++++++++++++++++++--
 arch/arm/mach-imx/clk.h                            |   17 +++
 arch/arm/mach-imx/common.h                         |   10 +-
 arch/arm/mach-imx/gpc.c                            |   23 +++-
 arch/arm/mach-imx/mach-imx6q.c                     |   74 ++++-------
 arch/arm/mach-imx/mm-imx1.c                        |    2 +
 arch/arm/mach-imx/mxc.h                            |   11 ++
 arch/arm/mach-imx/platsmp.c                        |    4 +-
 arch/arm/mach-imx/pm-imx6q.c                       |    4 +-
 arch/arm/mach-imx/src.c                            |   65 ++++++++++
 drivers/staging/imx-drm/ipu-v3/ipu-common.c        |   12 +-
 22 files changed, 525 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.txt
 create mode 100644 arch/arm/mach-imx/anatop.c
