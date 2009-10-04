From: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 04 Oct 2009 16:09:05 +0100
Subject: [RFC PATCH 06/10] PCMCIA: sa1111: remove duplicated initializers
In-Reply-To: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
References: <6cc18319511869ba8c46bf1d1b20553baa170904.1253722954.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <2b6120cf79e55c9ac72c96018cf55a6fd1c35b99.1253722954.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_lubbock.c    |    4 ----
 drivers/pcmcia/sa1100_badge4.c     |    6 ------
 drivers/pcmcia/sa1100_jornada720.c |   28 +++++++---------------------
 drivers/pcmcia/sa1100_neponset.c   |    4 ----
 drivers/pcmcia/sa1111_generic.c    |   11 ++++++++---
 drivers/pcmcia/sa1111_generic.h    |    3 ---
 6 files changed, 15 insertions(+), 41 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_lubbock.c b/drivers/pcmcia/pxa2xx_lubbock.c
index 35d5280..b9f8c8f 100644
--- a/drivers/pcmcia/pxa2xx_lubbock.c
+++ b/drivers/pcmcia/pxa2xx_lubbock.c
@@ -201,12 +201,8 @@ lubbock_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 
 static struct pcmcia_low_level lubbock_pcmcia_ops = {
 	.owner			= THIS_MODULE,
-	.hw_init		= sa1111_pcmcia_hw_init,
-	.hw_shutdown		= sa1111_pcmcia_hw_shutdown,
-	.socket_state		= sa1111_pcmcia_socket_state,
 	.configure_socket	= lubbock_pcmcia_configure_socket,
 	.socket_init		= sa1111_pcmcia_socket_init,
-	.socket_suspend		= sa1111_pcmcia_socket_suspend,
 	.first			= 0,
 	.nr			= 2,
 };
diff --git a/drivers/pcmcia/sa1100_badge4.c b/drivers/pcmcia/sa1100_badge4.c
index 6399314..1ce53f4 100644
--- a/drivers/pcmcia/sa1100_badge4.c
+++ b/drivers/pcmcia/sa1100_badge4.c
@@ -127,14 +127,8 @@ badge4_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state
 
 static struct pcmcia_low_level badge4_pcmcia_ops = {
 	.owner			= THIS_MODULE,
-	.hw_init		= sa1111_pcmcia_hw_init,
-	.hw_shutdown		= sa1111_pcmcia_hw_shutdown,
-	.socket_state		= sa1111_pcmcia_socket_state,
 	.configure_socket	= badge4_pcmcia_configure_socket,
-
 	.socket_init		= sa1111_pcmcia_socket_init,
-	.socket_suspend		= sa1111_pcmcia_socket_suspend,
-
 	.first			= 0,
 	.nr			= 2,
 };
diff --git a/drivers/pcmcia/sa1100_jornada720.c b/drivers/pcmcia/sa1100_jornada720.c
index 1abdd57..755a433 100644
--- a/drivers/pcmcia/sa1100_jornada720.c
+++ b/drivers/pcmcia/sa1100_jornada720.c
@@ -22,21 +22,6 @@
 #warning *** Does SOCKET1_3V actually do anything?
 #define SOCKET1_3V	GPIO_GPIO3
 
