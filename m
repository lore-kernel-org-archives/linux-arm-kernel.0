From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 12 Aug 2013 17:39:59 +0800
Subject: [PATCH V3 0/8] ARM: tegra: support LP1 suspend mode
Message-ID: <1376300407-14750-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds the support of LP1 suspend mode for Tegra.

V3:
* setting up CCLK burst policy to PLLX in LP1 resume code for Tegra114 too
* moving the CCLKG burst policy resume code to tegra_cpu_car_ops for Tegra114
V2:
* double confirm each patch can be built with all the combination of
  Tegra SoCs by bisect
* and make sure the function is still OK with above testing

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
  ARM: tegra: add LP1 suspend support for Tegra30
  ARM: tegra: add LP1 suspend support for Tegra20
  ARM: tegra: add LP1 suspend support for Tegra114
  ARM: tegra: enable LP1 suspend mode

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
 arch/arm/mach-tegra/iomap.h                |   8 +
 arch/arm/mach-tegra/pm-tegra20.c           |  34 ++
 arch/arm/mach-tegra/pm-tegra30.c           |  34 ++
 arch/arm/mach-tegra/pm.c                   | 138 ++++++-
 arch/arm/mach-tegra/pm.h                   |  12 +
 arch/arm/mach-tegra/pmc.c                  |  37 ++
 arch/arm/mach-tegra/pmc.h                  |   3 +
 arch/arm/mach-tegra/reset-handler.S        |  13 +
 arch/arm/mach-tegra/reset.c                |   2 +
 arch/arm/mach-tegra/reset.h                |   4 +
 arch/arm/mach-tegra/sleep-tegra20.S        | 296 ++++++++++++++
 arch/arm/mach-tegra/sleep-tegra30.S        | 607 +++++++++++++++++++++++++++++
 arch/arm/mach-tegra/sleep.S                |   8 +-
 arch/arm/mach-tegra/sleep.h                |   8 +
 drivers/clk/tegra/clk-tegra114.c           |  12 +
 27 files changed, 1221 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/mach-tegra/pm-tegra20.c
 create mode 100644 arch/arm/mach-tegra/pm-tegra30.c

-- 
1.8.3.4
