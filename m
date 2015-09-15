From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 15 Sep 2015 12:05:12 +0100
Subject: [PATCH v2] arm: Fix backtrace generation when IPI is masked
In-Reply-To: <1442222294-2756-1-git-send-email-daniel.thompson@linaro.org>
References: <1442222294-2756-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1442315112-14039-1-git-send-email-daniel.thompson@linaro.org>
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
    Changes in v2:
    
    * Improved commit message to better describe the changes to the generic
      code (Hillf Danton).

 arch/arm/kernel/smp.c | 7 +++++++
 lib/nmi_backtrace.c   | 5 ++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48185a773852..4d8a80328c74 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -748,6 +748,13 @@ core_initcall(register_cpufreq_notifier);

 static void raise_nmi(cpumask_t *mask)
 {
+	/*
+	 * Generate the backtrace directly if we are running in a
+	 * calling context that is not preemptible by the backtrace IPI.
+	 */
+	if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
+		nmi_cpu_backtrace(NULL);
+
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }

diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 88d3d32e5923..be0466a80d0b 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -149,7 +149,10 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
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
