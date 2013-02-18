From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:10:13 +0530
Subject: [PATCH v6 14/46] sched/rt: Use get/put_online_cpus_atomic() to
 prevent CPU offline
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124012.26245.44243.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/sched/rt.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4f02b28..e546c98 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -6,6 +6,7 @@
 #include "sched.h"
 
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
 
@@ -26,7 +27,9 @@ static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
 		if (!overrun)
 			break;
 
+		get_online_cpus_atomic();
 		idle = do_sched_rt_period_timer(rt_b, overrun);
+		put_online_cpus_atomic();
 	}
 
 	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
