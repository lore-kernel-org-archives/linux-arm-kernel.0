From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed,  3 Apr 2013 14:15:19 +0200
Subject: [PATCH 6/9] ARM: davinci: cpuidle: fix wrong enter function
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1364991322-20585-6-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The davinci_enter_idle is called from the cpuidle with the
cpuidle_wrap_enter function. This one does the time compution
for entering and exiting the idle function and then we call
again cpuidle_wrap_enter for cpu_do_idle. This is wrong, we
are calling recursively cpuidle_wrap_enter for nothing and
furthermore reenabling the local irq.

Remove this and replace it by the cpu_do_idle function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-davinci/cpuidle.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 5ac9e93..22d6d4a 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -50,14 +50,10 @@ static void davinci_save_ddr_power(int enter, bool pdown)
 
 /* Actual code that puts the SoC in different idle states */
 static int davinci_enter_idle(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv,
-						int index)
+			      struct cpuidle_driver *drv, int index)
 {
 	davinci_save_ddr_power(1, ddr2_pdown);
-
-	index = cpuidle_wrap_enter(dev,	drv, index,
-				arm_cpuidle_simple_enter);
-
+	cpu_do_idle();
 	davinci_save_ddr_power(0, ddr2_pdown);
 
 	return index;
-- 
1.7.9.5
