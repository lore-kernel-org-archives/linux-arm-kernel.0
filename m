From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 27 Jan 2014 01:08:19 -0500
Subject: [PATCH 4/9] idle: move the cpuidle entry point to the generic idle
 loop
In-Reply-To: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1390802904-28399-5-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to integrate cpuidle with the scheduler, we must have a better
proximity in the core code with what cpuidle is doing and not delegate
such interaction to arch code.

Architectures implementing arch_cpu_idle() should simply enter
a cheap idle mode in the absence of a proper cpuidle driver.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 kernel/cpu/idle.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
index 4e327e211b..a6f40ad9f8 100644
--- a/kernel/cpu/idle.c
+++ b/kernel/cpu/idle.c
@@ -3,6 +3,7 @@
  */
 #include <linux/sched.h>
 #include <linux/cpu.h>
+#include <linux/cpuidle.h>
 #include <linux/tick.h>
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
@@ -94,7 +95,8 @@ static void cpu_idle_loop(void)
 				if (!current_clr_polling_and_test()) {
 					stop_critical_timings();
 					rcu_idle_enter();
-					arch_cpu_idle();
+					if (cpuidle_idle_call())
+						arch_cpu_idle();
 					WARN_ON_ONCE(irqs_disabled());
 					rcu_idle_exit();
 					start_critical_timings();
-- 
1.8.4.108.g55ea5f6
