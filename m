From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:04:09 +0100
Subject: [PATCH 3/8] pcmcia: pxa2xx: update socket driver to use
 devm_clk_get() API
In-Reply-To: <20150715180342.GB7557@n2100.arm.linux.org.uk>
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFR2P-0007MM-Gp@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the pxa2xx socket driver to use the devm_clk_get() API so that
the cleanup paths are simplified.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 984a8ff559d8..197c77a64ce0 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -296,17 +296,15 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 		goto err0;
 	}
 
-	clk = clk_get(&dev->dev, NULL);
+	clk = devm_clk_get(&dev->dev, NULL);
 	if (IS_ERR(clk))
 		return -ENODEV;
 
 	pxa2xx_drv_pcmcia_ops(ops);
 
 	sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
-	if (!sinfo) {
-		clk_put(clk);
+	if (!sinfo)
 		return -ENOMEM;
-	}
 
 	sinfo->nskt = ops->nr;
 	sinfo->clk = clk;
@@ -332,7 +330,6 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 err1:
 	while (--i >= 0)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
-	clk_put(clk);
 	kfree(sinfo);
 err0:
 	return ret;
@@ -348,7 +345,6 @@ static int pxa2xx_drv_pcmcia_remove(struct platform_device *dev)
 	for (i = 0; i < sinfo->nskt; i++)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
 
-	clk_put(sinfo->clk);
 	kfree(sinfo);
 	return 0;
 }
-- 
2.1.0
