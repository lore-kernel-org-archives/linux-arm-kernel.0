From: mfuzzey@gmail.com (Martin Fuzzey)
Date: Tue, 27 Oct 2009 18:26:57 +0100
Subject: [RFC PATCH 1/2] PCMCIA: Add soc_common support for banked SoC drivers.
In-Reply-To: <20091027172652.7671.85583.stgit@srv002.fuzzey.net>
References: <20091027172652.7671.85583.stgit@srv002.fuzzey.net>
Message-ID: <20091027172657.7671.95785.stgit@srv002.fuzzey.net>
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
index 163cf98..c06440c 100644
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
 
 	debug(skt, 2, "map %u  speed %u start 0x%08x stop 0x%08x\n",
 		map->map, map->speed, map->start, map->stop);
@@ -367,11 +369,14 @@ soc_common_pcmcia_set_io_map(struct pcmcia_socket *sock, struct pccard_io_map *m
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
 
 
@@ -389,6 +394,7 @@ soc_common_pcmcia_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map
 	struct soc_pcmcia_socket *skt = to_soc_pcmcia_socket(sock);
 	struct resource *res;
 	unsigned short speed = map->speed;
+	int ret = 0;
 
 	debug(skt, 2, "map %u speed %u card_start %08x\n",
 		map->map, map->speed, map->card_start);
@@ -423,10 +429,12 @@ soc_common_pcmcia_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map
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
@@ -519,7 +527,8 @@ int soc_pcmcia_request_irqs(struct soc_pcmcia_socket *skt,
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
index 290e143..9076003 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -113,6 +113,12 @@ struct pcmcia_low_level {
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
 
 
@@ -120,6 +126,7 @@ struct pcmcia_irqs {
 	int sock;
 	int irq;
 	const char *str;
+	unsigned long flags;
 };
 
 struct soc_pcmcia_timing {
