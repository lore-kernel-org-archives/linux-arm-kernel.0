From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:25:17 +0100
Subject: [PATCH 14/33] pcmcia: soc_common: add CF socket state helper
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJkj-0000n4-71@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to get the voltage state of CF sockets, where the voltage
sense pins are not wired up.  Switch assabet and cerf to use this
helper.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/sa1100_assabet.c |  9 +--------
 drivers/pcmcia/sa1100_cerf.c    |  9 +--------
 drivers/pcmcia/soc_common.c     | 12 ++++++++++++
 drivers/pcmcia/soc_common.h     |  2 ++
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/pcmcia/sa1100_assabet.c b/drivers/pcmcia/sa1100_assabet.c
index 44cfc4416e54..71ace6910d7e 100644
--- a/drivers/pcmcia/sa1100_assabet.c
+++ b/drivers/pcmcia/sa1100_assabet.c
@@ -31,13 +31,6 @@ static int assabet_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	return 0;
 }
 
-static void
-assabet_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
-{
-	state->vs_3v  = 1; /* Can only apply 3.3V on Assabet. */
-	state->vs_Xv  = 0;
-}
-
 static int
 assabet_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
 {
@@ -90,7 +83,7 @@ static void assabet_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
 static struct pcmcia_low_level assabet_pcmcia_ops = { 
 	.owner			= THIS_MODULE,
 	.hw_init		= assabet_pcmcia_hw_init,
-	.socket_state		= assabet_pcmcia_socket_state,
+	.socket_state		= soc_common_cf_socket_state,
 	.configure_socket	= assabet_pcmcia_configure_socket,
 	.socket_suspend		= assabet_pcmcia_socket_suspend,
 };
diff --git a/drivers/pcmcia/sa1100_cerf.c b/drivers/pcmcia/sa1100_cerf.c
index b3774e5d0396..c3f67363f6a1 100644
--- a/drivers/pcmcia/sa1100_cerf.c
+++ b/drivers/pcmcia/sa1100_cerf.c
@@ -45,13 +45,6 @@ static void cerf_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
 	gpio_free(CERF_GPIO_CF_RESET);
 }
 
-static void
-cerf_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
-{
-	state->vs_3v	= 1;
-	state->vs_Xv	= 0;
-}
-
 static int
 cerf_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 			     const socket_state_t *state)
@@ -77,7 +70,7 @@ static struct pcmcia_low_level cerf_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 	.hw_init		= cerf_pcmcia_hw_init,
 	.hw_shutdown		= cerf_pcmcia_hw_shutdown,
-	.socket_state		= cerf_pcmcia_socket_state,
+	.socket_state		= soc_common_cf_socket_state,
 	.configure_socket	= cerf_pcmcia_configure_socket,
 };
 
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index d8508c41d7da..f880f805c2ca 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -235,6 +235,18 @@ static void soc_pcmcia_hw_disable(struct soc_pcmcia_socket *skt)
 			irq_set_irq_type(skt->stat[i].irq, IRQ_TYPE_NONE);
 }
 
+/*
+ * The CF 3.0 specification says that cards tie VS1 to ground and leave
+ * VS2 open.  Many implementations do not wire up the VS signals, so we
+ * provide hard-coded values as per the CF 3.0 spec.
+ */
+void soc_common_cf_socket_state(struct soc_pcmcia_socket *skt,
+	struct pcmcia_state *state)
+{
+	state->vs_3v = 1;
+}
+EXPORT_SYMBOL_GPL(soc_common_cf_socket_state);
+
 static unsigned int soc_common_pcmcia_skt_state(struct soc_pcmcia_socket *skt)
 {
 	struct pcmcia_state state;
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 686ba3238c76..39c1e15167f3 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -143,6 +143,8 @@ void soc_pcmcia_remove_one(struct soc_pcmcia_socket *skt);
 int soc_pcmcia_add_one(struct soc_pcmcia_socket *skt);
 int soc_pcmcia_request_gpiods(struct soc_pcmcia_socket *skt);
 
+void soc_common_cf_socket_state(struct soc_pcmcia_socket *skt,
+	struct pcmcia_state *state);
 
 #ifdef CONFIG_PCMCIA_DEBUG
 
-- 
2.1.0