-static int jornada720_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
-{
-  struct sa1111_pcmcia_socket *s = to_skt(skt);
-  /*
-   * What is all this crap for?
-   */
-  GRER |= 0x00000002;
-  /* Set GPIO_A<3:1> to be outputs for PCMCIA/CF power controller: */
-  sa1111_set_io_dir(s->dev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
-  sa1111_set_io(s->dev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-  sa1111_set_sleep_io(s->dev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
-
-  return sa1111_pcmcia_hw_init(skt);
-}
-
 static int
 jornada720_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
 {
@@ -94,14 +79,8 @@ printk("%s(): config socket %d vcc %d vpp %d\n", __func__,
 
 static struct pcmcia_low_level jornada720_pcmcia_ops = {
   .owner		= THIS_MODULE,
-  .hw_init		= jornada720_pcmcia_hw_init,
-  .hw_shutdown		= sa1111_pcmcia_hw_shutdown,
-  .socket_state		= sa1111_pcmcia_socket_state,
   .configure_socket	= jornada720_pcmcia_configure_socket,
-
   .socket_init		= sa1111_pcmcia_socket_init,
-  .socket_suspend	= sa1111_pcmcia_socket_suspend,
-
   .first		= 0,
   .nr			= 2,
 };
@@ -111,6 +90,13 @@ int __devinit pcmcia_jornada720_init(struct device *dev)
 	int ret = -ENODEV;
 
 	if (machine_is_jornada720()) {
+		GRER |= 0x00000002;
+
+		/* Set GPIO_A<3:1> to be outputs for PCMCIA/CF power controller: */
+		sa1111_set_io_dir(dev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0, 0);
+		sa1111_set_io(dev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
+		sa1111_set_sleep_io(dev, GPIO_A0|GPIO_A1|GPIO_A2|GPIO_A3, 0);
+
 		sa11xx_drv_pcmcia_ops(&jornada720_pcmcia_ops);
 		ret = sa1111_pcmcia_add(dev, &jornada720_pcmcia_ops,
 				sa11xx_drv_pcmcia_add_one);
diff --git a/drivers/pcmcia/sa1100_neponset.c b/drivers/pcmcia/sa1100_neponset.c
index cb7d5e6..7b57b3b 100644
--- a/drivers/pcmcia/sa1100_neponset.c
+++ b/drivers/pcmcia/sa1100_neponset.c
@@ -116,12 +116,8 @@ static void neponset_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
 
 static struct pcmcia_low_level neponset_pcmcia_ops = {
 	.owner			= THIS_MODULE,
-	.hw_init		= sa1111_pcmcia_hw_init,
-	.hw_shutdown		= sa1111_pcmcia_hw_shutdown,
-	.socket_state		= sa1111_pcmcia_socket_state,
 	.configure_socket	= neponset_pcmcia_configure_socket,
 	.socket_init		= neponset_pcmcia_socket_init,
-	.socket_suspend 	= sa1111_pcmcia_socket_suspend,
 	.first			= 0,
 	.nr			= 2,
 };
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 251d4a4..4d2dcff 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -28,12 +28,12 @@ static struct pcmcia_irqs irqs[] = {
 	{ 1, IRQ_S1_BVD1_STSCHG, "SA1111 CF BVD1"            },
 };
 
-int sa1111_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+static int sa1111_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
 
-void sa1111_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
+static void sa1111_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
 	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
@@ -111,7 +111,7 @@ void sa1111_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
 	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
 
-void sa1111_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
+static void sa1111_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 {
 	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
@@ -122,6 +122,11 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 	struct sa1111_pcmcia_socket *s;
 	int i, ret = 0;
 
+	ops->hw_init = sa1111_pcmcia_hw_init;
+	ops->hw_shutdown = sa1111_pcmcia_hw_shutdown;
+	ops->socket_state = sa1111_pcmcia_socket_state;
+	ops->socket_suspend = sa1111_pcmcia_socket_suspend;
+
 	s = kzalloc(sizeof(*s) * ops->nr, GFP_KERNEL);
 	if (!s)
 		return -ENODEV;
diff --git a/drivers/pcmcia/sa1111_generic.h b/drivers/pcmcia/sa1111_generic.h
index 536fe15..02dc857 100644
--- a/drivers/pcmcia/sa1111_generic.h
+++ b/drivers/pcmcia/sa1111_generic.h
@@ -15,12 +15,9 @@ static inline struct sa1111_pcmcia_socket *to_skt(struct soc_pcmcia_socket *s)
 int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 	int (*add)(struct soc_pcmcia_socket *));
 
-extern int sa1111_pcmcia_hw_init(struct soc_pcmcia_socket *);
-extern void sa1111_pcmcia_hw_shutdown(struct soc_pcmcia_socket *);
 extern void sa1111_pcmcia_socket_state(struct soc_pcmcia_socket *, struct pcmcia_state *);
 extern int sa1111_pcmcia_configure_socket(struct soc_pcmcia_socket *, const socket_state_t *);
 extern void sa1111_pcmcia_socket_init(struct soc_pcmcia_socket *);
-extern void sa1111_pcmcia_socket_suspend(struct soc_pcmcia_socket *);
 
 extern int pcmcia_badge4_init(struct device *);
 extern int pcmcia_jornada720_init(struct device *);
-- 
1.6.2.5
