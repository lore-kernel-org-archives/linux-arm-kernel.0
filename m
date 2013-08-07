From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  7 Aug 2013 11:32:27 +0200
Subject: [PATCHv7 06/13] irqdomain: add support to associate an irq_domain
 with a msi_chip
In-Reply-To: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375867954-2320-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1375867954-2320-7-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Message Signaled Interrupts are a PCI-specific mechanism that allows
PCI devices to notify interrupts to the CPU using in-band
messages. The PCI subsystem represents an MSI-capable interrupt
controller as an msi_chip structure, and this patch improves the
irqdomain subsystem with a new pointer associating an irq_domain with
the corresponding msi_chip.

The irq_domain structure gains a pointer to a msi_chip structure, and
a new helper function irq_domain_add_msi() is added to help in
allocating, initializing and registering an irq_domain for a MSI-type
interrupt controller.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Daniel Price <daniel.price@gmail.com>
---
 include/linux/irqdomain.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 7113941..b0504ff 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -38,6 +38,7 @@
 struct device_node;
 struct irq_domain;
 struct of_device_id;
+struct msi_chip;
 
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
@@ -101,6 +102,7 @@ struct irq_domain {
 	/* Optional data */
 	struct device_node *of_node;
 	struct irq_domain_chip_generic *gc;
+	struct msi_chip *msi_chip;
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t hwirq_max;
@@ -177,6 +179,22 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 		__irq_domain_register(d);
 	return d;
 }
+static inline struct irq_domain *irq_domain_add_msi(struct device_node *of_node,
+						    unsigned int size,
+						    const struct irq_domain_ops *ops,
+						    struct msi_chip *msi_chip,
+						    void *host_data)
+{
+	struct irq_domain *d;
+	d = __irq_domain_alloc(of_node, size, size, 0, ops, host_data);
+	if (d) {
+		d->msi_chip = msi_chip;
+		__irq_domain_register(d);
+	}
+
+	return d;
+}
+
 
 extern void irq_domain_remove(struct irq_domain *host);
 
-- 
1.8.1.2
