From: rrichter@cavium.com (Robert Richter)
Date: Wed, 1 Feb 2017 18:38:31 +0100
Subject: [PATCH 7/9] irqchip/gic-v3-its: Initialize its nodes later
In-Reply-To: <20170201173833.12630-1-rrichter@cavium.com>
References: <20170201173833.12630-1-rrichter@cavium.com>
Message-ID: <20170201173833.12630-8-rrichter@cavium.com>
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
index 68b468686d5b..e915bb393c87 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1897,7 +1897,7 @@ int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	return 0;
 }
 
-int __init its_init(void)
+static int __init its_init(void)
 {
 	struct its_node *its, *tmp;
 	int err = 0, err2;
@@ -1938,3 +1938,4 @@ int __init its_init(void)
 
 	return 0;
 }
+subsys_initcall(its_init);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 2b9be256a9ec..69da7c1ccbf2 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1164,9 +1164,6 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_populate_ppi_partitions(node);
 	gic_of_setup_kvm_info(node);
-
-	its_init();
-
 	return 0;
 
 out_unmap_rdist:
@@ -1456,8 +1453,6 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
 	gic_acpi_setup_kvm_info();
 
-	its_init();
-
 	return 0;
 
 out_fwhandle_free:
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 8bc5c137b059..4cd6e6c3cbcf 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -433,7 +433,6 @@ struct irq_domain;
 struct fwnode_handle;
 int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	      struct irq_domain *domain);
-int its_init(void);
 
 static inline bool gic_enable_sre(void)
 {
-- 
2.11.0
