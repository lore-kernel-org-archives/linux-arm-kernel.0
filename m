From: james.morse@arm.com (James Morse)
Date: Tue, 26 Apr 2016 12:15:01 +0100
Subject: [PATCH] ARM: cpuidle: Pass on arm_cpuidle_suspend()'s return value
Message-ID: <1461669301-30834-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm_cpuidle_suspend() may return -EOPNOTSUPP, or any value returned
by the cpu_ops/cpuidle_ops suspend call. arm_enter_idle_state() doesn't
update 'ret' with this value, meaning we always signal success to
cpuidle_enter_state(), causing it to update the usage counters as if we
succeeded.

Fixes: 191de17aa3c1 ("ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function")
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/cpuidle/cpuidle-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
index 545069d5fdfb..e342565e8715 100644
--- a/drivers/cpuidle/cpuidle-arm.c
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -50,7 +50,7 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
 		 * call the CPU ops suspend protocol with idle index as a
 		 * parameter.
 		 */
-		arm_cpuidle_suspend(idx);
+		ret = arm_cpuidle_suspend(idx);
 
 		cpu_pm_exit();
 	}
-- 
2.8.0.rc3
