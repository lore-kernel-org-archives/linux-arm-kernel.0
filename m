From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 16 Feb 2015 14:36:42 +0100
Subject: [PATCH] ARM: EXYNOS: Don't use LDREX and STREX after disabling cache
 coherency
Message-ID: <1424093802-5488-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During CPU shutdown the exynos_cpu_power_down() is called after
disabling cache coherency and it uses LDREX and STREX instructions (by
calling of_machine_is_compatible() -> kobject_get() -> kref_get()).

The LDREX and STREX should not be used after disabling the cache
coherency so just use soc_is_exynos().

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Fixes: adc548d77c22 ("ARM: EXYNOS: Use MCPM call-backs to support S2R on exynos5420")
Cc: <stable@vger.kernel.org>
Reported-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-exynos/platsmp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/platsmp.c b/arch/arm/mach-exynos/platsmp.c
index 7a1ebfeeeeb8..0abb7dff73ab 100644
--- a/arch/arm/mach-exynos/platsmp.c
+++ b/arch/arm/mach-exynos/platsmp.c
@@ -126,8 +126,7 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
  */
 void exynos_cpu_power_down(int cpu)
 {
-	if (cpu == 0 && (of_machine_is_compatible("samsung,exynos5420") ||
-		of_machine_is_compatible("samsung,exynos5800"))) {
+	if (cpu == 0 && (soc_is_exynos5420() || soc_is_exynos5800())) {
 		/*
 		 * Bypass power down for CPU0 during suspend. Check for
 		 * the SYS_PWR_REG value to decide if we are suspending
-- 
1.9.1
