From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Sun, 20 Dec 2015 20:52:37 +0000
Subject: [PATCH 4.4-rc5 v22 4/4] ARM: Allow IPI_CPU_BACKTRACE to exploit FIQ
In-Reply-To: <1450644757-18734-1-git-send-email-daniel.thompson@linaro.org>
References: <1450644757-18734-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1450644757-18734-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC (v1 & v2) driver allows its implementation of handle_arch_irq()
to be called from the FIQ handler but currently the ARM code is not
able to exploit this.

Extend handle_fiq_as_nmi() to call handle_arch_irq(). This will affect
all interrupt controllers, including ones that do not support FIQ. This
is OK because a spurious FIQ is normally fatal. Handling a spurious FIQ
like a normal interrupt does risk deadlock but does give us a chance
of surviving long enough to get an error message out.

We also extend the SMP code to indicate to irq drivers which IPIs they
should seek to implement using FIQ.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/include/asm/smp.h | 9 +++++++++
 arch/arm/kernel/smp.c      | 6 ++++++
 arch/arm/kernel/traps.c    | 9 ++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/smp.h b/arch/arm/include/asm/smp.h
index 3d6dc8b460e4..daf869cff02e 100644
--- a/arch/arm/include/asm/smp.h
+++ b/arch/arm/include/asm/smp.h
@@ -18,6 +18,15 @@
 # error "<asm/smp.h> included in non-SMP build"
 #endif
 
+/*
+ * Identify which IPIs are safe for the irqchip to handle using FIQ.
+ *
+ * This information is advisory. The interrupt controller may not be capable
+ * of routing these IPIs to FIQ and the kernel will continue to work if they
+ * are routed to IRQ as normal.
+ */
+#define SMP_IPI_FIQ_MASK 0x80
+
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
 struct seq_file;
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index fe517f1e88d8..853089e1aa8a 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -639,6 +639,11 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CPU_BACKTRACE:
+		if (in_nmi()) {
+			nmi_cpu_backtrace(regs);
+			break;
+		}
+
 		irq_enter();
 		nmi_cpu_backtrace(regs);
 		irq_exit();
@@ -750,6 +755,7 @@ static void raise_nmi(cpumask_t *mask)
 	if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
 		nmi_cpu_backtrace(NULL);
 
+	BUILD_BUG_ON(SMP_IPI_FIQ_MASK != BIT(IPI_CPU_BACKTRACE));
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index bc698383e822..a04426ee7684 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -479,7 +479,14 @@ asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
 
 	nmi_enter();
 
-	/* nop. FIQ handlers for special arch/arm features can be added here. */
+	/*
+	 * Either the interrupt controller supports FIQ, meaning it will
+	 * do the right thing with this call, or we will end up treating a
+	 * spurious FIQ (which is normally fatal) as though it were an IRQ
+	 * which, although it risks deadlock, still gives us a sporting
+	 * chance of surviving long enough to log errors.
+	 */
+	handle_arch_irq(regs);
 
 	nmi_exit();
 
-- 
2.5.0
