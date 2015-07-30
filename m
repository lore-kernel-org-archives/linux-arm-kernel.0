From: vthakkar1994@gmail.com (Vaishali Thakkar)
Date: Thu, 30 Jul 2015 08:42:58 +0530
Subject: [PATCH] soc: versatile: Use devm_kzalloc
Message-ID: <20150730031257.GA3133@vaishali-Ideapad-Z570>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch introduces the use of devm_kzalloc and does away
with kfree in the probe function.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/soc/versatile/soc-realview.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index e642c45..0889710 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -103,7 +103,8 @@ static int realview_soc_probe(struct platform_device *pdev)
 	if (IS_ERR(syscon_regmap))
 		return PTR_ERR(syscon_regmap);
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(&pdev->dev, sizeof(*soc_dev_attr),
+				    GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -115,10 +116,9 @@ static int realview_soc_probe(struct platform_device *pdev)
 	soc_dev_attr->machine = "RealView";
 	soc_dev_attr->family = "Versatile";
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr);
+	if (IS_ERR(soc_dev))
 		return -ENODEV;
-	}
+
 	ret = regmap_read(syscon_regmap, REALVIEW_SYS_ID_OFFSET,
 			  &realview_coreid);
 	if (ret)
-- 
1.9.1
