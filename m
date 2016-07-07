From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu,  7 Jul 2016 18:10:49 +0100
Subject: [PATCH v8 4/6] cpuidle: introduce CPU_IDLE_ENTER_WRAPPED macro for
 ARM{32, 64}
In-Reply-To: <1467911451-24731-4-git-send-email-sudeep.holla@arm.com>
References: <1467911451-24731-1-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-2-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-3-git-send-email-sudeep.holla@arm.com>
 <1467911451-24731-4-git-send-email-sudeep.holla@arm.com>
Message-ID: <1467911451-24731-5-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function arm_enter_idle_state is exactly the same in both generic
ARM{32,64} CPUIdle driver and will be the same even on ARM64 backend
for ACPI processor idle driver. So we can unify it and move it to a
common place by introducing CPU_IDLE_ENTER_WRAPPED macro that can be
used in all places avoiding duplication.

This is in preparation of reuse of the generic cpuidle entry function
for ACPI LPI support on ARM64.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Suggested-by: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpuidle/cpuidle-arm.c | 26 ++++++--------------------
 include/linux/cpuidle.h       | 18 ++++++++++++++++++
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index e342565e8715..1714d4103623 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -36,26 +36,12 @@
 static int arm_enter_idle_state(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv, int idx)
 {
-	int ret;
-
-	if (!idx) {
-		cpu_do_idle();
-		return idx;
-	}
-
-	ret = cpu_pm_enter();
-	if (!ret) {
-		/*
-		 * Pass idle state index to cpu_suspend which in turn will
-		 * call the CPU ops suspend protocol with idle index as a
-		 * parameter.
-		 */
-		ret = arm_cpuidle_suspend(idx);
-
-		cpu_pm_exit();
-	}
-
-	return ret ? -1 : idx;
+	/*
+	 * Pass idle state index to arm_cpuidle_suspend which in turn
+	 * will call the CPU ops suspend protocol with idle index as a
+	 * parameter.
+	 */
+	return CPU_IDLE_ENTER_WRAPPED(arm_cpuidle_suspend, idx);
 }
 
 static struct cpuidle_driver arm_idle_driver = {
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 07b83d32f66c..5c432c8a9fdd 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -252,4 +252,22 @@ static inline int cpuidle_register_governor(struct cpuidle_governor *gov)
 #define CPUIDLE_DRIVER_STATE_START	0
 #endif
 
+#define CPU_IDLE_ENTER_WRAPPED(low_level_idle_enter, idx)	\
+({								\
+	int __ret;						\
+								\
+	if (!idx) {						\
+		cpu_do_idle();					\
+		return idx;					\
+	}							\
+								\
+	__ret = cpu_pm_enter();					\
+	if (!__ret) {						\
+		__ret = low_level_idle_enter(idx);		\
+		cpu_pm_exit();					\
+	}							\
+								\
+	__ret ? -1 : idx;					\
+})
+
 #endif /* _LINUX_CPUIDLE_H */
-- 
2.7.4
