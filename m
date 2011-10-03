From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon,  3 Oct 2011 18:04:04 +0100
Subject: [PATCH v4 2/4] genirq: percpu: allow interrupt type to be set at
	enable time
In-Reply-To: <1317661446-2876-1-git-send-email-marc.zyngier@arm.com>
References: <1317661446-2876-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1317661446-2876-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As request_percpu_irq() doesn't allow for a percpu interrupt to have
its type configured (it is generally impossible to configure it on all
CPUs at once), add a 'type' argument to enable_percpu_irq().

This allows some low-level, board specific init code to be switched to
a generic API.

[ tglx: Added WARN_ON argument ]

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    2 +-
 kernel/irq/manage.c       |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 1cdfd09..664544f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -223,7 +223,7 @@ extern void disable_irq_nosync(unsigned int irq);
 extern void disable_irq(unsigned int irq);
 extern void disable_percpu_irq(unsigned int irq);
 extern void enable_irq(unsigned int irq);
-extern void enable_percpu_irq(unsigned int irq);
+extern void enable_percpu_irq(unsigned int irq, unsigned int type);
 
 /* The following three functions are for the core kernel use only. */
 #ifdef CONFIG_GENERIC_HARDIRQS
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 7b4b156..2bc8686 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1419,7 +1419,7 @@ int request_any_context_irq(unsigned int irq, irq_handler_t handler,
 }
 EXPORT_SYMBOL_GPL(request_any_context_irq);
 
-void enable_percpu_irq(unsigned int irq)
+void enable_percpu_irq(unsigned int irq, unsigned int type)
 {
 	unsigned int cpu = smp_processor_id();
 	unsigned long flags;
@@ -1428,7 +1428,20 @@ void enable_percpu_irq(unsigned int irq)
 	if (!desc)
 		return;
 
+	type &= IRQ_TYPE_SENSE_MASK;
+	if (type != IRQ_TYPE_NONE) {
+		int ret;
+
+		ret = __irq_set_trigger(desc, irq, type);
+
+		if (ret) {
+			WARN(1, "failed to set type for IRQ%d\n, irq");
+			goto out;
+		}
+	}
+
 	irq_percpu_enable(desc, cpu);
+out:
 	irq_put_desc_unlock(desc, flags);
 }
 
-- 
1.7.0.4
