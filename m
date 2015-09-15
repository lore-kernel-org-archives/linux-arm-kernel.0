From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 15 Sep 2015 15:40:05 +0100
Subject: [PATCH v3] arm: Fix backtrace generation when IPI is masked
In-Reply-To: <1442222294-2756-1-git-send-email-daniel.thompson@linaro.org>
References: <1442222294-2756-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1442328005-13661-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently on ARM when <SysRq-L> is triggered from an interrupt handler
(e.g. a SysRq issued using UART or kbd) the main CPU will wedge for ten
seconds with interrupts masked before issuing a backtrace for every CPU
except itself.

The new backtrace code introduced by commit 96f0e00378d4 ("ARM: add
basic support for on-demand backtrace of other CPUs") does not work
correctly when run from an interrupt handler because IPI_CPU_BACKTRACE
is used to generate the backtrace on all CPUs but cannot preempt the
current calling context.

This can be fixed by detecting that the calling context cannot be
preempted and issuing the backtrace directly in this case. Issuing
directly leaves us without any pt_regs to pass to nmi_cpu_backtrace()
so we also modify the generic code to call dump_stack() when its
argument is NULL.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    Changes in v3:
    
    * Added comments to describe how raise_nmi() and nmi_cpu_backtrace()
      interact with backtrace_mask (Russell King).
    
    Changes in v2:
    
    * Improved commit message to better describe the changes to the generic
      code (Hillf Danton).

 arch/arm/kernel/smp.c |  9 +++++++++
 lib/nmi_backtrace.c   | 11 ++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48185a773852..0c4e7fdb9636 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -748,6 +748,15 @@ core_initcall(register_cpufreq_notifier);

 static void raise_nmi(cpumask_t *mask)
 {
+	/*
+	 * Generate the backtrace directly if we are running in a calling
+	 * context that is not preemptible by the backtrace IPI. Note
+	 * that nmi_cpu_backtrace() automatically removes the current cpu
+	 * from mask.
+	 */
+	if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
+		nmi_cpu_backtrace(NULL);
+
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }

diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 88d3d32e5923..6019c53c669e 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -43,6 +43,12 @@ static void print_seq_line(struct nmi_seq_buf *s, int start, int end)
 	printk("%.*s", (end - start) + 1, buf);
 }

+/*
+ * When raise() is called it will be is passed a pointer to the
+ * backtrace_mask. Architectures that call nmi_cpu_backtrace()
+ * directly from their raise() functions may rely on the mask
+ * they are passed being updated as a side effect of this call.
+ */
 void nmi_trigger_all_cpu_backtrace(bool include_self,
 				   void (*raise)(cpumask_t *mask))
 {
@@ -149,7 +155,10 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 		/* Replace printk to write into the NMI seq */
 		this_cpu_write(printk_func, nmi_vprintk);
 		pr_warn("NMI backtrace for cpu %d\n", cpu);
-		show_regs(regs);
+		if (regs)
+			show_regs(regs);
+		else
+			dump_stack();
 		this_cpu_write(printk_func, printk_func_save);

 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
--
2.4.3
