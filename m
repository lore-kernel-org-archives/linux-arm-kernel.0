From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 15:55:27 +0200
Subject: [PATCH 07/17] irqchip/irq-mvebu-icu: make irq_domain local
In-Reply-To: <20180421135537.24716-1-miquel.raynal@bootlin.com>
References: <20180421135537.24716-1-miquel.raynal@bootlin.com>
Message-ID: <20180421135537.24716-8-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the current MSI irq_domain local to ease the split between ICU
platform device code and NSR platform device code.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/irqchip/irq-mvebu-icu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 580586240781..493c9625d48b 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -43,7 +43,6 @@
 struct mvebu_icu {
 	struct irq_chip irq_chip;
 	struct regmap *regmap;
-	struct irq_domain *domain;
 	struct device *dev;
 };
 
@@ -198,6 +197,7 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 	struct mvebu_icu *icu;
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *gicp_dn;
+	struct irq_domain *irq_domain;
 	struct resource *res;
 	phys_addr_t setspi, clrspi;
 	int ret;
@@ -269,11 +269,11 @@ static int mvebu_icu_probe(struct platform_device *pdev)
 			regmap_write(icu->regmap, ICU_INT_CFG(i), 0);
 	}
 
-	icu->domain =
+	irq_domain =
 		platform_msi_create_device_domain(&pdev->dev, ICU_MAX_IRQS,
 						  mvebu_icu_write_msg,
 						  &mvebu_icu_domain_ops, icu);
-	if (!icu->domain) {
+	if (!irq_domain) {
 		dev_err(&pdev->dev, "Failed to create ICU domain\n");
 		return -ENOMEM;
 	}
-- 
2.14.1
