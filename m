From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 15 Jul 2013 16:24:35 +0200
Subject: [PATCH 0/3] i2c-mv64xxx: Fixes and new feature for controlers
 embedded in Aramda XP
Message-ID: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch set adds support for the I2C Transaction Generator which
offloads CPU from managing I2C transfer step by step. This feature is
currently only available on the I2C controller IP embedded in the
Armada XP SoC.

This is mainly a updated series rebased on 3.11-rc1.

This series also contains a real fix for the I2C controller of the
Armada XP SoC.

The first two patches modify the driver itself and should go through
i2c subsystem.

The last patch updates the device tree to be able to use this new
feature and should go through mvebu subsystem.

Thanks,

Change log:
v3->v4:

 - reverse the order of the compatible strings, with the most
   specific first

 - rebased on 3.11-rc1

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


Gregory CLEMENT (3):
  i2c-mv64xxx: Add I2C Transaction Generator support
  i2c-mv64xxx: Fix timing issue on Armada XP (errata FE-8471889)
  ARM: dts: mvebu: Introduce a new compatible string for mv64xxx-i2c

 .../devicetree/bindings/i2c/i2c-mv64xxx.txt        |  13 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |   2 -
 arch/arm/boot/dts/armada-370.dtsi                  |   8 +
 arch/arm/boot/dts/armada-xp.dtsi                   |  10 +
 drivers/i2c/busses/i2c-mv64xxx.c                   | 216 ++++++++++++++++++++-
 5 files changed, 236 insertions(+), 13 deletions(-)

-- 
1.8.1.2
