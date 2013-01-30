From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Jan 2013 14:42:33 -0700
Subject: [GIT PULL 2/8] ARM: tegra: Common Clock Framework rework
In-Reply-To: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
References: <1359582159-28816-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1359582159-28816-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra already supports the common clock framework, but had issues:

1) The clock driver was located in arch/arm/mach-tegra/ rather than
   drivers/clk/.

2) A single "Tegra clock" type was implemented, rather than separate
   clock types for PLL, mux, divider, ... type in HW.

3) Clock lookups by device drivers were still driven by device name
   and connection ID, rather than through device tree.

This pull request solves all three issues. This required some DT changes
to add clocks properties, and driver changes to request clocks more
"correctly". Finally, this rework allows all AUXDATA to be removed from
Tegra board files, and various duplicate clock lookup entries to be
removed from the driver.

This pull request is based on the previous pull request, with tag
tegra-for-3.9-cleanup.

----------------------------------------------------------------

The following changes since commit 24e30c9417230b359bf6dfeb923e90138df7c112:

  ARM: tegra: fix compile error when disable CPU_IDLE

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.9-soc-ccf

for you to fetch changes up to ef3ffe5a0458606c488def757bb7f6dd013c2db5:

  clk: tegra30: remove unused TEGRA_CLK_DUPLICATE()s

----------------------------------------------------------------

Prashant Gaikwad (18):
      ARM: tegra: add function to read chipid
      ARM: tegra: move tegra_cpu_car.h to linux/clk/tegra.h
      ARM: tegra: define Tegra30 CAR binding
      clk: tegra: add Tegra specific clocks
      clk: tegra: add clock support for Tegra20
      clk: tegra: add clock support for Tegra30
      ARM: tegra: migrate to new clock code
      ARM: tegra: remove legacy clock code
      spi: tegra: do not use clock name to get clock
      ARM: tegra: add clock properties to Tegra20 DT
      ARM: tegra: add clock properties to Tegra30 DT
      ARM: tegra: paz00: add clock information to DT
      staging: nvec: remove use of clk_get_sys
      ASoC: tegra: remove auxdata
      ARM: tegra20: remove auxdata
      ARM: tegra30: remove auxdata
      clk: tegra20: remove unused TEGRA_CLK_DUPLICATE()s
      clk: tegra30: remove unused TEGRA_CLK_DUPLICATE()s

