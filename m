From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:36 +0200
Subject: [PATCH V4 05/20] ARM: exynos: cpuidle: Move some code inside the
 idle_finisher
In-Reply-To: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397123751-1957-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the code around to differentiate different section of code and prepare it
to be factored out in the next patches.

The call order changed but hat doesn't have a side effect because they are
independent. The important call is cpu_do_idle() which must be done the last.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/cpuidle.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 16e3325..cdfb1ae 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -87,7 +87,16 @@ static void restore_cpu_arch_register(void)
 
 static int idle_finisher(unsigned long flags)
 {
+	exynos_set_wakeupmask();
+
+	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
+	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
+
+	/* Set value of power down register for aftr mode */
+	exynos_sys_powerdown_conf(SYS_AFTR);
+
 	cpu_do_idle();
+
 	return 1;
 }
 
@@ -97,14 +106,6 @@ static int exynos_enter_core0_aftr(struct cpuidle_device *dev,
 {
 	unsigned long tmp;
 
-	exynos_set_wakeupmask();
-
-	/* Set value of power down register for aftr mode */
-	exynos_sys_powerdown_conf(SYS_AFTR);
-
-	__raw_writel(virt_to_phys(exynos_cpu_resume), REG_DIRECTGO_ADDR);
-	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
-
 	save_cpu_arch_register();
 
 	/* Setting Central Sequence Register for power down mode */
-- 
1.7.9.5
