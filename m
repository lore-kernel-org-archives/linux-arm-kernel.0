From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:18:50 +0000
Subject: [PATCH 05/19] PCMCIA: sa11x0: assabet: convert to use new irq/gpio
 management
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBYY-0005he-Rv@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Assabet socket driver to use the new irq/gpio management.
This is slightly more involved because we have to touch the private
platform header file to modify the GPIO bitmasks to be GPIO numbers.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/assabet.h |   15 +++----
 drivers/pcmcia/sa1100_assabet.c             |   64 ++++++--------------------
 2 files changed, 21 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/assabet.h b/arch/arm/mach-sa1100/include/mach/assabet.h
index 28c2cf5..3073914 100644
--- a/arch/arm/mach-sa1100/include/mach/assabet.h
+++ b/arch/arm/mach-sa1100/include/mach/assabet.h
@@ -85,21 +85,18 @@ extern void ASSABET_BCR_frob(unsigned int mask, unsigned int set);
 #define ASSABET_BSR_RAD_RI	(1 << 31)
 
 
-/* GPIOs for which the generic definition doesn't say much */
+/* GPIOs (bitmasks) for which the generic definition doesn't say much */
 #define ASSABET_GPIO_RADIO_IRQ		GPIO_GPIO (14)	/* Radio interrupt request  */
 #define ASSABET_GPIO_PS_MODE_SYNC	GPIO_GPIO (16)	/* Power supply mode/sync   */
 #define ASSABET_GPIO_STEREO_64FS_CLK	GPIO_GPIO (19)	/* SSP UDA1341 clock input  */
-#define ASSABET_GPIO_CF_IRQ		GPIO_GPIO (21)	/* CF IRQ   */
-#define ASSABET_GPIO_CF_CD		GPIO_GPIO (22)	/* CF CD */
-#define ASSABET_GPIO_CF_BVD2		GPIO_GPIO (24)	/* CF BVD */
 #define ASSABET_GPIO_GFX_IRQ		GPIO_GPIO (24)	/* Graphics IRQ */
-#define ASSABET_GPIO_CF_BVD1		GPIO_GPIO (25)	/* CF BVD */
 #define ASSABET_GPIO_BATT_LOW		GPIO_GPIO (26)	/* Low battery */
 #define ASSABET_GPIO_RCLK		GPIO_GPIO (26)	/* CCLK/2  */
 
-#define ASSABET_IRQ_GPIO_CF_IRQ		IRQ_GPIO21
-#define ASSABET_IRQ_GPIO_CF_CD		IRQ_GPIO22
-#define ASSABET_IRQ_GPIO_CF_BVD2	IRQ_GPIO24
-#define ASSABET_IRQ_GPIO_CF_BVD1	IRQ_GPIO25
+/* These are gpiolib GPIO numbers, not bitmasks */
+#define ASSABET_GPIO_CF_IRQ		21	/* CF IRQ */
+#define ASSABET_GPIO_CF_CD		22	/* CF CD  */
+#define ASSABET_GPIO_CF_BVD2		24	/* CF BVD / IOSPKR */
+#define ASSABET_GPIO_CF_BVD1		25	/* CF BVD / IOSTSCHG */
 
 #endif
diff --git a/drivers/pcmcia/sa1100_assabet.c b/drivers/pcmcia/sa1100_assabet.c
index f1e8822..618f546 100644
--- a/drivers/pcmcia/sa1100_assabet.c
+++ b/drivers/pcmcia/sa1100_assabet.c
@@ -10,45 +10,30 @@
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/gpio.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/irq.h>
-#include <asm/signal.h>
 #include <mach/assabet.h>
 
 #include "sa1100_generic.h"
 
-static struct pcmcia_irqs irqs[] = {
-	{ 1, ASSABET_IRQ_GPIO_CF_CD,   "CF CD"   },
-	{ 1, ASSABET_IRQ_GPIO_CF_BVD2, "CF BVD2" },
-	{ 1, ASSABET_IRQ_GPIO_CF_BVD1, "CF BVD1" },
-};
-
 static int assabet_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->socket.pci_irq = ASSABET_IRQ_GPIO_CF_IRQ;
-
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
+	skt->stat[SOC_STAT_CD].gpio = ASSABET_GPIO_CF_CD;
+	skt->stat[SOC_STAT_CD].name = "CF CD";
+	skt->stat[SOC_STAT_BVD1].gpio = ASSABET_GPIO_CF_BVD1;
+	skt->stat[SOC_STAT_BVD1].name = "CF BVD1";
+	skt->stat[SOC_STAT_BVD2].gpio = ASSABET_GPIO_CF_BVD2;
+	skt->stat[SOC_STAT_BVD2].name = "CF BVD2";
+	skt->stat[SOC_STAT_RDY].gpio = ASSABET_GPIO_CF_IRQ;
+	skt->stat[SOC_STAT_RDY].name = "CF RDY";
 
-/*
- * Release all resources.
- */
-static void assabet_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	return 0;
 }
 
 static void
 assabet_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
-	unsigned long levels = GPLR;
-
-	state->detect = (levels & ASSABET_GPIO_CF_CD) ? 0 : 1;
-	state->ready  = (levels & ASSABET_GPIO_CF_IRQ) ? 1 : 0;
-	state->bvd1   = (levels & ASSABET_GPIO_CF_BVD1) ? 1 : 0;
-	state->bvd2   = (levels & ASSABET_GPIO_CF_BVD2) ? 1 : 0;
 	state->wrprot = 0; /* Not available on Assabet. */
 	state->vs_3v  = 1; /* Can only apply 3.3V on Assabet. */
 	state->vs_Xv  = 0;
@@ -78,38 +63,24 @@ assabet_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_stat
 		return -1;
 	}
 
-	/* Silently ignore Vpp, output enable, speaker enable. */
+	/* Silently ignore Vpp, speaker enable. */
 
 	if (state->flags & SS_RESET)
 		mask |= ASSABET_BCR_CF_RST;
+	if (!(state->flags & SS_OUTPUT_ENA))
+		mask |= ASSABET_BCR_CF_BUS_OFF;
 
-	ASSABET_BCR_frob(ASSABET_BCR_CF_RST | ASSABET_BCR_CF_PWR, mask);
+	ASSABET_BCR_frob(ASSABET_BCR_CF_RST | ASSABET_BCR_CF_PWR |
+			ASSABET_BCR_CF_BUS_OFF, mask);
 
 	return 0;
 }
 
 /*
- * Enable card status IRQs on (re-)initialisation.  This can
- * be called at initialisation, power management event, or
- * pcmcia event.
- */
-static void assabet_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
-{
-	/*
-	 * Enable CF bus
-	 */
-	ASSABET_BCR_clear(ASSABET_BCR_CF_BUS_OFF);
-
-	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-}
-
-/*
  * Disable card status IRQs on suspend.
  */
 static void assabet_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 {
-	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-
 	/*
 	 * Tristate the CF bus signals.  Also assert CF
 	 * reset as per user guide page 4-11.
@@ -119,14 +90,9 @@ static void assabet_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 
 static struct pcmcia_low_level assabet_pcmcia_ops = { 
 	.owner			= THIS_MODULE,
-
 	.hw_init		= assabet_pcmcia_hw_init,
-	.hw_shutdown		= assabet_pcmcia_hw_shutdown,
-
 	.socket_state		= assabet_pcmcia_socket_state,
 	.configure_socket	= assabet_pcmcia_configure_socket,
-
-	.socket_init		= assabet_pcmcia_socket_init,
 	.socket_suspend		= assabet_pcmcia_socket_suspend,
 };
 
-- 
1.7.4.4
