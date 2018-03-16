From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 16 Mar 2018 14:55:11 +0000
Subject: [PATCH 2/2] irqchip/gic-v3: Loudly complain about the use of
 IRQ_TYPE_NONE
In-Reply-To: <20180316145511.28362-1-marc.zyngier@arm.com>
References: <20180316145511.28362-1-marc.zyngier@arm.com>
Message-ID: <20180316145511.28362-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a huge number of broken device trees out there. Just
grepping through the tree for the use of IRQ_TYPE_NONE in conjunction
with the GIC is scary.

People just don't realise that IRQ_TYPE_NONE just doesn't exist, and
you just get whatever junk was there before. So let's make them aware
of the issue.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3e9eeb6cb294..5bb7bb22f1c1 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -916,6 +916,9 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 		}
 
 		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+		/* Make it clear that broken DTs are... broken */
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
@@ -925,6 +928,8 @@ static int gic_irq_domain_translate(struct irq_domain *d,
 
 		*hwirq = fwspec->param[0];
 		*type = fwspec->param[1];
+
+		WARN_ON(*type == IRQ_TYPE_NONE);
 		return 0;
 	}
 
-- 
2.14.2
