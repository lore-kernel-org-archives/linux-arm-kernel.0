From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 02 Dec 2014 17:49:37 +0900
Subject: [PATCHv2 00/19] arm64: Add the support for new 64-bit Exynos5433 SoC
Message-ID: <1417510196-6714-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds new 64-bit Exynos5433 Samsung SoC which contains quad
Cortex-A57 and quad Cortex-A53. It is desigend with the 20nm low power process.

This patchset include some patches such as:
- Support booting of Exynos5433
- Support UART/MCT/GIC/HSI2C/SPI/PDMA/MSHC
- Support the clock control for Exynos5433 using common clk framework

This patchst is based on linux-samsung.git (branch: v3.19-next/dt-samsung-64)

This patchset has the dependency as following list:
: The Exynos7 patchset[1] specified dependent patchset for 64-bit SoC.
 So, this patchset used same dependent patchset of Exynos7 patchset and Exynos7
 patchset about pinctrl patch. Additionally, SPI/MMC/PDMA patch [2-5] is used
 for kernel booting and mounting rootfs.

1. [PATCH v7 0/7] Enable support for Samsung Exynos7 SoC
- [1] http://www.spinics.net/lists/linux-samsung-soc/msg38734.html
2. [PATCH] spi: s3c64xx: add support for exynos7 SPI controller
- [2] http://www.spinics.net/lists/linux-samsung-soc/msg38607.html
3. [PATCH V7] mmc: dw_mmc: Add IDMAC 64-bit address mode support
- [3] https://lkml.org/lkml/2014/10/20/58
4. [PATCH] mmc: dw_mmc: exynos: Add support for exynos7
- [4] http://www.spinics.net/lists/linux-mmc/msg28294.html
5. [PATCH] dmaengine: pl330: Correct device assignment
- [5] https://lkml.org/lkml/2014/11/6/207

Changes from v1:
- Merge two patches (patch2, patch3) to solve incomplete description [by Arnd]
- Exynos5433 Clock driver
 : Fix wrong register and code clean by using space instead of tab [Pankaj]
 : Add CLK_IGNORE_UNUSED flag to pclk_sysreg_* clock for accessing system control register
 : Remove duplicate definition on the patch for CMU_BUS{0|1|2} domain
- Exynos5433 SoC DTS
 : Remove un-supported properties of arch_timer [by Marc and Mark]
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

Chanwoo Choi (18):
  clk: samsung: exynos5433: Add clocks using common clock framework
  clk: samsung: exynos5433: Add MUX clocks of CMU_TOP domain
  clk: samsung: exynos5433: Add clocks for CMU_PERIC domain
  clk: samsung: exynos5433: Add clocks for CMU_PERIS domain
  clk: samsung: exynos5433: Add clocks for CMU_G2D domain
  clk: samsung: exynos5433: Add clocks for CMU_MIF domain
  clk: samsung: exynos5433: Add clocks for CMU_DISP domain
  clk: samsung: exynos5433: Add clocks for CMU_AUD domain
  clk: samsung: exynos5433: Add clocks for CMU_BUS{0|1|2} domains
  clk: samsung: exynos5433: Add missing clocks for CMU_FSYS domain
  clk: samsung: exynos5433: Add clocks for CMU_G3D domain
  clk: samsung: exynos5433: Add clocks for CMU_GSCL domain
  arm64: exynos5433: Enable ARMv8-based Exynos5433 SoC support
  arm64: dts: exynos: Add dts files for 64-bit Exynos5433 SoC
  arm64: dts: exynos: Add SPI/PDMA dt node for Exynos5433
  serial: samsung: Add the support for Exynos5433 SoC
  clocksource: exynos_mct: Add the support for Exynos 64bit SoC
  arm64: Enable Exynos5433 SoC in the defconfig

Jaehoon Chung (1):
  arm64: dts: exynos: Add MSHC dt node for Exynos5433

 .../devicetree/bindings/clock/exynos5433-clock.txt |  167 +
 arch/arm64/Kconfig                                 |   10 +
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  698 ++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  675 ++++
 arch/arm64/configs/defconfig                       |    1 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos5433.c               | 3369 ++++++++++++++++++++
 drivers/clocksource/Kconfig                        |    1 -
 drivers/clocksource/exynos_mct.c                   |    4 +
 drivers/tty/serial/samsung.c                       |   56 +-
 include/dt-bindings/clock/exynos5433.h             |  843 +++++
 11 files changed, 5804 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5433-clock.txt
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos5433.c
 create mode 100644 include/dt-bindings/clock/exynos5433.h

-- 
1.8.5.5
