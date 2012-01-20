From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:21:33 +0000
Subject: [PATCH 13/19] PCMCIA: soc_common: remove soc_pcmcia_*_irqs functions
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBbB-0005iI-WC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we use gpios and gpio_to_irq() etc to manage the various card
status signals within soc_common, and all socket drivers are converted,
these functions are no longer used.  We can now get rid of these helper
functions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/soc_common.c |   63 -------------------------------------------
 drivers/pcmcia/soc_common.h |   10 -------
 2 files changed, 0 insertions(+), 73 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 09a9a52..e0433f5 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -634,69 +634,6 @@ static struct pccard_operations soc_common_pcmcia_operations = {
 };
 
 
-int soc_pcmcia_request_irqs(struct soc_pcmcia_socket *skt,
-			    struct pcmcia_irqs *irqs, int nr)
-{
-	int i, res = 0;
-
-	for (i = 0; i < nr; i++) {
-		if (irqs[i].sock != skt->nr)
-			continue;
-		res = request_irq(irqs[i].irq, soc_common_pcmcia_interrupt,
-				  IRQF_DISABLED, irqs[i].str, skt);
-		if (res)
-			break;
-		irq_set_irq_type(irqs[i].irq, IRQ_TYPE_NONE);
-	}
-
-	if (res) {
-		printk(KERN_ERR "PCMCIA: request for IRQ%d failed (%d)\n",
-			irqs[i].irq, res);
-
-		while (i--)
-			if (irqs[i].sock == skt->nr)
-				free_irq(irqs[i].irq, skt);
-	}
-	return res;
-}
-EXPORT_SYMBOL(soc_pcmcia_request_irqs);
-
-void soc_pcmcia_free_irqs(struct soc_pcmcia_socket *skt,
-			  struct pcmcia_irqs *irqs, int nr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++)
-		if (irqs[i].sock == skt->nr)
-			free_irq(irqs[i].irq, skt);
-}
-EXPORT_SYMBOL(soc_pcmcia_free_irqs);
-
-void soc_pcmcia_disable_irqs(struct soc_pcmcia_socket *skt,
-			     struct pcmcia_irqs *irqs, int nr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++)
-		if (irqs[i].sock == skt->nr)
-			irq_set_irq_type(irqs[i].irq, IRQ_TYPE_NONE);
-}
-EXPORT_SYMBOL(soc_pcmcia_disable_irqs);
-
-void soc_pcmcia_enable_irqs(struct soc_pcmcia_socket *skt,
-			    struct pcmcia_irqs *irqs, int nr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++)
-		if (irqs[i].sock == skt->nr) {
-			irq_set_irq_type(irqs[i].irq, IRQ_TYPE_EDGE_RISING);
-			irq_set_irq_type(irqs[i].irq, IRQ_TYPE_EDGE_BOTH);
-		}
-}
-EXPORT_SYMBOL(soc_pcmcia_enable_irqs);
-
-
 static LIST_HEAD(soc_pcmcia_sockets);
 static DEFINE_MUTEX(soc_pcmcia_sockets_lock);
 
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index ebdfa6c..e6fcbea 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -125,22 +125,12 @@ struct pcmcia_low_level {
 };
 
 
-struct pcmcia_irqs {
-	int sock;
-	int irq;
-	const char *str;
-};
-
 struct soc_pcmcia_timing {
 	unsigned short io;
 	unsigned short mem;
 	unsigned short attr;
 };
 
-extern int soc_pcmcia_request_irqs(struct soc_pcmcia_socket *skt, struct pcmcia_irqs *irqs, int nr);
-extern void soc_pcmcia_free_irqs(struct soc_pcmcia_socket *skt, struct pcmcia_irqs *irqs, int nr);
-extern void soc_pcmcia_disable_irqs(struct soc_pcmcia_socket *skt, struct pcmcia_irqs *irqs, int nr);
-extern void soc_pcmcia_enable_irqs(struct soc_pcmcia_socket *skt, struct pcmcia_irqs *irqs, int nr);
 extern void soc_common_pcmcia_get_timing(struct soc_pcmcia_socket *, struct soc_pcmcia_timing *);
 
 void soc_pcmcia_init_one(struct soc_pcmcia_socket *skt,
-- 
1.7.4.4
