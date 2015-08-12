From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 12 Aug 2015 14:16:19 +0000
Subject: [PATCH] arm64: Add __exception_irq_entry definition for function graph
Message-ID: <1439388979-1518-1-git-send-email-jungseoklee85@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gic_handle_irq() is defined with __exception_irq_entry attribute.
A single remaining work is to add its definition as ARM did. Below
shows how function graph data is changed with these hunks.

A prologue of an interrupt handler is drawn as follows.

- current status

 0)   0.208 us    |  cpuidle_not_available();
 0)               |  default_idle_call() {
 0)               |    arch_cpu_idle() {
 0)               |      __handle_domain_irq() {
 0)               |        irq_enter() {
 0)   0.313 us    |          rcu_irq_enter();
 0)   0.261 us    |          __local_bh_disable_ip();

- with this change

 0)   0.625 us    |  cpuidle_not_available();
 0)               |  default_idle_call() {
 0)               |    arch_cpu_idle() {
 0)   ==========> |
 0)               |      gic_handle_irq() {
 0)               |        __handle_domain_irq() {
 0)               |          irq_enter() {
 0)   0.885 us    |            rcu_irq_enter();
 0)   0.781 us    |            __local_bh_disable_ip();

An epilogue of an interrupt handler is recorded as follows.

- current status

 0)   0.261 us    |          idle_cpu();
 0)               |          rcu_irq_exit() {
 0)   0.521 us    |            rcu_eqs_enter_common.isra.46();
 0)   2.552 us    |          }
 0) ! 322.448 us  |        }
 0) ! 583.437 us  |      }
 0) # 1656.041 us |    }
 0) # 1658.073 us |  }

- with this change

 0)   0.677 us    |            idle_cpu();
 0)               |            rcu_irq_exit() {
 0)   1.770 us    |              rcu_eqs_enter_common.isra.46();
 0)   7.968 us    |            }
 0) # 1803.541 us |          }
 0) # 2626.667 us |        }
 0) # 2632.969 us |      }
 0)   <========== |
 0) # 14425.00 us |    }
 0) # 14430.98 us |  }

Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Rabin Vincent <rabin@rab.in>
Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Jungseok Lee <jungseoklee85@gmail.com>
---
 arch/arm64/include/asm/exception.h |  6 +++++
 arch/arm64/include/asm/traps.h     | 23 ++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
index 0303705..6cb7e1a 100644
--- a/arch/arm64/include/asm/exception.h
+++ b/arch/arm64/include/asm/exception.h
@@ -18,7 +18,13 @@
 #ifndef __ASM_EXCEPTION_H
 #define __ASM_EXCEPTION_H
 
+#include <linux/ftrace.h>
+
 #define __exception	__attribute__((section(".exception.text")))
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+#define __exception_irq_entry	__irq_entry
+#else
 #define __exception_irq_entry	__exception
+#endif
 
 #endif	/* __ASM_EXCEPTION_H */
diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 232e4ba..0cc2f29 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -34,13 +34,32 @@ struct undef_hook {
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+static inline int __in_irqentry_text(unsigned long ptr)
+{
+	extern char __irqentry_text_start[];
+	extern char __irqentry_text_end[];
+
+	return ptr >= (unsigned long)&__irqentry_text_start &&
+	       ptr < (unsigned long)&__irqentry_text_end;
+}
+#else
+static inline int __in_irqentry_text(unsigned long ptr)
+{
+	return 0;
+}
+#endif
+
 static inline int in_exception_text(unsigned long ptr)
 {
 	extern char __exception_text_start[];
 	extern char __exception_text_end[];
+	int in;
+
+	in = ptr >= (unsigned long)&__exception_text_start &&
+	     ptr < (unsigned long)&__exception_text_end;
 
-	return ptr >= (unsigned long)&__exception_text_start &&
-	       ptr < (unsigned long)&__exception_text_end;
+	return in ? : __in_irqentry_text(ptr);
 }
 
 #endif
-- 
1.9.1
