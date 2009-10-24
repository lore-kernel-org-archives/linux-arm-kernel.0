From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:37:40 +0400
Subject: [PATCH 19/20] SA1100: reuse h3600 PCMCIA driver on h3100
In-Reply-To: <1256416257-23003-2-git-send-email-mad_soft@inbox.ru>
References: <1256416257-23003-2-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256416661-23039-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both iPAQs h3600 and h3100 share the same control
GPIOs for PCMCIA, so driver can be reused.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 drivers/pcmcia/sa1100_generic.c |    2 +-
 drivers/pcmcia/sa1100_h3600.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 2d0e997..9e5679f 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -51,7 +51,7 @@ static int (*sa11x0_pcmcia_hw_init[])(struct device *dev) = {
 #ifdef CONFIG_SA1100_CERF
 	pcmcia_cerf_init,
 #endif
-#ifdef CONFIG_SA1100_H3600
+#if defined(CONFIG_SA1100_H3100) || defined(CONFIG_SA1100_H3600)
 	pcmcia_h3600_init,
 #endif
 #ifdef CONFIG_SA1100_SHANNON
diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index 4717aca..b763cea 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -223,7 +223,7 @@ int __init pcmcia_h3600_init(struct device *dev)
 {
 	int ret = -ENODEV;
 
-	if (machine_is_h3600())
+	if (machine_is_h3600() || machine_is_h3100())
 		ret = sa11xx_drv_pcmcia_probe(dev, &h3600_pcmcia_ops, 0, 2);
 
 	return ret;
-- 
1.6.5.1.63.ga9d7.dirty
