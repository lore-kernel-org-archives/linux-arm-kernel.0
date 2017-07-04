From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  4 Jul 2017 10:56:33 +0100
Subject: [PATCH 1/3] irqchip: gic-v3: Report failures in gic_irq_domain_alloc
In-Reply-To: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
References: <1499162195-5126-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1499162195-5126-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the GIC cannot map an IRQ via irq_domain_ops->alloc(), it doesn't
return an error code.  This can cause a problem with drivers, where
it thinks it has successfully got an IRQ for the device, but requesting
the same ends up failure with -ENOSYS (as the IRQ's chip is not set).

Fixes: commit 443acc4f37f6 ("irqchip: GICv3: Convert to domain hierarchy")
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fc037d9..ea82342 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -835,8 +835,11 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
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
