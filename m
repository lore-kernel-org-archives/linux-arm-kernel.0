From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  5 Apr 2013 11:03:43 -0600
Subject: [GIT PULL 5/8] ARM: tegra: clock driver development
In-Reply-To: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365181426-11547-5-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains most fixes and enhancements to the Tegra common
clock driver. The main new feature is a driver for Tegra114, which
coupled with later device tree changes enables many devices on that
chip, such as MMC, I2C, etc.

This branch depends on a patch in:

git://git.linaro.org/people/mturquette/linux.git clk-for-3.10

Mike has stated that this branch is stable, and is aware of this
dependency and merge.

Mike's branch is based on v3.9-rc3, which includes a USB change which
causes problems on Tegra. That problem was fixed in v3.9-rc4. Hence,
this branch pulls in v3.9-rc4 to ensure bisectability as much as
possible.

This branch is based on v3.9-rc4, followed by a merge of previous Tegra
"soc" pull request, followed by a merge of clk-for-3.10.

----------------------------------------------------------------

The following changes since commit 43089433b00a086980fc6e9571535477fb749e84:

  Merge remote-tracking branch 'linaro_mturquette_linux/clk-for-3.10' into for-3.10/clk

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.10-clk

for you to fetch changes up to 964ea47572b89589b61b553e44bbe9907d4f12a6:

  clk: tegra: fix enum tegra114_clk to match binding

----------------------------------------------------------------

Peter De Schrijver (14):
      clk: tegra: provide dummy cpu car ops
      clk: tegra: Refactor PLL programming code
      clk: tegra: Add TEGRA_PLL_BYPASS flag
      clk: tegra: introduce TEGRA_PLL_HAS_LOCK_ENABLE
      clk: tegra: Add PLL post divider table
      clk: tegra: move from a lock bit idx to a lock mask
      clk: tegra: Add new fields and PLL types for Tegra114
      clk: tegra: Add flags to tegra_clk_periph()
      clk: tegra: Workaround for Tegra114 MSENC problem
      ARM: tegra: Define Tegra114 CAR binding
      clk: tegra: Implement clocks for Tegra114
      clk: tegra: devicetree match for nvidia,tegra114-car
      ARM: dt: Add references to tegra_car clocks
      clk: tegra: Remove forced clk_enable of uartd

Prashant Gaikwad (1):
      clk: tegra: Fix cdev1 and cdev2 IDs

Stephen Warren (2):
      clk: tegra: defer application of init table
      clk: tegra: fix enum tegra114_clk to match binding

Thierry Reding (2):
      clk: tegra: Export peripheral reset functions
      clk: tegra: Make gr2d and gr3d clocks children of pll_c

Yen Lin (1):
      clk: tegra: Fix periph_clk_to_bit macro

 .../bindings/clock/nvidia,tegra114-car.txt      |  303 +++
 .../bindings/clock/nvidia,tegra20-car.txt       |    4 +-
 arch/arm/boot/dts/tegra114-dalmore.dts          |    1 -
 arch/arm/boot/dts/tegra114-pluto.dts            |    1 -
 arch/arm/boot/dts/tegra114.dtsi                 |    8 +-
 arch/arm/mach-tegra/tegra.c                     |    3 +
 drivers/clk/tegra/Makefile                      |    1 +
 drivers/clk/tegra/clk-periph-gate.c             |   11 +-
 drivers/clk/tegra/clk-periph.c                  |   14 +-
 drivers/clk/tegra/clk-pll.c                     | 1194 ++++++++--
 drivers/clk/tegra/clk-tegra114.c                | 2085 ++++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c                 |  184 +-
 drivers/clk/tegra/clk-tegra30.c                 |  276 +--
 drivers/clk/tegra/clk.c                         |   14 +-
 drivers/clk/tegra/clk.h                         |   98 +-
 include/linux/clk/tegra.h                       |    1 +
 16 files changed, 3832 insertions(+), 366 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
 create mode 100644 drivers/clk/tegra/clk-tegra114.c
