From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 15 Feb 2013 14:36:30 +0200
Subject: [PATCH v7 00/12] Tegra114 clockframework
Message-ID: <1360931849-7090-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the seventh version of the Tegra114 clockframework. It is based on the
for-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git and
http://www.spinics.net/lists/arm-kernel/msg220452.html.

It has been boottested on Pluto.

Changes from v6:

* Remove clock-frequency from DT serial nodes
* Remove useless 'cpu' clock from binding documentation
* Use HW gate control for PLLU divided outputs
* Fix clock ID for 'd_audio' clock
* Add dummy cpu car ops to ease making a bisectable series

Changes from v5:

* Add initialization code for PLLC
* Remove some unnecessary clocks
* Fix bug in PLL locking refactoring
* Add super clocks
* Remove most calls to clk_register_clkdev() for the peripheral clocks

Changes from v4:

* Split the new PLL types patch into smaller patches
* Fix some bugs in the PLL patches

Changes from v3:

* Merge with for-next branch
* Provide empty tegra_cpu_car_ops to make SMP boot not crash

Changes from v2:

* Added missing PLLs
* Added bindings to tegra114.dtsi
* Moved the table patch for clk-mux.c to 'clk: add table lookup to mux'
* Bugfixes

Changes from v1:

* Remove SATA and PCIe clocks. They don't appear in the internal TRM, so I
  assume they don't exist.
* Rebase on top of Hiroshi's latest Tegra114 patches
* More generic mux code. This is necessary for the AHUB and DAM clocks.

Peter De Schrijver (12):
  clk: tegra: provide dummy cpu car ops
  clk: tegra: Refactor PLL programming code
  clk: tegra: Add TEGRA_PLL_BYPASS flag
  clk: tegra: Add PLL post divider table
  clk: tegra: Add new fields and PLL types for Tegra114
  clk: tegra: Add flags to tegra_clk_periph()
  clk: tegra: Workaround for Tegra114 MSENC problem
  ARM: tegra: Define Tegra114 CAR binding
  clk: tegra: Implement clocks for Tegra114
  clk: tegra: devicetree match for nvidia,tegra114-car
  ARM: dt: Add references to tegra_car clocks
  clk: tegra: Remove forced clk_enable of uartd

 .../bindings/clock/nvidia,tegra114-car.txt         |  316 +++
 arch/arm/boot/dts/tegra114-dalmore.dts             |    1 -
 arch/arm/boot/dts/tegra114-pluto.dts               |    1 -
 arch/arm/boot/dts/tegra114.dtsi                    |    8 +-
 drivers/clk/tegra/Makefile                         |    1 +
 drivers/clk/tegra/clk-periph-gate.c                |    9 +
 drivers/clk/tegra/clk-periph.c                     |   11 +-
 drivers/clk/tegra/clk-pll.c                        | 1136 ++++++++++-
 drivers/clk/tegra/clk-tegra114.c                   | 2032 ++++++++++++++++++++
 drivers/clk/tegra/clk-tegra20.c                    |  153 +-
 drivers/clk/tegra/clk-tegra30.c                    |  243 ++--
 drivers/clk/tegra/clk.c                            |    4 +-
 drivers/clk/tegra/clk.h                            |   90 +-
 13 files changed, 3694 insertions(+), 311 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
 create mode 100644 drivers/clk/tegra/clk-tegra114.c
