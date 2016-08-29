From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:25:06 +0100
Subject: [PATCH 12/33] pcmcia: soc_common: add support for reset and bus
 enable GPIOs
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJkY-0000ms-Ut@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support to soc_common for controlling reset and bus enable GPIOs
from within the generic soc_common layer, rather than having
individual drivers having to perform this themselves.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/soc_common.c | 20 ++++++++++++++++++++
 drivers/pcmcia/soc_common.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index edfb6045fcda..822de207c408 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -122,6 +122,11 @@ static void __soc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt,
 	if (skt->ops->hw_shutdown)
 		skt->ops->hw_shutdown(skt);
 
+	if (skt->gpio_reset)
+		gpiod_put(skt->gpio_reset);
+	if (skt->gpio_bus_enable)
+		gpiod_put(skt->gpio_bus_enable);
+
 	clk_disable_unprepare(skt->clk);
 }
 
@@ -288,6 +293,21 @@ static int soc_common_pcmcia_config_skt(
 
 	ret = skt->ops->configure_socket(skt, state);
 	if (ret == 0) {
+		struct gpio_desc *descs[2];
+		int values[2], n = 0;
+
+		if (skt->gpio_reset) {
+			descs[n] = skt->gpio_reset;
+			values[n++] = !!(state->flags & SS_RESET);
+		}
+		if (skt->gpio_bus_enable) {
+			descs[n] = skt->gpio_bus_enable;
+			values[n++] = !!(state->flags & SS_OUTPUT_ENA);
+		}
+
+		if (n)
+			gpiod_set_array_value_cansleep(n, descs, values);
+
 		/*
 		 * This really needs a better solution.  The IRQ
 		 * may or may not be claimed by the driver.
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index ee40db16dc40..686ba3238c76 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -62,6 +62,9 @@ struct soc_pcmcia_socket {
 #define SOC_STAT_BVD2		2	/* BATWARN / IOSPKR */
 #define SOC_STAT_RDY		3	/* Ready / Interrupt */
 
+	struct gpio_desc	*gpio_reset;
+	struct gpio_desc	*gpio_bus_enable;
+
 	unsigned int		irq_state;
 
 	struct timer_list	poll_timer;
-- 
2.1.0
