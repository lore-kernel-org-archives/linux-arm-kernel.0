From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:17:29 +0000
Subject: [PATCH 01/19] PCMCIA: soc_common: move common initialization into
 soc_common
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBXF-0005hO-61@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move common socket initialization into soc_common.c.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c    |    5 +----
 drivers/pcmcia/sa1111_generic.c |    4 +---
 drivers/pcmcia/sa11xx_base.c    |    5 +----
 drivers/pcmcia/soc_common.c     |   10 ++++++++++
 drivers/pcmcia/soc_common.h     |    3 ++-
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index a87e272..18474f0 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -318,10 +318,7 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 
 		skt->nr = ops->first + i;
 		skt->clk = clk;
-		skt->ops = ops;
-		skt->socket.owner = ops->owner;
-		skt->socket.dev.parent = &dev->dev;
-		skt->socket.pci_irq = NO_IRQ;
+		soc_pcmcia_init_one(skt, ops, &dev->dev);
 
 		ret = pxa2xx_drv_pcmcia_add_one(skt);
 		if (ret)
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 5986690..7d6d3d4 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -141,9 +141,7 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 			return -ENOMEM;
 
 		s->soc.nr = ops->first + i;
-		s->soc.ops = ops;
-		s->soc.socket.owner = ops->owner;
-		s->soc.socket.dev.parent = &dev->dev;
+		soc_pcmcia_init_one(&s->soc, ops, &dev->dev);
 		s->soc.socket.pci_irq = s->soc.nr ?
 				dev->irq[IDX_IRQ_S0_READY_NINT] :
 				dev->irq[IDX_IRQ_S1_READY_NINT];
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index 0c62fe3..a3ee89a 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -236,10 +236,7 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 		skt = &sinfo->skt[i];
 
 		skt->nr = first + i;
-		skt->ops = ops;
-		skt->socket.owner = ops->owner;
-		skt->socket.dev.parent = dev;
-		skt->socket.pci_irq = NO_IRQ;
+		soc_pcmcia_init_one(skt, ops, dev);
 
 		ret = sa11xx_drv_pcmcia_add_one(skt);
 		if (ret)
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index a0a9c2a..84d90d5 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -635,6 +635,16 @@ module_exit(soc_pcmcia_cpufreq_unregister);
 
 #endif
 
+void soc_pcmcia_init_one(struct soc_pcmcia_socket *skt,
+	struct pcmcia_low_level *ops, struct device *dev)
+{
+	skt->ops = ops;
+	skt->socket.owner = ops->owner;
+	skt->socket.dev.parent = dev;
+	skt->socket.pci_irq = NO_IRQ;
+}
+EXPORT_SYMBOL(soc_pcmcia_init_one);
+
 void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt)
 {
 	mutex_lock(&soc_pcmcia_sockets_lock);
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 9daa736..3ff7ead 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -133,7 +133,8 @@ extern void soc_pcmcia_disable_irqs(struct soc_pcmcia_socket *skt, struct pcmcia
 extern void soc_pcmcia_enable_irqs(struct soc_pcmcia_socket *skt, struct pcmcia_irqs *irqs, int nr);
 extern void soc_common_pcmcia_get_timing(struct soc_pcmcia_socket *, struct soc_pcmcia_timing *);
 
-
+void soc_pcmcia_init_one(struct soc_pcmcia_socket *skt,
+	struct pcmcia_low_level *ops, struct device *dev);
 void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt);
 int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt);
 
-- 
1.7.4.4
