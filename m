From: tony.xie@rock-chips.com (Tony Xie)
Date: Tue, 23 Oct 2018 19:34:22 +0800
Subject: [PATCH v5 0/5] support a new type of PMIC,
 including two chips(rk817 and rk809)
Message-ID: <1540294467-25813-1-git-send-email-tony.xie@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of functions and registers of the rk817 and rk808 are the same,
so they can share allmost all codes.

Their specifications are as follows??
  1) The RK809 and RK809 consist of 5 DCDCs, 9 LDOs and have the same registers
     for these components except dcdc5.
  2) The dcdc5 is a boost dcdc for RK817 and is a buck for RK809.
  3) The RK817 has one switch but The Rk809 has two.

Changes in V2:
1. initialize the pm_pwroff_fn to NULL. 
2. use EXPORT_SYMBOL_GPL to export pm_power_off_prepare.
3. change patch 2/3/4/5 subjects. 

Changes in V3??
1. change patch 4 subjects
2. replace pr_ with dev_ for printing in patch 2
3. modify switch1 and switch2 configs in patch 2
4. explain gpio information for rk809 and rk817 in patch 4

Changes in V4:
1. modify some codes for patch 2 and patch 5 according to comments 
2. add reviewer mail lists for patch 3 and 4

Changes in V5:
modify some codes for patch 1 according to reveiw comments for v3.
 1) remove the pm_power_off_prepare() and replace with shutdown call-back from syscore
 2) move the macro REGMAP_IRQ_M into the regmap.h and rename it REGMAP_IRQ_LINE
 3) make some dev_warn() log clear

Tony Xie (5):
  mfd: rk808: Add RK817 and RK809 support
  regulator: rk808: add RK809 and RK817 support.
  dt-bindings: mfd: rk808: Add binding information for RK809 and RK817.
  rtc: rk808: add RK809 and RK817 support.
  clk: RK808: add RK809 and RK817 support.

 Documentation/devicetree/bindings/mfd/rk808.txt |  44 ++
 drivers/clk/Kconfig                             |   9 +-
 drivers/clk/clk-rk808.c                         |  64 ++-
 drivers/mfd/Kconfig                             |   6 +-
 drivers/mfd/rk808.c                             | 225 +++++++-
 drivers/regulator/Kconfig                       |   4 +-
 drivers/regulator/rk808-regulator.c             | 657 +++++++++++++++++++++++-
 drivers/rtc/Kconfig                             |   4 +-
 drivers/rtc/rtc-rk808.c                         |  68 ++-
 include/linux/mfd/rk808.h                       | 175 +++++++
 include/linux/regmap.h                          |   6 +
 11 files changed, 1193 insertions(+), 69 deletions(-)

-- 
1.9.1
