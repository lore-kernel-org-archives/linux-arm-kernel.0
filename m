From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Thu, 28 Mar 2013 17:11:26 +0100
Subject: [PATCH V2 00/12] ux500 suspend-resume
Message-ID: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for ux500 suspend/resume
operations with the sleep state ApSleep. (That is sleeping
with APE power domain turned off and ARM power domain in
retention).
Also this series adds the APE power domain to genpd and
introduces a new type of genpd notifiers that are used
for the special case when the context of a device needs to
be restored directly after a CPU coupled power domain (APE)
is turned on. Devices that need to be restored in such a way
are also included in this series.

Note that I will be out of office for three weeks and will
not be able to respond myself to comments on this patch
set. But comments are much appreciated.

Changes v1->v2:
* Added ICN driver and device
* Added TPIU driver and device
* Updated u8500 clk driver and device

Rickard Andersson (12):
  mfd: db8500: Add IO force function
  ARM: ux500: Add platform suspend ops
  PM / Domains: Add on-off notifiers
  PM / Domains: Lookup domain by name
  ARM: ux500: Create APE generic power domain
  clk: ux500: Add PRCC power management
  ARM: ux500: Create u8500-clk device
  ARM: ux500: Add ApSleep state to suspend
  drivers: bus: ux500: Add ICN driver
  ARM: ux500: Create ICN device
  misc: ux500: Add TPIU driver
  ARM: ux500: Create TPIU device

 arch/arm/boot/dts/dbx5x0.dtsi        |  19 ++
 arch/arm/mach-ux500/Kconfig          |   1 +
 arch/arm/mach-ux500/Makefile         |   1 +
 arch/arm/mach-ux500/board-mop500.c   |  27 +-
 arch/arm/mach-ux500/cpu-db8500.c     |   3 +
 arch/arm/mach-ux500/devices-common.c |  32 +++
 arch/arm/mach-ux500/devices-common.h |   2 +
 arch/arm/mach-ux500/devices-db8500.c |  41 +++
 arch/arm/mach-ux500/devices-db8500.h |   1 +
 arch/arm/mach-ux500/suspend.c        |  90 ++++++
 drivers/base/power/domain.c          |  65 ++++-
 drivers/bus/Makefile                 |   1 +
 drivers/bus/dbx500-icn.c             | 522 +++++++++++++++++++++++++++++++++++
 drivers/clk/ux500/clk-prcc.c         |  71 ++++-
 drivers/clk/ux500/clk.h              |   5 +
 drivers/clk/ux500/u8500_clk.c        |  88 ++++++
 drivers/mfd/db8500-prcmu.c           |   9 +
 drivers/misc/Makefile                |   1 +
 drivers/misc/dbx500-tpiu.c           | 182 ++++++++++++
 include/linux/mfd/db8500-prcmu.h     |   1 +
 include/linux/mfd/dbx500-prcmu.h     |   5 +
 include/linux/pm_domain.h            |  28 +-
 22 files changed, 1191 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-ux500/suspend.c
 create mode 100644 drivers/bus/dbx500-icn.c
 create mode 100644 drivers/misc/dbx500-tpiu.c

-- 
1.8.2
