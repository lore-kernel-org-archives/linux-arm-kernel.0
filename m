From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri,  2 May 2014 20:54:59 +0530
Subject: [PATCH v4 0/5] MCPM backend for Exynos5420
In-Reply-To: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
References: <1398528348-21214-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1399044299-15606-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v4 of the series adding MCPM backend support for SMP secondary boot
and core switching on Samsung's Exynos5420. The patches are based on the mcpm
support added for Exynos5420 in the Chromium kernel repository here:
https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/chromeos-3.8

This patchset depends on:
- [v2,1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM bindings
(https://patchwork.kernel.org/patch/4101091/)

The patches have been prepared on linux-next(20140501) and tested on SMDK5420
EVT1 using the "/dev/b.L_switcher" user interface. Secondary core boot-up has
also been tested on an Exynos5420-based chromebook.

Changes since v3:
	- Rebased on top of the latest SYSRAM DT patchset from Sachin Kamat.

Addressed the following comments from Lorenzo Pieralisi and Nicolas Pitre:
	- Dropped the patch "arm: exynos: Add /dev/bL_status user interface on
	  Exynos5420".
	- Fixed the header ordering and removed unnecessary header inclusions.
	- Made the enable/disable code for cluster power symmetric.
	- Fixed the error path in exynos_power_up.
	- Got rid of "cnt" variable used for last man checking.
	- Removed stale comments.
	- Replaced "soc_is" with "of_find_compatible_node" check for exynos5420.
	- Added L2 prefetching disable code for A15 power down from tc2_pm.c.

Changes since v2:
Addressed the following comments from Nicolas Pitre and Daniel Lezcano:
	- Added generic common (cluster) configuration functions to pm.c
	  which may be used by other subsystems.
	- Removed unused "cpumask" variable in mcpm code.
	- Re-worked exynos_power_down_finish() referencing the tc2_pm code.
	- Removed the status checks in core and cluster power functions. We
	  just set the power control bit and do not check the previous state
	  anymore.
	- Removed incorrect jiffies timeout usage in path where IRQs are
	  disabled.

Changes since v1:
Addressed the following comments from Dave Martin and Nicolas Pitre:
	- Fixed help text for EXYNOS5420_MCPM symbol.
	- Removed mcpm-exynos-setup.S file and added similar code from tc2_pm.c.
	- Changed the spinlock name from "bl_lock" to "exynos_mcpm_lock".
	- Removed snoop enable/disable calls due to possible cpuidle issue and
	  not having numbers proving a significant power savings. Dropped the
	  "drivers/bus: arm-cci: Add common control interface for ACE ports"
	  patch from v1 as it was no longer needed.
	- Created a macro for exynos-specific v7_exit_coherency_flush which
	  handles an erratum. This was done to prevent duplication of code.
	- Removed "outer_flush_all" call.
	- Removed redundant dsb in power_down function.
	- Removed unnecessary initialization of global variables to zero.
	- Split the /dev/bL_status debug interface into another patch.
	- Fixed error handling in exynos_mcpm_init().
	- Called mcpm_smp_set_ops directly from exynos_mcpm_init().
	- Added a TODO for supporting cluster down on exynos5420.

NOTE:
- Have added Leela Krishna's generic cpu power control function series
  as part of this patchset.
- Only the patch "arm: exynos: Add MCPM call-back functions" has changed
  from v3.
- I have tested with and without the erratum 799270 workaround and both
  work fine. I have kept the erratum fix for the time being.

Abhilash Kesavan (2):
  arm: exynos: Add generic cluster power control functions
  arm: exynos: Add MCPM call-back functions

Andrew Bresticker (1):
  ARM: dts: exynos5420: add CCI node

Leela Krishna Amudala (2):
  ARM: EXYNOS: Add generic cpu power control functions for all exynos
    based SoCs
  ARM: EXYNOS: use generic exynos cpu power control functions

 arch/arm/boot/dts/exynos5420.dtsi  |   27 +++
 arch/arm/mach-exynos/Kconfig       |    8 +
 arch/arm/mach-exynos/Makefile      |    2 +
 arch/arm/mach-exynos/common.h      |    6 +
 arch/arm/mach-exynos/mcpm-exynos.c |  345 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/platsmp.c     |    9 +-
 arch/arm/mach-exynos/pm.c          |   66 +++++++
 arch/arm/mach-exynos/regs-pmu.h    |   15 ++
 8 files changed, 472 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-exynos/mcpm-exynos.c

-- 
1.7.9.5
