From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 9 Dec 2009 18:54:05 +0800
Subject: [PATCH 2/2] pcmcia: fix now incorrect reference of skt->irq
Message-ID: <mailman.92.1260709815.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

by using skt->socket.pci_irq

commit 66024db removes all other references of skt->irq by using
skt->socket.pci_irq, while leaving these two missed. Get them fixed.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 drivers/pcmcia/pxa2xx_palmtc.c    |    2 +-
 drivers/pcmcia/pxa2xx_stargate2.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
index 3a8993e..459a232 100644
--- a/drivers/pcmcia/pxa2xx_palmtc.c
+++ b/drivers/pcmcia/pxa2xx_palmtc.c
@@ -67,7 +67,7 @@ static int palmtc_pcmcia_hw_init(struct
soc_pcmcia_socket *skt)
 	if (ret)
 		goto err7;

-	skt->irq = IRQ_GPIO(GPIO_NR_PALMTC_PCMCIA_READY);
+	skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMTC_PCMCIA_READY);
 	return 0;

 err7:
diff --git a/drivers/pcmcia/pxa2xx_stargate2.c
b/drivers/pcmcia/pxa2xx_stargate2.c
index 490749e..d08802f 100644
--- a/drivers/pcmcia/pxa2xx_stargate2.c
+++ b/drivers/pcmcia/pxa2xx_stargate2.c
@@ -40,7 +40,7 @@ static struct pcmcia_irqs irqs[] = {

 static int sg2_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->irq = IRQ_GPIO(SG2_S0_GPIO_READY);
+	skt->socket.pci_irq = IRQ_GPIO(SG2_S0_GPIO_READY);
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }

-- 
1.6.3.3
