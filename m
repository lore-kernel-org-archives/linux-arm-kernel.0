From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat,  2 Apr 2011 03:43:17 +0200
Subject: [PATCH 3/3] PXA: Reorganise pxa2xx_base init() function
In-Reply-To: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
References: <1301708597-7413-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1301708597-7413-3-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This kills dead code and kills some redundant code.

Original idea by: Cyril Hrubis <metan@ucw.cz>

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_base.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 2c54054..687d203 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -296,18 +296,20 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 		goto err0;
 	}
 
-	clk = clk_get(&dev->dev, NULL);
-	if (!clk)
-		return -ENODEV;
-
-	pxa2xx_drv_pcmcia_ops(ops);
-
 	sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
 	if (!sinfo) {
-		clk_put(clk);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err0;
 	}
 
+	clk = clk_get(&dev->dev, NULL);
+	if (!clk) {
+		ret = -ENODEV;
+		goto err0;
+	}
+
+	pxa2xx_drv_pcmcia_ops(ops);
+
 	sinfo->nskt = ops->nr;
 	sinfo->clk = clk;
 
@@ -327,15 +329,8 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 			goto err1;
 	}
 
-	if (ret) {
-		while (--i >= 0)
-			soc_pcmcia_remove_one(&sinfo->skt[i]);
-		kfree(sinfo);
-		clk_put(clk);
-	} else {
-		pxa2xx_configure_sockets(&dev->dev);
-		dev_set_drvdata(&dev->dev, sinfo);
-	}
+	pxa2xx_configure_sockets(&dev->dev);
+	dev_set_drvdata(&dev->dev, sinfo);
 
 	return 0;
 
@@ -343,6 +338,7 @@ err1:
 	while (--i >= 0)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
 	kfree(sinfo);
+	clk_put(clk);
 err0:
 	return ret;
 }
-- 
1.7.4.1
