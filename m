From: rob.lee@linaro.org (Robert Lee)
Date: Wed, 29 Feb 2012 18:42:58 -0600
Subject: [PATCH v7 9/9] SH: shmobile: Consolidate time keeping and irq enable
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1330562578-3410-10-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable core cpuidle timekeeping and irq enabling and remove that
handling from this code.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 6d62eb4..1ddc876 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -29,7 +29,6 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
 				int index)
 {
 	unsigned long allowed_mode = SUSP_SH_SLEEP;
-	ktime_t before, after;
 	int requested_state = index;
 	int allowed_state;
 	int k;
@@ -47,19 +46,16 @@ static int cpuidle_sleep_enter(struct cpuidle_device *dev,
 	 */
 	k = min_t(int, allowed_state, requested_state);
 
-	before = ktime_get();
 	sh_mobile_call_standby(cpuidle_mode[k]);
-	after = ktime_get();
-
-	dev->last_residency = (int)ktime_to_ns(ktime_sub(after, before)) >> 10;
 
 	return k;
 }
 
 static struct cpuidle_device cpuidle_dev;
 static struct cpuidle_driver cpuidle_driver = {
-	.name =		"sh_idle",
-	.owner =	THIS_MODULE,
+	.name			= "sh_idle",
+	.owner			= THIS_MODULE,
+	.en_core_tk_irqen	= 1,
 };
 
 void sh_mobile_setup_cpuidle(void)
-- 
1.7.1
