From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 18 Mar 2015 09:17:27 +0900
Subject: [PATCH v7 0/9] arm64: Add the support for new Exynos5433 SoC
Message-ID: <1426637856-3730-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds new 64-bit Exynos5433 Samsung SoC which contains quad
Cortex-A57 and quad Cortex-A53. It is desigend with the 20nm low power process.

Depends on:
- This patch-set has the dependency on Exynos5433 clock driver[1] and pinctrl driver[2].
The Exynos5433 clock controller patch-set[1] was merged by Michael Turquette.
and Exynos5433's pinctrl patch[2] was merged by Linus Walleij. Exynos5433's TMU patch[3]
will be refactoring without feature update.

[1] http://git.linaro.org/people/mike.turquette/linux.git/commit/cc91909b9683c834485fd0627708c81d9398bf02
[2] https://git.kernel.org/cgit/linux/kernel/git/linusw/linux-pinctrl.git/commit/?h=for-next&id=3c5ecc9ed3537846fd95e8f288d6d6968075879f
[3] [PATCH 0/3] thermal: exynos: Add support for Exynos5433 TMU
    - https://lkml.org/lkml/2015/2/26/234

Changelog:

Changes fromv v6:
(https://lkml.org/lkml/2015/3/9/1036)
- Fix wrong base address of CMU_MSCL dt node (0x105d0000 -> 0x150d0000)
- Adjust the length of memory mapped region for all clock domains

Changes from v5:
(https://lkml.org/lkml/2015/3/5/27)
- Move 'timer' dt node under root node by Mark Rutland's comment

Changes from v4:
(https://lkml.org/lkml/2015/2/24/2)
- Rebased it on Linux 4.0-rc2
- Remove CONFIG_ARCH_EXYNOS5433 configuration by Arnd Bergmann's comment
- Move 'aliases' dt node from SoC dtsi to board dts file by Arnd Bergmann's comment
- Add Exynos5433 TMU patches which got the Lukasz Majewski's reviewed message

Changes from v3:
(https://lkml.org/lkml/2015/2/12/65)
- Rebased it on Linux 4.0-rc1.
- Remove ARM_GIC and ARM_AMBA dependency because CONFIG_ARM64 already included them.

Changes from v2:
(https://lkml.org/lkml/2014/12/2/134)
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
-----------------------------------------------------

Chanwoo Choi (6):
  arm64: dts: exynos: Add dts files for 64-bit Exynos5433 SoC
  arm64: dts: exynos: Add SPI/PDMA dt node for Exynos5433
  arm64: dts: exynos: Add PMU dt node for Exynos5433
  arm64: dts: exynos: Add RTC and ADC dt node for Exynos5433 SoC
  arm64: dts: exynos: Add TMU sensor dt node for Exynos5433 SoC
  arm64: dts: exynos: Add thermal-zones dt node for Exynos5433 SoC

Inha Song (2):
  arm64: dts: exynos: Add ADMA dt node for Exynos5433 SoC
  arm64: dts: exynos: Add I2S dt node for Exynos5433 SoC

Jaehoon Chung (1):
  arm64: dts: exynos: Add MSHC dt node for Exynos5433

 .../devicetree/bindings/arm/samsung/pmu.txt        |   1 +
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 698 +++++++++++++++
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |  22 +
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 231 +++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 931 +++++++++++++++++++++
 5 files changed, 1883 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi

-- 
1.8.5.5
