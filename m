From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 15 Jul 2015 19:03:59 +0100
Subject: [PATCH 1/8] pcmcia: sa11x0: fix missing clk_put() in sa11x0 socket
 drivers
In-Reply-To: <20150715180342.GB7557@n2100.arm.linux.org.uk>
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZFR2F-0007JP-8b@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the lack of clk_put() in sa11xx_base.c's error cleanup paths by
converting the driver to the devm_* API.

Fixes: 86d88bfca475 ("ARM: 8247/2: pcmcia: sa1100: make use of device clock")
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/sa1100_generic.c | 1 -
 drivers/pcmcia/sa11xx_base.c    | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 803945259da8..42861cc70158 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -93,7 +93,6 @@ static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
 	for (i = 0; i < sinfo->nskt; i++)
 		soc_pcmcia_remove_one(&sinfo->skt[i]);
 
-	clk_put(sinfo->clk);
 	kfree(sinfo);
 	return 0;
 }
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index cf6de2c2b329..553d70a67f80 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -222,7 +222,7 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 	int i, ret = 0;
 	struct clk *clk;
 
-	clk = clk_get(dev, NULL);
+	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
@@ -251,7 +251,6 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 	if (ret) {
 		while (--i >= 0)
 			soc_pcmcia_remove_one(&sinfo->skt[i]);
-		clk_put(clk);
 		kfree(sinfo);
 	} else {
 		dev_set_drvdata(dev, sinfo);
-- 
2.1.0
