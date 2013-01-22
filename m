From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Tue, 22 Jan 2013 13:11:26 +0530
Subject: [PATCH v5 31/45] blackfin/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
Message-ID: <20130122074123.13822.39102.stgit@srivatsabhat.in.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Bob Liu <lliubbo@gmail.com>
Cc: Steven Miao <realmz6@gmail.com>
Cc: uclinux-dist-devel at blackfin.uclinux.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/blackfin/mach-common/smp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/blackfin/mach-common/smp.c b/arch/blackfin/mach-common/smp.c
index bb61ae4..6cc6d7a 100644
--- a/arch/blackfin/mach-common/smp.c
+++ b/arch/blackfin/mach-common/smp.c
@@ -194,6 +194,7 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	struct ipi_data *bfin_ipi_data;
 	unsigned long flags;
 
+	get_online_cpus_atomic();
 	local_irq_save(flags);
 	smp_mb();
 	for_each_cpu(cpu, cpumask) {
@@ -205,6 +206,7 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	}
 
 	local_irq_restore(flags);
+	put_online_cpus_atomic();
 }
 
 void arch_send_call_function_single_ipi(int cpu)
@@ -238,13 +240,13 @@ void smp_send_stop(void)
 {
 	cpumask_t callmap;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 	cpumask_copy(&callmap, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), &callmap);
 	if (!cpumask_empty(&callmap))
 		send_ipi(&callmap, BFIN_IPI_CPU_STOP);
 
-	preempt_enable();
+	put_online_cpus_atomic();
 
 	return;
 }
