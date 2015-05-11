From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 May 2015 12:14:24 +0900
Subject: [GIT PULL] ARM: EXYNOS: Improvements for 4.2, second try
Message-ID: <1431314064-17118-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

Updated pull request, replacing also the usage of soc_is_exynos4()
with of_machine_is_compatible(). You requested this in comments
for "ARM: EXYNOS: Fix failed second suspend on Exynos4".

This adds coupled cpuidle for Exynos3250 and improves the Exynos
code in few places. Everything for upcoming 4.2 merge window.
Description along with a tag.

Best regards,
Krzysztof


The following changes since commit b82f3a05ff0b5eaf2c9900eeb34e58a6624db8d9:

  ARM: EXYNOS: Fix failed second suspend on Exynos4 (2015-05-11 11:03:09 +0900)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-for-next-4.2-2

for you to fetch changes up to c91889378098ff0bb5fe6f422a3c0eb554b34930:

  ARM: plat-samsung: Constify platform_device_id (2015-05-11 11:05:31 +0900)

----------------------------------------------------------------
Extending cpuidle driver and improvements for Exynos based boards:
1. Replace soc_is_exynos4() with of_machine_is_compatible().
2. Add missing return-value checks and of_node_put() for power domain
   driver.
3. Fix missing clk_prepare in S3C24XX ADC driver.
4. Rework clock handling when switching power domains on/off. Instead
   of settting fixed parent in DTS we grab the parent clock before
   turning the domain off.
5. Add coupled cpuidle support for Exynos3250 to an existing
   cpuidle-exynos driver. As a result it enables AFTR mode
   (ARM-Off Top-Running) to be used by default on Exynos3250
   without the need to hot unplug CPU1 first.
6. Constify irq_domain_ops and platform_device_id.

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (5):
      ARM: EXYNOS: fix exynos_boot_secondary() return value on timeout
      ARM: EXYNOS: make exynos_core_restart() less verbose
      ARM: EXYNOS: add exynos_set_boot_addr() helper
      ARM: EXYNOS: add exynos_get_boot_addr() helper
      cpuidle: exynos: add coupled cpuidle support for Exynos3250

Krzysztof Kozlowski (8):
      ARM: EXYNOS: Use of_machine_is_compatible instead of soc_is_exynos4
      ARM: EXYNOS: Handle of of_iomap() failure
      ARM: EXYNOS: Handle of_find_device_by_node and kstrdup failures
      ARM: EXYNOS: Add missing of_node_put() when parsing power domains
      ARM: EXYNOS: Get current parent clock for power domain on/off
      ARM: dts: Use last parent for clocks during power domain on/off
      ARM: EXYNOS: Constify irq_domain_ops
      ARM: plat-samsung: Constify platform_device_id

Sergiy Kibrik (1):
      ARM: SAMSUNG: fix clk_enable() WARNing in S3C24XX ADC

 .../bindings/arm/exynos/power_domain.txt           |  7 +-
 arch/arm/boot/dts/exynos5420.dtsi                  | 13 +---
 arch/arm/include/asm/firmware.h                    |  4 +
 arch/arm/mach-exynos/common.h                      |  4 +-
 arch/arm/mach-exynos/exynos.c                      |  5 +-
 arch/arm/mach-exynos/firmware.c                    | 18 +++++
 arch/arm/mach-exynos/platsmp.c                     | 86 +++++++++++++++-------
 arch/arm/mach-exynos/pm.c                          | 51 +++++++++++--
 arch/arm/mach-exynos/pm_domains.c                  | 44 ++++++++---
 arch/arm/mach-exynos/suspend.c                     |  2 +-
 arch/arm/plat-samsung/adc.c                        |  6 +-
 11 files changed, 176 insertions(+), 64 deletions(-)
