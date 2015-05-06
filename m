From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 May 2015 11:19:08 +0900
Subject: [GIT PULL] ARM: EXYNOS: Improvements for 4.2, try 2
Message-ID: <1430878748-30149-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

Updated pull request. The first one contained an older version
of my patch.

This adds coupled cpuidle for Exynos3250 and improves the Exynos
code in few places. Everything for upcoming 4.2 merge window.
Description along with a tag.

Best regards,
Krzysztof

----------------------------------------------------------------
The following changes since commit 5ebe6afaf0057ac3eaeb98defd5456894b446d22:

  Linux 4.1-rc2 (2015-05-03 19:22:23 -0700)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-for-next-4.2

for you to fetch changes up to 182be665abb95fcddd656355ae6208d02533b6b9:

  ARM: plat-samsung: Constify platform_device_id (2015-05-06 11:05:43 +0900)

----------------------------------------------------------------
Extending cpuidle driver and improvements for Exynos based boards:
1. Add missing return-value checks and of_node_put() for power domain
   driver.
2. Fix missing clk_prepare in S3C24XX ADC driver.
3. Rework clock handling when switching power domains on/off. Instead
   of settting fixed parent in DTS we grab the parent clock before
   turning the domain off.
4. Add coupled cpuidle support for Exynos3250 to an existing
   cpuidle-exynos driver. As a result it enables AFTR mode
   (ARM-Off Top-Running) to be used by default on Exynos3250
   without the need to hot unplug CPU1 first.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (5):
      ARM: EXYNOS: fix exynos_boot_secondary() return value on timeout
      ARM: EXYNOS: make exynos_core_restart() less verbose
      ARM: EXYNOS: add exynos_set_boot_addr() helper
      ARM: EXYNOS: add exynos_get_boot_addr() helper
      cpuidle: exynos: add coupled cpuidle support for Exynos3250

Krzysztof Kozlowski (8):
      ARM: EXYNOS: Fix failed second suspend on Exynos4
      ARM: EXYNOS: Handle of of_iomap() failure
      ARM: EXYNOS: Handle of_find_device_by_node and kstrdup failures
      ARM: EXYNOS: Add missing of_node_put() when parsing power domains
      ARM: EXYNOS: Get current parent clock for power domain on/off
      ARM: dts: Use last parent for clocks during power domain on/off
      ARM: EXYNOS: Constify irq_domain_ops
      ARM: plat-samsung: Constify platform_device_id

Sergiy Kibrik (1):
      ARM: SAMSUNG: fix clk_enable() WARNing in S3C24XX ADC

 .../bindings/arm/exynos/power_domain.txt           |   7 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  13 +--
 arch/arm/include/asm/firmware.h                    |   4 +
 arch/arm/mach-exynos/common.h                      |   6 +-
 arch/arm/mach-exynos/exynos.c                      |  30 ++++-
 arch/arm/mach-exynos/firmware.c                    |  18 +++
 arch/arm/mach-exynos/platsmp.c                     | 123 ++++++++++-----------
 arch/arm/mach-exynos/pm.c                          |  51 +++++++--
 arch/arm/mach-exynos/pm_domains.c                  |  44 ++++++--
 arch/arm/mach-exynos/suspend.c                     |   5 +-
 arch/arm/plat-samsung/adc.c                        |   6 +-
 11 files changed, 208 insertions(+), 99 deletions(-)
