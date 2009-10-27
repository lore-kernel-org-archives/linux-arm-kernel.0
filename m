From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 23:12:15 -0000
Subject: [RFC PATCH 04/10] PCMCIA: soc_common: push socket probe down into SoC
	specific support
In-Reply-To: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <e3028d45d9bc509970cca8f11a63c13aceb43f55.1256684685.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the individual socket probing and initialization down into the
SoC specific support files, thereby allowing soc_common_drv_pcmcia_probe
to be eliminated.  soc_common.c now no longer deals with distinct groups
of sockets.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c |   77 +++++++++++++++++++++--------------
 drivers/pcmcia/sa11xx_base.c |   91 ++++++++++++++++++++++++++----------------
 drivers/pcmcia/soc_common.c  |   37 -----------------
 drivers/pcmcia/soc_common.h  |    2 -
 4 files changed, 103 insertions(+), 104 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 8a91106..3cb4fd2 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -228,6 +228,31 @@ static const char *skt_names[] = {
 #define SKT_DEV_INFO_SIZE(n) \
 	(sizeof(struct skt_dev_info) + (n)*sizeof(struct soc_pcmcia_socket))
 
+static int pxa2xx_drv_pcmcia_add_one(struct soc_pcmcia_socket *skt)
+{
+	skt->res_skt.start = _PCMCIA(skt->nr);
+	skt->res_skt.end = _PCMCIA(skt->nr) + PCMCIASp - 1;
+	skt->res_skt.name = skt_names[skt->nr];
+	skt->res_skt.flags = IORESOURCE_MEM;
+
+	skt->res_io.start = _PCMCIAIO(skt->nr);
+	skt->res_io.end = _PCMCIAIO(skt->nr) + PCMCIAIOSp - 1;
+	skt->res_io.name = "io";
+	skt->res_io.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	skt->res_mem.start = _PCMCIAMem(skt->nr);
+	skt->res_mem.end = _PCMCIAMem(skt->nr) + PCMCIAMemSp - 1;
+	skt->res_mem.name = "memory";
+	skt->res_mem.flags = IORESOURCE_MEM;
+
+	skt->res_attr.start = _PCMCIAAttr(skt->nr);
+	skt->res_attr.end = _PCMCIAAttr(skt->nr) + PCMCIAAttrSp - 1;
+	skt->res_attr.name = "attribute";
+	skt->res_attr.flags = IORESOURCE_MEM;
+
+	return soc_pcmcia_add_one(skt);
+}
+
 int __pxa2xx_drv_pcmcia_probe(struct device *dev)
 {
 	int i, ret;
@@ -240,6 +265,12 @@ int __pxa2xx_drv_pcmcia_probe(struct device *dev)
 
 	ops = (struct pcmcia_low_level *)dev->platform_data;
 
+	/* Provide our PXA2xx specific timing routines. */
+	ops->set_timing  = pxa2xx_pcmcia_set_timing;
+#ifdef CONFIG_CPU_FREQ
+	ops->frequency_change = pxa2xx_pcmcia_frequency_change;
+#endif
+
 	sinfo = kzalloc(SKT_DEV_INFO_SIZE(ops->nr), GFP_KERNEL);
 	if (!sinfo)
 		return -ENOMEM;
@@ -250,40 +281,26 @@ int __pxa2xx_drv_pcmcia_probe(struct device *dev)
 	for (i = 0; i < ops->nr; i++) {
 		skt = &sinfo->skt[i];
 
-		skt->nr		= ops->first + i;
-		skt->irq	= NO_IRQ;
-
-		skt->res_skt.start	= _PCMCIA(skt->nr);
-		skt->res_skt.end	= _PCMCIA(skt->nr) + PCMCIASp - 1;
-		skt->res_skt.name	= skt_names[skt->nr];
-		skt->res_skt.flags	= IORESOURCE_MEM;
+		skt->nr = ops->first + i;
+		skt->irq = NO_IRQ;
+		skt->dev = dev;
+		skt->ops = ops;
+		skt->socket.owner = ops->owner;
+		skt->socket.dev.parent = dev;
 
-		skt->res_io.start	= _PCMCIAIO(skt->nr);
-		skt->res_io.end		= _PCMCIAIO(skt->nr) + PCMCIAIOSp - 1;
-		skt->res_io.name	= "io";
-		skt->res_io.flags	= IORESOURCE_MEM | IORESOURCE_BUSY;
-
-		skt->res_mem.start	= _PCMCIAMem(skt->nr);
-		skt->res_mem.end	= _PCMCIAMem(skt->nr) + PCMCIAMemSp - 1;
-		skt->res_mem.name	= "memory";
-		skt->res_mem.flags	= IORESOURCE_MEM;
-
-		skt->res_attr.start	= _PCMCIAAttr(skt->nr);
-		skt->res_attr.end	= _PCMCIAAttr(skt->nr) + PCMCIAAttrSp - 1;
-		skt->res_attr.name	= "attribute";
-		skt->res_attr.flags	= IORESOURCE_MEM;
+		ret = pxa2xx_drv_pcmcia_add_one(skt);
+		if (ret)
+			break;
 	}
 
-	/* Provide our PXA2xx specific timing routines. */
-	ops->set_timing  = pxa2xx_pcmcia_set_timing;
-#ifdef CONFIG_CPU_FREQ
-	ops->frequency_change = pxa2xx_pcmcia_frequency_change;
-#endif
-
-	ret = soc_common_drv_pcmcia_probe(dev, ops, sinfo);
-
-	if (!ret)
+	if (ret) {
+		while (--i >= 0)
+			soc_pcmcia_remove_one(&sinfo->skt[i]);
+		kfree(sinfo);
+	} else {
 		pxa2xx_configure_sockets(dev);
+		dev_set_drvdata(dev, sinfo);
+	}
 
 	return ret;
 }
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index e15d59f..92a4348 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -171,6 +171,31 @@ static const char *skt_names[] = {
 #define SKT_DEV_INFO_SIZE(n) \
 	(sizeof(struct skt_dev_info) + (n)*sizeof(struct soc_pcmcia_socket))
 
+static int sa11xx_drv_pcmcia_add_one(struct soc_pcmcia_socket *skt)
+{
+	skt->res_skt.start = _PCMCIA(skt->nr);
+	skt->res_skt.end = _PCMCIA(skt->nr) + PCMCIASp - 1;
+	skt->res_skt.name = skt_names[skt->nr];
+	skt->res_skt.flags = IORESOURCE_MEM;
+
+	skt->res_io.start = _PCMCIAIO(skt->nr);
+	skt->res_io.end = _PCMCIAIO(skt->nr) + PCMCIAIOSp - 1;
+	skt->res_io.name = "io";
+	skt->res_io.flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	skt->res_mem.start = _PCMCIAMem(skt->nr);
+	skt->res_mem.end = _PCMCIAMem(skt->nr) + PCMCIAMemSp - 1;
+	skt->res_mem.name = "memory";
+	skt->res_mem.flags = IORESOURCE_MEM;
+
+	skt->res_attr.start = _PCMCIAAttr(skt->nr);
+	skt->res_attr.end = _PCMCIAAttr(skt->nr) + PCMCIAAttrSp - 1;
+	skt->res_attr.name = "attribute";
+	skt->res_attr.flags = IORESOURCE_MEM;
+
+	return soc_pcmcia_add_one(skt);
+}
+
 int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 			    int first, int nr)
 {
@@ -178,40 +203,6 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 	struct soc_pcmcia_socket *skt;
 	int i;
 
-	sinfo = kzalloc(SKT_DEV_INFO_SIZE(nr), GFP_KERNEL);
-	if (!sinfo)
-		return -ENOMEM;
-
-	sinfo->nskt = nr;
-
-	/* Initiliaze processor specific parameters */
-	for (i = 0; i < nr; i++) {
-		skt = &sinfo->skt[i];
-
-		skt->nr		= first + i;
-		skt->irq	= NO_IRQ;
-
-		skt->res_skt.start	= _PCMCIA(skt->nr);
-		skt->res_skt.end	= _PCMCIA(skt->nr) + PCMCIASp - 1;
-		skt->res_skt.name	= skt_names[skt->nr];
-		skt->res_skt.flags	= IORESOURCE_MEM;
-
-		skt->res_io.start	= _PCMCIAIO(skt->nr);
-		skt->res_io.end		= _PCMCIAIO(skt->nr) + PCMCIAIOSp - 1;
-		skt->res_io.name	= "io";
-		skt->res_io.flags	= IORESOURCE_MEM | IORESOURCE_BUSY;
-
-		skt->res_mem.start	= _PCMCIAMem(skt->nr);
-		skt->res_mem.end	= _PCMCIAMem(skt->nr) + PCMCIAMemSp - 1;
-		skt->res_mem.name	= "memory";
-		skt->res_mem.flags	= IORESOURCE_MEM;
-
-		skt->res_attr.start	= _PCMCIAAttr(skt->nr);
-		skt->res_attr.end	= _PCMCIAAttr(skt->nr) + PCMCIAAttrSp - 1;
-		skt->res_attr.name	= "attribute";
-		skt->res_attr.flags	= IORESOURCE_MEM;
-	}
-
 	/*
 	 * set default MECR calculation if the board specific
 	 * code did not specify one...
@@ -226,7 +217,37 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 	ops->frequency_change = sa1100_pcmcia_frequency_change;
 #endif
 
-	return soc_common_drv_pcmcia_probe(dev, ops, sinfo);
+	sinfo = kzalloc(SKT_DEV_INFO_SIZE(nr), GFP_KERNEL);
+	if (!sinfo)
+		return -ENOMEM;
+
+	sinfo->nskt = nr;
+
+	/* Initiliaze processor specific parameters */
+	for (i = 0; i < nr; i++) {
+		skt = &sinfo->skt[i];
+
+		skt->nr = first + i;
+		skt->irq = NO_IRQ;
+		skt->dev = dev;
+		skt->ops = ops;
+		skt->socket.owner = ops->owner;
+		skt->socket.dev.parent = dev;
+
+		ret = sa11xx_drv_pcmcia_add_one(skt);
+		if (ret)
+			break;
+	}
+
+	if (ret) {
+		while (--i >= 0)
+			soc_pcmcia_remove_one(&sinfo->skt[i]);
+		kfree(sinfo);
+	} else {
+		dev_set_drvdata(dev, sinfo);
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL(sa11xx_drv_pcmcia_probe);
 
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index c42b651..8e262a4 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -740,43 +740,6 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 }
 EXPORT_SYMBOL(soc_pcmcia_add_one);
 
-int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
-				struct skt_dev_info *sinfo)
-{
-	struct soc_pcmcia_socket *skt;
-	int ret, i;
-
-	/*
-	 * Initialise the per-socket structure.
-	 */
-	for (i = ret = 0; i < sinfo->nskt; i++) {
-		skt = &sinfo->skt[i];
-
-		skt->socket.owner = ops->owner;
-		skt->socket.dev.parent = dev;
-
-		skt->dev	= dev;
-		skt->ops	= ops;
-
-		ret = soc_pcmcia_add_one(skt);
-		if (ret)
-			break;
-
-		WARN_ON(skt->socket.sock != i);
-	}
-
-	if (ret) {
-		while (--i >= 0)
-			soc_pcmcia_remove_one(&sinfo->skt[i]);
-		kfree(sinfo);
-	} else {
-		dev_set_drvdata(dev, sinfo);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(soc_common_drv_pcmcia_probe);
-
 MODULE_AUTHOR("John Dorsey <john+@cs.cmu.edu>");
 MODULE_DESCRIPTION("Linux PCMCIA Card Services: Common SoC support");
 MODULE_LICENSE("Dual MPL/GPL");
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index c33b8c3..8a755c1 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -138,8 +138,6 @@ extern void soc_common_pcmcia_get_timing(struct soc_pcmcia_socket *, struct soc_
 void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt);
 int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt);
 
-extern int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops, struct skt_dev_info *sinfo);
-
 
 #ifdef CONFIG_PCMCIA_DEBUG
 
-- 
1.6.2.5
