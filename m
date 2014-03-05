From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Mar 2014 13:15:45 +0800
Subject: [GIT PULL] ARM: imx: soc changes for 3.15
Message-ID: <20140305051543.GB23980@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is the imx soc changes I collected for 3.15.  To avoid quite a few
annoying conflicts, I have to base the change set on 3.14-rc4 and Rob's
kconfig-cleanup-for-3.15.  Please be noted, there is conflict between
3.14-rc4 and kconfig-cleanup-for-3.15 on arch/arm/mach-omap2/Kconfig.
The conflict is quite obvious and easy to resolve though.

Shawn

The following changes since commit c1b2a174c33ae2bd453e40199de4f93c684500e6:

  Merge tag 'kconfig-cleanup-for-3.15' into imx/soc (2014-03-05 10:31:54 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.15

for you to fetch changes up to c8ae7e9bfc8caf679e891c4f0a04f2435b45e2da:

  ARM: imx6: drop .text.head section annotation from headsmp.S (2014-03-05 10:48:26 +0800)

----------------------------------------------------------------
i.MX SoC changes for 3.15:
 - Support suspend from ocram (DDR IO floating) for imx6 platforms
 - Add cpuidle support for imx6sl
 - Sparse warning fixes for imx6sl and vf610 clock code
 - Remove PWM platform code
 - Support ptp and rmii clock from pad
 - Support WEIM CS GPR configuration
 - Random cleanups and defconfig updates

----------------------------------------------------------------
Anson Huang (8):
      ARM: imx: AHB rate must be set to 132MHz on i.mx6sl
      ARM: imx: add cpuidle support for i.mx6sl
      ARM: imx: add suspend in ocram support for i.mx6q
      ARM: imx: add suspend in ocram support for i.mx6dl
      ARM: imx: add suspend in ocram support for i.mx6sl
      ARM: imx: add always-on clock array for i.mx6sl to maintain correct usecount
      ARM: imx: avoid calling clk APIs in idle thread which may cause schedule
      ARM: imx: add speed grading check for i.mx6 soc

Denis Carikli (3):
      ARM: imx_v6_v7_defconfig: Enable backlight gpio support.
      ARM i.MX35: build in pinctrl support.
      ARM: imx_v6_v7_defconfig: Enable some drivers used on the cpuimx35.

Fabio Estevam (7):
      ARM: imx_v6_v7_defconfig: Select PCI support
      ARM: imx: Use INT_MEM_CLK_LPM as the bit name
      ARM: imx_v4_v5_defconfig: Select CONFIG_MMC_UNSAFE_RESUME
      ARM: imx_v6_v7_defconfig: Select CONFIG_MMC_UNSAFE_RESUME
      ARM: mach-imx: Select CONFIG_SRAM at ARCH_MXC level
      ARM: imx_v6_v7_defconfig: Select CONFIG_DEBUG_FS
      ARM: mach-imx: Kconfig: Remove IMX_HAVE_PLATFORM_IMX2_WDT from SOC_IMX53

John Tobias (1):
      ARM: imx: add select on ARCH_MXC for cpufreq support

Liu Ying (2):
      ARM: imx: clk-imx6sl: Suppress duplicate const sparse warning
      ARM: imx: clk-vf610: Suppress duplicate const sparse warning

Philipp Zabel (2):
      ARM: imx6q: Add GPR6 and GPR7 register definitions for iomuxc gpr
      ARM i.MX6q: Mark VPU and IPU AXI transfers as cacheable, increase IPU priority

Sascha Hauer (1):
      ARM i.MX: remove PWM platform support

Sebastian Andrzej Siewior (1):
      ARM: imx: enable delaytimer on the imx timer

Shawn Guo (11):
      ARM: imx6q: remove unneeded clk lookups
      ARM: imx6q: support ptp and rmii clock from pad
      bus: imx-weim: support CS GPR configuration
      ARM: imx6: move v7_cpu_resume() into suspend-imx6.S
      ARM: imx6: build headsmp.o only on CONFIG_SMP
      ARM: imx6: call suspend_set_ops() from suspend routine
      ARM: imx6: do not call imx6q_suspend_init() with !CONFIG_SUSPEND
      ARM: imx6: introduce CONFIG_SOC_IMX6 for i.MX6 common stuff
      ARM: imx6: rename pm-imx6q.c to pm-imx6.c
      ARM: imx6: build suspend-imx6.o with CONFIG_SOC_IMX6
      ARM: imx6: drop .text.head section annotation from headsmp.S

 Documentation/devicetree/bindings/bus/imx-weim.txt |   28 +-
 arch/arm/configs/imx_v4_v5_defconfig               |    1 +
 arch/arm/configs/imx_v6_v7_defconfig               |    7 +
 arch/arm/mach-imx/Kconfig                          |   43 +-
 arch/arm/mach-imx/Makefile                         |    9 +-
 arch/arm/mach-imx/clk-imx21.c                      |    1 -
 arch/arm/mach-imx/clk-imx25.c                      |    8 -
 arch/arm/mach-imx/clk-imx27.c                      |    1 -
 arch/arm/mach-imx/clk-imx51-imx53.c                |    2 -
 arch/arm/mach-imx/clk-imx6q.c                      |    7 +-
 arch/arm/mach-imx/clk-imx6sl.c                     |  159 +++++-
 arch/arm/mach-imx/clk-vf610.c                      |   36 +-
 arch/arm/mach-imx/common.h                         |   17 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  |    4 +-
 arch/arm/mach-imx/cpuidle-imx6sl.c                 |   57 ++
 arch/arm/mach-imx/cpuidle.h                        |    5 +
 arch/arm/mach-imx/devices-imx25.h                  |    4 -
 arch/arm/mach-imx/devices-imx51.h                  |    4 -
 arch/arm/mach-imx/devices/Kconfig                  |    3 -
 arch/arm/mach-imx/devices/Makefile                 |    1 -
 arch/arm/mach-imx/devices/devices-common.h         |    9 -
 arch/arm/mach-imx/devices/platform-mxc_pwm.c       |   69 ---
 arch/arm/mach-imx/hardware.h                       |    4 +-
 arch/arm/mach-imx/headsmp.S                        |   40 --
 arch/arm/mach-imx/mach-imx6q.c                     |   98 +++-
 arch/arm/mach-imx/mach-imx6sl.c                    |    6 +-
 arch/arm/mach-imx/pm-imx6.c                        |  552 ++++++++++++++++++++
 arch/arm/mach-imx/pm-imx6q.c                       |  241 ---------
 arch/arm/mach-imx/suspend-imx6.S                   |  361 +++++++++++++
 arch/arm/mach-imx/time.c                           |   12 +
 drivers/bus/imx-weim.c                             |   58 ++
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |   18 +
 32 files changed, 1394 insertions(+), 471 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpuidle-imx6sl.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc_pwm.c
 create mode 100644 arch/arm/mach-imx/pm-imx6.c
 delete mode 100644 arch/arm/mach-imx/pm-imx6q.c
 create mode 100644 arch/arm/mach-imx/suspend-imx6.S
