From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 16 Sep 2013 15:43:49 -0700
Subject: [PATCH 2/2] sched/nohz: fix overflow error in
 scheduler_tick_max_deferment()
In-Reply-To: <1379371429-22214-1-git-send-email-khilman@linaro.org>
References: <1379371429-22214-1-git-send-email-khilman@linaro.org>
Message-ID: <1379371429-22214-2-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The conversion of the max deferment from usecs to nsecs can easily
overflow on platforms where a long is 32-bits.  To fix, cast the usecs
value to u64 before multiplying by NSECS_PER_USEC.

This was discovered on 32-bit ARM platform when extending the max
deferment value.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4b1fe3e..3d7c80e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2203,7 +2203,7 @@ u64 scheduler_tick_max_deferment(void)
 	if (time_before_eq(next, now))
 		return 0;
 
-	return jiffies_to_usecs(next - now) * NSEC_PER_USEC;
+	return (u64)jiffies_to_usecs(next - now) * NSEC_PER_USEC;
 }
 
 static __init int sched_nohz_full_init_debug(void)
-- 
1.8.3
