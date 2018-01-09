From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Jan 2018 16:58:57 +0900
Subject: [RFC PATCH 0/9] soc: samsung: Add support of suspend-to-RAM on
 Exynos5433
References: <CGME20180109075904epcas2p302d58aacfbb2195e455a25c90a1c610b@epcas2p3.samsung.com>
Message-ID: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the mainline, there is no case to support the suspend-to-RAM for Samsung
Exynos SoC. This patchset support the suspend-to-RAM for 64bit Exynos SoC.

For 32bit, arch/arm/mach-exynos/* directoy contains the suspend-related
codes such as suspend.c/exynos.c. But, 64bit Exynos should contain
the suspend-related codes in the drivers/soc/samsung/*. So, this patchset
develop the patch4/5 for drivers/soc/samsung/exynos-pm.c. to support suspend
64bit Exynos SoC.

But, I'm not sure what is proper approach for both 32/64bit Exynos.
- Approach1 : Split out the supend-related codes between 32/64bit.
  : arch/arm/mach-exynos/* contains the suspend-related codes for 32bit.
  : drivers/soc/samsung/* contains the suspend-related codes for 64bit.
- Approach2 : Consolidate the all suspend-related codes to drivers/soc/samsung/.

Please let us know your opinion.

The patch1/2/3 and 6/7/8/9 is just general patch. So, I add 'RFC' prefix to
only cover-letter, patch4/5. If you want to add the 'RFC' prefix to all
patches, I'll add 'RFC' prefix on v2.

Based on:
- git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git (branch: for-next)

Need to discuss patch4/5:
- patch4: soc: samsung: Add generic power-management driver for Exynos
- patch5: soc: samsung: pm: Add support for suspend-to-ram of Exynos5433

[Remaining Issues]
- The hang-out happen when disabling the MMC clocks on dw_mmc.c.
  I reported to Jaehoon Chung. He is checking this issue. To test the
  suspend-to-ram temporarily, you need to add CLK_IS_CRITICAL flag to
  'aclk_mmc2/aclk_mmc0/sclk_mmc2/sclk_mmc0'.
- I enabled the at least kernel configuration in order to test
  the suspend-to-RAM. So, I need to test it more time with DRM/Multimedia
  and other. But, the suspend-to-RAM of cpu is successful.
- Exynos5433 SoC has two EXYNOS5433_EINT_WAKEUP_MASKx registers. The
  pinctr-exynos.c need to handle the extra EINT_WAKEUP_MASKx for Exynos5433.
  The suspend-to-ram test is failed on first time and then next tryout is ok.
  I'm developing it.

Chanwoo Choi (9):
  clk: samsung: exynos5433: Add clock flag to support suspend-to-ram
  soc: samsung: pmu: Add powerup_conf callback
  soc: samsung: pmu: Add the PMU data of exynos5433 to support low-power state
  soc: samsung: Add generic power-management driver for Exynos
  soc: samsung: pm: Add support for suspend-to-ram of Exynos5433
  arm64: dts: exynos: Add iRAM device-tree node for Exynos5433
  arm64: dts: exynos: Use power key as a wakeup source on TM2/TM2E board
  arm64: dts: exynos: Add cpu_suspend property of PSCI for exynos5433
  arm64: dts: exynos: Add cpu topology information for Exynos5433 SoC

 arch/arm/mach-exynos/common.h                      |   3 -
 arch/arm/mach-exynos/exynos.c                      |  23 +-
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |   1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  47 ++++
 drivers/clk/samsung/clk-exynos5433.c               |  22 +-
 drivers/soc/samsung/Makefile                       |   5 +-
 drivers/soc/samsung/exynos-pm.c                    | 214 +++++++++++++++
 drivers/soc/samsung/exynos-pmu.c                   |   9 +
 drivers/soc/samsung/exynos-pmu.h                   |   3 +
 drivers/soc/samsung/exynos5433-pmu.c               | 286 +++++++++++++++++++++
 include/linux/soc/samsung/exynos-pm.h              |  21 ++
 include/linux/soc/samsung/exynos-pmu.h             |   1 +
 include/linux/soc/samsung/exynos-regs-pmu.h        | 148 +++++++++++
 13 files changed, 745 insertions(+), 38 deletions(-)
 create mode 100644 drivers/soc/samsung/exynos-pm.c
 create mode 100644 drivers/soc/samsung/exynos5433-pmu.c
 create mode 100644 include/linux/soc/samsung/exynos-pm.h

--
1.9.1
