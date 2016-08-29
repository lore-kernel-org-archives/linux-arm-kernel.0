From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:25:22 +0100
Subject: [PATCH 15/33] pcmcia: soc_common: add support for Vcc and Vpp
 regulators
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJko-0000nA-Aj@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for handling supply regulators in the soc_common code.  This
allows us to separate out the board specifics for setting voltages from
the PCMCIA code.

We detect when setting a voltage fails, and report this fact - some
platforms have fixed-voltage supplies (eg, for CF sockets at 3.3V) and
we need to ignore attempts to configure for 5V, as per the existing
board specific drivers.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/soc_common.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pcmcia/soc_common.h | 11 +++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index f880f805c2ca..128d8611f39a 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 
@@ -80,6 +81,50 @@ EXPORT_SYMBOL(soc_pcmcia_debug);
 #define to_soc_pcmcia_socket(x)	\
 	container_of(x, struct soc_pcmcia_socket, socket)
 
+static void soc_pcmcia_regulator_put(struct soc_pcmcia_regulator *r)
+{
+	if (r->reg) {
+		regulator_put(r->reg);
+		r->reg = NULL;
+		r->on = false;
+	}
+}
+
+int soc_pcmcia_regulator_set(struct soc_pcmcia_socket *skt,
+	struct soc_pcmcia_regulator *r, int v)
+{
+	bool on;
+	int ret;
+
+	if (!r->reg)
+		return 0;
+
+	on = v != 0;
+	if (r->on == on)
+		return 0;
+
+	if (on) {
+		ret = regulator_set_voltage(r->reg, v * 100000, v * 100000);
+		if (ret) {
+			int vout = regulator_get_voltage(r->reg) / 100000;
+
+			dev_warn(&skt->socket.dev,
+				 "CS requested %s=%u.%uV, applying %u.%uV\n",
+				 r == &skt->vcc ? "Vcc" : "Vpp",
+				 v / 10, v % 10, vout / 10, vout % 10);
+		}
+
+		ret = regulator_enable(r->reg);
+	} else {
+		regulator_disable(r->reg);
+	}
+	if (ret == 0)
+		r->on = on;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(soc_pcmcia_regulator_set);
+
 static unsigned short
 calc_speed(unsigned short *spds, int num, unsigned short dflt)
 {
@@ -126,6 +171,8 @@ static void __soc_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt,
 		gpiod_put(skt->gpio_reset);
 	if (skt->gpio_bus_enable)
 		gpiod_put(skt->gpio_bus_enable);
+	soc_pcmcia_regulator_put(&skt->vcc);
+	soc_pcmcia_regulator_put(&skt->vpp);
 
 	clk_disable_unprepare(skt->clk);
 }
diff --git a/drivers/pcmcia/soc_common.h b/drivers/pcmcia/soc_common.h
index 39c1e15167f3..18a6df5ca374 100644
--- a/drivers/pcmcia/soc_common.h
+++ b/drivers/pcmcia/soc_common.h
@@ -19,6 +19,12 @@
 struct device;
 struct gpio_desc;
 struct pcmcia_low_level;
+struct regulator;
+
+struct soc_pcmcia_regulator {
+	struct regulator	*reg;
+	bool			on;
+};
 
 /*
  * This structure encapsulates per-socket state which we might need to
@@ -64,6 +70,8 @@ struct soc_pcmcia_socket {
 
 	struct gpio_desc	*gpio_reset;
 	struct gpio_desc	*gpio_bus_enable;
+	struct soc_pcmcia_regulator vcc;
+	struct soc_pcmcia_regulator vpp;
 
 	unsigned int		irq_state;
 
@@ -146,6 +154,9 @@ int soc_pcmcia_request_gpiods(struct soc_pcmcia_socket *skt);
 void soc_common_cf_socket_state(struct soc_pcmcia_socket *skt,
 	struct pcmcia_state *state);
 
+int soc_pcmcia_regulator_set(struct soc_pcmcia_socket *skt,
+	struct soc_pcmcia_regulator *r, int v);
+
 #ifdef CONFIG_PCMCIA_DEBUG
 
 extern void soc_pcmcia_debug(struct soc_pcmcia_socket *skt, const char *func,
-- 
2.1.0
