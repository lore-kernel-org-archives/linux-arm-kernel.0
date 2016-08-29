From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:26:23 +0100
Subject: [PATCH 27/33] ARM: sa1100/simpad: switch simpad CF to use gpiod APIs
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJln-0000oL-Tv@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch simpad's CF implementation to use the gpiod APIs.  The inverted
detection is handled using gpiolib's native inversion abilities.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/simpad.c  | 12 ++++++++++++
 drivers/pcmcia/sa1100_simpad.c | 12 +++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index bb3ca9c763de..5301a3036212 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/tty.h>
@@ -354,12 +355,23 @@ static struct platform_device *devices[] __initdata = {
 	&simpad_i2c,
 };
 
+/* Compact Flash */
+static struct gpiod_lookup_table simpad_cf_gpio_table = {
+	.dev_id = "sa11x0-pcmcia",
+	.table = {
+		GPIO_LOOKUP("gpio", GPIO_CF_IRQ, "cf-ready", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", GPIO_CF_CD, "cf-detect", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
 
 
 static int __init simpad_init(void)
 {
 	int ret;
 
+	gpiod_add_lookup_table(&simpad_cf_gpio_table);
+
 	spin_lock_init(&cs3_lock);
 
 	cs3_gpio.label = "simpad_cs3";
diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
index 73fd37968b6a..e14b2f5a18bb 100644
--- a/drivers/pcmcia/sa1100_simpad.c
+++ b/drivers/pcmcia/sa1100_simpad.c
@@ -11,7 +11,6 @@
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/irq.h>
 #include <mach/simpad.h>
 #include "sa1100_generic.h"
  
@@ -20,12 +19,10 @@ static int simpad_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 
 	simpad_clear_cs3_bit(VCC_3V_EN|VCC_5V_EN|EN0|EN1);
 
-	skt->stat[SOC_STAT_CD].gpio = GPIO_CF_CD;
-	skt->stat[SOC_STAT_CD].name = "CF_CD";
-	skt->stat[SOC_STAT_RDY].gpio = GPIO_CF_IRQ;
-	skt->stat[SOC_STAT_RDY].name = "CF_RDY";
+	skt->stat[SOC_STAT_CD].name = "cf-detect";
+	skt->stat[SOC_STAT_RDY].name = "cf-ready";
 
-	return 0;
+	return soc_pcmcia_request_gpiods(skt);
 }
 
 static void simpad_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
@@ -41,9 +38,6 @@ simpad_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 {
 	long cs3reg = simpad_get_cs3_ro();
 
-	/* the detect signal is inverted - fix that up here */
-	state->detect = !state->detect;
-
 	state->bvd1 = 1; /* Might be cs3reg & PCMCIA_BVD1 */
 	state->bvd2 = 1; /* Might be cs3reg & PCMCIA_BVD2 */
 
-- 
2.1.0
