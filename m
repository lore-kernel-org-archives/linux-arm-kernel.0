From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 17 Jan 2017 10:20:46 +0000
Subject: [RFC PATCH 25/33] irqchip/gic-v3-its: Add VPE invalidation hook
In-Reply-To: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1484648454-21216-26-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a guest issues a INVALL command targetting a collection, it must
be translated into a VINVALL for the VPE that has this collection.

This patch implements a hook that offers this functionallity to the
hypervisor.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f918d59..51a1930 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2090,6 +2090,12 @@ static int its_vpe_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
 		return 0;
 	}
 
+	case INVALL_VPE:
+	{
+		its_send_vinvall(vpe);
+		return 0;
+	}
+
 	default:
 		return -EINVAL;
 	}
-- 
2.1.4
