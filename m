From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:19:52 +0000
Subject: [PATCH 08/19] PCMCIA: sa11x0: nanoengine: convert to use new
 irq/gpio management
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBZY-0005hv-55@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Nanoengine socket driver to use the new irq/gpio management.
This is slightly more involved because we have to touch the private
platform header file to modify the GPIO bitmasks to be GPIO numbers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/nanoengine.h |    8 +-
 drivers/pcmcia/sa1100_nanoengine.c             |  101 +++---------------------
 2 files changed, 15 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/nanoengine.h b/arch/arm/mach-sa1100/include/mach/nanoengine.h
index 14f8382..ad24c6c 100644
--- a/arch/arm/mach-sa1100/include/mach/nanoengine.h
+++ b/arch/arm/mach-sa1100/include/mach/nanoengine.h
@@ -16,10 +16,10 @@
 
 #include <mach/irqs.h>
 
-#define GPIO_PC_READY0	GPIO_GPIO(11) /* ready for socket 0 (active high)*/
-#define GPIO_PC_READY1	GPIO_GPIO(12) /* ready for socket 1 (active high) */
-#define GPIO_PC_CD0	GPIO_GPIO(13) /* detect for socket 0 (active low) */
-#define GPIO_PC_CD1	GPIO_GPIO(14) /* detect for socket 1 (active low) */
+#define GPIO_PC_READY0	11 /* ready for socket 0 (active high)*/
+#define GPIO_PC_READY1	12 /* ready for socket 1 (active high) */
+#define GPIO_PC_CD0	13 /* detect for socket 0 (active low) */
+#define GPIO_PC_CD1	14 /* detect for socket 1 (active low) */
 #define GPIO_PC_RESET0	GPIO_GPIO(15) /* reset socket 0 */
 #define GPIO_PC_RESET1	GPIO_GPIO(16) /* reset socket 1 */
 
diff --git a/drivers/pcmcia/sa1100_nanoengine.c b/drivers/pcmcia/sa1100_nanoengine.c
index 93b9c9b..b19b816 100644
--- a/drivers/pcmcia/sa1100_nanoengine.c
+++ b/drivers/pcmcia/sa1100_nanoengine.c
@@ -34,43 +34,24 @@
 
 #include "sa1100_generic.h"
 
-static struct pcmcia_irqs irqs_skt0[] = {
-	/* socket, IRQ, name */
-	{ 0, NANOENGINE_IRQ_GPIO_PC_CD0, "PC CD0" },
-};
-
-static struct pcmcia_irqs irqs_skt1[] = {
-	/* socket, IRQ, name */
-	{ 1, NANOENGINE_IRQ_GPIO_PC_CD1, "PC CD1" },
-};
-
 struct nanoengine_pins {
-	unsigned input_pins;
 	unsigned output_pins;
 	unsigned clear_outputs;
-	unsigned transition_pins;
-	unsigned pci_irq;
-	struct pcmcia_irqs *pcmcia_irqs;
-	unsigned pcmcia_irqs_size;
+	int gpio_cd;
+	int gpio_rdy;
 };
 
 static struct nanoengine_pins nano_skts[] = {
 	{
-		.input_pins		= GPIO_PC_READY0 | GPIO_PC_CD0,
 		.output_pins		= GPIO_PC_RESET0,
 		.clear_outputs		= GPIO_PC_RESET0,
-		.transition_pins	= NANOENGINE_IRQ_GPIO_PC_CD0,
-		.pci_irq		= NANOENGINE_IRQ_GPIO_PC_READY0,
-		.pcmcia_irqs		= irqs_skt0,
-		.pcmcia_irqs_size	= ARRAY_SIZE(irqs_skt0)
+		.gpio_cd		= GPIO_PC_CD0,
+		.gpio_rdy		= GPIO_PC_READY0,
 	}, {
-		.input_pins		= GPIO_PC_READY1 | GPIO_PC_CD1,
 		.output_pins		= GPIO_PC_RESET1,
 		.clear_outputs		= GPIO_PC_RESET1,
-		.transition_pins	= NANOENGINE_IRQ_GPIO_PC_CD1,
-		.pci_irq		= NANOENGINE_IRQ_GPIO_PC_READY1,
-		.pcmcia_irqs		= irqs_skt1,
-		.pcmcia_irqs_size	= ARRAY_SIZE(irqs_skt1)
+		.gpio_cd		= GPIO_PC_CD1,
+		.gpio_rdy		= GPIO_PC_READY1,
 	}
 };
 
