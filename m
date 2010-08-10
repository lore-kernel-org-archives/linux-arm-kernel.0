From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 10 Aug 2010 14:44:03 +0900
Subject: [PATCH v7 0/6] ARM: S5PV210: CPUFREQ Initial Support
Message-ID: <1281419049-11562-1-git-send-email-myungjoo.ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PV210 CPUFREQ Initial Support.

This is a series of patches to enable CPUFREQ for S5PV210.

Although this works without PMIC's DVS support, it is not
as effective without DVS support as supposed. AVS is not
supported in this version.

At the patch revision v7, the following patches are updated from v6.
- 1/6: ARM: S5PV210: Allow to probe EVT revision number.
	* Removed revision check function and access EVT info directly.
- 4/6: ARM: S5PV210: Access for DMCx registers
	* removed unnecessary comment.
	* merged the two patches (virtual address + physical address)
		of previously 4/7 and 5/7
- 5/6: ARM: S5PV210: clock registers (CLK_DIV/SRC/STAT)
	* Removed unnecessary defines.
- 6/6: ARM: S5PV210: Initial CPUFREQ Support
	* Updated evt0-check method.
	* Enable CPUFREQ Only for Aquila/Goni
	* Style patch (inline functions)

At the patch revision v6, the following patches are updated from v5.
- 1/7: ARM: S5PV210: Allow to probe EVT revision number
	* Removed EVT1-Fused and related functions
	* Renamed evt related functions.
- 3/7: ARM: S5P: Added default pll values for APLL 800/100MHz
	* Corrected style.
- 7/7: ARM: S5PV210: Initial CPUFREQ Support
	* Following the renamed evt-related functions at 1/7 patch.

At the patch revision v5, the following patches are updated from v4.
- 1/7: ARM: S5PV210: Allow to probe EVT revision number
	* Renamed revision check function
	* Revise revision check function so that it does not access
	board-specific information
	* Chip-ID is used to identify some of EVT revisions.
	* Added "s5pv210_revision_or_later()" function
- 6/7: ARM: S5PV210: clock registers (CLK_DIV/SRC/STAT)
	* Added entry infromation for G3D/G2D/MFC of the register
	S5P_CLK_[DIV|MUX]_STAT[0|1]. These entries are accessed
	multiple times at /arch/arm/mach-s5pv210/cpufreq.c.
- 7/7: ARM: S5PV210: Initial CPUFREQ Support
	* Remove unnecessary USE_FREQ_TABLE
	* Renamed functions in cpufreq.c
	* Initialization of s5pv210_cpufreq_target (previously,
	s5pv210_target) is revised (initilization --> first_run)
	* "workaround" --> "revision"
	* CLK_*_STATx register entries use macros: they are used
	multiple times.

MyungJoo Ham (6):
  ARM: S5PV210: Allow to probe EVT revision number.
  ARM: Samsung SoC: added hclk/pclk info to s3c_freq for s5pv210
    cpu-freq
  ARM: S5P: Added default pll values for APLL 800/1000MHz
  ARM: S5PV210: Access for DMCx registers
  ARM: S5PV210: clock registers (CLK_DIV/SRC/STAT)
  ARM: S5PV210: Initial CPUFREQ Support

 arch/arm/Kconfig                                |    1 +
 arch/arm/mach-s5pv210/Kconfig                   |    6 +
 arch/arm/mach-s5pv210/Makefile                  |    2 +
 arch/arm/mach-s5pv210/cpu.c                     |   15 +-
 arch/arm/mach-s5pv210/cpufreq.c                 |  792 +++++++++++++++++++++++
 arch/arm/mach-s5pv210/include/mach/cpu-freq.h   |   38 ++
 arch/arm/mach-s5pv210/include/mach/hardware.h   |   11 +-
 arch/arm/mach-s5pv210/include/mach/map.h        |    3 +
 arch/arm/mach-s5pv210/include/mach/regs-clock.h |   45 ++-
 arch/arm/mach-s5pv210/mach-aquila.c             |    9 +
 arch/arm/mach-s5pv210/mach-goni.c               |    3 +
 arch/arm/plat-s5p/include/plat/map-s5p.h        |    3 +
 arch/arm/plat-s5p/include/plat/pll.h            |    3 +
 arch/arm/plat-samsung/include/plat/cpu-freq.h   |    6 +
 14 files changed, 932 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/cpufreq.c
 create mode 100644 arch/arm/mach-s5pv210/include/mach/cpu-freq.h
