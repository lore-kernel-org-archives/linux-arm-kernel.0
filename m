From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 10 Apr 2014 11:55:45 +0200
Subject: [PATCH V4 14/20] ARM: exynos: cpuidle: Encapsulate the AFTR code into
 a function
In-Reply-To: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1397123751-1957-15-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let's encapsulate the AFTR state specific call into a single function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-exynos/cpuidle.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-exynos/cpuidle.c
index d7091e0..0d3c839 100644
--- a/arch/arm/mach-exynos/cpuidle.c
+++ b/arch/arm/mach-exynos/cpuidle.c
@@ -51,13 +51,17 @@ static void exynos_cpu_set_boot_vector(long flags)
 	__raw_writel(flags, REG_DIRECTGO_FLAG);
 }
 
-static int idle_finisher(unsigned long flags)
+static void exynos_enter_aftr(void)
 {
 	exynos_set_wakeupmask(0x0000ff3e);
 	exynos_cpu_set_boot_vector(S5P_CHECK_AFTR);
 	/* Set value of power down register for aftr mode */
 	exynos_sys_powerdown_conf(SYS_AFTR);
+}
 
+static int idle_finisher(unsigned long flags)
+{
+	exynos_enter_aftr();
 	cpu_do_idle();
 
 	return 1;
-- 
1.7.9.5
