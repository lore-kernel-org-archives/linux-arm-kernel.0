From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Wed, 30 Mar 2016 13:16:08 -0400
Subject: [PATCH v4 2/4] nmi_backtrace: do a local dump_stack() instead of a
 self-NMI
In-Reply-To: <1459358170-27745-1-git-send-email-cmetcalf@mellanox.com>
References: <1459358170-27745-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1459358170-27745-3-git-send-email-cmetcalf@mellanox.com>
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
---
 arch/arm/kernel/smp.c | 9 ---------
 lib/nmi_backtrace.c   | 9 +++++++++
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 72ad8485993a..07223f2a3ee0 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -746,15 +746,6 @@ core_initcall(register_cpufreq_notifier);
 
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
index db63ac75eba0..9375c0279b73 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -76,6 +76,15 @@ void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 		seq_buf_init(&s->seq, s->buffer, NMI_BUF_SIZE);
 	}
 
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
