From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 29 Jul 2015 18:08:54 +0800
Subject: [PATCH v4 05/10] irqchip / GICv3: remove the useless comparision of
 device node in xlate
In-Reply-To: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
References: <1438164539-29256-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1438164539-29256-6-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In gic_irq_domain_xlate(), we match the domain's device node to the
controller and it turns out pretty useless, because we're always
registering the GIC domain with its device_node on DT, this is really
guaranteed to match.

Since we unify the way of matching irqdomain in DT and ACPI, this is
also a blocker of making this function usable in the context
of ACPI, so just remove it.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/irqchip/irq-gic-v3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 19a65de..c0b96c6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -706,8 +706,6 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 				const u32 *intspec, unsigned int intsize,
 				unsigned long *out_hwirq, unsigned int *out_type)
 {
-	if (irq_domain_get_of_node(d) != controller)
-		return -EINVAL;
 	if (intsize < 3)
 		return -EINVAL;
 
-- 
1.9.1
