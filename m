From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 24 Mar 2015 12:33:53 +0100
Subject: [PATCH] cpufreq: exynos: allow build for !THERMAL or !CPU_THERMAL
 cases
Message-ID: <2205924.4OPTnU534j@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow driver build for !THERMAL or !CPU_THERMAL cases.

The new dependency rule is the same as the one that CPUFREQ_DT
option has (for cpufreq-dt driver which has the same issue with
using of_cpufreq_cooling_register()).

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Fixes: 8b2b4a4e5366 ("cpufreq: exynos: allow modular build")
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
Hi Rafael, please apply this patch.  It has been ACKed by Viresh already.

 drivers/cpufreq/Kconfig.arm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1b06fc4..f4df4af3 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -28,7 +28,8 @@ config ARM_VEXPRESS_SPC_CPUFREQ
 config ARM_EXYNOS_CPUFREQ
 	tristate "SAMSUNG EXYNOS CPUfreq Driver"
 	depends on CPU_EXYNOS4210 || SOC_EXYNOS4212 || SOC_EXYNOS4412 || SOC_EXYNOS5250
-	depends on THERMAL
+	# if CPU_THERMAL is on and THERMAL=m, ARM_EXYNOS_CPUFREQ cannot be =y:
+	depends on !CPU_THERMAL || THERMAL
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS platforms.
 	  Supported SoC versions are:
-- 
1.8.2.3
