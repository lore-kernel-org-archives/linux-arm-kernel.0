From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri,  4 Apr 2014 15:42:52 +0200
Subject: [PATCH V2 00/17] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle
Message-ID: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:

V2: 
	* Added comment in changelog for calls order (5/17)
	* Call the powerdown only for cpu0 in the pm notifier
	* Set the pm notifier for all boards

V1: initial post

This patchset relies on the cpm_pm notifier to initiate the powerdown sequence
operations from pm.c instead cpuidle.c. Thus the cpuidle driver is no longer
dependent from arch specific code as everything is called from the pm.c file.

The patchset applies on top of linux-samsung/for-next.

Tested on exynos4: 4210
Tested on exynos5: 5250 (without AFTR)

Daniel Lezcano (17):
  ARM: exynos: cpuidle: Prevent forward declaration
  ARM: exynos: cpuidle: use cpuidle_register
  ARM: exynos: cpuidle: change function name prefix
  ARM: exynos: cpuidle: encapsulate register access inside a function
  ARM: exynos: cpuidle: Move some code inside the idle_finisher
  ARM: exynos: cpuidle: Fix S5P_WAKEUP_STAT call
  ARM: exynos: cpuidle: Use the cpu_pm notifier
  ARM: exynos: cpuidle: Move scu_enable in the cpu_pm notifier
  ARM: exynos: cpuidle: Remove ifdef for scu_enable
  ARM: exynos: cpuidle: Move exynos_set_wakeupmask in the cpu_pm
    notifier
  ARM: exynos: cpuidle: Move the power sequence call in the cpu_pm
    notifier
  ARM: exynos: cpuidle: Move S5P_CHECK_AFTR in a header
  ARM: exynos: cpuidle: Move clock setup to pm.c
  ARM: exynos: cpuidle: Move the boot vector in pm.c
  ARM: exynos: cpuidle: Pass the AFTR callback to the platform_data
  ARM: exynos: cpuidle: Move the driver to drivers/cpuidle directory
  ARM: exynos: config: Enable cpuidle

 arch/arm/configs/exynos_defconfig |    1 +
 arch/arm/mach-exynos/Makefile     |    1 -
 arch/arm/mach-exynos/common.c     |    5 +-
 arch/arm/mach-exynos/common.h     |    1 +
 arch/arm/mach-exynos/cpuidle.c    |  256 -------------------------------------
 arch/arm/mach-exynos/pm.c         |  191 ++++++++++++++++++++++-----
 arch/arm/mach-exynos/pmu.c        |    6 +
 arch/arm/mach-exynos/regs-pmu.h   |    1 +
 drivers/cpuidle/Kconfig.arm       |    7 +
 drivers/cpuidle/Makefile          |    1 +
 drivers/cpuidle/cpuidle-exynos.c  |  102 +++++++++++++++
 11 files changed, 281 insertions(+), 291 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-exynos.c

-- 
1.7.9.5
