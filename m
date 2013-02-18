From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:10:18 +0530
Subject: [PATCH v6 15/46] tick: Use get/put_online_cpus_atomic() to prevent
 CPU offline
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124018.26245.34450.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/time/tick-broadcast.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index f113755..d123a2c 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -160,6 +160,7 @@ static void tick_do_broadcast(struct cpumask *mask)
  */
 static void tick_do_periodic_broadcast(void)
 {
+	get_online_cpus_atomic();
 	raw_spin_lock(&tick_broadcast_lock);
 
 	cpumask_and(to_cpumask(tmpmask),
@@ -167,6 +168,7 @@ static void tick_do_periodic_broadcast(void)
 	tick_do_broadcast(to_cpumask(tmpmask));
 
 	raw_spin_unlock(&tick_broadcast_lock);
+	put_online_cpus_atomic();
 }
 
 /*
