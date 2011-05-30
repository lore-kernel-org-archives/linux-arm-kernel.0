From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 May 2011 11:04:43 +0100
Subject: [RFC PATCH v5 02/13] ARM: smp: add interrupt handler for local timers
In-Reply-To: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>
References: <1306749894-28749-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1306749894-28749-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Provide a "normal" interrupt handler for local timers.
It is expected that most timer implementations will use this
handler unless they have more specific requirements.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |    6 ++++++
 arch/arm/kernel/smp.c             |   12 ++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 080d74f..bef44b3 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -10,6 +10,8 @@
 #ifndef __ASM_ARM_LOCALTIMER_H
 #define __ASM_ARM_LOCALTIMER_H
 
+#include <linux/interrupt.h>
+
 struct clock_event_device;
 
 /*
@@ -22,6 +24,10 @@ void percpu_timer_setup(void);
  */
 asmlinkage void do_local_timer(struct pt_regs *);
 
+/*
+ * Per-cpu timer IRQ handler
+ */
+irqreturn_t percpu_timer_handler(int irq, void *dev_id);
 
 #ifdef CONFIG_LOCAL_TIMERS
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 344e52b..daa7088 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -460,6 +460,18 @@ asmlinkage void __exception_irq_entry do_local_timer(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+irqreturn_t percpu_timer_handler(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = dev_id;
+
+	if (local_timer_ack()) {
+		evt->event_handler(evt);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 void show_local_irqs(struct seq_file *p, int prec)
 {
 	unsigned int cpu;
-- 
1.7.5.2
