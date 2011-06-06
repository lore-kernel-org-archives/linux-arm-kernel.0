From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Mon,  6 Jun 2011 15:24:15 +0100
Subject: [PATCH 3/3] pxa2xx trizeps4 pcmcia: code cleanup
In-Reply-To: <1307370255-15963-1-git-send-email-jic23@cam.ac.uk>
References: <1307370255-15963-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <1307370255-15963-4-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check patch warnings and use of more modern gpio allocation etc.
More can be done in here, but this is a start. Getting these
cleaned up will make shared functionality much easier to spot
and patches easier to review.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/pcmcia/pxa2xx_trizeps4.c |   91 ++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 47 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_trizeps4.c b/drivers/pcmcia/pxa2xx_trizeps4.c
index 57ddb96..e275402 100644
--- a/drivers/pcmcia/pxa2xx_trizeps4.c
+++ b/drivers/pcmcia/pxa2xx_trizeps4.c
@@ -42,16 +42,12 @@ static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	 */
 	switch (skt->nr) {
 	case 0:
-		if (gpio_request(GPIO_PRDY, "cf_irq") < 0) {
-			pr_err("%s: sock %d unable to request gpio %d\n", __func__,
-				skt->nr, GPIO_PRDY);
-			return -EBUSY;
-		}
-		if (gpio_direction_input(GPIO_PRDY) < 0) {
-			pr_err("%s: sock %d unable to set input gpio %d\n", __func__,
-				skt->nr, GPIO_PRDY);
-			gpio_free(GPIO_PRDY);
-			return -EINVAL;
+		ret = gpio_request_one(GPIO_PRDY, GPIOF_IN, "cf_irq");
+		if (ret < 0) {
+			pr_err("%s: sock %d unable to request gpio %d\n",
+			       __func__,
+			       skt->nr, GPIO_PRDY);
+			return ret;
 		}
 		skt->socket.pci_irq = IRQ_GPIO(GPIO_PRDY);
 		break;
@@ -59,32 +55,28 @@ static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		break;
 	}
 	/* release the reset of this card */
-	pr_debug("%s: sock %d irq %d\n", __func__, skt->nr, skt->socket.pci_irq);
+	pr_debug("%s: sock %d irq %d\n", __func__, skt->nr,
+		 skt->socket.pci_irq);
 
 	/* supplementory irqs for the socket */
 	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
 		if (irqs[i].sock != skt->nr)
 			continue;
-		if (gpio_request(irq_to_gpio(irqs[i].irq), irqs[i].str) < 0) {
+		ret = gpio_request_one(irq_to_gpio(irqs[i].irq), GPIOF_IN,
+				       irqs[i].str);
+		if (ret < 0) {
 			pr_err("%s: sock %d unable to request gpio %d\n",
 				__func__, skt->nr, irq_to_gpio(irqs[i].irq));
-			ret = -EBUSY;
-			goto error;
-		}
-		if (gpio_direction_input(irq_to_gpio(irqs[i].irq)) < 0) {
-			pr_err("%s: sock %d unable to set input gpio %d\n",
-				__func__, skt->nr, irq_to_gpio(irqs[i].irq));
-			ret = -EINVAL;
 			goto error;
 		}
 	}
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 
 error:
-	for (; i >= 0; i--) {
+	for (; i >= 0; i--)
 		gpio_free(irq_to_gpio(irqs[i].irq));
-	}
-	return (ret);
+
+	return ret;
 }
 
 static void trizeps_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
@@ -94,6 +86,7 @@ static void trizeps_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 	gpio_free(GPIO_PRDY);
 	for (i = 0; i < ARRAY_SIZE(irqs); i++)
 		gpio_free(irq_to_gpio(irqs[i].irq));
+	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
 
 static unsigned long trizeps_pcmcia_status[2];
