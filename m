From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 15 Nov 2014 10:49:13 +0000
Subject: [PATCH 2/2] genirq: Work around __irq_set_handler vs stacked domains
 ordering issues
In-Reply-To: <1416048553-29289-1-git-send-email-marc.zyngier@arm.com>
References: <1416048553-29289-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1416048553-29289-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of stacked domains, we have the issue that,
depending on where in the stack this is called, __irq_set_handler
will succeed or fail: If this is called from the inner irqchip,
__irq_set_handler() will fail, as it will look at the outer domain
as the (desc->irq_data.chip == &no_irq_chip) test fails (we haven't
set the top level yet).

This patch implements the following: "If there is at least one
valid irqchip in the domain, it will probably sort itself out".
This is clearly not ideal, but it is far less confusing then
crashing because the top-level domain is not up yet.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/chip.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index d028b34..cad4f62 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -731,7 +731,16 @@ __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
 	if (!handle) {
 		handle = handle_bad_irq;
 	} else {
-		if (WARN_ON(desc->irq_data.chip == &no_irq_chip))
+		struct irq_data *irq_data = &desc->irq_data;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+		while (irq_data) {
+			if (irq_data->chip != &no_irq_chip)
+				break;
+			irq_data = irq_data->parent_data;
+		}
+#endif
+
+		if (WARN_ON(!irq_data || irq_data->chip == &no_irq_chip))
 			goto out;
 	}
 
-- 
2.1.0
