From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 27 Oct 2009 23:13:47 -0000
Subject: [RFC PATCH 10/10] PCMCIA: stop duplicating pci_irq in
	soc_pcmcia_socket
In-Reply-To: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
References: <925a8da0d92cdf1f37aaef988fcc63bf9744576e.1256684685.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <104e2dd0700bd7921433779187c189ff7795d385.1256684685.git.rmk+kernel@arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

skt->irq is a mere duplication of pcmcia_socket's pci_irq member.
Get rid of it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/pxa2xx_base.c      |    2 +-
 drivers/pcmcia/pxa2xx_cm_x255.c   |    2 +-
 drivers/pcmcia/pxa2xx_cm_x270.c   |    2 +-
 drivers/pcmcia/pxa2xx_e740.c      |    2 +-
 drivers/pcmcia/pxa2xx_mainstone.c |    2 +-
 drivers/pcmcia/pxa2xx_palmld.c    |    2 +-
 drivers/pcmcia/pxa2xx_palmtx.c    |    2 +-
 drivers/pcmcia/pxa2xx_sharpsl.c   |    2 +-
 drivers/pcmcia/pxa2xx_trizeps4.c  |    4 ++--
 drivers/pcmcia/pxa2xx_viper.c     |    2 +-
 drivers/pcmcia/sa1100_assabet.c   |    2 +-
 drivers/pcmcia/sa1100_cerf.c      |    2 +-
 drivers/pcmcia/sa1100_h3600.c     |    4 ++--
 drivers/pcmcia/sa1100_shannon.c   |    2 +-
 drivers/pcmcia/sa1100_simpad.c    |    2 +-
 drivers/pcmcia/sa1111_generic.c   |    2 +-
 drivers/pcmcia/sa11xx_base.c      |    2 +-
 drivers/pcmcia/soc_common.c       |    8 ++++----
 drivers/pcmcia/soc_common.h       |    1 -
 19 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 7f61b62..84dde77 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -287,10 +287,10 @@ int __pxa2xx_drv_pcmcia_probe(struct device *dev)
 		skt = &sinfo->skt[i];
 
 		skt->nr = ops->first + i;
-		skt->irq = NO_IRQ;
 		skt->ops = ops;
 		skt->socket.owner = ops->owner;
 		skt->socket.dev.parent = dev;
+		skt->socket.pci_irq = NO_IRQ;
 
 		ret = pxa2xx_drv_pcmcia_add_one(skt);
 		if (ret)
diff --git a/drivers/pcmcia/pxa2xx_cm_x255.c b/drivers/pcmcia/pxa2xx_cm_x255.c
index 5143a76..05913d0 100644
--- a/drivers/pcmcia/pxa2xx_cm_x255.c
+++ b/drivers/pcmcia/pxa2xx_cm_x255.c
@@ -44,7 +44,7 @@ static int cmx255_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		return ret;
 	gpio_direction_output(GPIO_PCMCIA_RESET, 0);
 
-	skt->irq = skt->nr == 0 ? PCMCIA_S0_RDYINT : PCMCIA_S1_RDYINT;
+	skt->socket.pci_irq = skt->nr == 0 ? PCMCIA_S0_RDYINT : PCMCIA_S1_RDYINT;
 	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 	if (!ret)
 		gpio_free(GPIO_PCMCIA_RESET);
diff --git a/drivers/pcmcia/pxa2xx_cm_x270.c b/drivers/pcmcia/pxa2xx_cm_x270.c
index a7b943d..5662646 100644
--- a/drivers/pcmcia/pxa2xx_cm_x270.c
+++ b/drivers/pcmcia/pxa2xx_cm_x270.c
@@ -38,7 +38,7 @@ static int cmx270_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		return ret;
 	gpio_direction_output(GPIO_PCMCIA_RESET, 0);
 
-	skt->irq = PCMCIA_S0_RDYINT;
+	skt->socket.pci_irq = PCMCIA_S0_RDYINT;
 	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 	if (!ret)
 		gpio_free(GPIO_PCMCIA_RESET);
