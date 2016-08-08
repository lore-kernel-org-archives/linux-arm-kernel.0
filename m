From: cmetcalf@mellanox.com (Chris Metcalf)
Date: Mon,  8 Aug 2016 12:03:35 -0400
Subject: [PATCH v7 1/4] nmi_backtrace: add more trigger_*_cpu_backtrace()
 methods
In-Reply-To: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
Message-ID: <1470672218-16059-2-git-send-email-cmetcalf@mellanox.com>
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
 arch/arm/include/asm/irq.h    |  5 +++--
 arch/arm/kernel/smp.c         |  4 ++--
 arch/x86/include/asm/irq.h    |  5 +++--
 arch/x86/kernel/apic/hw_nmi.c |  7 ++++---
 include/linux/nmi.h           | 49 +++++++++++++++++++++++++++++++------------
 lib/nmi_backtrace.c           | 13 ++++++------
 6 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 1bd9510de1b9..edbbb0e78f9c 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -36,8 +36,9 @@ extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 #endif
 
 #ifdef CONFIG_SMP
-extern void arch_trigger_all_cpu_backtrace(bool);
-#define arch_trigger_all_cpu_backtrace(x) arch_trigger_all_cpu_backtrace(x)
+extern void arch_trigger_cpumask_backtrace(bool include_self,
+					   const cpumask_t *mask);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
 static inline int nr_legacy_irqs(void)
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 861521606c6d..732583dcb8f8 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -760,7 +760,7 @@ static void raise_nmi(cpumask_t *mask)
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
-void arch_trigger_all_cpu_backtrace(bool include_self)
+void arch_trigger_cpumask_backtrace(bool include_self, const cpumask_t *mask)
 {
-	nmi_trigger_all_cpu_backtrace(include_self, raise_nmi);
+	nmi_trigger_cpumask_backtrace(include_self, mask, raise_nmi);
 }
diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index e7de5c9a4fbd..5e7e826308b6 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -50,8 +50,9 @@ extern int vector_used_by_percpu_irq(unsigned int vector);
 extern void init_ISA_irqs(void);
 
 #ifdef CONFIG_X86_LOCAL_APIC
-void arch_trigger_all_cpu_backtrace(bool);
-#define arch_trigger_all_cpu_backtrace arch_trigger_all_cpu_backtrace
+void arch_trigger_cpumask_backtrace(bool include_self,
+				    const struct cpumask *mask);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
 #endif /* _ASM_X86_IRQ_H */
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index f29501e1a5c1..6da698d54256 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -26,15 +26,16 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 }
 #endif
 
-#ifdef arch_trigger_all_cpu_backtrace
+#ifdef arch_trigger_cpumask_backtrace
 static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 {
 	apic->send_IPI_mask(mask, NMI_VECTOR);
 }
 
-void arch_trigger_all_cpu_backtrace(bool include_self)
+void arch_trigger_cpumask_backtrace(bool include_self, const cpumask_t *mask)
 {
-	nmi_trigger_all_cpu_backtrace(include_self, nmi_raise_cpu_backtrace);
+	nmi_trigger_cpumask_backtrace(include_self, mask,
+				      nmi_raise_cpu_backtrace);
 }
 
 static int
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 4630eeae18e0..8e9ad95df219 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -31,38 +31,61 @@ static inline void hardlockup_detector_disable(void) {}
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
+	arch_trigger_cpumask_backtrace(true, cpu_online_mask);
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
+#elif defined(arch_trigger_cpumask_backtrace)
+	arch_trigger_cpumask_backtrace(false, cpu_online_mask);
+	return true;
+#else
+	return false;
+#endif
 }
 
-/* generic implementation */
-void nmi_trigger_all_cpu_backtrace(bool include_self,
-				   void (*raise)(cpumask_t *mask));
-bool nmi_cpu_backtrace(struct pt_regs *regs);
-
-#else
-static inline bool trigger_all_cpu_backtrace(void)
+static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
 {
+#if defined(arch_trigger_cpumask_backtrace)
+	arch_trigger_cpumask_backtrace(true, mask);
+	return true;
+#else
 	return false;
+#endif
 }
-static inline bool trigger_allbutself_cpu_backtrace(void)
+
+static inline bool trigger_single_cpu_backtrace(int cpu)
 {
+#if defined(arch_trigger_cpumask_backtrace)
+	arch_trigger_cpumask_backtrace(true, cpumask_of(cpu));
+	return true;
+#else
 	return false;
-}
 #endif
+}
+
+/* generic implementation */
+void nmi_trigger_cpumask_backtrace(bool include_self,
+				   const cpumask_t *mask,
+				   void (*raise)(cpumask_t *mask));
+bool nmi_cpu_backtrace(struct pt_regs *regs);
 
 #ifdef CONFIG_LOCKUP_DETECTOR
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 26caf51cc238..5448d6621102 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -17,7 +17,7 @@
 #include <linux/kprobes.h>
 #include <linux/nmi.h>
 
-#ifdef arch_trigger_all_cpu_backtrace
+#ifdef arch_trigger_cpumask_backtrace
 /* For reliability, we're prepared to waste bits here. */
 static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
 
@@ -25,12 +25,13 @@ static DECLARE_BITMAP(backtrace_mask, NR_CPUS) __read_mostly;
 static unsigned long backtrace_flag;
 
 /*
- * When raise() is called it will be is passed a pointer to the
+ * When raise() is called it will be passed a pointer to the
  * backtrace_mask. Architectures that call nmi_cpu_backtrace()
  * directly from their raise() functions may rely on the mask
  * they are passed being updated as a side effect of this call.
  */
-void nmi_trigger_all_cpu_backtrace(bool include_self,
+void nmi_trigger_cpumask_backtrace(bool include_self,
+				   const cpumask_t *mask,
 				   void (*raise)(cpumask_t *mask))
 {
 	int i, this_cpu = get_cpu();
@@ -44,13 +45,13 @@ void nmi_trigger_all_cpu_backtrace(bool include_self,
 		return;
 	}
 
-	cpumask_copy(to_cpumask(backtrace_mask), cpu_online_mask);
+	cpumask_copy(to_cpumask(backtrace_mask), mask);
 	if (!include_self)
 		cpumask_clear_cpu(this_cpu, to_cpumask(backtrace_mask));
 
 	if (!cpumask_empty(to_cpumask(backtrace_mask))) {
-		pr_info("Sending NMI to %s CPUs:\n",
-			(include_self ? "all" : "other"));
+		pr_info("Sending NMI from CPU %d to CPUs %*pbl:\n",
+			this_cpu, nr_cpumask_bits, to_cpumask(backtrace_mask));
 		raise(to_cpumask(backtrace_mask));
 	}
 
-- 
2.7.2