Stephen Warren (1):
      ARM: tegra: define Tegra20 CAR binding

 .../bindings/clock/nvidia,tegra20-car.txt       |  205 ++
 .../bindings/clock/nvidia,tegra30-car.txt       |  262 ++
 arch/arm/boot/dts/tegra20-paz00.dts             |    2 +
 arch/arm/boot/dts/tegra20.dtsi                  |   50 +
 arch/arm/boot/dts/tegra30.dtsi                  |   62 +-
 arch/arm/mach-tegra/Makefile                    |    5 -
 arch/arm/mach-tegra/board-dt-tegra20.c          |   54 -
 arch/arm/mach-tegra/board-dt-tegra30.c          |   62 +-
 arch/arm/mach-tegra/clock.c                     |  166 --
 arch/arm/mach-tegra/clock.h                     |  153 --
 arch/arm/mach-tegra/common.c                    |   44 +-
 arch/arm/mach-tegra/cpu-tegra.c                 |    2 +-
 arch/arm/mach-tegra/cpuidle-tegra30.c           |    2 +-
 arch/arm/mach-tegra/fuse.c                      |    8 +-
 arch/arm/mach-tegra/hotplug.c                   |    2 +-
 arch/arm/mach-tegra/include/mach/clk.h          |   44 -
 arch/arm/mach-tegra/pcie.c                      |    2 +-
 arch/arm/mach-tegra/platsmp.c                   |    2 +-
 arch/arm/mach-tegra/pm.c                        |    2 +-
 arch/arm/mach-tegra/powergate.c                 |    2 +-
 arch/arm/mach-tegra/tegra20_clocks.c            | 1623 ------------
 arch/arm/mach-tegra/tegra20_clocks.h            |   42 -
 arch/arm/mach-tegra/tegra20_clocks_data.c       | 1143 --------
 arch/arm/mach-tegra/tegra30_clocks.c            | 2506 ------------------
 arch/arm/mach-tegra/tegra30_clocks.h            |   54 -
 arch/arm/mach-tegra/tegra30_clocks_data.c       | 1425 ----------
 drivers/clk/Makefile                            |    1 +
 drivers/clk/tegra/Makefile                      |   11 +
 drivers/clk/tegra/clk-audio-sync.c              |   87 +
 drivers/clk/tegra/clk-divider.c                 |  187 ++
 drivers/clk/tegra/clk-periph-gate.c             |  179 ++
 drivers/clk/tegra/clk-periph.c                  |  218 ++
 drivers/clk/tegra/clk-pll-out.c                 |  123 +
 drivers/clk/tegra/clk-pll.c                     |  648 +++++
 drivers/clk/tegra/clk-super.c                   |  154 ++
 drivers/clk/tegra/clk-tegra20.c                 | 1256 +++++++++
 drivers/clk/tegra/clk-tegra30.c                 | 1987 ++++++++++++++
 drivers/clk/tegra/clk.c                         |   85 +
 drivers/clk/tegra/clk.h                         |  502 ++++
 drivers/dma/tegra20-apb-dma.c                   |    2 +-
 drivers/gpu/drm/tegra/dc.c                      |    3 +-
 drivers/gpu/drm/tegra/drm.c                     |    1 -
 drivers/gpu/drm/tegra/hdmi.c                    |    3 +-
 drivers/i2c/busses/i2c-tegra.c                  |    3 +-
 drivers/input/keyboard/tegra-kbc.c              |    2 +-
 drivers/spi/spi-tegra20-sflash.c                |    4 +-
 drivers/spi/spi-tegra20-slink.c                 |    4 +-
 drivers/staging/nvec/TODO                       |    4 -
 drivers/staging/nvec/nvec.c                     |    5 +-
 .../linux/clk/tegra.h                           |   13 +-
 include/linux/tegra-soc.h                       |   22 +
 sound/soc/tegra/tegra30_ahub.c                  |   16 +-
 52 files changed, 6079 insertions(+), 7365 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra30-car.txt
 delete mode 100644 arch/arm/mach-tegra/clock.c
 delete mode 100644 arch/arm/mach-tegra/clock.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/clk.h
 delete mode 100644 arch/arm/mach-tegra/tegra20_clocks.c
 delete mode 100644 arch/arm/mach-tegra/tegra20_clocks.h
 delete mode 100644 arch/arm/mach-tegra/tegra20_clocks_data.c
 delete mode 100644 arch/arm/mach-tegra/tegra30_clocks.c
 delete mode 100644 arch/arm/mach-tegra/tegra30_clocks.h
 delete mode 100644 arch/arm/mach-tegra/tegra30_clocks_data.c
 create mode 100644 drivers/clk/tegra/Makefile
 create mode 100644 drivers/clk/tegra/clk-audio-sync.c
 create mode 100644 drivers/clk/tegra/clk-divider.c
 create mode 100644 drivers/clk/tegra/clk-periph-gate.c
 create mode 100644 drivers/clk/tegra/clk-periph.c
 create mode 100644 drivers/clk/tegra/clk-pll-out.c
 create mode 100644 drivers/clk/tegra/clk-pll.c
 create mode 100644 drivers/clk/tegra/clk-super.c
 create mode 100644 drivers/clk/tegra/clk-tegra20.c
 create mode 100644 drivers/clk/tegra/clk-tegra30.c
 create mode 100644 drivers/clk/tegra/clk.c
 create mode 100644 drivers/clk/tegra/clk.h
 rename arch/arm/mach-tegra/tegra_cpu_car.h => include/linux/clk/tegra.h (91%)
 create mode 100644 include/linux/tegra-soc.h
