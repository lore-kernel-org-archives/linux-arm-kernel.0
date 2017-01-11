From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Jan 2017 23:06:38 +0800
Subject: [PATCH v7 14/15] irqchip: mbigen: introduce mbigen_of_create_domain()
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1484147199-4267-15-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kefeng Wang <wangkefeng.wang@huawei.com>

Introduce mbigen_of_create_domain() to consolidate OF related
code and prepare for ACPI later, no funtional change.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Reviewed-by: Ma Jun <majun258@huawei.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-mbigen.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index c01ab41..4e11da5 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -236,27 +236,15 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
 	.free		= irq_domain_free_irqs_common,
 };
 
-static int mbigen_device_probe(struct platform_device *pdev)
+static int mbigen_of_create_domain(struct platform_device *pdev,
+				   struct mbigen_device *mgn_chip)
 {
-	struct mbigen_device *mgn_chip;
+	struct device *parent;
 	struct platform_device *child;
 	struct irq_domain *domain;
 	struct device_node *np;
-	struct device *parent;
-	struct resource *res;
 	u32 num_pins;
 
-	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
-	if (!mgn_chip)
-		return -ENOMEM;
-
-	mgn_chip->pdev = pdev;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(mgn_chip->base))
-		return PTR_ERR(mgn_chip->base);
-
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
@@ -280,6 +268,30 @@ static int mbigen_device_probe(struct platform_device *pdev)
 			return -ENOMEM;
 	}
 
+	return 0;
+}
+
+static int mbigen_device_probe(struct platform_device *pdev)
+{
+	struct mbigen_device *mgn_chip;
+	struct resource *res;
+	int err;
+
+	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
+	if (!mgn_chip)
+		return -ENOMEM;
+
+	mgn_chip->pdev = pdev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	mgn_chip->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(mgn_chip->base))
+		return PTR_ERR(mgn_chip->base);
+
+	err = mbigen_of_create_domain(pdev, mgn_chip);
+	if (err)
+		return err;
+
 	platform_set_drvdata(pdev, mgn_chip);
 	return 0;
 }
-- 
1.9.1
