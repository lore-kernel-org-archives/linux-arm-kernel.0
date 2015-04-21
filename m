From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 21 Apr 2015 17:49:02 +0200
Subject: [PATCH v2 5/8] ARM: Exynos: use generic cpufreq driver for Exynos5420
In-Reply-To: <1429631345-16409-1-git-send-email-b.zolnierkie@samsung.com>
References: <1429631345-16409-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1429631345-16409-6-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

The new CPU clock type allows the use of generic arm_big_little_dt
cpufreq driver for Exynos5420.

Changes by Bartlomiej:
- split Exynos5420 support from the original patch
- disable cpufreq if big.LITTLE switcher support is enabled

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 4b03a32..11ac7fb 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -207,6 +207,13 @@ struct cpufreq_dt_platform_data cpufreq_dt_pd = {
 static const struct of_device_id exynos_cpufreq_matches[] = {
 	{ .compatible = "samsung,exynos4210", .data = "cpufreq-dt" },
 	{ .compatible = "samsung,exynos5250", .data = "cpufreq-dt" },
+/*
+ * FIXME: When big.LITTLE switcher is enabled system lockups during
+ * ondemand governor stress testing (observed on ODROID-XU3 board).
+ */
+#ifndef CONFIG_BL_SWITCHER
+	{ .compatible = "samsung,exynos5420", .data = "arm-bL-cpufreq-dt" },
+#endif
 	{ /* sentinel */ }
 };
 
-- 
1.7.9.5
