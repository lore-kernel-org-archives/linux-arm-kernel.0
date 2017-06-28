From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:35 +0100
Subject: [PATCH v2 16/52] irqchip/gic-v3-its: Add VLPI configuration hook
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-17-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the skeleton irq_set_vcpu_affinity method that will be used
to configure VLPIs.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 25e53958a618..c02e1e6cd169 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -36,6 +36,7 @@
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqchip/arm-gic-v4.h>
 
 #include <asm/cputype.h>
 #include <asm/exception.h>
@@ -779,6 +780,28 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
 	return 0;
 }
 
+static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
+{
+	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
+	struct its_cmd_info *info = vcpu_info;
+
+	/* Need a v4 ITS */
+	if (!its_dev->its->is_v4 || !info)
+		return -EINVAL;
+
+	switch (info->cmd_type) {
+	case MAP_VLPI:
+
+	case GET_VLPI:
+
+	case PROP_UPDATE_VLPI:
+	case PROP_UPDATE_AND_INV_VLPI:
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct irq_chip its_irq_chip = {
 	.name			= "ITS",
 	.irq_mask		= its_mask_irq,
@@ -787,6 +810,7 @@ static struct irq_chip its_irq_chip = {
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
 	.irq_set_irqchip_state	= its_irq_set_irqchip_state,
+	.irq_set_vcpu_affinity	= its_irq_set_vcpu_affinity,
 };
 
 /*
-- 
2.11.0
