From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 17:28:39 +0530
Subject: [PATCH v6 0/5] MCPM backend for Exynos5420
Message-ID: <1399982324-27879-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v6 of the series adding MCPM backend support for SMP secondary boot
and core switching on Samsung's Exynos5420. The patches are based on the mcpm
support added for Exynos5420 in the Chromium kernel repository here:
https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/chromeos-3.8

The patches have been prepared on Kukjin Kim's for-next branch and tested on
SMDK5420 EVT1 as well as an exynos5420 based chromebook (peach-pit) using the
"/dev/b.L_switcher" user interface. Secondary core boot-up has also been tested
on both the boards.

Changes since v5:
Addressed the following comments from Kukjin Kim:
	- The recently merged sysram dt patch has a slightly modified compatible
	  string (exynos4210-sysram-ns). Made the appropriate change in the mcpm
	  back-end to handle this.
	- Changed the naming of generic cpu/cluster control functions.
	  Correspondingly changed the usage in the mcpm back-end.
	- Modified hotplug.c to use the generic cpu power down function.
	- Cleaned up unused S5P_ARM_CORE1_CONFIGURATION and S5P_ARM_CORE1_STATUS
	  macros.
	- Added a macro for cpu boot address offset and changed debug statement
	  from pr_warn to pr_debug.
	- Added missing signed-off-by's to the generic cpu/cluster control
	  patches.

Changes since v4:
Addressed the following comments from Nicolas Pitre:
	- Fixed the location of L2 prefetching disable code.
	- Fixed the location of the "TODO" comment.
	- Fixed a possible race in mcpm cluster state check in
	  exynos_power_up().
	
Changes since v3:
	- Rebased on top of the latest SYSRAM DT patchset from Sachin Kamat.

Addressed the following comments from Lorenzo Pieralisi and Nicolas Pitre:
	- Dropped the patch "arm: exynos: Add /dev/bL_status user interface on
	  Exynos5420".
	- Fixed the header ordering and removed unnecessary header inclusions.
	- Made the code symmetric in exynos_cluster_power_control().
	- Fixed the error path in exynos_power_up.
	- Got rid of "cnt" variable used for last man checking.
	- Removed stale comments.
	- Replaced "soc_is" with "of_find_compatible_node" check for exynos5420.
	- Added L2 prefetching disable code needed during A15 power down.

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
 arch/arm/mach-exynos/hotplug.c     |    2 +-
 arch/arm/mach-exynos/mcpm-exynos.c |  346 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/platsmp.c     |    9 +-
 arch/arm/mach-exynos/pm.c          |   66 +++++++
 arch/arm/mach-exynos/regs-pmu.h    |   16 +-
 9 files changed, 473 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/mach-exynos/mcpm-exynos.c

-- 
1.7.9.5
