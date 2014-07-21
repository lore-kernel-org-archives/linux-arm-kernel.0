From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 21 Jul 2014 10:36:10 +0200
Subject: [PATCH 2/3] ARM: EXYNOS: Enable cpuidle in WFI on all SoCs
In-Reply-To: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
References: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1405931771-24100-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add cpuidle device for each SoC but set AFTR enter function only on
supported ones (for now these are only Exynos4210 and Exynos5250). For
other chipsets use only WFI.

This actually does not give any special energy-saving benefits but
allows to track the idle time of each core.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/mach-exynos/exynos.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 2a43a1734eca..4109d592f6fc 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -171,14 +171,20 @@ static void exynos_restart(enum reboot_mode mode, const char *cmd)
 
 static struct platform_device exynos_cpuidle = {
 	.name              = "exynos_cpuidle",
-	.dev.platform_data = exynos_enter_aftr,
+	/*
+	 * Currently AFTR is not implemented for each SoC.
+	 * Set this to exynos_enter_aftr() only for supported SoCs.
+	 */
+	.dev.platform_data = NULL,
 	.id                = -1,
 };
 
 void __init exynos_cpuidle_init(void)
 {
 	if (soc_is_exynos4210() || soc_is_exynos5250())
-		platform_device_register(&exynos_cpuidle);
+		exynos_cpuidle.dev.platform_data = exynos_enter_aftr;
+
+	platform_device_register(&exynos_cpuidle);
 }
 
 void __init exynos_cpufreq_init(void)
-- 
1.9.1
