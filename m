From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 16 Jun 2016 23:27:18 +0200
Subject: [PATCH V2 59/63] clocksource/drivers/smp_twd: Convert init function
 to return error
In-Reply-To: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1466112442-31105-60-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/kernel/smp_twd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 1bfa7a7..2b24be4 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -390,7 +390,7 @@ int __init twd_local_timer_register(struct twd_local_timer *tlt)
 }
 
 #ifdef CONFIG_OF
-static void __init twd_local_timer_of_register(struct device_node *np)
+static int __init twd_local_timer_of_register(struct device_node *np)
 {
 	int err;
 
@@ -410,8 +410,9 @@ static void __init twd_local_timer_of_register(struct device_node *np)
 
 out:
 	WARN(err, "twd_local_timer_of_register failed (%d)\n", err);
+	return err;
 }
-CLOCKSOURCE_OF_DECLARE(arm_twd_a9, "arm,cortex-a9-twd-timer", twd_local_timer_of_register);
-CLOCKSOURCE_OF_DECLARE(arm_twd_a5, "arm,cortex-a5-twd-timer", twd_local_timer_of_register);
-CLOCKSOURCE_OF_DECLARE(arm_twd_11mp, "arm,arm11mp-twd-timer", twd_local_timer_of_register);
+CLOCKSOURCE_OF_DECLARE_RET(arm_twd_a9, "arm,cortex-a9-twd-timer", twd_local_timer_of_register);
+CLOCKSOURCE_OF_DECLARE_RET(arm_twd_a5, "arm,cortex-a5-twd-timer", twd_local_timer_of_register);
+CLOCKSOURCE_OF_DECLARE_RET(arm_twd_11mp, "arm,arm11mp-twd-timer", twd_local_timer_of_register);
 #endif
-- 
1.9.1
