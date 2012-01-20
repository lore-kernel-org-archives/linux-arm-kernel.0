From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:20:32 +0000
Subject: [PATCH 10/19] PCMCIA: sa11x0: shannon: convert to use new irq/gpio
 management
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBaC-0005i5-Mt@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Shannon socket driver to use the new irq/gpio management.
This is slightly more involved because we have to touch the private
platform header file to modify the GPIO bitmasks to be GPIO numbers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/shannon.h |   12 ++----
 drivers/pcmcia/sa1100_shannon.c             |   50 +++++++++-----------------
 2 files changed, 21 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/shannon.h b/arch/arm/mach-sa1100/include/mach/shannon.h
index ec27d6e..019f857 100644
--- a/arch/arm/mach-sa1100/include/mach/shannon.h
+++ b/arch/arm/mach-sa1100/include/mach/shannon.h
@@ -23,14 +23,10 @@
 #define SHANNON_GPIO_SENSE_12V		GPIO_GPIO (21)	/* Input, 12v flash unprotect detected */
 #define SHANNON_GPIO_DISP_EN		GPIO_GPIO (22)	/* out */
 /* XXX GPIO 23 unaccounted for */
-#define SHANNON_GPIO_EJECT_0		GPIO_GPIO (24)	/* in */
-#define SHANNON_IRQ_GPIO_EJECT_0	IRQ_GPIO24
-#define SHANNON_GPIO_EJECT_1		GPIO_GPIO (25)	/* in */
-#define SHANNON_IRQ_GPIO_EJECT_1	IRQ_GPIO25
-#define SHANNON_GPIO_RDY_0		GPIO_GPIO (26)	/* in */
-#define SHANNON_IRQ_GPIO_RDY_0		IRQ_GPIO26
-#define SHANNON_GPIO_RDY_1		GPIO_GPIO (27)	/* in */
-#define SHANNON_IRQ_GPIO_RDY_1		IRQ_GPIO27
+#define SHANNON_GPIO_EJECT_0		24		/* in */
+#define SHANNON_GPIO_EJECT_1		25		/* in */
+#define SHANNON_GPIO_RDY_0		26		/* in */
+#define SHANNON_GPIO_RDY_1		27		/* in */
 
 /* MCP UCB codec GPIO pins... */
 
diff --git a/drivers/pcmcia/sa1100_shannon.c b/drivers/pcmcia/sa1100_shannon.c
index 7ff1b43..7337cbc 100644
--- a/drivers/pcmcia/sa1100_shannon.c
+++ b/drivers/pcmcia/sa1100_shannon.c
@@ -15,27 +15,27 @@
 #include <asm/irq.h>
 #include "sa1100_generic.h"
 
-static struct pcmcia_irqs irqs[] = {
-	{ 0, SHANNON_IRQ_GPIO_EJECT_0, "PCMCIA_CD_0" },
-	{ 1, SHANNON_IRQ_GPIO_EJECT_1, "PCMCIA_CD_1" },
-};
-
 static int shannon_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	/* All those are inputs */
-	GPDR &= ~(SHANNON_GPIO_EJECT_0 | SHANNON_GPIO_EJECT_1 | 
-		  SHANNON_GPIO_RDY_0 | SHANNON_GPIO_RDY_1);
-	GAFR &= ~(SHANNON_GPIO_EJECT_0 | SHANNON_GPIO_EJECT_1 | 
-		  SHANNON_GPIO_RDY_0 | SHANNON_GPIO_RDY_1);
-
-	skt->socket.pci_irq = skt->nr ? SHANNON_IRQ_GPIO_RDY_1 : SHANNON_IRQ_GPIO_RDY_0;
-
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
+	GAFR &= ~(GPIO_GPIO(SHANNON_GPIO_EJECT_0) |
+		  GPIO_GPIO(SHANNON_GPIO_EJECT_1) |
+		  GPIO_GPIO(SHANNON_GPIO_RDY_0) |
+		  GPIO_GPIO(SHANNON_GPIO_RDY_1));
+
+	if (skt->nr == 0) {
+		skt->stat[SOC_STAT_CD].gpio = SHANNON_GPIO_EJECT_0;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA_CD_0";
+		skt->stat[SOC_STAT_RDY].gpio = SHANNON_GPIO_RDY_0;
+		skt->stat[SOC_STAT_RDY].name = "PCMCIA_RDY_0";
+	} else {
+		skt->stat[SOC_STAT_CD].gpio = SHANNON_GPIO_EJECT_1;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA_CD_1";
+		skt->stat[SOC_STAT_RDY].gpio = SHANNON_GPIO_RDY_1;
+		skt->stat[SOC_STAT_RDY].name = "PCMCIA_RDY_1";
+	}
 
-static void shannon_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	return 0;
 }
 
 static void
@@ -46,7 +46,6 @@ shannon_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 
 	switch (skt->nr) {
 	case 0:
-		state->detect = (levels & SHANNON_GPIO_EJECT_0) ? 0 : 1;
 		state->ready  = (levels & SHANNON_GPIO_RDY_0) ? 1 : 0;
 		state->wrprot = 0; /* Not available on Shannon. */
 		state->bvd1   = 1; 
@@ -56,7 +55,6 @@ shannon_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 		break;
 
 	case 1:
-		state->detect = (levels & SHANNON_GPIO_EJECT_1) ? 0 : 1;
 		state->ready  = (levels & SHANNON_GPIO_RDY_1) ? 1 : 0;
 		state->wrprot = 0; /* Not available on Shannon. */
 		state->bvd1   = 1; 
@@ -92,25 +90,11 @@ shannon_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void shannon_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
-static void shannon_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
 static struct pcmcia_low_level shannon_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.hw_init		= shannon_pcmcia_hw_init,
-	.hw_shutdown		= shannon_pcmcia_hw_shutdown,
 	.socket_state		= shannon_pcmcia_socket_state,
 	.configure_socket	= shannon_pcmcia_configure_socket,
-
-	.socket_init		= shannon_pcmcia_socket_init,
-	.socket_suspend		= shannon_pcmcia_socket_suspend,
 };
 
 int __devinit pcmcia_shannon_init(struct device *dev)
-- 
1.7.4.4
