From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Fri, 04 Dec 2009 16:27:51 +0000
Subject: [PATCH] pcmcia: Fix additional platforms after removal of skt->irq
	in 66024db57d5b9011e274b314affad68f370c0d6f
In-Reply-To: <104e2dd0700bd7921433779187c189ff7795d385.1256684685.git.rmk+kernel@arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
	<104e2dd0700bd7921433779187c189ff7795d385.1256684685.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <4B193887.8090608@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---

Russell's original patch is currently in linux-next (and hence I'm
guessing heading for the merge window?).  In the intervening time,
2 platforms have been added using the now nonexistent skt-irq.
This patch fixes them as per the other platforms.

 drivers/pcmcia/pxa2xx_palmtc.c    |    2 +-
 drivers/pcmcia/pxa2xx_stargate2.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_palmtc.c b/drivers/pcmcia/pxa2xx_palmtc.c
index 3a8993e..459a232 100644
--- a/drivers/pcmcia/pxa2xx_palmtc.c
+++ b/drivers/pcmcia/pxa2xx_palmtc.c
@@ -67,7 +67,7 @@ static int palmtc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	if (ret)
 		goto err7;
 
-	skt->irq = IRQ_GPIO(GPIO_NR_PALMTC_PCMCIA_READY);
+	skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMTC_PCMCIA_READY);
 	return 0;
 
 err7:
diff --git a/drivers/pcmcia/pxa2xx_stargate2.c b/drivers/pcmcia/pxa2xx_stargate2.c
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
1.6.4.4
