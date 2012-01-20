From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:17:49 +0000
Subject: [PATCH 02/19] PCMCIA: soc_common: add GPIO support for card status
 signals
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBXZ-0005hS-Jz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add GPIO support for reading the card status (card detect, ready,
battery voltage detect) signals into soc_common code.  As we want
interrupts from these GPIOs, this takes over the old irq handling
infrastructure for card status signals, which will now be managed
entirely by the soc_common code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/pcmcia/soc_common.c |  120 +++++++++++++++++++++++++++++++++++++++++-
 drivers/pcmcia/soc_common.h |   10 ++++
 2 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 84d90d5..09a9a52 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -32,6 +32,7 @@
 
 
 #include <linux/cpufreq.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -49,6 +50,8 @@
 
 #include "soc_common.h"
 
+static irqreturn_t soc_common_pcmcia_interrupt(int irq, void *dev);
+
 #ifdef CONFIG_PCMCIA_DEBUG
 
 static int pc_debug;
@@ -104,6 +107,93 @@ void soc_common_pcmcia_get_timing(struct soc_pcmcia_socket *skt,
 }
 EXPORT_SYMBOL(soc_common_pcmcia_get_timing);
 
+static void __soc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt,
+	unsigned int nr)
+{
+	unsigned int i;
+
+	for (i = 0; i < nr; i++) {
+		if (skt->stat[i].irq)
+			free_irq(skt->stat[i].irq, skt);
+		if (gpio_is_valid(skt->stat[i].gpio))
+			gpio_free(skt->stat[i].gpio);
+	}
+
+	if (skt->ops->hw_shutdown)
+		skt->ops->hw_shutdown(skt);
+}
+
+static void soc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
+{
+	__soc_pcmcia_hw_shutdown(skt, ARRAY_SIZE(skt->stat));
+}
+
+static int soc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+{
+	int ret = 0, i;
+
+	if (skt->ops->hw_init) {
+		ret = skt->ops->hw_init(skt);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(skt->stat); i++) {
+		if (gpio_is_valid(skt->stat[i].gpio)) {
+			int irq;
+
+			ret = gpio_request_one(skt->stat[i].gpio, GPIOF_IN,
+					       skt->stat[i].name);
+			if (ret) {
+				__soc_pcmcia_hw_shutdown(skt, i);
+				return ret;
+			}
+
+			irq = gpio_to_irq(skt->stat[i].gpio);
+
+			if (i == SOC_STAT_RDY)
+				skt->socket.pci_irq = irq;
+			else
+				skt->stat[i].irq = irq;
+		}
+
+		if (skt->stat[i].irq) {
+			ret = request_irq(skt->stat[i].irq,
+					  soc_common_pcmcia_interrupt,
+					  IRQF_TRIGGER_NONE,
+					  skt->stat[i].name, skt);
+			if (ret) {
+				if (gpio_is_valid(skt->stat[i].gpio))
+					gpio_free(skt->stat[i].gpio);
+				__soc_pcmcia_hw_shutdown(skt, i);
+				return ret;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static void soc_pcmcia_hw_enable(struct soc_pcmcia_socket *skt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(skt->stat); i++)
+		if (skt->stat[i].irq) {
+			irq_set_irq_type(skt->stat[i].irq, IRQ_TYPE_EDGE_RISING);
+			irq_set_irq_type(skt->stat[i].irq, IRQ_TYPE_EDGE_BOTH);
+		}
+}
+
+static void soc_pcmcia_hw_disable(struct soc_pcmcia_socket *skt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(skt->stat); i++)
+		if (skt->stat[i].irq)
+			irq_set_irq_type(skt->stat[i].irq, IRQ_TYPE_NONE);
+}
+
 static unsigned int soc_common_pcmcia_skt_state(struct soc_pcmcia_socket *skt)
 {
 	struct pcmcia_state state;
@@ -111,6 +201,22 @@ static unsigned int soc_common_pcmcia_skt_state(struct soc_pcmcia_socket *skt)
 
 	memset(&state, 0, sizeof(struct pcmcia_state));
 
+	/* Make battery voltage state report 'good' */
+	state.bvd1 = 1;
+	state.bvd2 = 1;
+
+	/* CD is active low by default */
+	if (gpio_is_valid(skt->stat[SOC_STAT_CD].gpio))
+		state.detect = !gpio_get_value(skt->stat[SOC_STAT_CD].gpio);
+
+	/* RDY and BVD are active high by default */
+	if (gpio_is_valid(skt->stat[SOC_STAT_RDY].gpio))
+		state.ready = !!gpio_get_value(skt->stat[SOC_STAT_RDY].gpio);
+	if (gpio_is_valid(skt->stat[SOC_STAT_BVD1].gpio))
+		state.bvd1 = !!gpio_get_value(skt->stat[SOC_STAT_BVD1].gpio);
+	if (gpio_is_valid(skt->stat[SOC_STAT_BVD2].gpio))
+		state.bvd2 = !!gpio_get_value(skt->stat[SOC_STAT_BVD2].gpio);
+
 	skt->ops->socket_state(skt, &state);
 
 	stat = state.detect  ? SS_DETECT : 0;
@@ -188,6 +294,7 @@ static int soc_common_pcmcia_sock_init(struct pcmcia_socket *sock)
 	debug(skt, 2, "initializing socket\n");
 	if (skt->ops->socket_init)
 		skt->ops->socket_init(skt);
+	soc_pcmcia_hw_enable(skt);
 	return 0;
 }
 
@@ -207,6 +314,7 @@ static int soc_common_pcmcia_suspend(struct pcmcia_socket *sock)
 
 	debug(skt, 2, "suspending socket\n");
 
+	soc_pcmcia_hw_disable(skt);
 	if (skt->ops->socket_suspend)
 		skt->ops->socket_suspend(skt);
 
@@ -638,10 +746,15 @@ module_exit(soc_pcmcia_cpufreq_unregister);
 void soc_pcmcia_init_one(struct soc_pcmcia_socket *skt,
 	struct pcmcia_low_level *ops, struct device *dev)
 {
+	int i;
+
 	skt->ops = ops;
 	skt->socket.owner = ops->owner;
 	skt->socket.dev.parent = dev;
 	skt->socket.pci_irq = NO_IRQ;
+
+	for (i = 0; i < ARRAY_SIZE(skt->stat); i++)
+		skt->stat[i].gpio = -EINVAL;
 }
 EXPORT_SYMBOL(soc_pcmcia_init_one);
 
@@ -652,8 +765,9 @@ void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt)
 
 	pcmcia_unregister_socket(&skt->socket);
 
-	skt->ops->hw_shutdown(skt);
+	soc_pcmcia_hw_shutdown(skt);
 
+	/* should not be required; violates some lowlevel drivers */
 	soc_common_pcmcia_config_skt(skt, &dead_socket);
 
 	list_del(&skt->node);
@@ -710,7 +824,7 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 	 */
 	skt->ops->set_timing(skt);
 
-	ret = skt->ops->hw_init(skt);
+	ret = soc_pcmcia_hw_init(skt);
 	if (ret)
 		goto out_err_6;
 
@@ -743,7 +857,7 @@ int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt)
 	pcmcia_unregister_socket(&skt->socket);
 
  out_err_7:
-	skt->ops->hw_shutdown(skt);
+	soc_pcmcia_hw_shutdown(skt);
  out_err_6:
 	list_del(&skt->node);
 	mutex_unlock(&soc_pcmcia_sockets_lock);
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 3ff7ead..ebdfa6c 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -50,6 +50,16 @@ struct soc_pcmcia_socket {
 	struct resource		res_attr;
 	void __iomem		*virt_io;
 
+	struct {
+		int		gpio;
+		unsigned int	irq;
+		const char	*name;
+	} stat[4];
+#define SOC_STAT_CD		0	/* Card detect */
+#define SOC_STAT_BVD1		1	/* BATDEAD / IOSTSCHG */
+#define SOC_STAT_BVD2		2	/* BATWARN / IOSPKR */
+#define SOC_STAT_RDY		3	/* Ready / Interrupt */
+
 	unsigned int		irq_state;
 
 	struct timer_list	poll_timer;
-- 
1.7.4.4
