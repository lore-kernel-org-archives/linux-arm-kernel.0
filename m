From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 11 Oct 2013 19:24:03 +0100
Subject: [PATCHv4 3/6] arm64: factor out spin-table boot method
In-Reply-To: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
References: <1381515846-1684-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1381515846-1684-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 kernel has an internal holding pen, which is necessary for
some systems where we can't bring CPUs online individually and must hold
multiple CPUs in a safe area until the kernel is able to handle them.
The current SMP infrastructure for arm64 is closely coupled to this
holding pen, and alternative boot methods must launch CPUs into the pen,
where they sit before they are launched into the kernel proper.

With PSCI (and possibly other future boot methods), we can bring CPUs
online individually, and need not perform the secondary_holding_pen
dance. Instead, this patch factors the holding pen management code out
to the spin-table boot method code, as it is the only boot method
requiring the pen.

A new entry point for secondaries, secondary_entry is added for other
boot methods to use, which bypasses the holding pen and its associated
overhead when bringing CPUs online. The smp.pen.text section is also
removed, as the pen can live in head.text without problem.

The cpu_operations structure is extended with two new functions,
cpu_boot and cpu_postboot, for bringing a cpu into the kernel and
performing any post-boot cleanup required by a bootmethod (e.g.
resetting the secondary_holding_pen_release to INVALID_HWID).
Documentation is added for cpu_operations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/cpu_ops.h   | 16 ++++++++
 arch/arm64/include/asm/smp.h       |  3 +-
 arch/arm64/kernel/head.S           | 12 +++++-
 arch/arm64/kernel/psci.c           | 18 +++++----
 arch/arm64/kernel/smp.c            | 65 +++------------------------------
 arch/arm64/kernel/smp_spin_table.c | 75 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/vmlinux.lds.S    |  1 -
 7 files changed, 117 insertions(+), 73 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index 3c60c8d..1720be6 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -21,10 +21,26 @@
 
 struct device_node;
 
+/**
+ * struct cpu_operations - Callback operations for hotplugging CPUs.
+ *
+ * @name:	Name of the property as appears in a devicetree cpu node's
+ *		enable-method property.
+ * @cpu_init:	Reads any data necessary for a specific enable-method form the
+ *		devicetree, for a given cpu node and proposed logical id.
+ * @cpu_prepare: Early one-time preparation step for a cpu. If there is a
+ *		mechanism for doing so, tests whether it is possible to boot
+ *		the given CPU.
+ * @cpu_boot:	Boots a cpu into the kernel.
+ * @cpu_postboot: Optionally, perform any post-boot cleanup or necesary
+ *		synchronisation. Called from the cpu being booted.
+ */
 struct cpu_operations {
 	const char	*name;
 	int		(*cpu_init)(struct device_node *, unsigned int);
 	int		(*cpu_prepare)(unsigned int);
+	int		(*cpu_boot)(unsigned int);
+	void		(*cpu_postboot)(void);
 };
 
 extern const struct cpu_operations *cpu_ops[NR_CPUS];
diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 7e34295..d64187c 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -60,8 +60,7 @@ struct secondary_data {
 	void *stack;
 };
 extern struct secondary_data secondary_data;
-extern void secondary_holding_pen(void);
-extern volatile unsigned long secondary_holding_pen_release;
+extern void secondary_entry(void);
 
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7090c12..bf7efdf 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -225,7 +225,6 @@ ENTRY(__boot_cpu_mode)
 	.quad	PAGE_OFFSET
 
 #ifdef CONFIG_SMP
-	.pushsection    .smp.pen.text, "ax"
 	.align	3
 1:	.quad	.
 	.quad	secondary_holding_pen_release
@@ -250,7 +249,16 @@ pen:	ldr	x4, [x3]
 	wfe
 	b	pen
 ENDPROC(secondary_holding_pen)
-	.popsection
+
+	/*
+	 * Secondary entry point that jumps straight into the kernel. Only to
+	 * be used where CPUs are brought online dynamically by the kernel.
+	 */
+ENTRY(secondary_entry)
+	bl	__calc_phys_offset		// x2=phys offset
+	bl	el2_setup			// Drop to EL1
+	b	secondary_startup
+ENDPROC(secondary_entry)
 
 ENTRY(secondary_startup)
 	/*
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index ccec2ca..fb56b61 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -239,26 +239,28 @@ static int __init cpu_psci_cpu_init(struct device_node *dn, unsigned int cpu)
 
 static int __init cpu_psci_cpu_prepare(unsigned int cpu)
 {
-	int err;
-
 	if (!psci_ops.cpu_on) {
 		pr_err("no cpu_on method, not booting CPU%d\n", cpu);
 		return -ENODEV;
 	}
 
-	err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_holding_pen));
-	if (err) {
-		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
-		return err;
-	}
-
 	return 0;
 }
 
+static int cpu_psci_cpu_boot(unsigned int cpu)
+{
+	int err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa(secondary_entry));
+	if (err)
+		pr_err("psci: failed to boot CPU%d (%d)\n", cpu, err);
+
+	return err;
+}
+
 const struct cpu_operations cpu_psci_ops = {
 	.name		= "psci",
 	.cpu_init	= cpu_psci_cpu_init,
 	.cpu_prepare	= cpu_psci_cpu_prepare,
+	.cpu_boot	= cpu_psci_cpu_boot,
 };
 
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 8965fb7..6806bc4 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -55,7 +55,6 @@
  * where to place its SVC stack
  */
 struct secondary_data secondary_data;
-volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
 
 enum ipi_msg_type {
 	IPI_RESCHEDULE,
@@ -64,61 +63,16 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 };
 
-static DEFINE_RAW_SPINLOCK(boot_lock);
-
-/*
- * Write secondary_holding_pen_release in a way that is guaranteed to be
- * visible to all observers, irrespective of whether they're taking part
- * in coherency or not.  This is necessary for the hotplug code to work
- * reliably.
- */
-static void write_pen_release(u64 val)
-{
-	void *start = (void *)&secondary_holding_pen_release;
-	unsigned long size = sizeof(secondary_holding_pen_release);
-
-	secondary_holding_pen_release = val;
-	__flush_dcache_area(start, size);
-}
-
 /*
  * Boot a secondary CPU, and assign it the specified idle task.
  * This also gives us the initial stack to use for this CPU.
  */
 static int boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
-
-	/*
-	 * Set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	raw_spin_lock(&boot_lock);
-
-	/*
-	 * Update the pen release flag.
-	 */
-	write_pen_release(cpu_logical_map(cpu));
+	if (cpu_ops[cpu]->cpu_boot)
+		return cpu_ops[cpu]->cpu_boot(cpu);
 
-	/*
-	 * Send an event, causing the secondaries to read pen_release.
-	 */
-	sev();
-
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		if (secondary_holding_pen_release == INVALID_HWID)
-			break;
-		udelay(10);
-	}
-
-	/*
-	 * Now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	raw_spin_unlock(&boot_lock);
-
-	return secondary_holding_pen_release != INVALID_HWID ? -ENOSYS : 0;
+	return -EOPNOTSUPP;
 }
 
 static DECLARE_COMPLETION(cpu_running);
@@ -188,17 +142,8 @@ asmlinkage void secondary_start_kernel(void)
 	preempt_disable();
 	trace_hardirqs_off();
 
-	/*
-	 * Let the primary processor know we're out of the
-	 * pen, then head off into the C entry point
-	 */
-	write_pen_release(INVALID_HWID);
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	raw_spin_lock(&boot_lock);
-	raw_spin_unlock(&boot_lock);
+	if (cpu_ops[cpu]->cpu_postboot)
+		cpu_ops[cpu]->cpu_postboot();
 
 	/*
 	 * OK, now it's safe to let the boot CPU continue.  Wait for
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index a8b76e4..27f0836 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -16,14 +16,37 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
+#include <asm/cputype.h>
+#include <asm/smp_plat.h>
+
+extern void secondary_holding_pen(void);
+volatile unsigned long secondary_holding_pen_release = INVALID_HWID;
 
 static phys_addr_t cpu_release_addr[NR_CPUS];
+static DEFINE_RAW_SPINLOCK(boot_lock);
+
+/*
+ * Write secondary_holding_pen_release in a way that is guaranteed to be
+ * visible to all observers, irrespective of whether they're taking part
+ * in coherency or not.  This is necessary for the hotplug code to work
+ * reliably.
+ */
+static void write_pen_release(u64 val)
+{
+	void *start = (void *)&secondary_holding_pen_release;
+	unsigned long size = sizeof(secondary_holding_pen_release);
+
+	secondary_holding_pen_release = val;
+	__flush_dcache_area(start, size);
+}
+
 
 static int smp_spin_table_cpu_init(struct device_node *dn, unsigned int cpu)
 {
@@ -60,8 +83,60 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
 	return 0;
 }
 
+static int smp_spin_table_cpu_boot(unsigned int cpu)
+{
+	unsigned long timeout;
+
+	/*
+	 * Set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	raw_spin_lock(&boot_lock);
+
+	/*
+	 * Update the pen release flag.
+	 */
+	write_pen_release(cpu_logical_map(cpu));
+
+	/*
+	 * Send an event, causing the secondaries to read pen_release.
+	 */
+	sev();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		if (secondary_holding_pen_release == INVALID_HWID)
+			break;
+		udelay(10);
+	}
+
+	/*
+	 * Now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	raw_spin_unlock(&boot_lock);
+
+	return secondary_holding_pen_release != INVALID_HWID ? -ENOSYS : 0;
+}
+
+void smp_spin_table_cpu_postboot(void)
+{
+	/*
+	 * Let the primary processor know we're out of the pen.
+	 */
+	write_pen_release(INVALID_HWID);
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	raw_spin_lock(&boot_lock);
+	raw_spin_unlock(&boot_lock);
+}
+
 const struct cpu_operations smp_spin_table_ops = {
 	.name		= "spin-table",
 	.cpu_init	= smp_spin_table_cpu_init,
 	.cpu_prepare	= smp_spin_table_cpu_prepare,
+	.cpu_boot	= smp_spin_table_cpu_boot,
+	.cpu_postboot	= smp_spin_table_cpu_postboot,
 };
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index f8ab9d8..991ffdd 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -54,7 +54,6 @@ SECTIONS
 	}
 	.text : {			/* Real text segment		*/
 		_stext = .;		/* Text and read-only data	*/
-			*(.smp.pen.text)
 			__exception_text_start = .;
 			*(.exception.text)
 			__exception_text_end = .;
-- 
1.8.1.1
