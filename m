From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 21 Jun 2013 15:32:05 +0200
Subject: [PATCH v3 0/4] i2c-mv64xxx: Fixes and new feature for controlers
 embedded in Aramda XP
Message-ID: <1371821529-13791-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch set adds support for the I2C Transaction Generator which
offloads CPU from managing I2C transfer step by step. This feature is
currently only available on the I2C controller IP embedded in the
Armada XP SoC.

This series also contains a real fix for the I2C controller of the
Armada XP SoC and a patch closer to an improvement than a fix.

The first three patches modify the driver itself and should go through
i2c subsystem.

The last patch updates the device tree to be able to use this new
feature and should go through mvebu subsystem.

Due to the recent changes in i2c-mv64xxx.c file, I based these patches
on the for-next branch of the i2c git repository.

Thanks,

Change log:

v2->v3:

 - Introduces a new compatible string mv78230-i2c which will be used
   for the fix and for the offload feature which are only present on
   the Armada XP SoCs

 - Removes the unneeded spin_lock_irqsave pointed by Russell King

 - The offload mechanism is now port of the fsm and handle the
   multiple messages.

 - The flag bridge-enabled is renamed to offload_enabled, but the
   register name stills contains the BRIDGE word to match the
   datasheet.

 - Uses writel_relaxed on the place pointed by Russell King

 - Uses the bool type for the flag (pointed by Thomas Petazzoni)

 - Removes useless code (pointed by Thomas Petazzoni)

 - Updates the bindings documentation

v1->v2:
 - Move the flag for the timing issue from global scope to per device
   scope
 - Assignment is no more done in if condition


Gregory CLEMENT (4):
  i2c-mv64xxx: Set bus frequency to 100kHz if clock-frequency is not
    provided
  i2c-mv64xxx: Add I2C Transaction Generator support
  i2c-mv64xxx: Fix timing issue on Armada XP (errata FE-8471889)
  ARM: dts: mvebu: Introduce a new compatible string for mv64xxx-i2c

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |  19 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   2 -
 arch/arm/boot/dts/armada-370.dtsi                  |   8 +
 arch/arm/boot/dts/armada-xp.dtsi                   |  10 +
 drivers/i2c/busses/i2c-mv64xxx.c                   | 222 ++++++++++++++++++++-
 5 files changed, 246 insertions(+), 15 deletions(-)

-- 
1.8.1.2
