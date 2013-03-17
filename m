From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Sun, 17 Mar 2013 14:07:17 +0100
Subject: [PATCH v3 4/6] irqchip: s3c24xx: use irq_create_mapping for parent
 irqs
In-Reply-To: <201303171404.06146.heiko@sntech.de>
References: <201303171404.06146.heiko@sntech.de>
Message-ID: <201303171407.17660.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting the parent irq number thru irq_find_mapping will fail for non-legacy
irq_domains, as the mapping of the parent irq won't have been created.

As irq_create_mapping will just output an already mapped irq number if its
already mapped, this does also not influence the legacy mappings.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/irqchip/irq-s3c24xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index a565eb8..1eba289 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -429,7 +429,7 @@ static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
 		parent_irq_data->sub_bits |= (1UL << hw);
 
 		/* attach the demuxer to the parent irq */
-		irqno = irq_find_mapping(parent_intc->domain,
+		irqno = irq_create_mapping(parent_intc->domain,
 					 irq_data->parent_irq);
 		if (!irqno) {
 			pr_err("irq-s3c24xx: could not find mapping for parent irq %lu\n",
-- 
1.7.2.3
