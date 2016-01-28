From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 28 Jan 2016 09:35:21 +0900
Subject: [PATCH v4 0/3] arm64/clk: EXYNOS: Consolidate Exynos7 symbol
Message-ID: <1453941324-15742-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Patchset attempts to remove the ARCH_EXYNOS7 symbol.

All patches depend on previous ones so no cherry-picked.
I was thinking about merging this through arm-soc tree after getting
needed acks (clk, arm-soc?).


Changes since v3:
=================
1. Rebase on next-20160127 (s3c64xx became multiplatform).

Changes since v2:
=================
1. Follow Arnd's advice about not enabling silently the newly added
   EXYNOS_ARM64_COMMON_CLK, when COMPILE_TEST is enabled. This was
   also a trigger for some changes in placement of Samsung clocks
   Kconfig entries...
2. ... which lead to introducing patch 1.


Logic:
======
Now the clock selection algorithm works like:
1. For Exynos ARMv7 and ARMv8 the platforms select COMMON_CLK
   and COMMON_CLK_SAMSUNG.
2. As before: clock drivers for Exynos ARMv7 will be selected by
   respective SOC/ARCH_EXYNOS_XXX symbol.
3. For Exynos ARMv8 the clock drivers will be enabled by default
   by EXYNOS_ARM64_COMMON_CLK symbol.

Rationale:
==========
We don't need ARCH_EXYNOS7 symbol because all ARMv8 platforms should
fall under generic ARCH_EXYNOS. In the same time there is no sense
in building clocks for these ARMv8 SoCs on ARMv7 builds.


Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  clk: samsung: Enable COMPILE_TEST for Samsung clocks
  clk: samsung: Don't build ARMv8 clock drivers on ARMv7
  arm64: EXYNOS: Consolidate ARCH_EXYNOS7 symbol into ARCH_EXYNOS

 arch/arm/mach-exynos/Kconfig        |  1 +
 arch/arm/mach-s3c24xx/Kconfig       |  8 ++++++++
 arch/arm/mach-s3c64xx/Kconfig       |  1 +
 arch/arm/mach-s5pv210/Kconfig       |  1 +
 arch/arm64/Kconfig.platforms        | 12 +++---------
 arch/arm64/boot/dts/exynos/Makefile |  2 +-
 arch/arm64/configs/defconfig        |  2 +-
 drivers/clk/Kconfig                 |  2 +-
 drivers/clk/samsung/Kconfig         | 14 +++++++++-----
 drivers/clk/samsung/Makefile        |  4 ++--
 10 files changed, 28 insertions(+), 19 deletions(-)

-- 
1.9.1
