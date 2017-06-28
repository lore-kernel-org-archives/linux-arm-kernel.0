From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 28 Jun 2017 16:03:43 +0100
Subject: [PATCH v2 24/52] irqchip/gic-v3-its: Add VPE invalidation hook
In-Reply-To: <20170628150411.15846-1-marc.zyngier@arm.com>
References: <20170628150411.15846-1-marc.zyngier@arm.com>
Message-ID: <20170628150411.15846-25-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a guest issues a INVALL command targetting a collection, it must
be translated into a VINVALL for the VPE that has this collection.

This patch implements a hook that offers this functionallity to the
hypervisor.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index be8598354d5a..0eda36dc84b4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2211,6 +2211,10 @@ static int its_vpe_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 		its_vpe_deschedule(vpe);
 		return 0;
 
+	case INVALL_VPE:
+		its_send_vinvall(vpe);
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
-- 
2.11.0
