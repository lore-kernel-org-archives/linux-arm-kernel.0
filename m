From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun,  7 Aug 2011 15:05:31 +0400
Subject: [PATCH] pcmcia/pxa2xx_sharpsl: retain ops structure on collie
Message-ID: <1312715131-3956-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pxa2xx_sharpsl driver part is also used on collie, which (as
a StrongARM board) has different expectations for PCMCIA drivers.
So, on collie place sharpsl_pcmcia_ops in .data section rather than
in __initdata.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: stable at kernel.org

diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
index 69ae2fd..f2405dc 100644
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -219,7 +219,11 @@ static void sharpsl_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 	sharpsl_pcmcia_init_reset(skt);
 }
 
+#ifdef CONFIG_SA1100_COLLIE
+static struct pcmcia_low_level sharpsl_pcmcia_ops = {
+#else
 static struct pcmcia_low_level sharpsl_pcmcia_ops __initdata = {
+#endif
 	.owner                  = THIS_MODULE,
 	.hw_init                = sharpsl_pcmcia_hw_init,
 	.hw_shutdown            = sharpsl_pcmcia_hw_shutdown,
-- 
1.7.2.5