diff --git a/drivers/pcmcia/pxa2xx_e740.c b/drivers/pcmcia/pxa2xx_e740.c
index d09c0dc..8bfbd4d 100644
--- a/drivers/pcmcia/pxa2xx_e740.c
+++ b/drivers/pcmcia/pxa2xx_e740.c
@@ -38,7 +38,7 @@ static struct pcmcia_irqs cd_irqs[] = {
 
 static int e740_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->irq = skt->nr == 0 ? IRQ_GPIO(GPIO_E740_PCMCIA_RDY0) :
+	skt->socket.pci_irq = skt->nr == 0 ? IRQ_GPIO(GPIO_E740_PCMCIA_RDY0) :
 				IRQ_GPIO(GPIO_E740_PCMCIA_RDY1);
 
 	return soc_pcmcia_request_irqs(skt, &cd_irqs[skt->nr], 1);
diff --git a/drivers/pcmcia/pxa2xx_mainstone.c b/drivers/pcmcia/pxa2xx_mainstone.c
index 1138551..92016fe 100644
--- a/drivers/pcmcia/pxa2xx_mainstone.c
+++ b/drivers/pcmcia/pxa2xx_mainstone.c
@@ -44,7 +44,7 @@ static int mst_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	 * before we enable them as outputs.
 	 */
 
-	skt->irq = (skt->nr == 0) ? MAINSTONE_S0_IRQ : MAINSTONE_S1_IRQ;
+	skt->socket.pci_irq = (skt->nr == 0) ? MAINSTONE_S0_IRQ : MAINSTONE_S1_IRQ;
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
 
diff --git a/drivers/pcmcia/pxa2xx_palmld.c b/drivers/pcmcia/pxa2xx_palmld.c
index 5ba9b36..6fb6f7f 100644
--- a/drivers/pcmcia/pxa2xx_palmld.c
+++ b/drivers/pcmcia/pxa2xx_palmld.c
@@ -45,7 +45,7 @@ static int palmld_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	if (ret)
 		goto err4;
 
-	skt->irq = IRQ_GPIO(GPIO_NR_PALMLD_PCMCIA_READY);
+	skt->socket.pci_irq = IRQ_GPIO(GPIO_NR_PALMLD_PCMCIA_READY);
 	return 0;
 
 err4:
diff --git a/drivers/pcmcia/pxa2xx_palmtx.c b/drivers/pcmcia/pxa2xx_palmtx.c
index e07b5c5..b07b247 100644
--- a/drivers/pcmcia/pxa2xx_palmtx.c
+++ b/drivers/pcmcia/pxa2xx_palmtx.c
@@ -53,7 +53,7 @@ static int palmtx_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	if (ret)
 		goto err5;
 
-	skt->irq = gpio_to_irq(GPIO_NR_PALMTX_PCMCIA_READY);
+	skt->socket.pci_irq = gpio_to_irq(GPIO_NR_PALMTX_PCMCIA_READY);
 	return 0;
 
 err5:
diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
index bc43f78..0ea3b29 100644
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -66,7 +66,7 @@ static int sharpsl_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		}
 	}
 
-	skt->irq = SCOOP_DEV[skt->nr].irq;
+	skt->socket.pci_irq = SCOOP_DEV[skt->nr].irq;
 
 	return 0;
 }
diff --git a/drivers/pcmcia/pxa2xx_trizeps4.c b/drivers/pcmcia/pxa2xx_trizeps4.c
index e0e5cb3..b7e5966 100644
--- a/drivers/pcmcia/pxa2xx_trizeps4.c
+++ b/drivers/pcmcia/pxa2xx_trizeps4.c
@@ -53,7 +53,7 @@ static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 			gpio_free(GPIO_PRDY);
 			return -EINVAL;
 		}
-		skt->irq = IRQ_GPIO(GPIO_PRDY);
+		skt->socket.pci_irq = IRQ_GPIO(GPIO_PRDY);
 		break;
 
 #ifndef CONFIG_MACH_TRIZEPS_CONXS
