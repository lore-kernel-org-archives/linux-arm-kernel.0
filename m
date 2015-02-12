From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 12 Feb 2015 15:55:50 +0900
Subject: [PATCH v3 0/8] arm64: Add the support for new Exynos5433 SoC
Message-ID: <1423724158-23632-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds new 64-bit Exynos5433 Samsung SoC which contains quad
Cortex-A57 and quad Cortex-A53. It is desigend with the 20nm low power process.

This patchset is based on linux-samsung.git (branch: for-next).

Depends on:
- Exynos5433 clock controller patch-set[1][2] was merged by Sylwester Nawrocki,
(http://git.linuxtv.org/cgit.cgi/snawrocki/samsung.git/, branch:for-v3.20/clk/next)
- Exynos5433 UART patch[4] was merged by GregKH.

[1] [PATCH v5 00/13] clk: samsung: Add the support for exynos5433 clocks
- https://lkml.org/lkml/2015/2/2/368
[2] [PATCH v3 0/9] clk: samsung: Add clocks for remaining domains of Exynos5433
- https://lkml.org/lkml/2015/2/2/784
[3] [PATCHv2] pinctrl: exynos: Add support for Exynos543
- https://lkml.org/lkml/2014/12/2/207
[4] serial: samsung: Add the support for Exynos5433 SoC
- http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=31ec77aca72ee5920ed3ec3d047734dc0bc43342

Changelog:
Changes from v2:
(https://lkml.org/lkml/2014/12/2/134)
- Exynos5444 DTS modification
: Fix the range of GICC memory map (0x1000 -> 0x2000)
: Fix address space of 'range' property under 'soc' node
: Add ADMA / I2S dt node for sound playback/capture
- Select ARM_AMBA/ARM_GIC/HAVE_S3C_RTC for Exynos5433 in arch/arm64/Kconfig
- Send separate patch-set for Exynos5433 clock controller[1][2] and pinctrl[3]

Changes from v1:
(https://lkml.org/lkml/2014/11/27/92)
- Merge two patches (patch2, patch3) to solve incomplete description
- Exynos5433 Clock driver
 : Fix wrong register and code clean by using space instead of tab
 : Add CLK_IGNORE_UNUSED flag to pclk_sysreg_* clock for accessing system control register
 : Remove duplicate definition on the patch for CMU_BUS{0|1|2} domain
- Exynos5433 SoC DTS
 : Remove un-supported properties of arch_timer
 : Remove 'clock-frequency' property from 'cpus' dt node
 : Fix interrupt type from edge rising triggering to level high triggering
   because Cortex-A53/A57 use level triggering.
 : Fix defult address-size/size-celss from 1 to 2 because Exynos5433 is 64-bit SoC
 : Modify 'fin_pll' dt node to remove un-needed and ugly code
 : Move 'chipid' dt node under 'soc'
 : Use lowercase on all case in exynos5433.dtsi
 : Add PSCI dt node for secondary cpu boot
 : Add 'samsung,exynos5433' compatible to MCT dt node
- Divide pinctrl patch from this patchset
- Add new following patches:
  : clocksource: exynos_mct: Add the support for Exynos 64bit SoC
  : arm64: Enable Exynos5433 SoC in the defconfig

Chanwoo Choi (5):
  arm64: exynos5433: Enable ARMv8 based Exynos5433 (SoC) support
  arm64: dts: exynos: Add dts files for 64-bit Exynos5433 SoC
  arm64: dts: exynos: Add SPI/PDMA dt node for Exynos5433
  arm64: dts: exynos: Add PMU dt node for Exynos5433
  arm64: dts: exynos: Add RTC and ADC dt node for Exynos5433 SoC

Inha Song (2):
  arm64: dts: exynos: Add ADMA dt node for Exynos5433 SoC
  arm64: dts: exynos: Add I2S dt node for Exynos5433 SoC

Jaehoon Chung (1):
  arm64: dts: exynos: Add MSHC dt node for Exynos5433

 .../devicetree/bindings/arm/samsung/pmu.txt        |   1 +
 arch/arm64/Kconfig                                 |  13 +
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 698 ++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 911 +++++++++++++++++++++
 4 files changed, 1623 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi

-- 
1.8.5.5
