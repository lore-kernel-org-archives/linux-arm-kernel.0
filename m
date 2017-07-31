From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 31 Jul 2017 18:25:54 +0100
Subject: [PATCH v3 16/59] irqchip/gic-v3-its: Add VLPI configuration hook
In-Reply-To: <20170731172637.29355-1-marc.zyngier@arm.com>
References: <20170731172637.29355-1-marc.zyngier@arm.com>
Message-ID: <20170731172637.29355-17-marc.zyngier@arm.com>
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
index bc396ab24037..9ef4f161690a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -36,6 +36,7 @@
 
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-gic-v3.h>
+#include <linux/irqchip/arm-gic-v4.h>
 
 #include <asm/cputype.h>
 #include <asm/exception.h>
@@ -780,6 +781,28 @@ static int its_irq_set_irqchip_state(struct irq_data *d,
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
@@ -788,6 +811,7 @@ static struct irq_chip its_irq_chip = {
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
 	.irq_set_irqchip_state	= its_irq_set_irqchip_state,
+	.irq_set_vcpu_affinity	= its_irq_set_vcpu_affinity,
 };
 
 /*
-- 
2.11.0
