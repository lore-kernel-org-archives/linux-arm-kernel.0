From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 27 Jan 2015 18:46:30 -0800
Subject: [PATCH 0/9] Simplify regulator_set_optimum_mode
Message-ID: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series pushes the get_optimum_mode/set_mode pair from
regulator_set_optimum_mode into the individual drivers.

The first patch consolidates the two drms updating paths, to reduce code
duplication.

The second patch introduces the set_optimum_mode call, the following patches
moves drivers over to the new api and get_optimum_mode is finally dropped.

With this in place we can implement set_optimum_mode in the Qualcomm RPM
driver.


When we talked about this you (Mark) said that you wished that we simplified
this api, but how far would you like to take that?

* Drop input_uV/output_uV from set_optimum_mode? (there are no users today)
* Rename the op to set_current() (without in/out uV, this is basically what we have)
* s/regulator_set_optimum_mode/regulator_set_current/ ?
* Remove regulator_set_mode (consumers should know their expected load, not the
  expected operating mode of whatever regulator they are supplied by)

Bjorn Andersson (9):
  regulator: core: Consolidate drms update handling
  regulator: core: Introduce set_optimum_mode op
  regulator: ab8500: move to set_optimum_mode
  regulator: wm831x-ldo: move to set_optimum_mode
  regulator: wm8350: move to set_optimum_mode
  regulator: hi6421: move to set_optimum_mode
  regulator: wm8400: move to set_optimum_mode
  regulator: Drop now unused get_optimum_mode
  regulator: qcom-rpm: Implement set_optimum_mode

 drivers/regulator/ab8500.c             |  48 +++++++-------
 drivers/regulator/core.c               | 112 +++++++++------------------------
 drivers/regulator/hi6421-regulator.c   |  15 +++--
 drivers/regulator/qcom_rpm-regulator.c |  28 +++++++++
 drivers/regulator/wm831x-ldo.c         |  21 ++++---
 drivers/regulator/wm8350-regulator.c   |  12 ++--
 drivers/regulator/wm8400-regulator.c   |  10 +--
 include/linux/regulator/driver.h       |   8 +--
 8 files changed, 118 insertions(+), 136 deletions(-)

-- 
1.9.1
