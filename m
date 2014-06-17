From: thomas.ab@samsung.com (Thomas Abraham)
Date: Tue, 17 Jun 2014 20:55:32 +0530
Subject: [PATCH v6 5/6] ARM: Exynos: switch to using generic cpufreq driver
 for exynos4210/5250
In-Reply-To: <1403018733-4187-1-git-send-email-thomas.ab@samsung.com>
References: <1403018733-4187-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <1403018733-4187-7-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Abraham <thomas.ab@samsung.com>

Remove the platform device instantiation for Exynos4210/5250 cpufreq
driver and add the platform device for generic cpufreq drivers.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 arch/arm/mach-exynos/exynos.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index f38cf7c..cfcfe02 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -181,7 +181,20 @@ void __init exynos_cpuidle_init(void)
 
 void __init exynos_cpufreq_init(void)
 {
-	platform_device_register_simple("exynos-cpufreq", -1, NULL, 0);
+	char *dev_name;
+
+	if (of_machine_is_compatible("samsung,exynos5440"))
+		return;
+	if (of_machine_is_compatible("samsung,exynos5420"))
+		dev_name = "arm-bL-cpufreq-dt";
+	else
+		if (of_machine_is_compatible("samsung,exynos4412") ||
+			of_machine_is_compatible("samsung,exynos4212"))
+			dev_name = "exynos-cpufreq";
+		else
+			dev_name = "cpufreq-cpu0";
+
+	platform_device_register_simple(dev_name, -1, NULL, 0);
 }
 
 void __iomem *sysram_base_addr;
-- 
1.7.9.5
