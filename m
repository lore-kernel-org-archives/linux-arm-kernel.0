From: rrichter@cavium.com (Robert Richter)
Date: Tue,  8 Aug 2017 14:22:56 +0200
Subject: [PATCH v3 6/8] irqchip/gic-v3-its: Initialize its nodes later
In-Reply-To: <20170808122259.6299-1-rrichter@cavium.com>
References: <20170808122259.6299-1-rrichter@cavium.com>
Message-ID: <20170808122259.6299-7-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use an initcall to initialize its. This allows us to use the device
framework during initialization that is up at this point. We use
subsys_initcall() here since we need the arch to be initialized
first. It is before pci and platform device probe where devices are
bound to msi interrupts.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 3 ++-
 drivers/irqchip/irq-gic-v3.c       | 5 -----
 include/linux/irqchip/arm-gic-v3.h | 1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5e2d4f2876d8..488f811d5978 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1994,7 +1994,7 @@ int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	return 0;
 }
 
-int __init its_init(void)
+static int __init its_init(void)
 {
 	struct its_node *its, *tmp;
 	int err = 0, err2;
@@ -2036,3 +2036,4 @@ int __init its_init(void)
 
 	return 0;
 }
+subsys_initcall(its_init);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1476ce12b3b8..32bdfd656ea7 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1167,9 +1167,6 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_populate_ppi_partitions(node);
 	gic_of_setup_kvm_info(node);
-
-	its_init();
-
 	return 0;
 
 out_unmap_rdist:
@@ -1459,8 +1456,6 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
 	gic_acpi_setup_kvm_info();
 
-	its_init();
-
 	return 0;
 
 out_fwhandle_free:
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 15cbedbd82f1..3c375c593800 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -493,7 +493,6 @@ struct irq_domain;
 struct fwnode_handle;
 int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	      struct irq_domain *domain);
-int its_init(void);
 
 static inline bool gic_enable_sre(void)
 {
-- 
2.11.0
