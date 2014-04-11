From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 12:40:07 +0200
Subject: [PATCH V5 12/20] ARM: exynos: cpuidle: Encapsulate boot vector code
 into a function
In-Reply-To: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397212815-16068-13-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 169db74..f66ee4d 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -45,13 +45,16 @@ static void exynos_set_wakeupmask(long mask)
 	__raw_writel(mask, S5P_WAKEUP_MASK);
 }
 
+static void exynos_cpu_set_boot_vector(long flags)
+{
+	__raw_writel(virt_to_phys(exynos_cpu_resume), REG_DIRECTGO_ADDR);
+	__raw_writel(flags, REG_DIRECTGO_FLAG);
+}
+
 static int idle_finisher(unsigned long flags)
 {
 	exynos_set_wakeupmask(0x0000ff3e);
-
-	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
-	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
-
+	exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
 
-- 
1.7.9.5
