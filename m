From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:04:04 +0100
Subject: [PATCH 2/8] pcmcia: sa11x0: convert memory allocation to devm_* API
In-Reply-To: <20150715180342.GB7557@n2100.arm.linux.org.uk>
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFR2K-0007MF-Ci@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the sa11x0 socket driver memory allocation to use devm_kzalloc()
to simplify the cleanup path.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/sa1100_generic.c | 1 -
 drivers/pcmcia/sa11xx_base.c    | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 42861cc70158..66acdc85727c 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -93,7 +93,6 @@ static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
 	for (i = 0; i < sinfo->nskt; i++)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
 
-	kfree(sinfo);
 	return 0;
 }
 
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 553d70a67f80..6e6336d47d4a 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -228,7 +228,7 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 
 	sa11xx_drv_pcmcia_ops(ops);
 
-	sinfo = kzalloc(SKT_DEV_INFO_SIZE(nr), GFP_KERNEL);
+	sinfo = devm_kzalloc(dev, SKT_DEV_INFO_SIZE(nr), GFP_KERNEL);
 	if (!sinfo)
 		return -ENOMEM;
 
@@ -251,7 +251,6 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 	if (ret) {
 		while (--i >= 0)
 			soc_pcmcia_remove_one(&sinfo->skt[i]);
-		kfree(sinfo);
 	} else {
 		dev_set_drvdata(dev, sinfo);
 	}
-- 
2.1.0
