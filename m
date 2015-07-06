From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  6 Jul 2015 14:13:57 +0100
Subject: [PATCH 4.2-rc1 v21 5/6] x86/nmi: Use common printk functions
In-Reply-To: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
References: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1436188438-9478-6-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Much of the code sitting in arch/x86/kernel/apic/hw_nmi.c to support safe
all-cpu backtracing from NMI has been copied to printk.c to make it
accessible to other architectures.

Port the x86 NMI backtrace to the generic code.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org
---
 arch/x86/Kconfig              |   1 +
 arch/x86/kernel/apic/hw_nmi.c | 104 ++++--------------------------------------
 2 files changed, 10 insertions(+), 95 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 55bced17dc95..efc3510a3930 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -149,6 +149,7 @@ config X86
 	select VIRT_TO_BUS
 	select X86_DEV_DMA_OPS			if X86_64
 	select X86_FEATURE_NAMES		if PROC_FS
+	select PRINTK_NMI_BACKTRACE if X86_LOCAL_APIC
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 6873ab925d00..7a682beac3a0 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -30,40 +30,17 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 #ifdef arch_trigger_all_cpu_backtrace
 /* For reliability, we're prepared to waste bits here. */
 static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
-static cpumask_t printtrace_mask;
-
-#define NMI_BUF_SIZE		4096
-
-struct nmi_seq_buf {
-	unsigned char		buffer[NMI_BUF_SIZE];
-	struct seq_buf		seq;
-};
-
-/* Safe printing in NMI context */
-static DEFINE_PER_CPU(struct nmi_seq_buf, nmi_print_seq);
-
-/* "in progress" flag of arch_trigger_all_cpu_backtrace */
-static unsigned long backtrace_flag;
-
-static void print_seq_line(struct nmi_seq_buf *s, int start, int end)
-{
-	const char *buf = s->buffer + start;
-
-	printk("%.*s", (end - start) + 1, buf);
-}
 
 void arch_trigger_all_cpu_backtrace(bool include_self)
 {
-	struct nmi_seq_buf *s;
-	int len;
-	int cpu;
-	int i;
+	int err, i;
 	int this_cpu = get_cpu();
 
-	if (test_and_set_bit(0, &backtrace_flag)) {
+	err = printk_nmi_backtrace_prepare();
+	if (err) {
 		/*
-		 * If there is already a trigger_all_cpu_backtrace() in progress
-		 * (backtrace_flag == 1), don't output double cpu dump infos.
+		 * If there is already an nmi printk sequence in
+		 * progress then just give up...
 		 */
 		put_cpu();
 		return;
@@ -73,16 +50,6 @@ void arch_trigger_all_cpu_backtrace(bool include_self)
 	if (!include_self)
 		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
 
-	cpumask_copy(&printtrace_mask, to_cpumask(backtrace_mask));
-	/*
-	 * Set up per_cpu seq_buf buffers that the NMIs running on the other
-	 * CPUs will write to.
-	 */
-	for_each_cpu(cpu, to_cpumask(backtrace_mask)) {
-		s = &per_cpu(nmi_print_seq, cpu);
-		seq_buf_init(&s->seq, s->buffer, NMI_BUF_SIZE);
-	}
-
 	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
 		pr_info("sending NMI to %s CPUs:\n",
 			(include_self ? "all" : "other"));
@@ -97,73 +64,20 @@ void arch_trigger_all_cpu_backtrace(bool include_self)
 		touch_softlockup_watchdog();
 	}
 
-	/*
-	 * Now that all the NMIs have triggered, we can dump out their
-	 * back traces safely to the console.
-	 */
-	for_each_cpu(cpu, &printtrace_mask) {
-		int last_i = 0;
-
-		s = &per_cpu(nmi_print_seq, cpu);
-		len = seq_buf_used(&s->seq);
-		if (!len)
-			continue;
-
-		/* Print line by line. */
-		for (i = 0; i < len; i++) {
-			if (s->buffer[i] == '\n') {
-				print_seq_line(s, last_i, i);
-				last_i = i + 1;
-			}
-		}
-		/* Check if there was a partial line. */
-		if (last_i < len) {
-			print_seq_line(s, last_i, len - 1);
-			pr_cont("\n");
-		}
-	}
-
-	clear_bit(0, &backtrace_flag);
-	smp_mb__after_atomic();
+	printk_nmi_backtrace_complete();
 	put_cpu();
 }
 
-/*
- * It is not safe to call printk() directly from NMI handlers.
- * It may be fine if the NMI detected a lock up and we have no choice
- * but to do so, but doing a NMI on all other CPUs to get a back trace
- * can be done with a sysrq-l. We don't want that to lock up, which
- * can happen if the NMI interrupts a printk in progress.
- *
- * Instead, we redirect the vprintk() to this nmi_vprintk() that writes
- * the content into a per cpu seq_buf buffer. Then when the NMIs are
- * all done, we can safely dump the contents of the seq_buf to a printk()
- * from a non NMI context.
- */
-static int nmi_vprintk(const char *fmt, va_list args)
-{
-	struct nmi_seq_buf *s = this_cpu_ptr(&nmi_print_seq);
-	unsigned int len = seq_buf_used(&s->seq);
-
-	seq_buf_vprintf(&s->seq, fmt, args);
-	return seq_buf_used(&s->seq) - len;
-}
-
 static int
 arch_trigger_all_cpu_backtrace_handler(unsigned int cmd, struct pt_regs *regs)
 {
-	int cpu;
-
-	cpu = smp_processor_id();
+	int cpu = smp_processor_id();
 
 	if (cpumask_test_cpu(cpu, to_cpumask(backtrace_mask))) {
-		printk_func_t printk_func_save = this_cpu_read(printk_func);
-
-		/* Replace printk to write into the NMI seq */
-		this_cpu_write(printk_func, nmi_vprintk);
+		printk_nmi_backtrace_this_cpu_begin();
 		printk(KERN_WARNING "NMI backtrace for cpu %d\n", cpu);
 		show_regs(regs);
-		this_cpu_write(printk_func, printk_func_save);
+		printk_nmi_backtrace_this_cpu_end();
 
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return NMI_HANDLED;
-- 
2.4.3