@@ -83,28 +64,15 @@ static int nanoengine_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	if (i >= num_nano_pcmcia_sockets)
 		return -ENXIO;
 
-	GPDR &= ~nano_skts[i].input_pins;
 	GPDR |= nano_skts[i].output_pins;
 	GPCR = nano_skts[i].clear_outputs;
-	irq_set_irq_type(nano_skts[i].transition_pins, IRQ_TYPE_EDGE_BOTH);
-	skt->socket.pci_irq = nano_skts[i].pci_irq;
 
-	return soc_pcmcia_request_irqs(skt,
-		nano_skts[i].pcmcia_irqs, nano_skts[i].pcmcia_irqs_size);
-}
+	skt->stat[SOC_STAT_CD].gpio = nano_skts[i].gpio_cd;
+	skt->stat[SOC_STAT_CD].name = i ? "PC CD1" : "PC CD0";
+	skt->stat[SOC_STAT_RDY].gpio = nano_skts[i].gpio_rdy;
+	skt->stat[SOC_STAT_RDY].name = i ? "PC RDY1" : "PC RDY0";
 
-/*
- * Release all resources.
- */
-static void nanoengine_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	unsigned i = skt->nr;
-
-	if (i >= num_nano_pcmcia_sockets)
-		return;
-
-	soc_pcmcia_free_irqs(skt,
-		nano_skts[i].pcmcia_irqs, nano_skts[i].pcmcia_irqs_size);
+	return 0;
 }
 
 static int nanoengine_pcmcia_configure_socket(
@@ -138,25 +106,11 @@ static int nanoengine_pcmcia_configure_socket(
 static void nanoengine_pcmcia_socket_state(
 	struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
-	unsigned long levels = GPLR;
 	unsigned i = skt->nr;
 
 	if (i >= num_nano_pcmcia_sockets)
 		return;
 
-	memset(state, 0, sizeof(struct pcmcia_state));
-	switch (i) {
-	case 0:
-		state->ready = (levels & GPIO_PC_READY0) ? 1 : 0;
-		state->detect = !(levels & GPIO_PC_CD0) ? 1 : 0;
-		break;
-	case 1:
-		state->ready = (levels & GPIO_PC_READY1) ? 1 : 0;
-		state->detect = !(levels & GPIO_PC_CD1) ? 1 : 0;
-		break;
-	default:
-		return;
-	}
 	state->bvd1 = 1;
 	state->bvd2 = 1;
 	state->wrprot = 0; /* Not available */
@@ -164,46 +118,13 @@ static void nanoengine_pcmcia_socket_state(
 	state->vs_Xv = 0;
 }
 
-/*
- * Enable card status IRQs on (re-)initialisation.  This can
- * be called at initialisation, power management event, or
- * pcmcia event.
- */
-static void nanoengine_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	unsigned i = skt->nr;
-
-	if (i >= num_nano_pcmcia_sockets)
-		return;
-
-	soc_pcmcia_enable_irqs(skt,
-		nano_skts[i].pcmcia_irqs, nano_skts[i].pcmcia_irqs_size);
-}
-
-/*
- * Disable card status IRQs on suspend.
- */
-static void nanoengine_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-	unsigned i = skt->nr;
-
-	if (i >= num_nano_pcmcia_sockets)
-		return;
-
-	soc_pcmcia_disable_irqs(skt,
-		nano_skts[i].pcmcia_irqs, nano_skts[i].pcmcia_irqs_size);
-}
-
 static struct pcmcia_low_level nanoengine_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 
 	.hw_init		= nanoengine_pcmcia_hw_init,
-	.hw_shutdown		= nanoengine_pcmcia_hw_shutdown,
 
 	.configure_socket	= nanoengine_pcmcia_configure_socket,
 	.socket_state		= nanoengine_pcmcia_socket_state,
-	.socket_init		= nanoengine_pcmcia_socket_init,
-	.socket_suspend		= nanoengine_pcmcia_socket_suspend,
 };
 
 int pcmcia_nanoengine_init(struct device *dev)
-- 
1.7.4.4
