From: olof@lixom.net (Olof Johansson)
Date: Mon,  1 Aug 2016 14:39:22 -0700
Subject: [GIT PULL 1/7] ARM: SoC cleanups for v4.8
In-Reply-To: <1470087568-4222-1-git-send-email-olof@lixom.net>
References: <1470087568-4222-1-git-send-email-olof@lixom.net>
Message-ID: <1470087568-4222-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cleanup branch keeps going down in size as we've completed a lot of
the major legacy platform removals and conversions.

A handful of changes this time around, some of the themes or larger sets are:

- A bunch of i.MX cleanups around platform detection, init call cleanups
- Misc fixes of missing/implicit includes
- Removal of ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB



Conflicts:

arch/arm/Kconfig:
Keep both sides (CPLS711X_TIMER and GPIOLIB selects). Feel free to fix sort
order.

arch/arm/mach-mxs/Kconfig:
Keep MXS_TIMER and GPIOLIB selects. Preferrably sorted.

----------------------------------------------------------------

The following changes since commit f38d2e5313f0af9d9b66c02a5d49c71deb994b85:

  Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanup

for you to fetch changes up to 3cc5612b21bab85c8ce68636f2047f8477220b35:

  Merge tag 'mvebu-cleanup-4.8-2' of git://git.infradead.org/linux-mvebu into next/cleanup

----------------------------------------------------------------

Alexander Shiyan (2):
      ARM: imx: Remove orphan header
      ARM: imx: Use IRQCHIP_DECLARE for TZIC

Andrea Gelmini (1):
      ARM: SAMSUNG: Fix typos

Andrey Smirnov (5):
      ARM: i.MX: system.c: Convert goto to if statement
      ARM: i.MX: system.c: Remove redundant errata 752271 code
      ARM: i.MX: system.c: Replace magic numbers
      ARM: i.MX: system.c: Tweak prefetch settings for performance
      ARM: i.MX: Do not explicitly call l2x0_of_init()

Arnd Bergmann (10):
      ARM: imx: remove cpu_is_mx1 check
      ARM: imx: deconstruct mxc_rnga initialization
      ARM: imx: deconstruct mx3_idle
      ARM: imx: rework mx27_pm_init() call
      ARM: imx: remove last call to cpu_is_mx5*
      ARM: imx: remove cpu_is_mx*()
      ARM: tegra: Remove board_init_funcs array
      ARM: s3c64xx: avoid warning about 'struct device_node'
      Merge tag 'tegra-for-4.8-arm-soc' of git://git.kernel.org/.../tegra/linux into next/cleanup
      Merge tag 'mvebu-cleanup-4.8-2' of git://git.infradead.org/linux-mvebu into next/cleanup

Baruch Siach (1):
      ARM: mps2: fix typo

Ben Dooks (14):
      ARM: vexpress/hotplug: fix missing core.h include
      ARM: versatile: fix missing <plat/platsmp.h> include
      ARM: vexpress/spc: fix missing include of spc.h
      power: vexpress: make dev_attr_active static
      mvebu: fix missing includes in pmsu.c
      mvebu: fix missing include of common.h in pm.c
      mvebu: fix missing include of common.h in cpu-reset.c
      mvebu: make mvebu_armada375_smp_wa_init() static
      mvebu: add definition for coherency_base
      ARM: orion5x: make orion5x_legacy_handle_irq static
      ARM: Kirkwood: make kirkwood_disable_mbus_error_propagation() static
      ARM: Kirkwood: fix kirkwood_pm_init() declaration/type
      bus: mvebu-mbus: fix __iomem on register pointers
      bus: mvebu-mbus: make mvebu_mbus_syscore_ops static

Jungseung Lee (1):
      ARM: iop: Fix indentation

Linus Walleij (1):
      ARM: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB

Masahiro Yamada (1):
      ARM: uniphier: drop code for old DT binding

