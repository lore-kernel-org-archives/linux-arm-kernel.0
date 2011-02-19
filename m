From: ccross@android.com (Colin Cross)
Date: Sat, 19 Feb 2011 14:25:49 -0800
Subject: [PATCH v2 00/21] Tegra clock updates for 2.6.39
In-Reply-To: <1298154371-5641-1-git-send-email-ccross@android.com>
References: <1298154371-5641-1-git-send-email-ccross@android.com>
Message-ID: <1298154371-5641-2-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series brings the Tegra clock subsystem closer to the
proposed common struct clk design, which should make converting
easier.  It also fixes a few bugs and adds new features including
memory bus scaling, disabling clocks left on by the bootloader,
and shared clocks.

V2 fixes locking issues in shared bus clocks pointed out by
Stephen Boyd.

Colin Cross (20):
      ARM: tegra: clock: Don't BUG on changing an enabled PLL
      ARM: tegra: clock: Drop debugging
      ARM: tegra: clock: Don't use PLL lock bits
      ARM: tegra: clock: Disable clocks left on by bootloader
      ARM: tegra: clock: Initialize clocks that have no enable
      ARM: tegra: clock: Drop CPU dvfs
      ARM: tegra: clock: Rearrange static clock tables
      ARM: tegra: clock: Move unshared clk struct members into union
      ARM: tegra: clock: Convert global lock to a lock per clock
      ARM: tegra: cpufreq: Take an extra reference to pllx
      ARM: tegra: clock: Add shared bus clock type
      ARM: tegra: clock: Remove unnecessary uses of #ifdef CONFIG_DEBUG_FS
      ARM: tegra: clock: Refcount periph clock enables
      ARM: tegra: clock: Round rate before setting rate
      ARM: tegra: Add external memory controller driver
      ARM: tegra: clocks: Add emc scaling
      ARM: tegra: cpufreq: Adjust memory frequency with cpu frequency
      ARM: tegra: clock: Add function to set SDMMC tap delay
      ARM: tegra: clock: Fix clock issues in suspend
      ARM: tegra: clock: Miscellaneous clock updates

Dima Zavin (1):
      ARM: tegra: clock: enable clk reset for non-peripheral clocks

 arch/arm/mach-tegra/Kconfig                        |   10 +
 arch/arm/mach-tegra/Makefile                       |    2 +-
 arch/arm/mach-tegra/clock.c                        |  559 +++++++-------
 arch/arm/mach-tegra/clock.h                        |  129 ++--
 arch/arm/mach-tegra/cpu-tegra.c                    |   25 +-
 arch/arm/mach-tegra/include/mach/clk.h             |    6 +-
 arch/arm/mach-tegra/tegra2_clocks.c                |  865 ++++++++++++++------
 arch/arm/mach-tegra/tegra2_dvfs.c                  |   86 --
 arch/arm/mach-tegra/tegra2_emc.c                   |  172 ++++
 .../arm/mach-tegra/{tegra2_dvfs.h => tegra2_emc.h} |   13 +-
 10 files changed, 1153 insertions(+), 714 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/tegra2_dvfs.c
 create mode 100644 arch/arm/mach-tegra/tegra2_emc.c
 rename arch/arm/mach-tegra/{tegra2_dvfs.h => tegra2_emc.h} (66%)
