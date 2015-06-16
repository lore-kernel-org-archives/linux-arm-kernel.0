From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jun 2015 23:06:20 +0100
Subject: [PATCH 1/9] irq: add irq_set_chained_handler_and_data()
Message-ID: <E1Z4yzs-0002Rw-4B@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Driver authors seem to get the ordering of irq_set_chained_handler()
and irq_set_handler_data() wrong - ordering the former before the
latter.  This opens a race window where, if there is an interrupt
pending, the handler will be called between these two calls,
potentially resulting in an oops.

Provide a single interface to set both of these together, especially
as that's commonly what is required.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
It probably makes sense to convert everything over to this new
registration function, and kill all users of irq_set_chained_handler()
to prevent this problem recurring.  Thoughts?

 include/linux/irq.h |  9 +++++++++
 kernel/irq/chip.c   | 45 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 62c6901cab55..4942cbc379bb 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -517,6 +517,15 @@ irq_set_chained_handler(unsigned int irq, irq_flow_handler_t handle)
 	__irq_set_handler(irq, handle, 1, NULL);
 }
 
+/*
+ * Set a highlevel chained flow handler and its data for a given IRQ.
+ * (a chained handler is automatically enabled and set to
+ *  IRQ_NOREQUEST, IRQ_NOPROBE, and IRQ_NOTHREAD)
+ */
+void
+irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
+				 void *data);
+
 void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set);
 
 static inline void irq_set_status_flags(unsigned int irq, unsigned long set)
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index eb9a4ea394ab..92bed9010bc6 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -719,15 +719,9 @@ void handle_percpu_devid_irq(unsigned int irq, struct irq_desc *desc)
 }
 
 void
-__irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
-		  const char *name)
+__irq_do_set_handler(struct irq_desc *desc, irq_flow_handler_t handle,
+		     int is_chained, const char *name)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, 0);
-
-	if (!desc)
-		return;
-
 	if (!handle) {
 		handle = handle_bad_irq;
 	} else {
@@ -749,13 +743,13 @@ __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
 			 * right away.
 			 */
 			if (WARN_ON(is_chained))
-				goto out;
+				return;
 			/* Try the parent */
 			irq_data = irq_data->parent_data;
 		}
 #endif
 		if (WARN_ON(!irq_data || irq_data->chip == &no_irq_chip))
-			goto out;
+			return;
 	}
 
 	/* Uninstall? */
@@ -774,12 +768,41 @@ __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
 		irq_settings_set_nothread(desc);
 		irq_startup(desc, true);
 	}
-out:
+}
+
+void
+__irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
+		  const char *name)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, 0);
+
+	if (!desc)
+		return;
+
+	__irq_do_set_handler(desc, handle, is_chained, name);
 	irq_put_desc_busunlock(desc, flags);
 }
 EXPORT_SYMBOL_GPL(__irq_set_handler);
 
 void
+irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
+				 void *data)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_get_desc_buslock(irq, &flags, 0);
+
+	if (!desc)
+		return;
+
+	__irq_do_set_handler(desc, handle, 1, NULL);
+	desc->irq_data.handler_data = data;
+	
+	irq_put_desc_busunlock(desc, flags);
+}
+EXPORT_SYMBOL_GPL(irq_set_chained_handler_and_data);
+
+void
 irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name)
 {
-- 
2.1.0
