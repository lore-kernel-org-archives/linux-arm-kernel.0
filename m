From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 26 Jul 2013 17:15:02 +0800
Subject: [PATCH 0/8] ARM: tegra: support LP1 suspend mode
Message-ID: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the support of LP1 suspend mode for Tegra.

Verified on Seaboard, Cardhu and Dalmore.
And tested with THUMB2_KERNEL as well.

P.S.
A known issue on Dalmore, the LP1 resume may take 10 ~ 15 seconds due to
the 792MHz BCT. It can't be reproduced on Seaboard or Cardhu. And the
root cause of this is about the default settings of EMC registers that
cause the DRAM can't leave self-refresh mode immediately. If you want
to test with quick LP1 resume on Dalmore, I can provide another HACK for
this.

Joseph Lo (8):
  ARM: tegra: add common resume handling code for LP1 resuming
  ARM: tegra: config the polarity of the request of sys clock
  clk: tegra114: add LP1 suspend/resume support
  ARM: tegra: add common LP1 suspend support
  ARM: tegra30: add LP1 suspend support
  ARM: tegra20: add LP1 suspend support
  ARM: tegra114: add LP1 suspend support
  ARM: dts: tegra: enable LP1 suspend mode

 arch/arm/boot/dts/tegra114-dalmore.dts     |   2 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi |   2 +-
 arch/arm/boot/dts/tegra20-harmony.dts      |   2 +-
 arch/arm/boot/dts/tegra20-paz00.dts        |   2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts     |   2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi    |   2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts    |   2 +-
 arch/arm/boot/dts/tegra20-ventana.dts      |   2 +-
 arch/arm/boot/dts/tegra20-whistler.dts     |   2 +-
 arch/arm/boot/dts/tegra30-beaver.dts       |   2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi      |   2 +-
 arch/arm/mach-tegra/Makefile               |   3 +
 arch/arm/mach-tegra/iomap.h                |   6 +
 arch/arm/mach-tegra/pm-tegra20.c           |  37 ++
 arch/arm/mach-tegra/pm-tegra30.c           |  37 ++
 arch/arm/mach-tegra/pm.c                   | 121 +++++-
 arch/arm/mach-tegra/pm.h                   |  23 ++
 arch/arm/mach-tegra/pmc.c                  |  36 +-
 arch/arm/mach-tegra/pmc.h                  |   3 +
 arch/arm/mach-tegra/reset-handler.S        |  13 +
 arch/arm/mach-tegra/reset.c                |   2 +
 arch/arm/mach-tegra/reset.h                |   4 +
 arch/arm/mach-tegra/sleep-tegra20.S        | 300 ++++++++++++++
 arch/arm/mach-tegra/sleep-tegra30.S        | 615 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S                |   8 +-
 arch/arm/mach-tegra/sleep.h                |  18 +
 drivers/clk/tegra/clk-tegra114.c           |  32 ++
 27 files changed, 1259 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/mach-tegra/pm-tegra20.c
 create mode 100644 arch/arm/mach-tegra/pm-tegra30.c

-- 
1.8.3.4
