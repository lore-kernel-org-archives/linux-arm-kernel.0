From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 11 Sep 2015 15:50:10 -0700
Subject: [PATCH 4.1 69/78] genirq: Introduce irq_chip_set_type_parent() helper
In-Reply-To: <20150911224606.758437370@linuxfoundation.org>
References: <20150911224606.758437370@linuxfoundation.org>
Message-ID: <20150911224616.466370883@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grygorii Strashko <grygorii.strashko@ti.com>

commit b7560de198222994374c1340a389f12d5efb244a upstream.

This helper is required for irq chips which do not implement a
irq_set_type callback and need to call down the irq domain hierarchy
for the actual trigger type change.

This helper is required to fix further wreckage caused by the
conversion of TI OMAP to hierarchical irq domains and therefor tagged
for stable.

[ tglx: Massaged changelog ]

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: <linux@arm.linux.org.uk>
Cc: <nsekhar@ti.com>
Cc: <jason@lakedaemon.net>
Cc: <balbi@ti.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: <tony@atomide.com>
Cc: <marc.zyngier@arm.com>
Cc: stable at vger.kernel.org # 4.1
Link: http://lkml.kernel.org/r/1439554830-19502-3-git-send-email-grygorii.strashko at ti.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/irq.h |    1 +
 kernel/irq/chip.c   |   17 +++++++++++++++++
 2 files changed, 18 insertions(+)

--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -467,6 +467,7 @@ extern int irq_chip_set_affinity_parent(
 					const struct cpumask *dest,
 					bool force);
 extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);
+extern int irq_chip_set_type_parent(struct irq_data *data, unsigned int type);
 #endif
 
 /* Handling of unhandled and spurious interrupts: */
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -934,6 +934,23 @@ int irq_chip_set_affinity_parent(struct
 }
 
 /**
+ * irq_chip_set_type_parent - Set IRQ type on the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ * @type:	IRQ_TYPE_{LEVEL,EDGE}_* value - see include/linux/irq.h
+ *
+ * Conditional, as the underlying parent chip might not implement it.
+ */
+int irq_chip_set_type_parent(struct irq_data *data, unsigned int type)
+{
+	data = data->parent_data;
+
+	if (data->chip->irq_set_type)
+		return data->chip->irq_set_type(data, type);
+
+	return -ENOSYS;
+}
+
+/**
  * irq_chip_retrigger_hierarchy - Retrigger an interrupt in hardware
  * @data:	Pointer to interrupt specific data
  *
