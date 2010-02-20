From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Sat, 20 Feb 2010 16:32:06 +0100
Subject: [PATCH 1/3] PCMCIA: Add soc_common support for banked SoC drivers.
In-Reply-To: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
References: <20100220153200.19692.70098.stgit@srv002.fuzzey.net>
Message-ID: <20100220153206.19692.90541.stgit@srv002.fuzzey.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some SoCs (like freescale MXC) require configuring a device register
to set the bank mapped into the memory window.

Also allow interrupt flags to be configured (to support shared interrupts).

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/pcmcia/soc_common.c |   21 +++++++++++++++------
 drivers/pcmcia/soc_common.h |    7 +++++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 6f1a86b..feab118 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -257,7 +257,8 @@ static irqreturn_t soc_common_pcmcia_interrupt(int irq, void *dev)
 	struct soc_pcmcia_socket *skt = dev;
 
 	debug(skt, 3, "servicing IRQ %d\n", irq);
-
+	if (skt->ops->ack_interrupt)
+		skt->ops->ack_interrupt(skt);
 	soc_common_check_status(skt);
 
 	return IRQ_HANDLED;
@@ -335,6 +336,7 @@ soc_common_pcmcia_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *m
 {
 	struct soc_pcmcia_socket *skt = to_soc_pcmcia_socket(sock);
 	unsigned short speed = map->speed;
+	int ret = 0;
 
 	debug(skt, 2, "map %u  speed %u start 0x%08llx stop 0x%08llx\n",
 		map->map, map->speed, (unsigned long long)map->start,
@@ -368,11 +370,14 @@ soc_common_pcmcia_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *m
 	if (map->stop == 1)
 		map->stop = PAGE_SIZE-1;
 
+	if (skt->ops->set_io_map)
+		ret = skt->ops->set_io_map(skt, map);
+
 	map->stop -= map->start;
 	map->stop += skt->socket.io_offset;
 	map->start = skt->socket.io_offset;
 
-	return 0;
+	return ret;
 }
 
 
@@ -390,6 +395,7 @@ soc_common_pcmcia_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map
 	struct soc_pcmcia_socket *skt = to_soc_pcmcia_socket(sock);
 	struct resource *res;
 	unsigned short speed = map->speed;
+	int ret = 0;
 
 	debug(skt, 2, "map %u speed %u card_start %08x\n",
 		map->map, map->speed, map->card_start);
@@ -424,10 +430,12 @@ soc_common_pcmcia_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map
 	}
 
 	skt->ops->set_timing(skt);
+	if (skt->ops->set_mem_map)
+		ret = skt->ops->set_mem_map(skt, map);
+	else
+		map->static_start = res->start + map->card_start;
 
-	map->static_start = res->start + map->card_start;
-
-	return 0;
+	return ret;
 }
 
 struct bittbl {
@@ -521,7 +529,8 @@ int soc_pcmcia_request_irqs(struct soc_pcmcia_socket *skt,
 		if (irqs[i].sock != skt->nr)
 			continue;
 		res = request_irq(irqs[i].irq, soc_common_pcmcia_interrupt,
-				  IRQF_DISABLED, irqs[i].str, skt);
+				  IRQF_DISABLED | irqs[i].flags,
+				  irqs[i].str, skt);
 		if (res)
 			break;
 		set_irq_type(irqs[i].irq, IRQ_TYPE_NONE);
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index e40824c..f0c7a15 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -111,6 +111,12 @@ struct pcmcia_low_level {
 	 */
 	int (*frequency_change)(struct soc_pcmcia_socket *, unsigned long, struct cpufreq_freqs *);
 #endif
+	void (*ack_interrupt)(struct soc_pcmcia_socket *);
+
+	/* Hardware specific mapping */
+	int (*set_mem_map)(struct soc_pcmcia_socket *, struct pccard_mem_map *);
+	int (*set_io_map)(struct soc_pcmcia_socket *, struct pccard_io_map *map);
+
 };
 
 
@@ -118,6 +124,7 @@ struct pcmcia_irqs {
 	int sock;
 	int irq;
 	const char *str;
+	unsigned long flags;
 };
 
 struct soc_pcmcia_timing {
