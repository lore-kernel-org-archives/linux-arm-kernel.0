From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:24:56 +0100
Subject: [PATCH 10/33] pcmcia: soc_common: switch to using gpio_descs
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJkO-0000mg-Lu@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to using the gpiod_* consumer API rather than the legacy API.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/soc_common.c | 57 +++++++++++++++++++++++++++++++++------------
 drivers/pcmcia/soc_common.h |  3 +++
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index d5ca760c4eb2..5d167512e96e 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -33,6 +33,7 @@
 
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -114,8 +115,8 @@ static void __soc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt,
 	for (i = 0; i < nr; i++) {
 		if (skt->stat[i].irq)
 			free_irq(skt->stat[i].irq, skt);
-		if (gpio_is_valid(skt->stat[i].gpio))
-			gpio_free(skt->stat[i].gpio);
+		if (skt->stat[i].desc)
+			gpiod_put(skt->stat[i].desc);
 	}
 
 	if (skt->ops->hw_shutdown)
@@ -129,6 +130,30 @@ static void soc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 	__soc_pcmcia_hw_shutdown(skt, ARRAY_SIZE(skt->stat));
 }
 
+int soc_pcmcia_request_gpiods(struct soc_pcmcia_socket *skt)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(skt->stat); i++) {
+		struct gpio_desc *desc;
+
+		desc = gpiod_get(skt->socket.dev.parent,
+				 skt->stat[i].name, GPIOD_IN);
+		if (IS_ERR(desc)) {
+			dev_err(skt->socket.dev.parent,
+				"Failed to get GPIO for %s: %ld\n",
+				skt->stat[i].name, PTR_ERR(desc));
+			__soc_pcmcia_hw_shutdown(skt, i);
+			return PTR_ERR(desc);
+		}
+
+		skt->stat[i].desc = desc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(soc_pcmcia_request_gpiods);
+
 static int soc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int ret = 0, i;
@@ -143,8 +168,6 @@ static int soc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 
 	for (i = 0; i < ARRAY_SIZE(skt->stat); i++) {
 		if (gpio_is_valid(skt->stat[i].gpio)) {
-			int irq;
-
 			ret = gpio_request_one(skt->stat[i].gpio, GPIOF_IN,
 					       skt->stat[i].name);
 			if (ret) {
@@ -152,7 +175,11 @@ static int soc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 				return ret;
 			}
 
-			irq = gpio_to_irq(skt->stat[i].gpio);
+			skt->stat[i].desc = gpio_to_desc(skt->stat[i].gpio);
+		}
+
+		if (skt->stat[i].desc) {
+			int irq = gpiod_to_irq(skt->stat[i].desc);
 
 			if (i == SOC_STAT_RDY)
 				skt->socket.pci_irq = irq;
@@ -166,8 +193,8 @@ static int soc_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 					  IRQF_TRIGGER_NONE,
 					  skt->stat[i].name, skt);
 			if (ret) {
-				if (gpio_is_valid(skt->stat[i].gpio))
-					gpio_free(skt->stat[i].gpio);
+				if (skt->stat[i].desc)
+					gpiod_put(skt->stat[i].desc);
 				__soc_pcmcia_hw_shutdown(skt, i);
 				return ret;
 			}
@@ -209,16 +236,16 @@ static unsigned int soc_common_pcmcia_skt_state(struct soc_pcmcia_socket *skt)
 	state.bvd2 = 1;
 
 	/* CD is active low by default */
-	if (gpio_is_valid(skt->stat[SOC_STAT_CD].gpio))
-		state.detect = !gpio_get_value(skt->stat[SOC_STAT_CD].gpio);
+	if (skt->stat[SOC_STAT_CD].desc)
+		state.detect = !gpiod_get_raw_value(skt->stat[SOC_STAT_CD].desc);
 
 	/* RDY and BVD are active high by default */
-	if (gpio_is_valid(skt->stat[SOC_STAT_RDY].gpio))
-		state.ready = !!gpio_get_value(skt->stat[SOC_STAT_RDY].gpio);
-	if (gpio_is_valid(skt->stat[SOC_STAT_BVD1].gpio))
-		state.bvd1 = !!gpio_get_value(skt->stat[SOC_STAT_BVD1].gpio);
-	if (gpio_is_valid(skt->stat[SOC_STAT_BVD2].gpio))
-		state.bvd2 = !!gpio_get_value(skt->stat[SOC_STAT_BVD2].gpio);
+	if (skt->stat[SOC_STAT_RDY].desc)
+		state.ready = !!gpiod_get_value(skt->stat[SOC_STAT_RDY].desc);
+	if (skt->stat[SOC_STAT_BVD1].desc)
+		state.bvd1 = !!gpiod_get_value(skt->stat[SOC_STAT_BVD1].desc);
+	if (skt->stat[SOC_STAT_BVD2].desc)
+		state.bvd2 = !!gpiod_get_value(skt->stat[SOC_STAT_BVD2].desc);
 
 	skt->ops->socket_state(skt, &state);
 
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 94762a54d731..ee40db16dc40 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -17,6 +17,7 @@
 
 
 struct device;
+struct gpio_desc;
 struct pcmcia_low_level;
 
 /*
@@ -52,6 +53,7 @@ struct soc_pcmcia_socket {
 
 	struct {
 		int		gpio;
+		struct gpio_desc *desc;
 		unsigned int	irq;
 		const char	*name;
 	} stat[4];
@@ -136,6 +138,7 @@ void soc_pcmcia_init_one(struct soc_pcmcia_socket *skt,
 	struct pcmcia_low_level *ops, struct device *dev);
 void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt);
 int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt);
+int soc_pcmcia_request_gpiods(struct soc_pcmcia_socket *skt);
 
 
 #ifdef CONFIG_PCMCIA_DEBUG
-- 
2.1.0
