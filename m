From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 23:11:59 -0000
Subject: [RFC PATCH 03/10] PCMCIA: soc_common: push socket removal down to SoC
	specific support
In-Reply-To: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <b6537d915e1fa050693446a106142bdfd8cfd55e.1256684685.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mechanically transplant the removal code from soc_common into each
SoC specific base support file, thereby allowing
soc_common_drv_pcmcia_remove to be removed.  No other changes.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c    |   11 ++++++++++-
 drivers/pcmcia/sa1100_generic.c |   11 ++++++++++-
 drivers/pcmcia/sa1111_generic.c |   10 +++++++++-
 drivers/pcmcia/soc_common.c     |   16 ----------------
 drivers/pcmcia/soc_common.h     |    1 -
 5 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 0e35acb..8a91106 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -297,7 +297,16 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 
 static int pxa2xx_drv_pcmcia_remove(struct platform_device *dev)
 {
-	return soc_common_drv_pcmcia_remove(&dev->dev);
+	struct skt_dev_info *sinfo = platform_get_drvdata(dev);
+	int i;
+
+	platform_set_drvdata(dev, NULL);
+
+	for (i = 0; i < sinfo->nskt; i++)
+		soc_pcmcia_remove_one(&sinfo->skt[i]);
+
+	kfree(sinfo);
+	return 0;
 }
 
 static int pxa2xx_drv_pcmcia_suspend(struct device *dev)
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 2d0e997..11cc3ba 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -83,7 +83,16 @@ static int sa11x0_drv_pcmcia_probe(struct platform_device *dev)
 
 static int sa11x0_drv_pcmcia_remove(struct platform_device *dev)
 {
-	return soc_common_drv_pcmcia_remove(&dev->dev);
+	struct skt_dev_info *sinfo = platform_get_drvdata(dev);
+	int i;
+
+	platform_set_drvdata(dev, NULL);
+
+	for (i = 0; i < sinfo->nskt; i++)
+		soc_pcmcia_remove_one(&sinfo->skt[i]);
+
+	kfree(sinfo);
+	return 0;
 }
 
 static int sa11x0_drv_pcmcia_suspend(struct platform_device *dev,
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 4be4e17..a6793e3 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -152,7 +152,15 @@ static int pcmcia_probe(struct sa1111_dev *dev)
 
 static int __devexit pcmcia_remove(struct sa1111_dev *dev)
 {
-	soc_common_drv_pcmcia_remove(&dev->dev);
+	struct skt_dev_info *sinfo = dev_get_drvdata(&dev->dev);
+	int i;
+
+	dev_set_drvdata(&dev->dev, NULL);
+
+	for (i = 0; i < sinfo->nskt; i++)
+		soc_pcmcia_remove_one(&sinfo->skt[i]);
+
+	kfree(sinfo);
 	release_mem_region(dev->res.start, 512);
 	return 0;
 }
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 8938608..c42b651 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -777,22 +777,6 @@ int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops
 }
 EXPORT_SYMBOL(soc_common_drv_pcmcia_probe);
 
-int soc_common_drv_pcmcia_remove(struct device *dev)
-{
-	struct skt_dev_info *sinfo = dev_get_drvdata(dev);
-	int i;
-
-	dev_set_drvdata(dev, NULL);
-
-	for (i = 0; i < sinfo->nskt; i++)
-		soc_pcmcia_remove_one(&sinfo->skt[i]);
-
-	kfree(sinfo);
-
-	return 0;
-}
-EXPORT_SYMBOL(soc_common_drv_pcmcia_remove);
-
 MODULE_AUTHOR("John Dorsey <john+@cs.cmu.edu>");
 MODULE_DESCRIPTION("Linux PCMCIA Card Services: Common SoC support");
 MODULE_LICENSE("Dual MPL/GPL");
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 51c72ba..c33b8c3 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -139,7 +139,6 @@ void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt);
 int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt);
 
 extern int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops, struct skt_dev_info *sinfo);
-extern int soc_common_drv_pcmcia_remove(struct device *dev);
 
 
 #ifdef CONFIG_PCMCIA_DEBUG
-- 
1.6.2.5
