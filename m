From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:19:31 +0000
Subject: [PATCH 07/19] PCMCIA: sa11x0: cerf: convert reset handling to use
 GPIO subsystem
In-Reply-To: <20120120101709.GE1068@n2100.arm.linux.org.uk>
References: <20120120101709.GE1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoBZD-0005hm-NN@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than accessing GPSR and GPCR directly, use the GPIO subsystem
instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/cerf.h |    2 +-
 drivers/pcmcia/sa1100_cerf.c             |   19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/cerf.h b/arch/arm/mach-sa1100/include/mach/cerf.h
index 0e49545..88fd9c0 100644
--- a/arch/arm/mach-sa1100/include/mach/cerf.h
+++ b/arch/arm/mach-sa1100/include/mach/cerf.h
@@ -16,7 +16,7 @@
 
 #define CERF_GPIO_CF_BVD2		19
 #define CERF_GPIO_CF_BVD1		20
-#define CERF_GPIO_CF_RESET		GPIO_GPIO (21)
+#define CERF_GPIO_CF_RESET		21
 #define CERF_GPIO_CF_IRQ		22
 #define CERF_GPIO_CF_CD			23
 
diff --git a/drivers/pcmcia/sa1100_cerf.c b/drivers/pcmcia/sa1100_cerf.c
index 9d0424e..50df0e6 100644
--- a/drivers/pcmcia/sa1100_cerf.c
+++ b/drivers/pcmcia/sa1100_cerf.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -21,6 +22,12 @@
 
 static int cerf_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
+	int ret;
+
+	ret = gpio_request_one(CERF_GPIO_CF_RESET, GPIOF_OUT_INIT_LOW, "CF_RESET");
+	if (ret)
+		return ret;
+
 	skt->stat[SOC_STAT_CD].gpio = CERF_GPIO_CF_CD;
 	skt->stat[SOC_STAT_CD].name = "CF_CD";
 	skt->stat[SOC_STAT_BVD1].gpio = CERF_GPIO_CF_BVD1;
@@ -33,6 +40,11 @@ static int cerf_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 	return 0;
 }
 
+static void cerf_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
+{
+	gpio_free(CERF_GPIO_CF_RESET);
+}
+
 static void
 cerf_pcmcia_socket_state(struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
 {
@@ -57,11 +69,7 @@ cerf_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 		return -1;
 	}
 
-	if (state->flags & SS_RESET) {
-		GPSR = CERF_GPIO_CF_RESET;
-	} else {
-		GPCR = CERF_GPIO_CF_RESET;
-	}
+	gpio_set_value(CERF_GPIO_CF_RESET, !!(state->flags & SS_RESET));
 
 	return 0;
 }
@@ -69,6 +77,7 @@ cerf_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
 static struct pcmcia_low_level cerf_pcmcia_ops = { 
 	.owner			= THIS_MODULE,
 	.hw_init		= cerf_pcmcia_hw_init,
+	.hw_shutdown		= cerf_pcmcia_hw_shutdown,
 	.socket_state		= cerf_pcmcia_socket_state,
 	.configure_socket	= cerf_pcmcia_configure_socket,
 };
-- 
1.7.4.4