@@ -101,32 +94,25 @@ static unsigned long trizeps_pcmcia_status[2];
 static void trizeps_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 				struct pcmcia_state *state)
 {
-	unsigned short status = 0, change;
+	unsigned short status, change;
+
 	status = CFSR_readw();
 	change = (status ^ trizeps_pcmcia_status[skt->nr]) &
 				ConXS_CFSR_BVD_MASK;
-	if (change) {
+	if (change)
 		trizeps_pcmcia_status[skt->nr] = status;
-		if (status & ConXS_CFSR_BVD1) {
-			/* enable_irq empty */
-		} else {
-			/* disable_irq empty */
-		}
-	}
 
 	switch (skt->nr) {
 	case 0:
 		/* just fill in fix states */
-		state->detect = gpio_get_value(GPIO_PCD) ? 0 : 1;
-		state->ready  = gpio_get_value(GPIO_PRDY) ? 1 : 0;
-		state->bvd1   = (status & ConXS_CFSR_BVD1) ? 1 : 0;
-		state->bvd2   = (status & ConXS_CFSR_BVD2) ? 1 : 0;
-		state->vs_3v  = (status & ConXS_CFSR_VS1) ? 0 : 1;
-		state->vs_Xv  = (status & ConXS_CFSR_VS2) ? 0 : 1;
+		state->detect = !gpio_get_value(GPIO_PCD);
+		state->ready  = !!gpio_get_value(GPIO_PRDY);
+		state->bvd1   = !!(status & ConXS_CFSR_BVD1);
+		state->bvd2   = !!(status & ConXS_CFSR_BVD2);
+		state->vs_3v  = !(status & ConXS_CFSR_VS1);
+		state->vs_Xv  = !(status & ConXS_CFSR_VS2);
 		state->wrprot = 0;	/* not available */
 		break;
-
-#ifndef CONFIG_MACH_TRIZEPS_CONXS
 	/* on ConXS we only have one slot. Second is inactive */
 	case 1:
 		state->detect = 0;
@@ -137,8 +123,6 @@ static void trizeps_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 		state->vs_Xv  = 0;
 		state->wrprot = 0;
 		break;
-
-#endif
 	}
 }
 
@@ -150,8 +134,12 @@ static int trizeps_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 
 	/* we do nothing here just check a bit */
 	switch (state->Vcc) {
-	case 0:  power &= 0xfc; break;
-	case 33: power |= ConXS_BCR_S0_VCC_3V3; break;
+	case 0:
+		power &= 0xfc;
+		break;
+	case 33:
+		power |= ConXS_BCR_S0_VCC_3V3;
+		break;
 	case 50:
 		pr_err("%s(): Vcc 5V not supported in socket\n", __func__);
 		break;
@@ -161,8 +149,12 @@ static int trizeps_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 	}
 
 	switch (state->Vpp) {
-	case 0:  power &= 0xf3; break;
-	case 33: power |= ConXS_BCR_S0_VPP_3V3; break;
+	case 0:
+		power &= 0xf3;
+		break;
+	case 33:
+		power |= ConXS_BCR_S0_VPP_3V3;
+		break;
 	case 120:
 		pr_err("%s(): Vpp 12V not supported in socket\n", __func__);
 		break;
@@ -232,12 +224,17 @@ static int __init trizeps_pcmcia_init(void)
 	ret = platform_device_add_data(trizeps_pcmcia_device,
 			&trizeps_pcmcia_ops, sizeof(trizeps_pcmcia_ops));
 
-	if (ret == 0)
-		ret = platform_device_add(trizeps_pcmcia_device);
+	if (ret)
+		goto error_put_dev;
 
+	ret = platform_device_add(trizeps_pcmcia_device);
 	if (ret)
-		platform_device_put(trizeps_pcmcia_device);
+		goto error_put_dev;
+
+	return 0;
 
+error_put_dev:
+	platform_device_put(trizeps_pcmcia_device);
 	return ret;
 }
 
-- 
1.7.3.4
