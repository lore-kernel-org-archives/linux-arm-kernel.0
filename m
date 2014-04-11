From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 12:40:06 +0200
Subject: [PATCH V5 11/20] ARM: exynos: cpuidle: Pass wakeup mask parameter to
 function
In-Reply-To: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397212815-16068-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397212815-16068-12-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the wakeup mask to 'exynos_set_wakeupmask' as this function could be used
for different idle states with different mask.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 95826c6..169db74 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -40,14 +40,14 @@
 #define S5P_CHECK_AFTR		0xFCBA0D10
 
 /* Ext-GIC nIRQ/nFIQ is the only wakeup source in AFTR */
-static void exynos_set_wakeupmask(void)
+static void exynos_set_wakeupmask(long mask)
 {
-	__raw_writel(0x0000ff3e, S5P_WAKEUP_MASK);
+	__raw_writel(mask, S5P_WAKEUP_MASK);
 }
 
 static int idle_finisher(unsigned long flags)
 {
-	exynos_set_wakeupmask();
+	exynos_set_wakeupmask(0x0000ff3e);
 
 	__raw_writel(virt_to_phys(s3c_cpu_resume), REG_DIRECTGO_ADDR);
 	__raw_writel(S5P_CHECK_AFTR, REG_DIRECTGO_FLAG);
-- 
1.7.9.5
