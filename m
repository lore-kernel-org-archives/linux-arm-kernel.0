From: robherring2@gmail.com (Rob Herring)
Date: Tue, 26 Feb 2013 21:42:04 -0600
Subject: [PATCH 0/4] Convert highbank to use PSCI calls
Message-ID: <1361936528-25998-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series converts highbank to use PSCI calls for secondary core boot,
hotplug, cpuidle, suspend/resume, reset, and poweroff. Doing this removes
about 200 lines of platform code (1/3 of it) and abstracts out the A9 and
A15 differences (some of which are not yet in place).

Will, I'm using the id field to specify system level events which are
highbank specific. I worry that the id field will be abused for things
that could be standardized. Having standard PSCI calls for reset and
poweroff would avoid this for highbank.

Rob

Rob Herring (4):
  ARM: highbank: clean-up some unused includes
  dts: calxeda: add ARM PSCI binding
  cpuidle: calxeda: add support to use PSCI calls
  ARM: highbank: adapt to use ARM PSCI calls

 arch/arm/boot/dts/ecx-common.dtsi |    8 +++++
 arch/arm/mach-highbank/Kconfig    |    2 +-
 arch/arm/mach-highbank/Makefile   |    2 +-
 arch/arm/mach-highbank/core.h     |    3 --
 arch/arm/mach-highbank/highbank.c |   53 +++++------------------------
 arch/arm/mach-highbank/hotplug.c  |   12 +------
 arch/arm/mach-highbank/platsmp.c  |   42 ++++-------------------
 arch/arm/mach-highbank/pm.c       |   25 +++++---------
 arch/arm/mach-highbank/sysregs.h  |   67 ++++++-------------------------------
 arch/arm/mach-highbank/system.c   |   32 ------------------
 drivers/cpuidle/cpuidle-calxeda.c |   54 ++++--------------------------
 drivers/mailbox/pl320-ipc.c       |    2 +-
 12 files changed, 53 insertions(+), 249 deletions(-)
 delete mode 100644 arch/arm/mach-highbank/system.c

-- 
1.7.10.4
