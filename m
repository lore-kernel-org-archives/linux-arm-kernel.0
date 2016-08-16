From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Tue, 16 Aug 2016 15:50:22 -0400
Subject: [PATCH v8 2/4] nmi_backtrace: do a local dump_stack() instead of a
 self-NMI
In-Reply-To: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1471377024-2244-3-git-send-email-cmetcalf@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently on arm there is code that checks whether it should call
dump_stack() explicitly, to avoid trying to raise an NMI when the
current context is not preemptible by the backtrace IPI.  Similarly,
the forthcoming arch/tile support uses an IPI mechanism that does
not support generating an NMI to self.

Accordingly, move the code that guards this case into the generic
mechanism, and invoke it unconditionally whenever we want a
backtrace of the current cpu.  It seems plausible that in all cases,
dump_stack() will generate better information than generating a
stack from the NMI handler.  The register state will be missing,
but that state is likely not particularly helpful in any case.

Or, if we think it is helpful, we should be capturing and emitting
the current register state in all cases when regs == NULL is passed
to nmi_cpu_backtrace().

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
Acked-by: Aaron Tomlin <atomlin@redhat.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 arch/arm/kernel/smp.c | 9 ---------
 lib/nmi_backtrace.c   | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 2a367b2de0e1..173ad30c20e0 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -748,15 +748,6 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	/*
-	 * Generate the backtrace directly if we are running in a calling
-	 * context that is not preemptible by the backtrace IPI. Note
-	 * that nmi_cpu_backtrace() automatically removes the current cpu
-	 * from mask.
-	 */
-	if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
-		nmi_cpu_backtrace(NULL);
-
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index df347e355267..393a3cca1f47 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -49,6 +49,15 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 	if (exclude_self)
 		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
 
+	/*
+	 * Don't try to send an NMI to this cpu; it may work on some
+	 * architectures, but on others it may not, and we'll get
+	 * information at least as useful just by doing a dump_stack() here.
+	 * Note that nmi_cpu_backtrace(NULL) will clear the cpu bit.
+	 */
+	if (cpumask_test_cpu(this_cpu, to_cpumask(backtrace_mask)))
+		nmi_cpu_backtrace(NULL);
+
 	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
 		pr_info("Sending NMI from CPU %d to CPUs %*pbl:\n",
 			this_cpu, nr_cpumask_bits, to_cpumask(backtrace_mask));
-- 
2.7.2
