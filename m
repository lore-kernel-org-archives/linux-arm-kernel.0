From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 21 Nov 2013 02:48:03 +0400
Subject: [PATCH 1/2] pcmcia: sa1111: pass sa1111_dev to badge4-specific code
In-Reply-To: <1384987684-10692-1-git-send-email-dbaryshkov@gmail.com>
References: <1384987684-10692-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1384987684-10692-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass sa1111_dev to platform-specific init code, as it is done by lubbock
and neponset. This removes a compilation warnings:

drivers/pcmcia/sa1111_badge4.c: In function 'pcmcia_badge4_init':
drivers/pcmcia/sa1111_badge4.c:147:5: warning: passing argument 1 of 'sa1111_pcmcia_add' from incompatible pointer type [enabled by default]
In file included from drivers/pcmcia/sa1111_badge4.c:26:0:
drivers/pcmcia/sa1111_generic.h:15:5: note: expected 'struct sa1111_dev *' but argument is of type 'struct device *'

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/pcmcia/sa1111_badge4.c  | 2 +-
 drivers/pcmcia/sa1111_generic.c | 2 +-
 drivers/pcmcia/sa1111_generic.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/sa1111_badge4.c b/drivers/pcmcia/sa1111_badge4.c
index 4d206f4..12f0dd0 100644
--- a/drivers/pcmcia/sa1111_badge4.c
+++ b/drivers/pcmcia/sa1111_badge4.c
@@ -132,7 +132,7 @@ static struct pcmcia_low_level badge4_pcmcia_ops = {
 	.nr			= 2,
 };
 
-int pcmcia_badge4_init(struct device *dev)
+int pcmcia_badge4_init(struct sa1111_dev *dev)
 {
 	int ret = -ENODEV;
 
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 65b02c3..a353186 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -197,7 +197,7 @@ static int pcmcia_probe(struct sa1111_dev *dev)
 	sa1111_writel(PCCR_S0_FLT | PCCR_S1_FLT, base + PCCR);
 
 #ifdef CONFIG_SA1100_BADGE4
-	pcmcia_badge4_init(&dev->dev);
+	pcmcia_badge4_init(dev);
 #endif
 #ifdef CONFIG_SA1100_JORNADA720
 	pcmcia_jornada720_init(&dev->dev);
diff --git a/drivers/pcmcia/sa1111_generic.h b/drivers/pcmcia/sa1111_generic.h
index f6376e3..86b9cc8 100644
--- a/drivers/pcmcia/sa1111_generic.h
+++ b/drivers/pcmcia/sa1111_generic.h
@@ -18,7 +18,7 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 extern void sa1111_pcmcia_socket_state(struct soc_pcmcia_socket *, struct pcmcia_state *);
 extern int sa1111_pcmcia_configure_socket(struct soc_pcmcia_socket *, const socket_state_t *);
 
-extern int pcmcia_badge4_init(struct device *);
+extern int pcmcia_badge4_init(struct sa1111_dev *);
 extern int pcmcia_jornada720_init(struct device *);
 extern int pcmcia_lubbock_init(struct sa1111_dev *);
 extern int pcmcia_neponset_init(struct sa1111_dev *);
-- 
1.8.4.2
