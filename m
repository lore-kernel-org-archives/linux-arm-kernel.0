From: rrichter@cavium.com (Robert Richter)
Date: Wed, 28 Nov 2018 14:43:34 +0000
Subject: [PATCH v2 09/10] irqchip/gic-v3-its: Initialize its nodes later
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
Message-ID: <20181128144240.28727-10-rrichter@cavium.com>
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
 drivers/irqchip/irq-gic-v3.c       | 4 ----
 include/linux/irqchip/arm-gic-v3.h | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fd8561fcfdf3..13cf56c66483 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3920,7 +3920,7 @@ int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	return 0;
 }
 
-int __init its_init(void)
+static int __init its_init(void)
 {
 	struct its_node *its;
 	bool has_v4 = false;
@@ -3982,3 +3982,4 @@ int __init its_init(void)
 
 	return 0;
 }
+subsys_initcall(its_init);
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d2942efdb6d5..01538876ad15 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1323,8 +1323,6 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_of_setup_kvm_info(node);
 
-	its_init();
-
 	return 0;
 
 out_unmap_rdist:
@@ -1628,8 +1626,6 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
 
-	its_init();
-
 	return 0;
 
 out_fwhandle_free:
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index f4348fa4260a..885d5a4e239a 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -604,7 +604,6 @@ struct irq_domain;
 struct fwnode_handle;
 int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	      struct irq_domain *domain);
-int its_init(void);
 int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
 
 static inline bool gic_enable_sre(void)
-- 
2.11.0
