From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 Oct 2013 10:35:35 +0800
Subject: [GIT PULL 1/2] ARM: imx: soc changes for 3.13
Message-ID: <20131021023533.GE17165@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the imx/mxs soc changes I queued for 3.13.  A couple of notes:

* Since mach-mxs patch volume drops a lot, I start collecting mxs
  patches using imx branch from this cycle.  Hope it's fine.

* The change set conflicts with Sebastian's .init_time cleanup series
  quite badly.  The pull request is based on his branch [1] to solve
  those conflicts.

Shawn

[1] http://www.spinics.net/lists/arm-kernel/msg276175.html

The following changes since commit 6886530bab1e059a0fc5bab9813c739413d033bf:

  Merge remote-tracking branch 'shesselba/clk-of-init-v2_for-3.13' into imx/soc (2013-10-21 09:10:56 +0800)

are available in the git repository at:


  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-soc-3.13

for you to fetch changes up to 9ba64fe3eb461b95bf11436a13db0d9c79465514:

  ARM: imx: enable suspend for imx6sl (2013-10-21 09:39:27 +0800)

----------------------------------------------------------------
The imx/mxs soc changes for 3.13:

* Low-level debug support for Vybrid
* Support soc bus/device for imx6
* Suspend support for imx6dl and imx6sl
* The imx6q clock updates for PCIe and audio PLL support
* IOMUXC GPR update for fec support
* Some random cleanup
* A few defconfig updates

----------------------------------------------------------------
Fabio Estevam (9):
      ARM: imx_v6_v7_defconfig: Add SPDIF support
      ARM: imx_v6_v7_defconfig: Add CHIPIDEA_UDC support
      ARM: mxs_defconfig: Add CHIPIDEA_UDC support
      ARM: mach-imx: clk-imx51-imx53: Retrieve base address and irq from dt
      ARM: mach-imx: mm-imx5: Retrieve tzic base address from dt
      ARM: mach-imx: mm-imx5: Retrieve iomuxc base address from dt
      ARM: mxs_defconfig: Turn off CONFIG_DEBUG_GPIO
      ARM: imx_v6_v7_defconfig: Enable LEDS_GPIO related options
      ARM: imx_v6_v7_defconfig: Select CONFIG_PROVE_LOCKING

Fugang Duan (2):
      ARM: imx6sl: add imx6sl iomux-gpr field define
      ARM: imx6sl: config iomux-gpr1 to select clock for fec

Michael Opdenacker (1):
      ARM: imx: remove IRQF_DISABLED

Nicolin Chen (1):
      ARM: imx6q: Add pll4_audio_div to clock tree

Sean Cross (2):
      ARM: imx: Add LVDS general-purpose clocks to i.MX6Q
      ARM: imx6q: clock and Kconfig update for PCIe support

Shawn Guo (15):
      ARM: imx: add low-level debug for vybrid
      ARM: imx: add soc revision helper functions
      ARM: imx6q: use common soc revision helpers
      ARM: imx: add a common function to initialize revision from anatop
      ARM: imx: use imx_init_revision_from_anatop() on imx6sl
      ARM: imx6: report soc info via soc device
      ARM: imx: remove stale mx53_display_revision() declaration
      ARM: imx: replace imx6q_restart() with mxc_restart()
      ARM: imx: do not return from imx_cpu_die() call
      ARM: imx: reset core along with enable/disable operation
      ARM: imx: drop extern with function prototypes in common.h
      ARM: imx6q: move low-power code out of clock driver
      ARM: imx6q: call WB and RBC configuration from imx6q_pm_enter()
      ARM: imx: ensure dsm_request signal is not asserted when setting LPM
      ARM: imx: enable suspend for imx6sl

Thierry Reding (1):
      ARM: imx: Include linux/err.h

 .../devicetree/bindings/clock/imx6q-clock.txt      |    5 +
 arch/arm/Kconfig.debug                             |    8 +
 arch/arm/boot/dts/imx6sl.dtsi                      |    4 +-
 arch/arm/configs/imx_v6_v7_defconfig               |   16 +-
 arch/arm/configs/mxs_defconfig                     |    7 +-
 arch/arm/include/debug/vf.S                        |   26 +++
 arch/arm/mach-imx/Kconfig                          |    5 +-
 arch/arm/mach-imx/Makefile                         |    2 +
 arch/arm/mach-imx/anatop.c                         |   33 +++-
 arch/arm/mach-imx/clk-imx51-imx53.c                |   15 +-
 arch/arm/mach-imx/clk-imx6q.c                      |  190 ++++----------------
 arch/arm/mach-imx/clk-imx6sl.c                     |    3 +
 arch/arm/mach-imx/common.h                         |  186 ++++++++++---------
 arch/arm/mach-imx/cpu.c                            |   95 +++++++++-
 arch/arm/mach-imx/epit.c                           |    2 +-
 arch/arm/mach-imx/gpc.c                            |    4 +-
 arch/arm/mach-imx/hotplug.c                        |    4 +-
 arch/arm/mach-imx/mach-armadillo5x0.c              |    3 +-
 arch/arm/mach-imx/mach-imx6q.c                     |   77 ++------
 arch/arm/mach-imx/mach-imx6sl.c                    |   33 +++-
 arch/arm/mach-imx/mach-mx31_3ds.c                  |    2 +-
 arch/arm/mach-imx/mach-pcm037.c                    |    3 +-
 arch/arm/mach-imx/mm-imx5.c                        |   19 +-
 arch/arm/mach-imx/mx31lilly-db.c                   |    3 +-
 arch/arm/mach-imx/mxc.h                            |    6 +
 arch/arm/mach-imx/pm-imx6q.c                       |  176 +++++++++++++++++-
 arch/arm/mach-imx/src.c                            |    1 +
 arch/arm/mach-imx/system.c                         |    5 +
 arch/arm/mach-imx/time.c                           |    2 +-
 include/linux/mfd/syscon/imx6q-iomuxc-gpr.h        |    5 +
 30 files changed, 593 insertions(+), 347 deletions(-)
 create mode 100644 arch/arm/include/debug/vf.S
