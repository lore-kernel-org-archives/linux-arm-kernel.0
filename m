From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:21:13 +0000
Subject: [PATCH 12/19] PCMCIA: sa11x0: h3600: convert to use new irq/gpio
 management
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBar-0005iD-IH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert iPAQ socket driver to use the new irq/gpio management.  As
this already uses the GPIO subsystem, these changes are localized
to just the PCMCIA directory.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/sa1100_h3600.c |   95 ++++++----------------------------------
 1 files changed, 15 insertions(+), 80 deletions(-)

diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index edf8f00..410a636 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -19,36 +19,20 @@
 
 #include "sa1100_generic.h"
 
-static struct pcmcia_irqs irqs[] = {
-	{ .sock = 0, .str = "PCMCIA CD0" }, /* .irq will be filled later */
-	{ .sock = 1, .str = "PCMCIA CD1" }
-};
-
 static int h3600_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int err;
 
 	switch (skt->nr) {
 	case 0:
-		err = gpio_request(H3XXX_GPIO_PCMCIA_IRQ0, "PCMCIA IRQ0");
-		if (err)
-			goto err00;
-		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_IRQ0);
-		if (err)
-			goto err01;
-		skt->socket.pci_irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_IRQ0);
-
-		err = gpio_request(H3XXX_GPIO_PCMCIA_CD0, "PCMCIA CD0");
-		if (err)
-			goto err01;
-		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_CD0);
-		if (err)
-			goto err02;
-		irqs[0].irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_CD0);
+		skt->stat[SOC_STAT_CD].gpio = H3XXX_GPIO_PCMCIA_CD0;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA CD0";
+		skt->stat[SOC_STAT_RDY].gpio = H3XXX_GPIO_PCMCIA_IRQ0;
+		skt->stat[SOC_STAT_RDY].name = "PCMCIA IRQ0";
 
 		err = gpio_request(H3XXX_EGPIO_OPT_NVRAM_ON, "OPT NVRAM ON");
 		if (err)
-			goto err02;
+			goto err01;
 		err = gpio_direction_output(H3XXX_EGPIO_OPT_NVRAM_ON, 0);
 		if (err)
 			goto err03;
@@ -70,30 +54,12 @@ static int h3600_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		err = gpio_direction_output(H3XXX_EGPIO_CARD_RESET, 0);
 		if (err)
 			goto err06;
-		err = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-		if (err)
-			goto err06;
 		break;
 	case 1:
-		err = gpio_request(H3XXX_GPIO_PCMCIA_IRQ1, "PCMCIA IRQ1");
-		if (err)
-			goto err10;
-		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_IRQ1);
-		if (err)
-			goto err11;
-		skt->socket.pci_irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_IRQ1);
-
-		err = gpio_request(H3XXX_GPIO_PCMCIA_CD1, "PCMCIA CD1");
-		if (err)
-			goto err11;
-		err = gpio_direction_input(H3XXX_GPIO_PCMCIA_CD1);
-		if (err)
-			goto err12;
-		irqs[1].irq = gpio_to_irq(H3XXX_GPIO_PCMCIA_CD1);
-
-		err = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
-		if (err)
-			goto err12;
+		skt->stat[SOC_STAT_CD].gpio = H3XXX_GPIO_PCMCIA_CD1;
+		skt->stat[SOC_STAT_CD].name = "PCMCIA CD1";
+		skt->stat[SOC_STAT_RDY].gpio = H3XXX_GPIO_PCMCIA_IRQ1;
+		skt->stat[SOC_STAT_RDY].name = "PCMCIA IRQ1";
 		break;
 	}
 	return 0;
@@ -102,19 +68,12 @@ err06:	gpio_free(H3XXX_EGPIO_CARD_RESET);
 err05:	gpio_free(H3XXX_EGPIO_OPT_RESET);
 err04:	gpio_free(H3XXX_EGPIO_OPT_ON);
 err03:	gpio_free(H3XXX_EGPIO_OPT_NVRAM_ON);
-err02:	gpio_free(H3XXX_GPIO_PCMCIA_CD0);
 err01:	gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
-err00:	return err;
-
-err12:	gpio_free(H3XXX_GPIO_PCMCIA_CD0);
-err11:	gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
-err10:	return err;
+	return err;
 }
 
 static void h3600_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 {
-	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
-  
 	switch (skt->nr) {
 	case 0:
 		/* Disable CF bus: */
@@ -126,12 +85,8 @@ static void h3600_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 		gpio_free(H3XXX_EGPIO_OPT_RESET);
 		gpio_free(H3XXX_EGPIO_OPT_ON);
 		gpio_free(H3XXX_EGPIO_OPT_NVRAM_ON);
-		gpio_free(H3XXX_GPIO_PCMCIA_CD0);
-		gpio_free(H3XXX_GPIO_PCMCIA_IRQ0);
 		break;
 	case 1:
-		gpio_free(H3XXX_GPIO_PCMCIA_CD1);
-		gpio_free(H3XXX_GPIO_PCMCIA_IRQ1);
 		break;
 	}
 }
@@ -139,27 +94,11 @@ static void h3600_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 static void
 h3600_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
-	switch (skt->nr) {
-	case 0:
-		state->detect = !gpio_get_value(H3XXX_GPIO_PCMCIA_CD0);
-		state->ready = !!gpio_get_value(H3XXX_GPIO_PCMCIA_IRQ0);
-		state->bvd1 = 0;
-		state->bvd2 = 0;
-		state->wrprot = 0; /* Not available on H3600. */
-		state->vs_3v = 0;
-		state->vs_Xv = 0;
-		break;
-
-	case 1:
-		state->detect = !gpio_get_value(H3XXX_GPIO_PCMCIA_CD1);
-		state->ready = !!gpio_get_value(H3XXX_GPIO_PCMCIA_IRQ1);
-		state->bvd1 = 0;
-		state->bvd2 = 0;
-		state->wrprot = 0; /* Not available on H3600. */
-		state->vs_3v = 0;
-		state->vs_Xv = 0;
-		break;
-	}
+	state->bvd1 = 0;
+	state->bvd2 = 0;
+	state->wrprot = 0; /* Not available on H3600. */
+	state->vs_3v = 0;
+	state->vs_Xv = 0;
 }
 
 static int
@@ -186,14 +125,10 @@ static void h3600_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
 	gpio_set_value(H3XXX_EGPIO_OPT_RESET, 0);
 
 	msleep(10);
-
-	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
 
 static void h3600_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 {
-	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
-
 	/*
 	 * FIXME:  This doesn't fit well.  We don't have the mechanism in
 	 * the generic PCMCIA layer to deal with the idea of two sockets
-- 
1.7.4.4
