From: axel.lin@gmail.com (Axel Lin)
Date: Fri, 02 Dec 2011 19:25:07 +0800
Subject: [PATCH] ARM: pxa: fix error handling in pxa2xx_drv_pcmcia_probe
Message-ID: <1322825107.16787.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If pxa2xx_drv_pcmcia_add_one fails, it will go to err1 error path.
Add a missing clk_put in the error path.

Checking the ret value after the for loop is redundant, it is always false.
Thus remove the redundant checking.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/pcmcia/pxa2xx_base.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index a87e272..64d433e 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -328,21 +328,15 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
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
 
 err1:
 	while (--i >= 0)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
+	clk_put(clk);
 	kfree(sinfo);
 err0:
 	return ret;
-- 
1.7.5.4
