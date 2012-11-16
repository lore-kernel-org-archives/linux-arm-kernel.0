From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 12:43:55 -0700
Subject: [GIT PULL 3/6] ARM: tegra: cpuidle enhancements
In-Reply-To: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
References: <1353095038-20031-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1353095038-20031-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A cpuidle state "LP2" is added, which power-gates the CPUs. Support for
CPUs 1..n is essentially complete, although support for CPU0 could
benefit from future use of coupled-cpuidle or similar techniques.

A couple of very minor cleanups to cpuidle were included too.

This pull request is based on tegra-for-3.8-soc.

----------------------------------------------------------------

The following changes since commit d1d3b978f67c2c000f9d91387cffa630e738d529:

  ARM: tegra: Add Tegra30 host1x clock support

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.8-cpuidle

for you to fetch changes up to 29a0e7beab8e05be53d5b9c050253a4dc417041e:

  ARM: tegra: retain L2 content over CPU suspend/resume

----------------------------------------------------------------

Joseph Lo (10):
      ARM: tegra: cpuidle: replace LP3 with ARM_CPUIDLE_WFI_STATE
      ARM: tegra: rename the file of "sleep-tXX" to "sleep-tegraXX"
      ARM: tegra: cpuidle: separate cpuidle driver for different chips
      ARM: tegra: cpuidle: add CPU resume function
      ARM: tegra30: cpuidle: add powered-down state for secondary CPUs
      ARM: tegra30: common: enable csite clock
      ARM: tegra30: clocks: add CPU low-power function into tegra_cpu_car_ops
      ARM: tegra30: flowctrl: add cpu_suspend_exter/exit function
      ARM: tegra30: cpuidle: add powered-down state for CPU0
      ARM: tegra: retain L2 content over CPU suspend/resume

 arch/arm/mach-tegra/Makefile                    |   11 +-
 arch/arm/mach-tegra/common.c                    |    7 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c           |   66 ++++++
 arch/arm/mach-tegra/cpuidle-tegra30.c           |  188 +++++++++++++++
 arch/arm/mach-tegra/cpuidle.c                   |   83 ++-----
 arch/arm/mach-tegra/cpuidle.h                   |   32 +++
 arch/arm/mach-tegra/flowctrl.c                  |   47 ++++
 arch/arm/mach-tegra/flowctrl.h                  |    8 +
 arch/arm/mach-tegra/headsmp.S                   |   71 ++++++
 arch/arm/mach-tegra/pm.c                        |  216 ++++++++++++++++++
 arch/arm/mach-tegra/pm.h                        |   35 +++
 arch/arm/mach-tegra/reset.c                     |    6 +
 arch/arm/mach-tegra/reset.h                     |    9 +
 .../mach-tegra/{sleep-t20.S => sleep-tegra20.S} |    0
 .../mach-tegra/{sleep-t30.S => sleep-tegra30.S} |   66 ++++++
 arch/arm/mach-tegra/sleep.S                     |   78 +++++++
 arch/arm/mach-tegra/sleep.h                     |   37 +++
 arch/arm/mach-tegra/tegra30_clocks.c            |  108 +++++++++
 arch/arm/mach-tegra/tegra_cpu_car.h             |   37 +++
 19 files changed, 1032 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 create mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 create mode 100644 arch/arm/mach-tegra/cpuidle.h
 create mode 100644 arch/arm/mach-tegra/pm.c
 create mode 100644 arch/arm/mach-tegra/pm.h
 rename arch/arm/mach-tegra/{sleep-t20.S => sleep-tegra20.S} (100%)
 rename arch/arm/mach-tegra/{sleep-t30.S => sleep-tegra30.S} (63%)
