From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 28 Dec 2009 13:18:06 +0800
Subject: [PATCH 5/7] [ARM] sa1111: avoid using hardcoded IRQ numbers for
	PCMCIA driver
In-Reply-To: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1261977488-18271-6-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQs for card detect and status change are currently hardcoded in
SA1111 PCMCIA driver, which can be actually obtained from the .irq[]
from 'struct sa1111_dev' to keep it generic.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 drivers/pcmcia/sa1111_generic.c |   25 ++++++++++++++++++++-----
 1 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index de6bc33..db79ca6 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -21,11 +21,18 @@
 
 #include "sa1111_generic.h"
 
+#define IDX_IRQ_S0_READY_NINT	(0)
+#define IDX_IRQ_S0_CD_VALID	(1)
+#define IDX_IRQ_S0_BVD1_STSCHG	(2)
+#define IDX_IRQ_S1_READY_NINT	(3)
+#define IDX_IRQ_S1_CD_VALID	(4)
+#define IDX_IRQ_S1_BVD1_STSCHG	(5)
+
 static struct pcmcia_irqs irqs[] = {
-	{ 0, IRQ_S0_CD_VALID,    "SA1111 PCMCIA card detect" },
-	{ 0, IRQ_S0_BVD1_STSCHG, "SA1111 PCMCIA BVD1"        },
-	{ 1, IRQ_S1_CD_VALID,    "SA1111 CF card detect"     },
-	{ 1, IRQ_S1_BVD1_STSCHG, "SA1111 CF BVD1"            },
+	{ 0, NO_IRQ, "SA1111 PCMCIA card detect" },
+	{ 0, NO_IRQ, "SA1111 PCMCIA BVD1"        },
+	{ 1, NO_IRQ, "SA1111 CF card detect"     },
+	{ 1, NO_IRQ, "SA1111 CF BVD1"            },
 };
 
 static int sa1111_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
@@ -136,7 +143,9 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 		s->soc.ops = ops;
 		s->soc.socket.owner = ops->owner;
 		s->soc.socket.dev.parent = &dev->dev;
-		s->soc.socket.pci_irq = s->soc.nr ? IRQ_S1_READY_NINT : IRQ_S0_READY_NINT;
+		s->soc.socket.pci_irq = s->soc.nr ?
+				dev->irq[IDX_IRQ_S0_READY_NINT] :
+				dev->irq[IDX_IRQ_S1_READY_NINT];
 		s->dev = dev;
 
 		ret = add(&s->soc);
@@ -162,6 +171,12 @@ static int pcmcia_probe(struct sa1111_dev *dev)
 
 	base = dev->mapbase;
 
+	/* Initialize PCMCIA IRQs */
+	irqs[0].irq = dev->irq[IDX_IRQ_S0_CD_VALID];
+	irqs[1].irq = dev->irq[IDX_IRQ_S0_BVD1_STSCHG];
+	irqs[2].irq = dev->irq[IDX_IRQ_S1_CD_VALID];
+	irqs[3].irq = dev->irq[IDX_IRQ_S1_BVD1_STSCHG];
+
 	/*
 	 * Initialise the suspend state.
 	 */
-- 
1.6.3.3
