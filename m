From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Mon, 18 Feb 2013 18:12:54 +0530
Subject: [PATCH v6 33/46] cris/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130218124254.26245.4577.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Mikael Starvik <starvik@axis.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: linux-cris-kernel at axis.com
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/cris/arch-v32/kernel/smp.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/cris/arch-v32/kernel/smp.c b/arch/cris/arch-v32/kernel/smp.c
index 04a16ed..644b358 100644
--- a/arch/cris/arch-v32/kernel/smp.c
+++ b/arch/cris/arch-v32/kernel/smp.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/cpumask.h>
+#include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 
@@ -208,9 +209,12 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *tidle)
 void smp_send_reschedule(int cpu)
 {
 	cpumask_t cpu_mask;
+
+	get_online_cpus_atomic();
 	cpumask_clear(&cpu_mask);
 	cpumask_set_cpu(cpu, &cpu_mask);
 	send_ipi(IPI_SCHEDULE, 0, cpu_mask);
+	put_online_cpus_atomic();
 }
 
 /* TLB flushing
@@ -224,6 +228,7 @@ void flush_tlb_common(struct mm_struct* mm, struct vm_area_struct* vma, unsigned
 	unsigned long flags;
 	cpumask_t cpu_mask;
 
+	get_online_cpus_atomic();
 	spin_lock_irqsave(&tlbstate_lock, flags);
 	cpu_mask = (mm == FLUSH_ALL ? cpu_all_mask : *mm_cpumask(mm));
 	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
@@ -232,6 +237,7 @@ void flush_tlb_common(struct mm_struct* mm, struct vm_area_struct* vma, unsigned
 	flush_addr = addr;
 	send_ipi(IPI_FLUSH_TLB, 1, cpu_mask);
 	spin_unlock_irqrestore(&tlbstate_lock, flags);
+	put_online_cpus_atomic();
 }
 
 void flush_tlb_all(void)
@@ -312,6 +318,7 @@ int smp_call_function(void (*func)(void *info), void *info, int wait)
 	struct call_data_struct data;
 	int ret;
 
+	get_online_cpus_atomic();
 	cpumask_setall(&cpu_mask);
 	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
 
@@ -325,6 +332,7 @@ int smp_call_function(void (*func)(void *info), void *info, int wait)
 	call_data = &data;
 	ret = send_ipi(IPI_CALL, wait, cpu_mask);
 	spin_unlock(&call_lock);
+	put_online_cpus_atomic();
 
 	return ret;
 }
