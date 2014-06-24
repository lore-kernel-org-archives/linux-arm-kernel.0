From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Jun 2014 15:57:15 +0200
Subject: [PATCH 6/6] ARM: EXYNOS: Register cpuidle device only on Exynos4210
 and 5250
In-Reply-To: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
Message-ID: <1403618235-19353-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the Exynos cpuidle driver works correctly only on Exynos4210
and 5250. Trying to use it with just one CPU online on any other Exynos
SoC will lead to system failure, due to unsupported AFTR mode on other
SoCs. This patch fixes the problem by registering the driver only on
supported SoCs and letting others simply use default WFI mode until
support for them is added.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index f38cf7c..176bbf5 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -173,10 +173,8 @@ static struct platform_device exynos_cpuidle = {
 
 void __init exynos_cpuidle_init(void)
 {
-	if (soc_is_exynos5440())
-		return;
-
-	platform_device_register(&exynos_cpuidle);
+	if (soc_is_exynos4210() || soc_is_exynos5250())
+		platform_device_register(&exynos_cpuidle);
 }
 
 void __init exynos_cpufreq_init(void)
-- 
1.9.3
