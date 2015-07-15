From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:04:14 +0100
Subject: [PATCH 4/8] pcmcia: pxa2xx: convert memory allocation to devm_* API
In-Reply-To: <20150715180342.GB7557@n2100.arm.linux.org.uk>
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFR2U-0007MS-Lr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the pxa2xx socket driver memory allocation to use devm_kzalloc()
to simplify the cleanup path.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 197c77a64ce0..0f42d55e7c7f 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -302,7 +302,8 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 
 	pxa2xx_drv_pcmcia_ops(ops);
 
-	sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
+	sinfo = devm_kzalloc(&dev->dev, SKT_DEV_INFO_SIZE(ops->nr),
+			     GFP_KERNEL);
 	if (!sinfo)
 		return -ENOMEM;
 
@@ -330,7 +331,7 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 err1:
 	while (--i >= 0)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
-	kfree(sinfo);
+
 err0:
 	return ret;
 }
@@ -340,12 +341,9 @@ static int pxa2xx_drv_pcmcia_remove(struct platform_device *dev)
 	struct skt_dev_info *sinfo = platform_get_drvdata(dev);
 	int i;
 
-	platform_set_drvdata(dev, NULL);
-
 	for (i = 0; i < sinfo->nskt; i++)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
 
-	kfree(sinfo);
 	return 0;
 }
 
-- 
2.1.0
