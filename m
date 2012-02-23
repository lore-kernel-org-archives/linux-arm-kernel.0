From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Feb 2012 15:19:59 +0000
Subject: [RFC PATCH] ARM: kexec: call platform_cpu_kill on the killer rather
 than the victim
Message-ID: <1330010399-1541-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When performing a kexec on an SMP system, the secondary cores are stopped
by calling machine_shutdown(), which in turn issues IPIs to offline the
other CPUs. Unfortunately, this isn't enough to reboot the cores into
a new kernel (since they are just executing a cpu_relax loop somewhere
in memory) so we make use of platform_cpu_kill, part of the CPU hotplug
implementation, to place the cores somewhere safe. This function expects
to be called on the killing CPU for each core that it takes out.

This patch moves the platform_cpu_kill callback out of the IPI handler
and into smp_send_stop, therefore ensuring that it executes on the
killing CPU rather than on the victim, matching what the hotplug code
requires.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/smp.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index cdeb727..3d279f7 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -506,10 +506,6 @@ static void ipi_cpu_stop(unsigned int cpu)
 	local_fiq_disable();
 	local_irq_disable();
 
-#ifdef CONFIG_HOTPLUG_CPU
-	platform_cpu_kill(cpu);
-#endif
-
 	while (1)
 		cpu_relax();
 }
@@ -572,16 +568,25 @@ void smp_send_reschedule(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void smp_kill_cpus(cpumask_t *mask)
+{
+	unsigned int cpu;
+	for_each_cpu(cpu, mask)
+		platform_cpu_kill(cpu);
+}
+#else
+static void smp_kill_cpus(cpumask_t *mask) { }
+#endif
+
 void smp_send_stop(void)
 {
 	unsigned long timeout;
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
 
-	if (num_online_cpus() > 1) {
-		cpumask_t mask = cpu_online_map;
-		cpu_clear(smp_processor_id(), mask);
-
+	if (num_online_cpus() > 1)
 		smp_cross_call(&mask, IPI_CPU_STOP);
-	}
 
 	/* Wait up to one second for other CPUs to stop */
 	timeout = USEC_PER_SEC;
@@ -590,6 +595,8 @@ void smp_send_stop(void)
 
 	if (num_online_cpus() > 1)
 		pr_warning("SMP: failed to stop secondary CPUs\n");
+
+	smp_kill_cpus(&mask);
 }
 
 /*
-- 
1.7.4.1
