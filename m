From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 8 Apr 2016 15:16:02 +0800
Subject: [PATCH] irqchip/mbigen: Display message of MBIGEN domain created
Message-ID: <1460099762-51497-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add message of MBIGEN domain created, it's useful for check
which MBIGEN domain is created.

Meanwhile, drop module owner, it will be set by driver core.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/irqchip/irq-mbigen.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index d67baa2..a4dc7a0 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -257,14 +257,19 @@ static int mbigen_device_probe(struct platform_device *pdev)
 	if (IS_ERR(mgn_chip->base))
 		return PTR_ERR(mgn_chip->base);
 
+	dev_info(&pdev->dev, "%s\n", pdev->dev.of_node->full_name);
+
 	for_each_child_of_node(pdev->dev.of_node, np) {
 		if (!of_property_read_bool(np, "interrupt-controller"))
 			continue;
 
 		parent = platform_bus_type.dev_root;
 		child = of_platform_device_create(np, NULL, parent);
-		if (IS_ERR(child))
+		if (IS_ERR(child)) {
+			dev_err(&pdev->dev, "failed to create for %s\n",
+				np->full_name);
 			return PTR_ERR(child);
+		}
 
 		if (of_property_read_u32(child->dev.of_node, "num-pins",
 					 &num_pins) < 0) {
@@ -276,8 +281,13 @@ static int mbigen_device_probe(struct platform_device *pdev)
 							   mbigen_write_msg,
 							   &mbigen_domain_ops,
 							   mgn_chip);
-		if (!domain)
+		if (!domain) {
+			dev_info(&pdev->dev, "unable to create %s domain\n",
+				 np->full_name);
 			return -ENOMEM;
+		}
+
+		dev_info(&pdev->dev, "%s domain created\n", np->full_name);
 	}
 
 	platform_set_drvdata(pdev, mgn_chip);
@@ -293,7 +303,6 @@ MODULE_DEVICE_TABLE(of, mbigen_of_match);
 static struct platform_driver mbigen_platform_driver = {
 	.driver = {
 		.name		= "Hisilicon MBIGEN-V2",
-		.owner		= THIS_MODULE,
 		.of_match_table	= mbigen_of_match,
 	},
 	.probe			= mbigen_device_probe,
-- 
1.7.12.4
