From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 13 May 2014 17:31:58 +0530
Subject: [PATCH v4 0/4] Adds PMU and S2R support for exynos5420
Message-ID: <1399982522-27928-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rebased on
1] Kukjin Kim's tree for-next branch (which has Sachin Kamat's SYSRAM
patches merged) with Tomasz Figa's samsung clock tree (samsung-next branch)
merged. 
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
2] Pankaj Dubey's v4 PMU patchset
https://lkml.org/lkml/2014/5/10/29

Pankaj's patches have the following dependencies:
	[1] mfd: syscon: Support early initialization
	https://lkml.org/lkml/2014/4/8/239
	[2] Daniel Lezcano's Exynos cpuidle refactor patches
	http://thread.gmane.org/gmane.linux.kernel.samsung-soc/29085
	[3] Allow NULL property in syscon_early_regmap_lookup_by_phandle
	https://lkml.org/lkml/2014/5/10/10 and
	https://lkml.org/lkml/2014/4/29/661

Note: Some of the above patches did not apply cleanly on Kgene's for-next branch.

changes since v3:
Addressed the following comments from Pankaj Dubey, Bartlomiej Zolnierkiewicz,
Tomasz Figa and Alim Akhtar:
	- Moved EXYNOS5420_USE_STANDBY_WFI_ALL define to regs-pmu.h.
	- Merged exynos5420_set_core_flag function into powerdown_conf.
	- Removed XXTI_DURATION3 register setting.
	- Updated the commit message and ordered the clock registers in clock
	  patch.
	- Removed the code for SYS_DISP1_BLK_CFG handling.
	- Modified SoC checks to A9 specific checks in PM code. 
	- Updated some comments in the code and added macros for register offsets.
	- Fixed code which was changing pad retention code for older SoCs.

changes since v2:
        - Addressed comments from Tomasz figa
        - rebased on Pankaj's V3 patchset https://lkml.org/lkml/2014/5/2/612
        - dropped patch "ARM: dts: Add node for GPIO keys on SMDK5420",
          will be sent separately.

changes since v1:
        - Addressed comments from Tomasz figa.
        - restructured/consolidated as per Tomasz figa's PM consolidations for exynos

Tested on Exynos5420 and Exynos5250 based chromebooks (peach-pit and snow).

Abhilash Kesavan (4):
  arm: exynos5: Add PMU support for 5420
  arm: exynos: Modify code to check for cortex A9 rather than the SoC
  arm: exynos5: Add Suspend-to-RAM support for 5420
  clk: samsung: exynos5420: Setup clocks before system suspend

 arch/arm/mach-exynos/exynos.c        |    1 +
 arch/arm/mach-exynos/pm.c            |  216 ++++++++++++++++++++---
 arch/arm/mach-exynos/pmu.c           |  310 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h      |  239 ++++++++++++++++++++++++++
 drivers/clk/samsung/clk-exynos5420.c |   25 +++
 5 files changed, 769 insertions(+), 22 deletions(-)

-- 
1.7.9.5
