From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 14 Nov 2016 20:27:05 +0200
Subject: [PATCH] ARM: Drop fixed 200 Hz timer requirement from Exynos platforms
Message-ID: <1479148025-469-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All Samsung platforms, including the Exynos, are selecting HZ_FIXED with
200 Hz.  Unfortunately in case of multiplatform image this affects also
other platforms when Exynos is selected.

This looks like an very old legacy code, dating back to initial
upstreaming of S3C24xx.  Probably it was required for s3c24xx timer
driver, which was removed in commit ad38bdd15d5b ("ARM: SAMSUNG: Remove
unused plat-samsung/time.c").

Since then, this fixed 200 Hz spread everywhere, including out-of-tree
Samsung kernels (SoC vendor's and Tizen's).  I believe this choice
was rather an effect of coincidence instead of conscious choice.  In
fact Exynos can work with different timers.

Few perf mem and sched tests on Odroid XU3 board (Exynos5422, 4x Cortex
A7, 4x Cortex A15) show no regressions when switching from 200 Hz to
other values.

Reported-by: Lee Jones <lee.jones@linaro.org>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Testing on other Exynos platforms would be appreciated.
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b5d529fdffab..0d10e45f9175 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1497,7 +1497,7 @@ source kernel/Kconfig.preempt
 config HZ_FIXED
 	int
 	default 200 if ARCH_EBSA110 || ARCH_S3C24XX || \
-		ARCH_S5PV210 || ARCH_EXYNOS4
+		ARCH_S5PV210
 	default 128 if SOC_AT91RM9200
 	default 0
 
-- 
2.7.4
