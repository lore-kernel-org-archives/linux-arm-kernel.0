From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  4 Jul 2017 10:56:34 +0100
Subject: [PATCH 2/3] irqchip: gic-v2: Report failures in gic_irq_domain_alloc
In-Reply-To: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
References: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1499162195-5126-3-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the GIC cannot map an IRQ via irq_domain_ops->alloc(), it doesn't
return an error code.  This can cause a problem with drivers, where
it thinks it has successfully got an IRQ for the device, but requesting
the same ends up failure with -ENOSYS (as the IRQ's chip is not set).

Fixes: commit 9a1091ef0017c ("irqchip: gic: Support hierarchy irq domain.")
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/irqchip/irq-gic.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 1b1df4f..940c162 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1027,8 +1027,11 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < nr_irqs; i++)
-		gic_irq_domain_map(domain, virq + i, hwirq + i);
+	for (i = 0; i < nr_irqs; i++) {
+		ret = gic_irq_domain_map(domain, virq + i, hwirq + i);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.7.5
