From: rf@opensource.wolfsonmicro.com (Richard Fitzgerald)
Date: Tue, 18 Apr 2017 11:43:46 +0100
Subject: [PATCH 0/7] regulator: arizona: Prepare for sharing with Madera codecs
Message-ID: <1492512234-19210-1-git-send-email-rf@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches make various changes to the Arizona regulators so that they
can be re-used for the Cirrus Madera codecs:
- pdata is moves out of struct arizona_pdata into driver-specific structs
- all unnecessary dependence on struct arizona is removed
- generic init that doesn't depend on struct arizona is factored out
- The ldo and micsupp drivers now have separate KConfig options because
  only the CS47L85/WM1840 Madera codecs have an LDO1, no other Madera
  codecs will.

The Exynos based Cragganmore platform is a user of struct arizona_pdata
for the LDO1 so patch #5 updates it to the new pdata.

Richard Fitzgerald (7):
  regulator: arizona: Split KConfig options for LDO1 and MICSUPP
    regulators
  regulator: arizona-micsupp: Move pdata into a separate structure
  regulator: arizona-micsupp: Make arizona_micsupp independent of struct
    arizona
  regulator: arizona-micsupp: Factor out generic initialization
  regulator: arizona-ldo1: Move pdata into a separate structure
  regulator: arizona-ldo1: Make arizona_ldo1 independent of struct
    arizona
  regulator: arizona-ldo1: Factor out generic initialization

 MAINTAINERS                                  |   1 +
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |   8 +-
 drivers/regulator/Kconfig                    |  14 ++-
 drivers/regulator/Makefile                   |   3 +-
 drivers/regulator/arizona-ldo1.c             | 143 +++++++++++++++------------
 drivers/regulator/arizona-micsupp.c          | 122 +++++++++++++----------
 include/linux/mfd/arizona/pdata.h            |   7 +-
 include/linux/regulator/arizona-ldo1.h       |  24 +++++
 include/linux/regulator/arizona-micsupp.h    |  21 ++++
 9 files changed, 221 insertions(+), 122 deletions(-)
 create mode 100644 include/linux/regulator/arizona-ldo1.h
 create mode 100644 include/linux/regulator/arizona-micsupp.h

-- 
1.9.1
