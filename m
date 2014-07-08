From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  8 Jul 2014 14:10:24 +0100
Subject: [PATCH 01/15] arm64: pass IRQ domain to the core IRQ handler
In-Reply-To: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
References: <1404825038-547-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404825038-547-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Calling irq_find_mapping from outside a irq_{enter,exit} section is
unsafe and produces ugly messages if CONFIG_PROVE_RCU is enabled:
If coming from the idle state, the rcu_read_lock call in irq_find_mapping
will generate an an unpleasant warning:

<quote>
===============================
[ INFO: suspicious RCU usage. ]
3.16.0-rc1+ #135 Not tainted
-------------------------------
include/linux/rcupdate.h:871 rcu_read_lock() used illegally while idle!

other info that might help us debug this:

RCU used illegally from idle CPU!
rcu_scheduler_active = 1, debug_locks = 0
RCU used illegally from extended quiescent state!
1 lock held by swapper/0/0:
 #0:  (rcu_read_lock){......}, at: [<ffffffc00010206c>]
irq_find_mapping+0x4c/0x198
</quote>

A solution is to add a new handle_domain_irq entry point into
the arm64 code that the interrupt controller code can call.
This new function takes an irq_domain, and calls into irq_find_domain
inside the irq_{enter,exit} block.

Interrupt controllers can then be updated to use the new mechanism.

Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/hardirq.h |  4 ++++
 arch/arm64/kernel/irq.c          | 23 ++++++++++++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 0be6782..fb3e318 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -49,6 +49,10 @@ static inline void ack_bad_irq(unsigned int irq)
 
 extern void handle_IRQ(unsigned int, struct pt_regs *);
 
+struct irq_domain;
+extern void handle_domain_irq(struct irq_domain *,
+			      unsigned int, struct pt_regs *);
+
 /*
  * No arch-specific IRQ flags.
  */
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 0f08dfd..cb487ad 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -23,6 +23,7 @@
 
 #include <linux/kernel_stat.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/irqchip.h>
@@ -45,19 +46,30 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  * not come via this function.  Instead, they should provide their
  * own 'handler'.  Used by platform code implementing C-based 1st
  * level decoding.
+ *
+ * handle_domain_irq does the same thing, but also converts the HW
+ * interrupt number into a logical one using the provided domain. A
+ * NULL domain indicates that this conversion has already been done.
  */
-void handle_IRQ(unsigned int irq, struct pt_regs *regs)
+void handle_domain_irq(struct irq_domain *domain,
+		       unsigned int hwirq, struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
+	unsigned int irq;
 
 	irq_enter();
 
+	if (domain)
+		irq = irq_find_mapping(domain, hwirq);
+	else
+		irq = hwirq;
+
 	/*
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(irq >= nr_irqs)) {
-		pr_warn_ratelimited("Bad IRQ%u\n", irq);
+	if (unlikely(!irq || irq >= nr_irqs)) {
+		pr_warn_ratelimited("Bad IRQ%u (%u)\n", irq, hwirq);
 		ack_bad_irq(irq);
 	} else {
 		generic_handle_irq(irq);
@@ -67,6 +79,11 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+void handle_IRQ(unsigned int irq, struct pt_regs *regs)
+{
+	handle_domain_irq(NULL, irq, regs);
+}
+
 void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
 {
 	if (handle_arch_irq)
-- 
2.0.0
