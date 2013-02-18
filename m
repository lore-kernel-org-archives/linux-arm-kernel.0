From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:10:52 +0530
Subject: [PATCH v6 19/46] irq: Use get/put_online_cpus_atomic() to prevent CPU
 offline
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124052.26245.30164.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 kernel/irq/manage.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index e49a288..b4240b9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
+#include <linux/cpu.h>
 #include <linux/task_work.h>
 
 #include "internals.h"
@@ -202,7 +203,9 @@ int irq_set_affinity(unsigned int irq, const struct cpumask *mask)
 		return -EINVAL;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
+	get_online_cpus_atomic();
 	ret =  __irq_set_affinity_locked(irq_desc_get_irq_data(desc), mask);
+	put_online_cpus_atomic();
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	return ret;
 }
@@ -343,7 +346,9 @@ int irq_select_affinity_usr(unsigned int irq, struct cpumask *mask)
 	int ret;
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
+	get_online_cpus_atomic();
 	ret = setup_affinity(irq, desc, mask);
+	put_online_cpus_atomic();
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 	return ret;
 }
@@ -1126,7 +1131,9 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		}
 
 		/* Set default affinity mask once everything is setup */
+		get_online_cpus_atomic();
 		setup_affinity(irq, desc, mask);
+		put_online_cpus_atomic();
 
 	} else if (new->flags & IRQF_TRIGGER_MASK) {
 		unsigned int nmsk = new->flags & IRQF_TRIGGER_MASK;
