From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:31 +0200
Subject: [PATCH V4 00/20] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle
Message-ID: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:

V4:
	* Took into account Tomasz's comments
		* Fixed missing call in for central suspend
		* Passed parameter to the wakeup mask function
		* Moved wakeup mask, boot vector and aftr state into a single
		function
		* Used this function as callback for platform data
		* Moved S5P_CHECK_AFTR/S5P_CHECK_SLEEP into pm.c
		* Set boot vector only one time
	* Splitted some patches to make them more readable
V3:
	* Added patch   : "ARM: exynos: cpuidle: Disable cpuidle for 5440"
	* Removed patch : "ARM: exynos: config: Enable cpuidle"
	* Removed default ARM_EXYNOS4210_CPUIDLE=y
	* Added comment about bug fix side effect 'for_each_possible_cpu'
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


Daniel Lezcano (20):
  ARM: exynos: cpuidle: Prevent forward declaration
  ARM: exynos: cpuidle: Use cpuidle_register
  ARM: exynos: cpuidle: Change function name prefix
  ARM: exynos: cpuidle: Encapsulate register access inside a function
  ARM: exynos: cpuidle: Move some code inside the idle_finisher
  ARM: exynos: cpuidle: Fix S5P_WAKEUP_STAT call
  ARM: exynos: cpuidle: Use the cpu_pm notifier
  ARM: exynos: cpuidle: Move scu_enable in the cpu_pm notifier
  ARM: exynos: cpuidle: Remove ifdef for scu_enable
  ARM: exynos: cpuidle: Move clock setup to pm.c
  ARM: exynos: cpuidle: Pass wakeup mask parameter to function
  ARM: exynos: cpuidle: Encapsulate boot vector code into a function
  ARM: exynos: cpuidle: Disable cpuidle for 5440
  ARM: exynos: cpuidle: Encapsulate the AFTR code into a function
  ARM: exynos: cpuidle: Move the AFTR state function into pm.c
  ARM: exynos: cpuidle: Move the power sequence call in the cpu_pm
    notifier
  ARM: exynos: cpuidle: Move S5P_CHECK_SLEEP into pm.c
  ARM: exynos: cpuidle: Pass the AFTR callback to the platform_data
  ARM: exynos: cpuidle: Cleanup all unneeded headers from cpuidle.c
  ARM: exynos: cpuidle: Move the driver to drivers/cpuidle directory

 arch/arm/mach-exynos/Makefile    |    1 -
 arch/arm/mach-exynos/common.h    |    1 +
 arch/arm/mach-exynos/cpuidle.c   |  255 --------------------------------------
 arch/arm/mach-exynos/exynos.c    |    8 +-
 arch/arm/mach-exynos/pm.c        |  187 +++++++++++++++++++++++-----
 arch/arm/mach-exynos/regs-pmu.h  |   21 +++-
 drivers/cpuidle/Kconfig.arm      |    6 +
 drivers/cpuidle/Makefile         |    1 +
 drivers/cpuidle/cpuidle-exynos.c |   98 +++++++++++++++
 9 files changed, 289 insertions(+), 289 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-exynos.c

-- 
1.7.9.5
