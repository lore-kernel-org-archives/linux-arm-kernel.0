From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed,  3 Nov 2010 16:29:36 +0100
Subject: [PATCH 2/2] ARM: pxa: Add pxa320 PCMCIA check
In-Reply-To: <1288798176-5019-1-git-send-email-marek.vasut@gmail.com>
References: <1288798176-5019-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1288798176-5019-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On PXA320, there's only one PCMCIA slot available. Check for cases where the
user would want to register multiple. Also, rework failpath.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/pcmcia/pxa2xx_base.c |   37 ++++++++++++++++++++++++-------------
 1 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 380d760..65a8b6f 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -284,14 +284,24 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 	struct soc_pcmcia_socket *skt;
 
 	ops = (struct pcmcia_low_level *)dev->dev.platform_data;
-	if (!ops)
-		return -ENODEV;
+	if (!ops) {
+		ret = -ENODEV;
+		goto err0;
+	}
+
+	if (cpu_is_pxa320() && ops->nr > 1) {
+		dev_err(&dev->dev, "pxa320 supports only one pcmcia slot");
+		ret = -EINVAL;
+		goto err0;
+	}
 
 	pxa2xx_drv_pcmcia_ops(ops);
 
 	sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
-	if (!sinfo)
-		return -ENOMEM;
+	if (!sinfo) {
+		ret = -ENOMEM;
+		goto err0;
+	}
 
 	sinfo->nskt = ops->nr;
 
@@ -307,18 +317,19 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 
 		ret = pxa2xx_drv_pcmcia_add_one(skt);
 		if (ret)
-			break;
+			goto err1;
 	}
 
-	if (ret) {
-		while (--i >= 0)
-			soc_pcmcia_remove_one(&sinfo->skt[i]);
-		kfree(sinfo);
-	} else {
-		pxa2xx_configure_sockets(&dev->dev);
-		dev_set_drvdata(&dev->dev, sinfo);
-	}
+	pxa2xx_configure_sockets(&dev->dev);
+	dev_set_drvdata(&dev->dev, sinfo);
 
+	return 0;
+
+err1:
+	while (--i >= 0)
+		soc_pcmcia_remove_one(&sinfo->skt[i]);
+	kfree(sinfo);
+err0:
 	return ret;
 }
 
-- 
1.7.2.3
