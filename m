From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:18:30 +0000
Subject: [PATCH 04/19] PCMCIA: sa1111: use new per-socket irq/gpio
 infrastructure
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBYE-0005ha-F6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert sa1111 PCMCIA drivers to use the new per-socket irq/gpio
infrastructure.  As the core takes care of handling the IRQs, we
can get rid of sa1111_pcmcia_socket_init(), sa1111_pcmcia_socket_suspend(),
sa1111_pcmcia_hw_init() and sa1111_pcmcia_hw_shutdown(), as well
as the private IRQ table.

We remove the NCR_0 setting in Neponset, as this is duplicating
what's already done via configure_socket in suspend.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_lubbock.c    |    1 -
 drivers/pcmcia/sa1100_badge4.c     |    1 -
 drivers/pcmcia/sa1100_jornada720.c |    1 -
 drivers/pcmcia/sa1100_neponset.c   |    9 ------
 drivers/pcmcia/sa1111_generic.c    |   52 +++++++++---------------------------
 drivers/pcmcia/sa1111_generic.h    |    1 -
 6 files changed, 13 insertions(+), 52 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_lubbock.c b/drivers/pcmcia/pxa2xx_lubbock.c
index c21888e..c5caf57 100644
--- a/drivers/pcmcia/pxa2xx_lubbock.c
+++ b/drivers/pcmcia/pxa2xx_lubbock.c
@@ -202,7 +202,6 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 static struct pcmcia_low_level lubbock_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.configure_socket	= lubbock_pcmcia_configure_socket,
-	.socket_init		= sa1111_pcmcia_socket_init,
 	.first			= 0,
 	.nr			= 2,
 };
diff --git a/drivers/pcmcia/sa1100_badge4.c b/drivers/pcmcia/sa1100_badge4.c
index 1ce53f4..ca97cb8 100644
--- a/drivers/pcmcia/sa1100_badge4.c
+++ b/drivers/pcmcia/sa1100_badge4.c
@@ -128,7 +128,6 @@ badge4_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state
 static struct pcmcia_low_level badge4_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.configure_socket	= badge4_pcmcia_configure_socket,
-	.socket_init		= sa1111_pcmcia_socket_init,
 	.first			= 0,
 	.nr			= 2,
 };
diff --git a/drivers/pcmcia/sa1100_jornada720.c b/drivers/pcmcia/sa1100_jornada720.c
index 6bcabee..61b443e 100644
--- a/drivers/pcmcia/sa1100_jornada720.c
+++ b/drivers/pcmcia/sa1100_jornada720.c
@@ -92,7 +92,6 @@ jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_s
 static struct pcmcia_low_level jornada720_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.configure_socket	= jornada720_pcmcia_configure_socket,
-	.socket_init		= sa1111_pcmcia_socket_init,
 	.first			= 0,
 	.nr			= 2,
 };
diff --git a/drivers/pcmcia/sa1100_neponset.c b/drivers/pcmcia/sa1100_neponset.c
index c95639b..1eac3fd 100644
--- a/drivers/pcmcia/sa1100_neponset.c
+++ b/drivers/pcmcia/sa1100_neponset.c
@@ -106,18 +106,9 @@ neponset_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_sta
 	return 0;
 }
 
-static void neponset_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	if (skt->nr == 0)
-		NCR_0 &= ~(NCR_A0VPP | NCR_A1VPP);
-
-	sa1111_pcmcia_socket_init(skt);
-}
-
 static struct pcmcia_low_level neponset_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.configure_socket	= neponset_pcmcia_configure_socket,
-	.socket_init		= neponset_pcmcia_socket_init,
 	.first			= 0,
 	.nr			= 2,
 };
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 7d6d3d4..7510d50 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -29,23 +29,6 @@
 #define IDX_IRQ_S1_CD_VALID	(4)
 #define IDX_IRQ_S1_BVD1_STSCHG	(5)
 
