From: keescook@chromium.org (Kees Cook)
Date: Tue, 24 Oct 2017 03:23:31 -0700
Subject: [PATCH] drivers/pcmcia: Convert timers to use timer_setup()
Message-ID: <20171024102331.GA69696@beast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list at broadcom.com
Cc: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-pcmcia at lists.infradead.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/pcmcia/bcm63xx_pcmcia.c | 6 +++---
 drivers/pcmcia/bfin_cf_pcmcia.c | 6 +++---
 drivers/pcmcia/i82365.c         | 6 ++----
 drivers/pcmcia/omap_cf.c        | 8 ++++----
 drivers/pcmcia/pd6729.c         | 7 +++----
 drivers/pcmcia/soc_common.c     | 7 +++----
 drivers/pcmcia/tcic.c           | 8 +++-----
 drivers/pcmcia/yenta_socket.c   | 7 +++----
 8 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/pcmcia/bcm63xx_pcmcia.c b/drivers/pcmcia/bcm63xx_pcmcia.c
index 0802e0bc7d0c..16f573173471 100644
--- a/drivers/pcmcia/bcm63xx_pcmcia.c
+++ b/drivers/pcmcia/bcm63xx_pcmcia.c
@@ -263,12 +263,12 @@ static int bcm63xx_pcmcia_get_status(struct pcmcia_socket *sock,
 /*
  * socket polling timer callback
  */
-static void bcm63xx_pcmcia_poll(unsigned long data)
+static void bcm63xx_pcmcia_poll(struct timer_list *t)
 {
 	struct bcm63xx_pcmcia_socket *skt;
 	unsigned int stat, events;
 
-	skt = (struct bcm63xx_pcmcia_socket *)data;
+	skt = from_timer(skt, t, timer);
 
 	spin_lock_bh(&skt->lock);
 
@@ -392,7 +392,7 @@ static int bcm63xx_drv_pcmcia_probe(struct platform_device *pdev)
 	sock->map_size = resource_size(skt->common_res);
 
 	/* initialize polling timer */
-	setup_timer(&skt->timer, bcm63xx_pcmcia_poll, (unsigned long)skt);
+	timer_setup(&skt->timer, bcm63xx_pcmcia_poll, 0);
 
 	/* initialize  pcmcia  control register,  drive  VS[12] to  0,
 	 * leave CB IDSEL to the old  value since it is set by the PCI
diff --git a/drivers/pcmcia/bfin_cf_pcmcia.c b/drivers/pcmcia/bfin_cf_pcmcia.c
index 8b0923fd76c6..00a296d431ba 100644
--- a/drivers/pcmcia/bfin_cf_pcmcia.c
+++ b/drivers/pcmcia/bfin_cf_pcmcia.c
@@ -86,9 +86,9 @@ static int bfin_cf_ss_init(struct pcmcia_socket *s)
 }
 
 /* the timer is primarily to kick this socket's pccardd */
-static void bfin_cf_timer(unsigned long _cf)
+static void bfin_cf_timer(struct timer_list *t)
 {
-	struct bfin_cf_socket *cf = (void *)_cf;
+	struct bfin_cf_socket *cf = from_timer(cf, t, timer);
 	unsigned short present = bfin_cf_present(cf->cd_pfx);
 
 	if (present != cf->present) {
@@ -227,7 +227,7 @@ static int bfin_cf_probe(struct platform_device *pdev)
 
 	cf->cd_pfx = cd_pfx;
 
-	setup_timer(&cf->timer, bfin_cf_timer, (unsigned long)cf);
+	timer_setup(&cf->timer, bfin_cf_timer, 0);
 
 	cf->pdev = pdev;
 	platform_set_drvdata(pdev, cf);
diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index fb38cc01859f..891ccea2cccb 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -875,7 +875,7 @@ static irqreturn_t pcic_interrupt(int irq, void *dev)
     return IRQ_RETVAL(handled);
 } /* pcic_interrupt */
 
-static void pcic_interrupt_wrapper(u_long data)
+static void pcic_interrupt_wrapper(struct timer_list *unused)
 {
     pcic_interrupt(0, NULL);
     poll_timer.expires = jiffies + poll_interval;
@@ -1289,9 +1289,7 @@ static int __init init_i82365(void)
 
     /* Finally, schedule a polling interrupt */
     if (poll_interval != 0) {
-	poll_timer.function = pcic_interrupt_wrapper;
-	poll_timer.data = 0;
-	init_timer(&poll_timer);
+	timer_setup(&poll_timer, pcic_interrupt_wrapper, 0);
     	poll_timer.expires = jiffies + poll_interval;
 	add_timer(&poll_timer);
     }
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 4e2f501e5548..8216ceb51b18 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -80,9 +80,9 @@ static int omap_cf_ss_init(struct pcmcia_socket *s)
 }
 
 /* the timer is primarily to kick this socket's pccardd */
-static void omap_cf_timer(unsigned long _cf)
+static void omap_cf_timer(struct timer_list *t)
 {
-	struct omap_cf_socket	*cf = (void *) _cf;
+	struct omap_cf_socket	*cf = from_timer(cf, t, timer);
 	unsigned		present = omap_cf_present();
 
 	if (present != cf->present) {
@@ -102,7 +102,7 @@ static void omap_cf_timer(unsigned long _cf)
  */
 static irqreturn_t omap_cf_irq(int irq, void *_cf)
 {
-	omap_cf_timer((unsigned long)_cf);
+	omap_cf_timer(&_cf->timer);
 	return IRQ_HANDLED;
 }
 
@@ -220,7 +220,7 @@ static int __init omap_cf_probe(struct platform_device *pdev)
 	cf = kzalloc(sizeof *cf, GFP_KERNEL);
 	if (!cf)
 		return -ENOMEM;
-	setup_timer(&cf->timer, omap_cf_timer, (unsigned long)cf);
+	timer_setup(&cf->timer, omap_cf_timer, 0);
 
 	cf->pdev = pdev;
 	platform_set_drvdata(pdev, cf);
diff --git a/drivers/pcmcia/pd6729.c b/drivers/pcmcia/pd6729.c
index 0f70b4d58f9e..959ae3e65ef8 100644
--- a/drivers/pcmcia/pd6729.c
+++ b/drivers/pcmcia/pd6729.c
@@ -234,9 +234,9 @@ static irqreturn_t pd6729_interrupt(int irq, void *dev)
 
 /* socket functions */
 
-static void pd6729_interrupt_wrapper(unsigned long data)
+static void pd6729_interrupt_wrapper(struct timer_list *t)
 {
-	struct pd6729_socket *socket = (struct pd6729_socket *) data;
+	struct pd6729_socket *socket = from_timer(socket, t, poll_timer);
 
 	pd6729_interrupt(0, (void *)socket);
 	mod_timer(&socket->poll_timer, jiffies + HZ);
@@ -707,8 +707,7 @@ static int pd6729_pci_probe(struct pci_dev *dev,
 		}
 	} else {
 		/* poll Card status change */
-		setup_timer(&socket->poll_timer, pd6729_interrupt_wrapper,
-			    (unsigned long)socket);
+		timer_setup(&socket->poll_timer, pd6729_interrupt_wrapper, 0);
 		mod_timer(&socket->poll_timer, jiffies + HZ);
 	}
 
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index b6b316de055c..764650eb8897 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -456,9 +456,9 @@ static void soc_common_check_status(struct soc_pcmcia_socket *skt)
 }
 
 /* Let's poll for events in addition to IRQs since IRQ only is unreliable... */
-static void soc_common_pcmcia_poll_event(unsigned long dummy)
+static void soc_common_pcmcia_poll_event(struct timer_list *t)
 {
-	struct soc_pcmcia_socket *skt = (struct soc_pcmcia_socket *)dummy;
+	struct soc_pcmcia_socket *skt = from_timer(skt, t, poll_timer);
 	debug(skt, 4, "polling for events\n");
 
 	mod_timer(&skt->poll_timer, jiffies + SOC_PCMCIA_POLL_PERIOD);
@@ -794,8 +794,7 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 
 	skt->cs_state = dead_socket;
 
-	setup_timer(&skt->poll_timer, soc_common_pcmcia_poll_event,
-		    (unsigned long)skt);
+	timer_setup(&skt->poll_timer, soc_common_pcmcia_poll_event, 0);
 	skt->poll_timer.expires = jiffies + SOC_PCMCIA_POLL_PERIOD;
 
 	ret = request_resource(&iomem_resource, &skt->res_skt);
diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index a1ac72d51d70..1a0e3f098759 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -98,7 +98,7 @@ module_param(cycle_time, int, 0444);
 /*====================================================================*/
 
 static irqreturn_t tcic_interrupt(int irq, void *dev);
-static void tcic_timer(u_long data);
+static void tcic_timer(struct timer_list *unused);
 static struct pccard_operations tcic_operations;
 
 struct tcic_socket {
@@ -435,9 +435,7 @@ static int __init init_tcic(void)
     }
     
     /* Set up polling */
-    poll_timer.function = &tcic_timer;
-    poll_timer.data = 0;
-    init_timer(&poll_timer);
+    timer_setup(&poll_timer, &tcic_timer, 0);
 
     /* Build interrupt mask */
     printk(KERN_CONT ", %d sockets\n", sockets);
@@ -583,7 +581,7 @@ static irqreturn_t tcic_interrupt(int irq, void *dev)
     return IRQ_HANDLED;
 } /* tcic_interrupt */
 
-static void tcic_timer(u_long data)
+static void tcic_timer(struct timer_list *unused)
 {
     pr_debug("tcic_timer()\n");
     tcic_timer_pending = 0;
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 5d6d9b1549bc..ab3da2262f0f 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -534,9 +534,9 @@ static irqreturn_t yenta_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void yenta_interrupt_wrapper(unsigned long data)
+static void yenta_interrupt_wrapper(struct timer_list *t)
 {
-	struct yenta_socket *socket = (struct yenta_socket *) data;
+	struct yenta_socket *socket = from_timer(socket, t, poll_timer);
 
 	yenta_interrupt(0, (void *)socket);
 	socket->poll_timer.expires = jiffies + HZ;
@@ -1233,8 +1233,7 @@ static int yenta_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, IRQF_SHARED, "yenta", socket)) {
 		/* No IRQ or request_irq failed. Poll */
 		socket->cb_irq = 0; /* But zero is a valid IRQ number. */
-		setup_timer(&socket->poll_timer, yenta_interrupt_wrapper,
-			    (unsigned long)socket);
+		timer_setup(&socket->poll_timer, yenta_interrupt_wrapper, 0);
 		mod_timer(&socket->poll_timer, jiffies + HZ);
 		dev_info(&dev->dev,
 			 "no PCI IRQ, CardBus support disabled for this socket.\n");
-- 
2.7.4


-- 
Kees Cook
Pixel Security
