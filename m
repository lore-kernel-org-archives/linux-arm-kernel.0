From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 22 Jan 2013 13:08:42 +0530
Subject: [PATCH v5 20/45] block: Use get/put_online_cpus_atomic() to prevent
 CPU offline
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130122073838.13822.28777.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 block/blk-softirq.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 467c8de..448f9a9 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -58,6 +58,8 @@ static void trigger_softirq(void *data)
  */
 static int raise_blk_irq(int cpu, struct request *rq)
 {
+	get_online_cpus_atomic();
+
 	if (cpu_online(cpu)) {
 		struct call_single_data *data = &rq->csd;
 
@@ -66,9 +68,11 @@ static int raise_blk_irq(int cpu, struct request *rq)
 		data->flags = 0;
 
 		__smp_call_function_single(cpu, data, 0);
+		put_online_cpus_atomic();
 		return 0;
 	}
 
+	put_online_cpus_atomic();
 	return 1;
 }
 #else /* CONFIG_SMP && CONFIG_USE_GENERIC_SMP_HELPERS */
