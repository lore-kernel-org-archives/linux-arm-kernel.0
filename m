From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 11 Aug 2016 12:55:15 +0100
Subject: [PATCH 4.8-rc1 v23 4/4] ARM: Allow IPI_CPU_BACKTRACE to exploit FIQ
In-Reply-To: <1470916515-28510-1-git-send-email-daniel.thompson@linaro.org>
References: <1436188438-9478-1-git-send-email-daniel.thompson@linaro.org>
 <1470916515-28510-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1470916515-28510-5-git-send-email-daniel.thompson@linaro.org>
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
 arch/arm/include/asm/smp.h |  9 +++++++++
 arch/arm/kernel/smp.c      |  6 ++++++
 arch/arm/kernel/traps.c    | 11 ++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

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
index 861521606c6d..5e955ad80a1e 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -644,6 +644,11 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 
 	case IPI_CPU_BACKTRACE:
+		if (in_nmi()) {
+			nmi_cpu_backtrace(regs);
+			break;
+		}
+
 		printk_nmi_enter();
 		irq_enter();
 		nmi_cpu_backtrace(regs);
@@ -757,6 +762,7 @@ static void raise_nmi(cpumask_t *mask)
 	if (cpumask_test_cpu(smp_processor_id(), mask) && irqs_disabled())
 		nmi_cpu_backtrace(NULL);
 
+	BUILD_BUG_ON(SMP_IPI_FIQ_MASK != BIT(IPI_CPU_BACKTRACE));
 	smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index bc698383e822..8f6173cd0a54 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -479,7 +479,16 @@ asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
 
 	nmi_enter();
 
-	/* nop. FIQ handlers for special arch/arm features can be added here. */
+	/*
+	 * Either the interrupt controller supports FIQ, meaning it will
+	 * do the right thing with this call, or we will end up treating a
+	 * spurious FIQ (which is normally fatal) as though it were an IRQ
+	 * which, although it risks deadlock, still gives us a sporting
+	 * chance of surviving long enough to log errors.
+	 */
+#ifdef CONFIG_MULTI_IRQ_HANDLER
+	handle_arch_irq(regs);
+#endif
 
 	nmi_exit();
 
-- 
2.7.4
