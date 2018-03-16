From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 16 Mar 2018 19:57:15 +0000
Subject: [PATCH 8/8] ARM: sa1100/simpad: switch simpad CF to use gpiod APIs
In-Reply-To: <20180316195552.GS9418@n2100.armlinux.org.uk>
References: <20180316195552.GS9418@n2100.armlinux.org.uk>
Message-ID: <E1ewvTX-0004YV-Rb@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch simpad's CF implementation to use the gpiod APIs.  The inverted
detection is handled using gpiolib's native inversion abilities.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/simpad.c  | 11 +++++++++++
 drivers/pcmcia/sa1100_simpad.c | 12 +++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
index 7d4feb8a49ac..ace010479eb6 100644
--- a/arch/arm/mach-sa1100/simpad.c
+++ b/arch/arm/mach-sa1100/simpad.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/gpio/machine.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/tty.h>
@@ -364,6 +365,15 @@ static struct platform_device *devices[] __initdata = {
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
@@ -385,6 +395,7 @@ static int __init simpad_init(void)
 
 	pm_power_off = simpad_power_off;
 
+	sa11x0_register_pcmcia(-1, &simpad_cf_gpio_table);
 	sa11x0_ppc_configure_mcp();
 	sa11x0_register_mtd(&simpad_flash_data, simpad_flash_resources,
 			      ARRAY_SIZE(simpad_flash_resources));
diff --git a/drivers/pcmcia/sa1100_simpad.c b/drivers/pcmcia/sa1100_simpad.c
index 7ce65bb23a8e..e235ee14eaa6 100644
--- a/drivers/pcmcia/sa1100_simpad.c
+++ b/drivers/pcmcia/sa1100_simpad.c
@@ -12,7 +12,6 @@
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/irq.h>
 #include <mach/simpad.h>
 #include "sa1100_generic.h"
  
@@ -21,12 +20,10 @@ static int simpad_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 
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
@@ -42,9 +39,6 @@ simpad_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
 {
 	long cs3reg = simpad_get_cs3_ro();
 
-	/* the detect signal is inverted - fix that up here */
-	state->detect = !state->detect;
-
 	state->bvd1 = 1; /* Might be cs3reg & PCMCIA_BVD1 */
 	state->bvd2 = 1; /* Might be cs3reg & PCMCIA_BVD2 */
 
-- 
2.7.4