-static struct pcmcia_irqs irqs[] = {
-	{ 0, NO_IRQ, "SA1111 PCMCIA card detect" },
-	{ 0, NO_IRQ, "SA1111 PCMCIA BVD1"        },
-	{ 1, NO_IRQ, "SA1111 CF card detect"     },
-	{ 1, NO_IRQ, "SA1111 CF BVD1"            },
-};
-
-static int sa1111_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
-{
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
-static void sa1111_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
 void sa1111_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
 	struct sa1111_pcmcia_socket *s = to_skt(skt);
@@ -114,26 +97,13 @@ int sa1111_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_s
 	return 0;
 }
 
-void sa1111_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
-static void sa1111_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
 int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 	int (*add)(struct soc_pcmcia_socket *))
 {
 	struct sa1111_pcmcia_socket *s;
 	int i, ret = 0;
 
-	ops->hw_init = sa1111_pcmcia_hw_init;
-	ops->hw_shutdown = sa1111_pcmcia_hw_shutdown;
 	ops->socket_state = sa1111_pcmcia_socket_state;
-	ops->socket_suspend = sa1111_pcmcia_socket_suspend;
 
 	for (i = 0; i < ops->nr; i++) {
 		s = kzalloc(sizeof(*s), GFP_KERNEL);
@@ -142,10 +112,20 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 
 		s->soc.nr = ops->first + i;
 		soc_pcmcia_init_one(&s->soc, ops, &dev->dev);
-		s->soc.socket.pci_irq = s->soc.nr ?
-				dev->irq[IDX_IRQ_S0_READY_NINT] :
-				dev->irq[IDX_IRQ_S1_READY_NINT];
 		s->dev = dev;
+		if (s->soc.nr) {
+			s->soc.socket.pci_irq = dev->irq[IDX_IRQ_S1_READY_NINT];
+			s->soc.stat[SOC_STAT_CD].irq = dev->irq[IDX_IRQ_S1_CD_VALID];
+			s->soc.stat[SOC_STAT_CD].name = "SA1111 CF card detect";
+			s->soc.stat[SOC_STAT_BVD1].irq = dev->irq[IDX_IRQ_S1_BVD1_STSCHG];
+			s->soc.stat[SOC_STAT_BVD1].name = "SA1111 CF BVD1";
+		} else {
+			s->soc.socket.pci_irq = dev->irq[IDX_IRQ_S0_READY_NINT];
+			s->soc.stat[SOC_STAT_CD].irq = dev->irq[IDX_IRQ_S0_CD_VALID];
+			s->soc.stat[SOC_STAT_CD].name = "SA1111 PCMCIA card detect";
+			s->soc.stat[SOC_STAT_BVD1].irq = dev->irq[IDX_IRQ_S0_BVD1_STSCHG];
+			s->soc.stat[SOC_STAT_BVD1].name = "SA1111 PCMCIA BVD1";
+		}
 
 		ret = add(&s->soc);
 		if (ret == 0) {
@@ -170,12 +150,6 @@ static int pcmcia_probe(struct sa1111_dev *dev)
 
 	base = dev->mapbase;
 
-	/* Initialize PCMCIA IRQs */
-	irqs[0].irq = dev->irq[IDX_IRQ_S0_CD_VALID];
-	irqs[1].irq = dev->irq[IDX_IRQ_S0_BVD1_STSCHG];
-	irqs[2].irq = dev->irq[IDX_IRQ_S1_CD_VALID];
-	irqs[3].irq = dev->irq[IDX_IRQ_S1_BVD1_STSCHG];
-
 	/*
 	 * Initialise the suspend state.
 	 */
diff --git a/drivers/pcmcia/sa1111_generic.h b/drivers/pcmcia/sa1111_generic.h
index 02dc857..f6376e3 100644
--- a/drivers/pcmcia/sa1111_generic.h
+++ b/drivers/pcmcia/sa1111_generic.h
@@ -17,7 +17,6 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 
 extern void sa1111_pcmcia_socket_state(struct soc_pcmcia_socket *, struct pcmcia_state *);
 extern int sa1111_pcmcia_configure_socket(struct soc_pcmcia_socket *, const socket_state_t *);
-extern void sa1111_pcmcia_socket_init(struct soc_pcmcia_socket *);
 
 extern int pcmcia_badge4_init(struct device *);
 extern int pcmcia_jornada720_init(struct device *);
-- 
1.7.4.4
