From: will.deacon@arm.com (Will Deacon)
Date: Thu, 9 Feb 2012 22:48:30 +0000
Subject: [PATCH v6 13/15] ARM: hotplug: Introduce dummy_cpu_kill
In-Reply-To: <20120209084642.GO889@n2100.arm.linux.org.uk>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
 <1328661059-24584-14-git-send-email-marc.zyngier@arm.com>
 <alpine.LFD.2.02.1202081608100.1656@xanadu.home>
 <20120209084642.GO889@n2100.arm.linux.org.uk>
Message-ID: <20120209224830.GB5789@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2012 at 08:46:42AM +0000, Russell King - ARM Linux wrote:
> I'm not sure that the call to platform_cpu_kill() in ipi_cpu_stop() is
> correct - platform_cpu_kill() is supposed to run on a CPU which is not
> the one going down, whereas platform_cpu_die() runs on the CPU which
> is going down.

I added that call for the kexec down path, where we re-use the hotplug
code to kill a CPU and put it into a state where the new kernel can boot
it via the usual SMP bringup path.

If we need to ensure that the code runs on the CPU making the kexec then
we need to hack smp_send_stop to make the callback for each CPU that was
offlined (untested patch below). The only alternative I can think of is
to add a platform callback from machine_kexec before we tear down the
final processor but this precludes any reuse of the hotplug code.

Will

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
