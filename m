From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:04:04 +0400
Subject: [PATCH 06/20] pcmcia: convert sa1100_h3600 driver to gpiolib
In-Reply-To: <1256414658-22611-6-git-send-email-mad_soft@inbox.ru>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-2-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-3-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-4-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-5-git-send-email-mad_soft@inbox.ru>
	<1256414658-22611-6-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256414658-22611-7-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert all operations with GPLR/GPCR/GPSR to gpiolibs calls.
Also change all IRQ_GPIO* to gpio_to_irq(*GPIO*)

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 drivers/pcmcia/sa1100_h3600.c |   82 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index 0cc3748..6d92a49 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -10,26 +10,78 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <mach/h3600.h>
+#include <mach/h3600_gpio.h>
 
 #include "sa1100_generic.h"
 
 static struct pcmcia_irqs irqs[] = {
-	{ 0, IRQ_GPIO_H3600_PCMCIA_CD0, "PCMCIA CD0" },
-	{ 1, IRQ_GPIO_H3600_PCMCIA_CD1, "PCMCIA CD1" }
+	{ .sock = 0, .str = "PCMCIA CD0" }, /* .irq will be filled later */
+	{ .sock = 1, .str = "PCMCIA CD1" }
 };
 
 static int h3600_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->irq = skt->nr ? IRQ_GPIO_H3600_PCMCIA_IRQ1
-			   : IRQ_GPIO_H3600_PCMCIA_IRQ0;
+	int err;
 
+	switch (skt->nr) {
+	case 0:
+		err = gpio_request(H3XXX_GPIO_PCMCIA_IRQ0, "PCMCIA IRQ0");
+		if (err)
+			goto err00;
+		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_IRQ0);
+		if (err)
+			goto err01;
+		skt->irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_IRQ0);
+
+		err = gpio_request(H3XXX_GPIO_PCMCIA_CD0, "PCMCIA CD0");
+		if (err)
+			goto err01;
+		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_CD0);
+		if (err)
+			goto err02;
+		irqs[0].irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_CD0);
+
+		err = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+		if (err)
+			goto err02;
+		break;
+	case 1:
+		err = gpio_request(H3XXX_GPIO_PCMCIA_IRQ1, "PCMCIA IRQ1");
+		if (err)
+			goto err10;
+		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_IRQ1);
+		if (err)
+			goto err11;
+		skt->irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_IRQ1);
+
+		err = gpio_request(H3XXX_GPIO_PCMCIA_CD1, "PCMCIA CD1");
+		if (err)
+			goto err11;
+		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_CD1);
+		if (err)
+			goto err12;
+		irqs[1].irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_CD1);
+
+		err = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+		if (err)
+			goto err12;
+		break;
+	}
+	return 0;
+
+err02:	gpio_free(H3XXX_GPIO_PCMCIA_CD0);
+err01:	gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
+err00:	return err;
 
-	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+err12:	gpio_free(H3XXX_GPIO_PCMCIA_CD0);
+err11:	gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
+err10:	return err;
 }
 
 static void h3600_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
@@ -40,17 +92,25 @@ static void h3600_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 	assign_h3600_egpio(IPAQ_EGPIO_OPT_NVRAM_ON, 0);
 	assign_h3600_egpio(IPAQ_EGPIO_OPT_ON, 0);
 	assign_h3600_egpio(IPAQ_EGPIO_OPT_RESET, 1);
+	switch (skt->nr) {
+	case 0:
+		gpio_free(H3XXX_GPIO_PCMCIA_CD0);
+		gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
+		break;
+	case 1:
+		gpio_free(H3XXX_GPIO_PCMCIA_CD1);
+		gpio_free(H3XXX_GPIO_PCMCIA_IRQ1);
+		break;
+	}
 }
 
 static void
 h3600_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
-	unsigned long levels = GPLR;
-
 	switch (skt->nr) {
 	case 0:
-		state->detect = levels & GPIO_H3600_PCMCIA_CD0 ? 0 : 1;
-		state->ready = levels & GPIO_H3600_PCMCIA_IRQ0 ? 1 : 0;
+		state->detect = !gpio_get_value(H3XXX_GPIO_PCMCIA_CD0);
+		state->ready = !!gpio_get_value(H3XXX_GPIO_PCMCIA_IRQ0);
 		state->bvd1 = 0;
 		state->bvd2 = 0;
 		state->wrprot = 0; /* Not available on H3600. */
@@ -59,8 +119,8 @@ h3600_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *st
 		break;
 
 	case 1:
-		state->detect = levels & GPIO_H3600_PCMCIA_CD1 ? 0 : 1;
-		state->ready = levels & GPIO_H3600_PCMCIA_IRQ1 ? 1 : 0;
+		state->detect = !gpio_get_value(H3XXX_GPIO_PCMCIA_CD1);
+		state->ready = !!gpio_get_value(H3XXX_GPIO_PCMCIA_IRQ1);
 		state->bvd1 = 0;
 		state->bvd2 = 0;
 		state->wrprot = 0; /* Not available on H3600. */
-- 
1.6.5.1.63.ga9d7.dirty
