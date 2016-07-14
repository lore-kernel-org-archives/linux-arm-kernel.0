From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Thu, 14 Jul 2016 16:50:29 -0400
Subject: [PATCH v6 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <1468529432-28026-1-git-send-email-cmetcalf@mellanox.com>
References: <1468529432-28026-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1468529432-28026-2-git-send-email-cmetcalf@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently you can only request a backtrace of either all cpus, or
all cpus but yourself.  It can also be helpful to request a remote
backtrace of a single cpu, and since we want that, the logical
extension is to support a cpumask as the underlying primitive.

This change modifies the existing lib/nmi_backtrace.c code to take
a cpumask as its basic primitive, and modifies the linux/nmi.h code
to use either the old "all/all_but_self" arch methods, or the new
"cpumask" method, depending on which is available.

The existing clients of nmi_backtrace (arm and x86) are converted
to using the new cpumask approach in this change.

Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
Reviewed-by: Aaron Tomlin <atomlin@redhat.com>
---
 arch/arm/include/asm/irq.h    |  4 +--
 arch/arm/kernel/smp.c         |  4 +--
 arch/x86/include/asm/irq.h    |  4 +--
 arch/x86/kernel/apic/hw_nmi.c |  6 ++---
 include/linux/nmi.h           | 63 ++++++++++++++++++++++++++++++++++---------
 lib/nmi_backtrace.c           | 15 +++++------
 6 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 1bd9510de1b9..13f9a9a17eca 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -36,8 +36,8 @@ extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #endif
 
 #ifdef CONFIG_SMP
-extern void arch_trigger_all_cpu_backtrace(bool);
-#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask);
+#define arch_trigger_cpumask_backtrace(x) arch_trigger_cpumask_backtrace(x)
 #endif
 
 static inline int nr_legacy_irqs(void)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 861521606c6d..a3f422022561 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -760,7 +760,7 @@ static void raise_nmi(cpumask_t *mask)
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
-void arch_trigger_all_cpu_backtrace(bool include_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask)
 {
-	nmi_trigger_all_cpu_backtrace(include_self, raise_nmi);
+	nmi_trigger_cpumask_backtrace(mask, raise_nmi);
 }
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index e7de5c9a4fbd..18bdc8cc5c63 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -50,8 +50,8 @@ extern int vector_used_by_percpu_irq(unsigned int vector);
 extern void init_ISA_irqs(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-void arch_trigger_all_cpu_backtrace(bool);
-#define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
+void arch_trigger_cpumask_backtrace(const struct cpumask *mask);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
 #endif /* _ASM_X86_IRQ_H */
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 7788ce643bf4..be27ef1f5332 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -26,15 +26,15 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 }
 #endif
 
-#ifdef arch_trigger_all_cpu_backtrace
+#ifdef arch_trigger_cpumask_backtrace
 static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 {
 	apic->send_IPI_mask(mask, NMI_VECTOR);
 }
 
-void arch_trigger_all_cpu_backtrace(bool include_self)
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask)
 {
-	nmi_trigger_all_cpu_backtrace(include_self, nmi_raise_cpu_backtrace);
+	nmi_trigger_cpumask_backtrace(mask, nmi_raise_cpu_backtrace);
 }
 
 static int
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 4630eeae18e0..434208af10fc 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -31,38 +31,75 @@ static inline void hardlockup_detector_disable(void) {}
 #endif
 
 /*
- * Create trigger_all_cpu_backtrace() out of the arch-provided
- * base function. Return whether such support was available,
+ * Create trigger_all_cpu_backtrace() etc out of the arch-provided
+ * base function(s). Return whether such support was available,
  * to allow calling code to fall back to some other mechanism:
  */
-#ifdef arch_trigger_all_cpu_backtrace
 static inline bool trigger_all_cpu_backtrace(void)
 {
+#if defined(arch_trigger_all_cpu_backtrace)
 	arch_trigger_all_cpu_backtrace(true);
-
 	return true;
+#elif defined(arch_trigger_cpumask_backtrace)
+	arch_trigger_cpumask_backtrace(cpu_online_mask);
+	return true;
+#else
+	return false;
+#endif
 }
+
 static inline bool trigger_allbutself_cpu_backtrace(void)
 {
+#if defined(arch_trigger_all_cpu_backtrace)
 	arch_trigger_all_cpu_backtrace(false);
 	return true;
-}
-
-/* generic implementation */
-void nmi_trigger_all_cpu_backtrace(bool include_self,
-				   void (*raise)(cpumask_t *mask));
-bool nmi_cpu_backtrace(struct pt_regs *regs);
+#elif defined(arch_trigger_cpumask_backtrace)
+	cpumask_var_t mask;
+	int cpu = get_cpu();
 
+	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
+		return false;
+	cpumask_copy(mask, cpu_online_mask);
+	cpumask_clear_cpu(cpu, mask);
+	arch_trigger_cpumask_backtrace(mask);
+	put_cpu();
+	free_cpumask_var(mask);
+	return true;
 #else
-static inline bool trigger_all_cpu_backtrace(void)
-{
 	return false;
+#endif
 }
-static inline bool trigger_allbutself_cpu_backtrace(void)
+
+static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
 {
+#if defined(arch_trigger_cpumask_backtrace)
+	arch_trigger_cpumask_backtrace(mask);
+	return true;
+#else
 	return false;
+#endif
 }
+
+static inline bool trigger_single_cpu_backtrace(int cpu)
+{
+#if defined(arch_trigger_cpumask_backtrace)
+	cpumask_var_t mask;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return false;
+	cpumask_set_cpu(cpu, mask);
+	arch_trigger_cpumask_backtrace(mask);
+	free_cpumask_var(mask);
+	return true;
+#else
+	return false;
 #endif
+}
+
+/* generic implementation */
+void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
+				   void (*raise)(cpumask_t *mask));
+bool nmi_cpu_backtrace(struct pt_regs *regs);
 
 #ifdef CONFIG_LOCKUP_DETECTOR
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 26caf51cc238..276540f6407e 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -17,7 +17,7 @@
 #include <linux/kprobes.h>
 #include <linux/nmi.h>
 
-#ifdef arch_trigger_all_cpu_backtrace
+#ifdef arch_trigger_cpumask_backtrace
 /* For reliability, we're prepared to waste bits here. */
 static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
 
@@ -25,12 +25,12 @@ static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
 static unsigned long backtrace_flag;
 
 /*
- * When raise() is called it will be is passed a pointer to the
+ * When raise() is called it will be passed a pointer to the
  * backtrace_mask. Architectures that call nmi_cpu_backtrace()
  * directly from their raise() functions may rely on the mask
  * they are passed being updated as a side effect of this call.
  */
-void nmi_trigger_all_cpu_backtrace(bool include_self,
+void nmi_trigger_cpumask_backtrace(const cpumask_t *mask,
 				   void (*raise)(cpumask_t *mask))
 {
 	int i, this_cpu = get_cpu();
@@ -44,13 +44,10 @@ void nmi_trigger_all_cpu_backtrace(bool include_self,
 		return;
 	}
 
-	cpumask_copy(to_cpumask(backtrace_mask), cpu_online_mask);
-	if (!include_self)
-		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
-
+	cpumask_copy(to_cpumask(backtrace_mask), mask);
 	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
-		pr_info("Sending NMI to %s CPUs:\n",
-			(include_self ? "all" : "other"));
+		pr_info("Sending NMI from CPU %d to CPUs %*pbl:\n",
+			this_cpu, nr_cpumask_bits, to_cpumask(backtrace_mask));
 		raise(to_cpumask(backtrace_mask));
 	}
 
-- 
2.7.2
