From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:20:12 +0000
Subject: [PATCH 09/19] PCMCIA: sa11x0: nanoengine: convert reset handling to
 use GPIO subsystem
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBZs-0005hz-8w@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than accessing GPSR and GPCR directly, use the GPIO subsystem
instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/nanoengine.h |    4 +-
 drivers/pcmcia/sa1100_nanoengine.c             |   38 ++++++++++--------------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/nanoengine.h b/arch/arm/mach-sa1100/include/mach/nanoengine.h
index ad24c6c..5ebd469 100644
--- a/arch/arm/mach-sa1100/include/mach/nanoengine.h
+++ b/arch/arm/mach-sa1100/include/mach/nanoengine.h
@@ -20,8 +20,8 @@
 #define GPIO_PC_READY1	12 /* ready for socket 1 (active high) */
 #define GPIO_PC_CD0	13 /* detect for socket 0 (active low) */
 #define GPIO_PC_CD1	14 /* detect for socket 1 (active low) */
-#define GPIO_PC_RESET0	GPIO_GPIO(15) /* reset socket 0 */
-#define GPIO_PC_RESET1	GPIO_GPIO(16) /* reset socket 1 */
+#define GPIO_PC_RESET0	15 /* reset socket 0 */
+#define GPIO_PC_RESET1	16 /* reset socket 1 */
 
 #define NANOENGINE_IRQ_GPIO_PCI		IRQ_GPIO0
 #define NANOENGINE_IRQ_GPIO_PC_READY0	IRQ_GPIO11
diff --git a/drivers/pcmcia/sa1100_nanoengine.c b/drivers/pcmcia/sa1100_nanoengine.c
index b19b816..cb43e39 100644
--- a/drivers/pcmcia/sa1100_nanoengine.c
+++ b/drivers/pcmcia/sa1100_nanoengine.c
@@ -19,6 +19,7 @@
  */
 #include <linux/device.h>
 #include <linux/errno.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/init.h>
@@ -37,19 +38,18 @@
 struct nanoengine_pins {
 	unsigned output_pins;
 	unsigned clear_outputs;
+	int gpio_rst;
 	int gpio_cd;
 	int gpio_rdy;
 };
 
 static struct nanoengine_pins nano_skts[] = {
 	{
-		.output_pins		= GPIO_PC_RESET0,
-		.clear_outputs		= GPIO_PC_RESET0,
+		.gpio_rst		= GPIO_PC_RESET0,
 		.gpio_cd		= GPIO_PC_CD0,
 		.gpio_rdy		= GPIO_PC_READY0,
 	}, {
-		.output_pins		= GPIO_PC_RESET1,
-		.clear_outputs		= GPIO_PC_RESET1,
+		.gpio_rst		= GPIO_PC_RESET1,
 		.gpio_cd		= GPIO_PC_CD1,
 		.gpio_rdy		= GPIO_PC_READY1,
 	}
@@ -60,12 +60,15 @@ unsigned num_nano_pcmcia_sockets = ARRAY_SIZE(nano_skts);
 static int nanoengine_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	unsigned i = skt->nr;
+	int ret;
 
 	if (i >= num_nano_pcmcia_sockets)
 		return -ENXIO;
 
-	GPDR |= nano_skts[i].output_pins;
-	GPCR = nano_skts[i].clear_outputs;
+	ret = gpio_request_one(nano_skts[i].gpio_rst, GPIOF_OUT_INIT_LOW,
+		i ? "PC RST1" : "PC RST0");
+	if (ret)
+		return ret;
 
 	skt->stat[SOC_STAT_CD].gpio = nano_skts[i].gpio_cd;
 	skt->stat[SOC_STAT_CD].name = i ? "PC CD1" : "PC CD0";
@@ -75,30 +78,20 @@ static int nanoengine_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	return 0;
 }
 
+static void nanoengine_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
+{
+	gpio_free(nano_skts[skt->nr].gpio_rst);
+}
+
 static int nanoengine_pcmcia_configure_socket(
 	struct soc_pcmcia_socket *skt, const socket_state_t *state)
 {
-	unsigned reset;
 	unsigned i = skt->nr;
 
 	if (i >= num_nano_pcmcia_sockets)
 		return -ENXIO;
 
-	switch (i) {
-	case 0:
-		reset = GPIO_PC_RESET0;
-		break;
-	case 1:
-		reset = GPIO_PC_RESET1;
-		break;
-	default:
-		return -ENXIO;
-	}
-
-	if (state->flags & SS_RESET)
-		GPSR = reset;
-	else
-		GPCR = reset;
+	gpio_set_value(nano_skts[skt->nr].gpio_rst, !!(state->flags & SS_RESET));
 
 	return 0;
 }
@@ -122,6 +115,7 @@ static struct pcmcia_low_level nanoengine_pcmcia_ops = {
 	.owner			= THIS_MODULE,
 
 	.hw_init		= nanoengine_pcmcia_hw_init,
+	.hw_shutdown		= nanoengine_pcmcia_hw_shutdown,
 
 	.configure_socket	= nanoengine_pcmcia_configure_socket,
 	.socket_state		= nanoengine_pcmcia_socket_state,
-- 
1.7.4.4
