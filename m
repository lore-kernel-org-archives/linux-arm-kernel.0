From: maz@misterjones.org (Marc Zyngier)
Date: Tue, 15 Dec 2009 21:11:21 +0100
Subject: [PATCH] pxa/pcmcia: Fix pxa2xx PCMCIA oops
Message-ID: <20091215211121.2cb4f5ac@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit d0d26c33b63c7ec10c3fdf9c7ce0aa035f0b3200:

PCMCIA: fix pxa2xx_lubbock modular build error

broke the driver by propagating a pointer to the platform_device
where a pointer to the generic device was expected, leading to a
spectacular crash...

Signed-off-by: Marc Zyngier <maz@misterjones.org>
---
 drivers/pcmcia/pxa2xx_base.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 3aabf1e..76e640b 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -291,7 +291,7 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 		skt->nr = ops->first + i;
 		skt->ops = ops;
 		skt->socket.owner = ops->owner;
-		skt->socket.dev.parent = dev;
+		skt->socket.dev.parent = &dev->dev;
 		skt->socket.pci_irq = NO_IRQ;
 
 		ret = pxa2xx_drv_pcmcia_add_one(skt);
@@ -304,8 +304,8 @@ static int pxa2xx_drv_pcmcia_probe(struct platform_device *dev)
 			soc_pcmcia_remove_one(&sinfo->skt[i]);
 		kfree(sinfo);
 	} else {
-		pxa2xx_configure_sockets(dev);
-		dev_set_drvdata(dev, sinfo);
+		pxa2xx_configure_sockets(&dev->dev);
+		dev_set_drvdata(&dev->dev, sinfo);
 	}
 
 	return ret;
-- 
1.6.0.4



-- 
I'm the slime oozin' out from your TV set...
