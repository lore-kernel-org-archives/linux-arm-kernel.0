From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue,  7 Jun 2016 14:30:57 +0100
Subject: [RFC PATCH v2 02/15] drivers: irqchip: its: fix its_acpi_probe()
 prototype
In-Reply-To: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1465306270-27076-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The empty stub for its_acpi_probe() on !CONFIG_ACPI systems has
a wrong prototype, which causes compilation errors:

drivers/irqchip/irq-gic-v3-its.c: In function 'its_init':
drivers/irqchip/irq-gic-v3-its.c:1762:3: error: too few arguments to
function 'its_acpi_probe'
   its_acpi_probe();
   ^
drivers/irqchip/irq-gic-v3-its.c:1749:27: note: declared here
 static inline void __init its_acpi_probe(struct irq_domain
*parent_domain) { }

This patch fixes the prototype and the corresponding compilation
errors.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c8f36a5..1846800 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1700,7 +1700,7 @@ void __init its_acpi_probe(void)
 		pr_info("No valid GIC ITS entries exist\n");
 }
 #else
-static inline void __init its_acpi_probe(struct irq_domain *parent_domain) { }
+static inline void __init its_acpi_probe(void) { }
 #endif
 
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
-- 
2.6.4
