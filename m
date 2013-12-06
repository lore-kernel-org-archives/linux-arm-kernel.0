From: stefan@agner.ch (Stefan Agner)
Date: Fri,  6 Dec 2013 13:51:44 +0100
Subject: [PATCH v5 0/3] regulator: tps6586x: add version detection and voltage
 tables
Message-ID: <cover.1386333697.git.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the 5th version of this patchset which adds version detection
for the tps6586x mfd family. Just discovered a missing null reference
check which did not triggered in my tests, sorry about that.

This is required because some regulator versions use different voltage
tables. The regulator driver now uses the right voltage table according
to the version.

While at it, there are a few other incorrect regulator entries in the
device tree, change them accordingly (this patch is new and grew out
of a patch with the same name which Lucas Stach posted in July).

Tested on Colibri T20 V1.1 and V1.2 which makes use of diffent version
of that regulator.

Changes since v4:
  - Use variable named version instead of ret

Changes since v3:
  - Check if version specific table is necessary

Changes since v2:
  - Avoid moving devm_kzalloc
  - Removed reg_ from reg_version
  - Moved walk through version dependent tables to find_regulator_info,
    removed the inline definition. This reduces .o size and encapsulates
    the logic of finding the right regulator into one function. It comes
    with a slight code duplication, the table search now appears twice.

Changes since v1:
  - Merged DT and driver change (preserves bisectability)
  - Use different regulator tables for different regulator version
    * This also makes the TPS6586X_ANY version needless
  - Replaced enum with defines
  - Move version message in a sperate function
  - Include regulator bugfix, use correct supply voltage
  - Checked all voltages, fix SM0/SM1 (Core/CPU) and LDO6 voltage (VDAC/VI)
    in another commit
  - Rebased on top of v3.13-rc2


Stefan Agner (3):
  mfd: tps6586x: add version detection
  regulator: tps6586x: add and use correct voltage table
  ARM: tegra: correct Colibri T20 regulator settings

 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 34 +++++------
 drivers/mfd/tps6586x.c                     | 50 +++++++++++++---
 drivers/regulator/tps6586x-regulator.c     | 93 ++++++++++++++++++++++++------
 include/linux/mfd/tps6586x.h               |  7 +++
 4 files changed, 140 insertions(+), 44 deletions(-)

-- 
1.8.4.2
