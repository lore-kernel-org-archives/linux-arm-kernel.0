From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 29 Sep 2017 11:51:22 +0100
Subject: [PATCH 6/8] video: sa1100fb: clean up failure path
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
References: <20170929105004.GY20805@n2100.armlinux.org.uk>
Message-ID: <E1dxst8-0006jN-Vn@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We merely return from the failed path, so remove all the gotos and use
return statements instead.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/video/fbdev/sa1100fb.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 7fa6c8f74ec6..16a974471c02 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -1222,41 +1222,36 @@ static int sa1100fb_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	fbi = sa1100fb_init_fbinfo(&pdev->dev);
-	ret = -ENOMEM;
 	if (!fbi)
-		goto failed;
+		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	fbi->base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(fbi->base)) {
-		ret = PTR_ERR(fbi->base);
-		goto failed;
-	}
+	if (IS_ERR(fbi->base))
+		return PTR_ERR(fbi->base);
 
 	fbi->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(fbi->clk)) {
-		ret = PTR_ERR(fbi->clk);
-		goto failed;
-	}
+	if (IS_ERR(fbi->clk))
+		return PTR_ERR(fbi->clk);
 
 	ret = devm_request_irq(&pdev->dev, irq, sa1100fb_handle_irq, 0,
 			       "LCD", fbi);
 	if (ret) {
 		dev_err(&pdev->dev, "request_irq failed: %d\n", ret);
-		goto failed;
+		return ret;
 	}
 
 	if (machine_is_shannon()) {
 		ret = devm_gpio_request_one(&pdev->dev, SHANNON_GPIO_DISP_EN,
 			GPIOF_OUT_INIT_LOW, "display enable");
 		if (ret)
-			goto failed;
+			return ret;
 	}
 
 	/* Initialize video memory */
 	ret = sa1100fb_map_video_memory(fbi);
 	if (ret)
-		goto failed;
+		return ret;
 
 	/*
 	 * This makes sure that our colour bitfield
-- 
2.7.4
