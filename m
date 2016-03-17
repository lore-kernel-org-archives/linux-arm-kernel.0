From: majun258@huawei.com (MaJun)
Date: Thu, 17 Mar 2016 16:34:01 +0800
Subject: [PATCH v3 2/2] irqchip/mbigen:Change the mbigen driver based on the
 new mbigen node definition.
In-Reply-To: <1458203641-17172-1-git-send-email-majun258@huawei.com>
References: <1458203641-17172-1-git-send-email-majun258@huawei.com>
Message-ID: <1458203641-17172-3-git-send-email-majun258@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ma Jun <majun258@huawei.com>

In current mbigen driver, each mbigen device is initialized as a platform device.
When these devices belong to same mbigen hardware module(chip), they use the
same register definition in their device node and caused the problem of registers
remapped repeatedly.

Now, I try to initialize the mbigen module(chip) as a platform device and remap
the register once to fix this problem.

Signed-off-by: Ma Jun <majun258@huawei.com>
---
 drivers/irqchip/irq-mbigen.c |   30 +++++++++++++++++++++---------
 1 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 4dd3eb8..4d413bc 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -242,6 +242,8 @@ static int mbigen_device_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct irq_domain *domain;
 	u32 num_pins;
+	struct platform_device *child_pdev;
+	struct device_node *np;
 
 	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
 	if (!mgn_chip)
@@ -251,25 +253,35 @@ static int mbigen_device_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
+
 	if (IS_ERR(mgn_chip->base))
 		return PTR_ERR(mgn_chip->base);
 
-	if (of_property_read_u32(pdev->dev.of_node, "num-pins", &num_pins) < 0) {
-		dev_err(&pdev->dev, "No num-pins property\n");
-		return -EINVAL;
-	}
+	for_each_child_of_node(pdev->dev.of_node, np) {
+		if (!of_property_read_bool(np, "interrupt-controller"))
+			continue;
+
+		child_pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
+		if (IS_ERR(child_pdev))
+			return PTR_ERR(child_pdev);
+
+		if (of_property_read_u32(child_pdev->dev.of_node, "num-pins", &num_pins) < 0) {
+			dev_err(&pdev->dev, "No num-pins property\n");
+			return -EINVAL;
+		}
 
-	domain = platform_msi_create_device_domain(&pdev->dev, num_pins,
+		domain = platform_msi_create_device_domain(&child_pdev->dev, num_pins,
 							mbigen_write_msg,
 							&mbigen_domain_ops,
 							mgn_chip);
 
-	if (!domain)
-		return -ENOMEM;
+		if (!domain)
+			return -ENOMEM;
 
-	platform_set_drvdata(pdev, mgn_chip);
+		dev_info(&child_pdev->dev, "Allocated %d MSIs\n", num_pins);
+	}
 
-	dev_info(&pdev->dev, "Allocated %d MSIs\n", num_pins);
+	platform_set_drvdata(pdev, mgn_chip);
 
 	return 0;
 }
-- 
1.7.1
