From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:14:20 +0530
Subject: [PATCH v6 43/46] tile: Use get/put_online_cpus_atomic() to prevent
 CPU offline
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124419.26245.57077.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Chris Metcalf <cmetcalf@tilera.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/tile/kernel/smp.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/tile/kernel/smp.c b/arch/tile/kernel/smp.c
index cbc73a8..fb30624 100644
--- a/arch/tile/kernel/smp.c
+++ b/arch/tile/kernel/smp.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/smp.h>
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -82,9 +83,12 @@ void send_IPI_many(const struct cpumask *mask, int tag)
 void send_IPI_allbutself(int tag)
 {
 	struct cpumask mask;
+
+	get_online_cpus_atomic();
 	cpumask_copy(&mask, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), &mask);
 	send_IPI_many(&mask, tag);
+	put_online_cpus_atomic();
 }
 
 /*