@@ -63,7 +63,7 @@ static int trizeps_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 		break;
 	}
 	/* release the reset of this card */
-	pr_debug("%s: sock %d irq %d\n", __func__, skt->nr, skt->irq);
+	pr_debug("%s: sock %d irq %d\n", __func__, skt->nr, skt->socket.pci_irq);
 
 	/* supplementory irqs for the socket */
 	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
diff --git a/drivers/pcmcia/pxa2xx_viper.c b/drivers/pcmcia/pxa2xx_viper.c
index 1787136..27be2e1 100644
--- a/drivers/pcmcia/pxa2xx_viper.c
+++ b/drivers/pcmcia/pxa2xx_viper.c
@@ -40,7 +40,7 @@ static int viper_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	unsigned long flags;
 
-	skt->irq = gpio_to_irq(VIPER_CF_RDY_GPIO);
+	skt->socket.pci_irq = gpio_to_irq(VIPER_CF_RDY_GPIO);
 
 	if (gpio_request(VIPER_CF_CD_GPIO, "CF detect"))
 		goto err_request_cd;
diff --git a/drivers/pcmcia/sa1100_assabet.c b/drivers/pcmcia/sa1100_assabet.c
index ac8aa09..fd013a1 100644
--- a/drivers/pcmcia/sa1100_assabet.c
+++ b/drivers/pcmcia/sa1100_assabet.c
@@ -27,7 +27,7 @@ static struct pcmcia_irqs irqs[] = {
 
 static int assabet_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->irq = ASSABET_IRQ_GPIO_CF_IRQ;
+	skt->socket.pci_irq = ASSABET_IRQ_GPIO_CF_IRQ;
 
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
diff --git a/drivers/pcmcia/sa1100_cerf.c b/drivers/pcmcia/sa1100_cerf.c
index 63e6bc4..9bf088b 100644
--- a/drivers/pcmcia/sa1100_cerf.c
+++ b/drivers/pcmcia/sa1100_cerf.c
@@ -27,7 +27,7 @@ static struct pcmcia_irqs irqs[] = {
 
 static int cerf_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->irq = CERF_IRQ_GPIO_CF_IRQ;
+	skt->socket.pci_irq = CERF_IRQ_GPIO_CF_IRQ;
 
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index 0cc3748..3a121ac 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -25,8 +25,8 @@ static struct pcmcia_irqs irqs[] = {
 
 static int h3600_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	skt->irq = skt->nr ? IRQ_GPIO_H3600_PCMCIA_IRQ1
-			   : IRQ_GPIO_H3600_PCMCIA_IRQ0;
+	skt->socket.pci_irq = skt->nr ? IRQ_GPIO_H3600_PCMCIA_IRQ1
+				      : IRQ_GPIO_H3600_PCMCIA_IRQ0;
 
 
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
diff --git a/drivers/pcmcia/sa1100_shannon.c b/drivers/pcmcia/sa1100_shannon.c
index 46d8c19..c4d5186 100644
--- a/drivers/pcmcia/sa1100_shannon.c
+++ b/drivers/pcmcia/sa1100_shannon.c
@@ -28,7 +28,7 @@ static int shannon_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	GAFR &= ~(SHANNON_GPIO_EJECT_0 | SHANNON_GPIO_EJECT_1 | 
 		  SHANNON_GPIO_RDY_0 | SHANNON_GPIO_RDY_1);
 
-	skt->irq = skt->nr ? SHANNON_IRQ_GPIO_RDY_1 : SHANNON_IRQ_GPIO_RDY_0;
+	skt->socket.pci_irq = skt->nr ? SHANNON_IRQ_GPIO_RDY_1 : SHANNON_IRQ_GPIO_RDY_0;
 
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
index 33a08ae..05bd504 100644
--- a/drivers/pcmcia/sa1100_simpad.c
+++ b/drivers/pcmcia/sa1100_simpad.c
@@ -28,7 +28,7 @@ static int simpad_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 
 	clear_cs3_bit(VCC_3V_EN|VCC_5V_EN|EN0|EN1);
 
-	skt->irq = IRQ_GPIO_CF_IRQ;
+	skt->socket.pci_irq = IRQ_GPIO_CF_IRQ;
 
 	return soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
 }
diff --git a/drivers/pcmcia/sa1111_generic.c b/drivers/pcmcia/sa1111_generic.c
index 219860a..deb5036 100644
--- a/drivers/pcmcia/sa1111_generic.c
+++ b/drivers/pcmcia/sa1111_generic.c
@@ -137,10 +137,10 @@ int sa1111_pcmcia_add(struct sa1111_dev *dev, struct pcmcia_low_level *ops,
 			return -ENOMEM;
 
 		s->soc.nr = ops->first + i;
-		s->soc.irq = s->soc.nr ? IRQ_S1_READY_NINT : IRQ_S0_READY_NINT;
 		s->soc.ops = ops;
 		s->soc.socket.owner = ops->owner;
 		s->soc.socket.dev.parent = &dev->dev;
+		s->soc.socket.pci_irq = s->soc.nr ? IRQ_S1_READY_NINT : IRQ_S0_READY_NINT;
 		s->dev = dev;
 
 		ret = add(&s->soc);
diff --git a/drivers/pcmcia/sa11xx_base.c b/drivers/pcmcia/sa11xx_base.c
index ac99872..fc9a652 100644
--- a/drivers/pcmcia/sa11xx_base.c
+++ b/drivers/pcmcia/sa11xx_base.c
@@ -235,10 +235,10 @@ int sa11xx_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops,
 		skt = &sinfo->skt[i];
 
 		skt->nr = first + i;
-		skt->irq = NO_IRQ;
 		skt->ops = ops;
 		skt->socket.owner = ops->owner;
 		skt->socket.dev.parent = dev;
+		skt->socket.pci_irq = NO_IRQ;
 
 		ret = sa11xx_drv_pcmcia_add_one(skt);
 		if (ret)
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 8e262a4..5ddf8fa 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -144,10 +144,10 @@ soc_common_pcmcia_config_skt(struct soc_pcmcia_socket *skt, socket_state_t *stat
 		 */
 		if (skt->irq_state != 1 && state->io_irq) {
 			skt->irq_state = 1;
-			set_irq_type(skt->irq, IRQ_TYPE_EDGE_FALLING);
+			set_irq_type(skt->socket.pci_irq, IRQ_TYPE_EDGE_FALLING);
 		} else if (skt->irq_state == 1 && state->io_irq == 0) {
 			skt->irq_state = 0;
-			set_irq_type(skt->irq, IRQ_TYPE_NONE);
+			set_irq_type(skt->socket.pci_irq, IRQ_TYPE_NONE);
 		}
 
 		skt->cs_state = *state;
@@ -491,7 +491,8 @@ static ssize_t show_status(struct device *dev, struct device_attribute *attr, ch
 
 	p+=sprintf(p, "Vcc      : %d\n", skt->cs_state.Vcc);
 	p+=sprintf(p, "Vpp      : %d\n", skt->cs_state.Vpp);
-	p+=sprintf(p, "IRQ      : %d (%d)\n", skt->cs_state.io_irq, skt->irq);
+	p+=sprintf(p, "IRQ      : %d (%d)\n", skt->cs_state.io_irq,
+		skt->socket.pci_irq);
 	if (skt->ops->show_timing)
 		p+=skt->ops->show_timing(skt, p);
 
@@ -694,7 +695,6 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 	skt->socket.resource_ops = &pccard_static_ops;
 	skt->socket.irq_mask = 0;
 	skt->socket.map_size = PAGE_SIZE;
-	skt->socket.pci_irq = skt->irq;
 	skt->socket.io_offset = (unsigned long)skt->virt_io;
 
 	skt->status = soc_common_pcmcia_skt_state(skt);
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 4fb06f7..e40824c 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -31,7 +31,6 @@ struct soc_pcmcia_socket {
 	 * Info from low level handler
 	 */
 	unsigned int		nr;
-	unsigned int		irq;
 
 	/*
 	 * Core PCMCIA state
-- 
1.6.2.5
