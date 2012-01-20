From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:19:11 +0000
Subject: [PATCH 06/19] PCMCIA: sa11x0: cerf: convert to use new irq/gpio
 management
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBYt-0005hi-9G@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Cerf socket driver to use the new irq/gpio management.
This is slightly more involved because we have to touch the private
platform header file to modify the GPIO bitmasks to be GPIO numbers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/cerf.h |   13 +++------
 drivers/pcmcia/sa1100_cerf.c             |   42 ++++++-----------------------
 2 files changed, 13 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/cerf.h b/arch/arm/mach-sa1100/include/mach/cerf.h
index c3ac3d0..0e49545 100644
--- a/arch/arm/mach-sa1100/include/mach/cerf.h
+++ b/arch/arm/mach-sa1100/include/mach/cerf.h
@@ -14,15 +14,10 @@
 #define CERF_ETH_IO			0xf0000000
 #define CERF_ETH_IRQ IRQ_GPIO26
 
-#define CERF_GPIO_CF_BVD2		GPIO_GPIO (19)
-#define CERF_GPIO_CF_BVD1		GPIO_GPIO (20)
+#define CERF_GPIO_CF_BVD2		19
+#define CERF_GPIO_CF_BVD1		20
 #define CERF_GPIO_CF_RESET		GPIO_GPIO (21)
-#define CERF_GPIO_CF_IRQ		GPIO_GPIO (22)
-#define CERF_GPIO_CF_CD			GPIO_GPIO (23)
-
-#define CERF_IRQ_GPIO_CF_BVD2		IRQ_GPIO19
-#define CERF_IRQ_GPIO_CF_BVD1		IRQ_GPIO20
-#define CERF_IRQ_GPIO_CF_IRQ		IRQ_GPIO22
-#define CERF_IRQ_GPIO_CF_CD		IRQ_GPIO23
+#define CERF_GPIO_CF_IRQ		22
+#define CERF_GPIO_CF_CD			23
 
 #endif // _INCLUDE_CERF_H_
diff --git a/drivers/pcmcia/sa1100_cerf.c b/drivers/pcmcia/sa1100_cerf.c
index 30560df..9d0424e 100644
--- a/drivers/pcmcia/sa1100_cerf.c
+++ b/drivers/pcmcia/sa1100_cerf.c
@@ -19,33 +19,23 @@
 
 #define CERF_SOCKET	1
 
-static struct pcmcia_irqs irqs[] = {
-	{ CERF_SOCKET, CERF_IRQ_GPIO_CF_CD,   "CF_CD"   },
-	{ CERF_SOCKET, CERF_IRQ_GPIO_CF_BVD2, "CF_BVD2" },
-	{ CERF_SOCKET, CERF_IRQ_GPIO_CF_BVD1, "CF_BVD1" }
-};
-
 static int cerf_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->socket.pci_irq = CERF_IRQ_GPIO_CF_IRQ;
-
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
+	skt->stat[SOC_STAT_CD].gpio = CERF_GPIO_CF_CD;
+	skt->stat[SOC_STAT_CD].name = "CF_CD";
+	skt->stat[SOC_STAT_BVD1].gpio = CERF_GPIO_CF_BVD1;
+	skt->stat[SOC_STAT_BVD1].name = "CF_BVD1";
+	skt->stat[SOC_STAT_BVD2].gpio = CERF_GPIO_CF_BVD2;
+	skt->stat[SOC_STAT_BVD2].name = "CF_BVD2";
+	skt->stat[SOC_STAT_RDY].gpio = CERF_GPIO_CF_IRQ;
+	skt->stat[SOC_STAT_RDY].name = "CF_IRQ";
 
-static void cerf_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	return 0;
 }
 
 static void
 cerf_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
-	unsigned long levels = GPLR;
-
-	state->detect	= (levels & CERF_GPIO_CF_CD)  ?0:1;
-	state->ready	= (levels & CERF_GPIO_CF_IRQ) ?1:0;
-	state->bvd1	= (levels & CERF_GPIO_CF_BVD1)?1:0;
-	state->bvd2	= (levels & CERF_GPIO_CF_BVD2)?1:0;
 	state->wrprot	= 0;
 	state->vs_3v	= 1;
 	state->vs_Xv	= 0;
@@ -76,25 +66,11 @@ cerf_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void cerf_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
-static void cerf_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
 static struct pcmcia_low_level cerf_pcmcia_ops = { 
 	.owner			= THIS_MODULE,
 	.hw_init		= cerf_pcmcia_hw_init,
-	.hw_shutdown		= cerf_pcmcia_hw_shutdown,
 	.socket_state		= cerf_pcmcia_socket_state,
 	.configure_socket	= cerf_pcmcia_configure_socket,
-
-	.socket_init		= cerf_pcmcia_socket_init,
-	.socket_suspend		= cerf_pcmcia_socket_suspend,
 };
 
 int __devinit pcmcia_cerf_init(struct device *dev)
-- 
1.7.4.4