Olof Johansson (4):
      Merge tag 'samsung-soc-4.8' of git://git.kernel.org/.../krzk/linux into next/cleanup
      Merge tag 'vexpress-fixes-4.8' of git://git.kernel.org/.../sudeep.holla/linux into next/cleanup
      Merge tag 'mvebu-cleanup-4.8-1' of git://git.infradead.org/linux-mvebu into next/cleanup
      Merge tag 'imx-cleanup-4.8' of git://git.kernel.org/.../shawnguo/linux into next/cleanup

Sudeep Holla (1):
      ARM: vexpress/spc: remove unused variable perf_stat_reg

Thierry Reding (4):
      ARM: tegra: hotplug: Include missing common.h
      ARM: tegra: cpuidle: Add missing cpuidle.h include
      ARM: tegra: irq: Add missing irq.h include
      ARM: tegra: pm: Add tegra_cpu_do_idle() prototype

Viresh Kumar (1):
      ARM: s3c24xx: Sort cpufreq tables


 arch/arm/Kconfig                                |  38 ++++---
 arch/arm/mach-at91/Kconfig                      |   2 +-
 arch/arm/mach-bcm/Kconfig                       |   7 +-
 arch/arm/mach-berlin/Kconfig                    |   2 +-
 arch/arm/mach-digicolor/Kconfig                 |   2 +-
 arch/arm/mach-exynos/Kconfig                    |   2 +-
 arch/arm/mach-imx/Kconfig                       |   6 +-
 arch/arm/mach-imx/Makefile                      |   4 +-
 arch/arm/mach-imx/common.h                      |   3 +-
 arch/arm/mach-imx/cpu-imx5.c                    |   8 --
 arch/arm/mach-imx/cpu.c                         |   2 -
 arch/arm/mach-imx/devices/Kconfig               |   4 -
 arch/arm/mach-imx/devices/platform-mxc_rnga.c   |  53 ----------
 arch/arm/mach-imx/eukrea-baseboards.h           |  42 --------
 arch/arm/mach-imx/imx27-dt.c                    |   1 +
 arch/arm/mach-imx/imx31-dt.c                    |  12 +++
 arch/arm/mach-imx/imx35-dt.c                    |  10 +-
 arch/arm/mach-imx/mach-imx50.c                  |   1 -
 arch/arm/mach-imx/mach-imx51.c                  |   1 -
 arch/arm/mach-imx/mach-imx53.c                  |   1 -
 arch/arm/mach-imx/mach-imx6q.c                  |   2 +
 arch/arm/mach-imx/mach-imx6sl.c                 |   2 +
 arch/arm/mach-imx/mach-imx6sx.c                 |   2 +
 arch/arm/mach-imx/mm-imx1.c                     |   2 +-
 arch/arm/mach-imx/mm-imx27.c                    |   2 +
 arch/arm/mach-imx/mm-imx3.c                     |  32 +++++-
 arch/arm/mach-imx/mxc.h                         | 101 -------------------
 arch/arm/mach-imx/pm-imx27.c                    |   8 +-
 arch/arm/mach-imx/pm-imx3.c                     |  38 -------
 arch/arm/mach-imx/system.c                      |  58 +++++------
 arch/arm/mach-imx/tzic.c                        |  10 +-
 arch/arm/mach-integrator/Kconfig                |   4 +-
 arch/arm/mach-meson/Kconfig                     |   2 +-
 arch/arm/mach-mmp/Kconfig                       |   2 +-
 arch/arm/mach-moxart/Kconfig                    |   2 +-
 arch/arm/mach-mv78xx0/Kconfig                   |   2 +-
 arch/arm/mach-mvebu/Kconfig                     |   4 +-
 arch/arm/mach-mvebu/coherency.h                 |   1 +
 arch/arm/mach-mvebu/cpu-reset.c                 |   2 +
 arch/arm/mach-mvebu/kirkwood-pm.c               |   4 +-
 arch/arm/mach-mvebu/kirkwood.c                  |   2 +-
 arch/arm/mach-mvebu/pm.c                        |   1 +
 arch/arm/mach-mvebu/pmsu.c                      |   3 +-
 arch/arm/mach-mvebu/system-controller.c         |   2 +-
 arch/arm/mach-mxs/Kconfig                       |   2 +-
 arch/arm/mach-nomadik/Kconfig                   |   2 +-
 arch/arm/mach-omap2/Kconfig                     |   2 +-
 arch/arm/mach-orion5x/Kconfig                   |   2 +-
 arch/arm/mach-orion5x/irq.c                     |   2 +-
 arch/arm/mach-oxnas/Kconfig                     |   2 +-
 arch/arm/mach-picoxcell/Kconfig                 |   2 +-
 arch/arm/mach-prima2/Kconfig                    |   2 +-
 arch/arm/mach-rockchip/Kconfig                  |   2 +-
 arch/arm/mach-s3c24xx/Kconfig                   |   2 +-
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h  |   2 +-
 arch/arm/mach-s3c24xx/iotiming-s3c2410.c        |   2 +-
 arch/arm/mach-s3c24xx/mach-n30.c                |   2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c         |   2 +-
 arch/arm/mach-s3c24xx/pll-s3c2410.c             |   3 +-
 arch/arm/mach-s3c24xx/pll-s3c2440-12000000.c    |   1 +
 arch/arm/mach-s3c24xx/pll-s3c2440-16934400.c    |   1 +
 arch/arm/mach-s3c64xx/Kconfig                   |   2 +-
 arch/arm/mach-s3c64xx/common.h                  |   1 +
 arch/arm/mach-s3c64xx/include/mach/map.h        |   2 +-
 arch/arm/mach-s5pv210/Kconfig                   |   2 +-
 arch/arm/mach-shmobile/Kconfig                  |   2 +-
 arch/arm/mach-spear/Kconfig                     |   2 +-
 arch/arm/mach-sti/Kconfig                       |   2 +-
 arch/arm/mach-sunxi/Kconfig                     |   2 +-
 arch/arm/mach-tegra/Kconfig                     |   2 +-
 arch/arm/mach-tegra/common.h                    |  22 ++++
 arch/arm/mach-tegra/cpuidle-tegra114.c          |   1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c           |   1 +
 arch/arm/mach-tegra/cpuidle-tegra30.c           |   1 +
 arch/arm/mach-tegra/cpuidle.h                   |   2 +
 arch/arm/mach-tegra/hotplug.c                   |   1 +
 arch/arm/mach-tegra/irq.c                       |   1 +
 arch/arm/mach-tegra/pm.h                        |   2 +-
 arch/arm/mach-tegra/tegra.c                     |  24 +----
 arch/arm/mach-u300/Kconfig                      |   2 +-
 arch/arm/mach-uniphier/platsmp.c                |  18 +---
 arch/arm/mach-ux500/Kconfig                     |   2 +-
 arch/arm/mach-vexpress/Kconfig                  |   2 +-
 arch/arm/mach-vexpress/hotplug.c                |   2 +
 arch/arm/mach-vexpress/spc.c                    |   6 +-
 arch/arm/mach-vt8500/Kconfig                    |   2 +-
 arch/arm/plat-iop/setup.c                       |   4 +-
 .../plat-samsung/include/plat/cpu-freq-core.h   |   2 +-
 arch/arm/plat-samsung/include/plat/fb-s3c2410.h |   2 +-
 arch/arm/plat-samsung/include/plat/gpio-cfg.h   |   2 +-
 arch/arm/plat-samsung/pm-check.c                |   2 +-
 arch/arm/plat-samsung/watchdog-reset.c          |   2 +-
 arch/arm/plat-versatile/platsmp.c               |   2 +
 drivers/bus/mvebu-mbus.c                        |  10 +-
 drivers/power/reset/vexpress-poweroff.c         |   4 +-
 include/linux/mbus.h                            |   2 +-
 96 files changed, 223 insertions(+), 437 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc_rnga.c
 delete mode 100644 arch/arm/mach-imx/eukrea-baseboards.h
 delete mode 100644 arch/arm/mach-imx/pm-imx3.c
