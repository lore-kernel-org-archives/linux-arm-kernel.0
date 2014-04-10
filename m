From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:42 +0200
Subject: [PATCH V4 11/20] ARM: exynos: cpuidle: Pass wakeup mask parameter to
 function
In-Reply-To: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397123751-1957-12-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the wakeup mask to 'exynos_set_wakeupmask' as this function could be used
for different idle states with different mask.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index 97a441f..ddbb2c5 100644
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
