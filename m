From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:20:53 +0000
Subject: [PATCH 11/19] PCMCIA: sa11x0: simpad: convert to use new irq/gpio
 management
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBaX-0005i9-4O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Simpad socket driver to use the new irq/gpio management.
This is slightly more involved because we have to touch the private
platform header file to modify the GPIO bitmasks to be GPIO numbers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/simpad.h |    6 ++----
 drivers/pcmcia/sa1100_simpad.c             |   26 ++++++++------------------
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/simpad.h b/arch/arm/mach-sa1100/include/mach/simpad.h
index db28118..cdea671 100644
--- a/arch/arm/mach-sa1100/include/mach/simpad.h
+++ b/arch/arm/mach-sa1100/include/mach/simpad.h
@@ -39,10 +39,8 @@
 
 
 /*---  PCMCIA  ---*/
-#define GPIO_CF_CD              GPIO_GPIO24
-#define GPIO_CF_IRQ             GPIO_GPIO1
-#define IRQ_GPIO_CF_IRQ         IRQ_GPIO1
-#define IRQ_GPIO_CF_CD          IRQ_GPIO24
+#define GPIO_CF_CD              24
+#define GPIO_CF_IRQ             1
 
 /*--- SmartCard ---*/
 #define GPIO_SMART_CARD		GPIO_GPIO10
diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
index 0fac965..39d2241 100644
--- a/drivers/pcmcia/sa1100_simpad.c
+++ b/drivers/pcmcia/sa1100_simpad.c
@@ -15,24 +15,21 @@
 #include <mach/simpad.h>
 #include "sa1100_generic.h"
  
-static struct pcmcia_irqs irqs[] = {
-	{ 1, IRQ_GPIO_CF_CD, "CF_CD" },
-};
-
 static int simpad_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 
 	simpad_clear_cs3_bit(VCC_3V_EN|VCC_5V_EN|EN0|EN1);
 
-	skt->socket.pci_irq = IRQ_GPIO_CF_IRQ;
+	skt->stat[SOC_STAT_CD].gpio = GPIO_CF_CD;
+	skt->stat[SOC_STAT_CD].name = "CF_CD";
+	skt->stat[SOC_STAT_RDY].gpio = GPIO_CF_IRQ;
+	skt->stat[SOC_STAT_RDY].name = "CF_RDY";
 
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	return 0;
 }
 
 static void simpad_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
-
 	/* Disable CF bus: */
 	/*simpad_set_cs3_bit(PCMCIA_BUFF_DIS);*/
 	simpad_clear_cs3_bit(PCMCIA_RESET);
@@ -42,11 +39,11 @@ static void
 simpad_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 			   struct pcmcia_state *state)
 {
-	unsigned long levels = GPLR;
 	long cs3reg = simpad_get_cs3_ro();
 
-	state->detect=((levels & GPIO_CF_CD)==0)?1:0;
-	state->ready=(levels & GPIO_CF_IRQ)?1:0;
+	/* the detect signal is inverted - fix that up here */
+	state->detect = !state->detect;
+
 	state->bvd1 = 1; /* Might be cs3reg & PCMCIA_BVD1 */
 	state->bvd2 = 1; /* Might be cs3reg & PCMCIA_BVD2 */
 	state->wrprot=0; /* Not available on Simpad. */
@@ -99,14 +96,8 @@ simpad_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	return 0;
 }
 
-static void simpad_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
 static void simpad_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 {
-	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
 	simpad_set_cs3_bit(PCMCIA_RESET);
 }
 
@@ -116,7 +107,6 @@ static struct pcmcia_low_level simpad_pcmcia_ops = {
 	.hw_shutdown		= simpad_pcmcia_hw_shutdown,
 	.socket_state		= simpad_pcmcia_socket_state,
 	.configure_socket	= simpad_pcmcia_configure_socket,
-	.socket_init		= simpad_pcmcia_socket_init,
 	.socket_suspend		= simpad_pcmcia_socket_suspend,
 };
 
-- 
1.7.4.4
