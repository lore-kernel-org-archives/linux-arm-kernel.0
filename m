From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon,  3 Mar 2014 12:51:38 -0700
Subject: [PATCH V3 3/5] irqchip: gic: parse IRQ specifier flag src/dst
 inversion
In-Reply-To: <1393876300-3061-1-git-send-email-swarren@wwwdotorg.org>
References: <1393876300-3061-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1393876300-3061-3-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Modify the GIC driver to parse IRQ specifier flag bit 4 (src/dst
inverted) in the xlate function.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v3: New patch.
---
 drivers/irqchip/irq-gic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 500e533b9648..97800b349f54 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -847,6 +847,9 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 		*out_hwirq += 16;
 
 	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
+	if (intspec[2] & BIT(4))
+		*out_type |= IRQ_SRC_DST_INVERTED;
+
 	return 0;
 }
 
-- 
1.8.1.5
