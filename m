From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:20 +0100
Subject: [PATCH v2 01/52] genirq: Let irq_set_vcpu_affinity() iterate over
 hierarchy
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When assigning an interrupt to a vcpu, it is not unlikely that
the level of the hierarchy implementing irq_set_vcpu_affinity
is not the top level (think a generic MSI domain on top of a
virtualization aware interrupt controller).

In such a case, let's iterate over the hierarchy until we find
an irqchip implementing it.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/manage.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 425170d4439b..804fb94e86e6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -431,8 +431,18 @@ int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info)
 		return -EINVAL;
 
 	data = irq_desc_get_irq_data(desc);
-	chip = irq_data_get_irq_chip(data);
-	if (chip && chip->irq_set_vcpu_affinity)
+	do {
+		chip = irq_data_get_irq_chip(data);
+		if (chip && chip->irq_set_vcpu_affinity)
+			break;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+		data = data->parent_data;
+#else
+		data = NULL;
+#endif
+	} while (data);
+
+	if (data)
 		ret = chip->irq_set_vcpu_affinity(data, vcpu_info);
 	irq_put_desc_unlock(desc, flags);
 
-- 
2.11.0
