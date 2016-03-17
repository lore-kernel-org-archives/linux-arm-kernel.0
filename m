From: david@lechnology.com (David Lechner)
Date: Wed, 16 Mar 2016 21:26:43 -0500
Subject: [PATCH v2 10/11] usb: musb: da8xx: Use devm in probe
In-Reply-To: <1458181615-27782-1-git-send-email-david@lechnology.com>
References: <1458181615-27782-1-git-send-email-david@lechnology.com>
Message-ID: <1458181615-27782-11-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simplify things a bit by using devm functions where possible.

Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes: This is part of a previous patch that was split. No changes from
previous version.


 drivers/usb/musb/da8xx.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index b03d3b8..50f07a5 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -489,32 +489,27 @@ static int da8xx_probe(struct platform_device *pdev)
 	struct platform_device		*musb;
 	struct da8xx_glue		*glue;
 	struct platform_device_info	pinfo;
-	struct clk			*clk;
+	int				ret;
 
-	int				ret = -ENOMEM;
-
-	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
+	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
 		dev_err(&pdev->dev, "failed to allocate glue context\n");
-		goto err0;
+		return -ENOMEM;
 	}
 
-	clk = clk_get(&pdev->dev, "usb20");
-	if (IS_ERR(clk)) {
+	glue->clk = devm_clk_get(&pdev->dev, "usb20");
+	if (IS_ERR(glue->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
-		ret = PTR_ERR(clk);
-		goto err3;
+		return PTR_ERR(glue->clk);
 	}
 
-	ret = clk_enable(clk);
+	ret = clk_enable(glue->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to enable clock\n");
 		goto err4;
 	}
 
 	glue->dev			= &pdev->dev;
-	glue->clk			= clk;
-
 	pdata->platform_ops		= &da8xx_ops;
 
 	glue->phy = usb_phy_generic_register();
@@ -557,15 +552,10 @@ err6:
 	usb_phy_generic_unregister(glue->phy);
 
 err5:
-	clk_disable(clk);
+	clk_disable(glue->clk);
 
 err4:
-	clk_put(clk);
-
-err3:
-	kfree(glue);
 
-err0:
 	return ret;
 }
 
@@ -576,8 +566,6 @@ static int da8xx_remove(struct platform_device *pdev)
 	platform_device_unregister(glue->musb);
 	usb_phy_generic_unregister(glue->phy);
 	clk_disable(glue->clk);
-	clk_put(glue->clk);
-	kfree(glue);
 
 	return 0;
 }
-- 
1.9.1
