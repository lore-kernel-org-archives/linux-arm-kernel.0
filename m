From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 13:24:52 +0100
Subject: [PATCH] irqchip/tegra: fix fix sparse warnings on __iomem
Message-ID: <1465302292-4840-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following warnings from sparse due to casting to/from __iomem
annotated variables:

drivers/irqchip/irq-tegra.c:93:31: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-tegra.c:93:31:    expected void [noderef] <asn:2>*base
drivers/irqchip/irq-tegra.c:93:31:    got void *chip_data
drivers/irqchip/irq-tegra.c:93:31: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-tegra.c:93:31:    expected void [noderef] <asn:2>*base
drivers/irqchip/irq-tegra.c:93:31:    got void *chip_data
drivers/irqchip/irq-tegra.c:93:31: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-tegra.c:93:31:    expected void [noderef] <asn:2>*base
drivers/irqchip/irq-tegra.c:93:31:    got void *chip_data
drivers/irqchip/irq-tegra.c:93:31: warning: incorrect type in initializer (different address spaces)
drivers/irqchip/irq-tegra.c:93:31:    expected void [noderef] <asn:2>*base
drivers/irqchip/irq-tegra.c:93:31:    got void *chip_data
drivers/irqchip/irq-tegra.c:269:57: warning: incorrect type in argument 5 (different address spaces)
drivers/irqchip/irq-tegra.c:269:57:    expected void *chip_data
drivers/irqchip/irq-tegra.c:269:57:    got void [noderef] <asn:2>*<noident>

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-tegra at vger.kernel.org
---
 drivers/irqchip/irq-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index e902f08..3973a14 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -90,7 +90,7 @@ static struct tegra_ictlr_info *lic;
 
 static inline void tegra_ictlr_write_mask(struct irq_data *d, unsigned long reg)
 {
-	void __iomem *base = d->chip_data;
+	void __iomem *base = (void __iomem __force *)d->chip_data;
 	u32 mask;
 
 	mask = BIT(d->hwirq % 32);
@@ -266,7 +266,7 @@ static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
 
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
 					      &tegra_ictlr_chip,
-					      info->base[ictlr]);
+					      (void __force *)info->base[ictlr]);
 	}
 
 	parent_fwspec = *fwspec;
-- 
2.8.1
