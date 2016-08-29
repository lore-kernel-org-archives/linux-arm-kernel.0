From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:26:18 +0100
Subject: [PATCH 26/33] ARM: sa1100/shannon: switch shannon PCMCIA to use gpiod
 APIs
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJli-0000oF-Q0@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch shannon's PCMCIA implementation to use the gpiod APIs.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/shannon.c  | 13 +++++++++++++
 drivers/pcmcia/sa1100_shannon.c | 25 ++++++-------------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index c8866bce7386..f2cc896e582f 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -4,6 +4,7 @@
 
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/gpio/machine.h>
 #include <linux/kernel.h>
 #include <linux/platform_data/sa11x0-serial.h>
 #include <linux/tty.h>
@@ -71,8 +72,20 @@ static struct sa1100fb_mach_info shannon_lcd_info = {
 	.lccr3		= LCCR3_ACBsDiv(512),
 };
 
+static struct gpiod_lookup_table shannon_pcmcia_gpio_table = {
+	.dev_id = "sa11x0-pcmcia",
+	.table = {
+		GPIO_LOOKUP("gpio", 24, "pcmcia0-detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", 25, "pcmcia1-detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", 26, "pcmcia0-ready", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 27, "pcmcia1-ready", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void __init shannon_init(void)
 {
+	gpiod_add_lookup_table(&shannon_pcmcia_gpio_table);
 	sa11x0_ppc_configure_mcp();
 	sa11x0_register_lcd(&shannon_lcd_info);
 	sa11x0_register_mtd(&shannon_flash_data, &shannon_flash_resource, 1);
diff --git a/drivers/pcmcia/sa1100_shannon.c b/drivers/pcmcia/sa1100_shannon.c
index b07a2dc3296e..51985c8ba830 100644
--- a/drivers/pcmcia/sa1100_shannon.c
+++ b/drivers/pcmcia/sa1100_shannon.c
@@ -8,35 +8,22 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/init.h>
-#include <linux/io.h>
 
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <mach/shannon.h>
-#include <asm/irq.h>
+
 #include "sa1100_generic.h"
 
 static int shannon_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
-	/* All those are inputs */
-	GAFR &= ~(GPIO_GPIO(SHANNON_GPIO_EJECT_0) |
-		  GPIO_GPIO(SHANNON_GPIO_EJECT_1) |
-		  GPIO_GPIO(SHANNON_GPIO_RDY_0) |
-		  GPIO_GPIO(SHANNON_GPIO_RDY_1));
-
 	if (skt->nr == 0) {
-		skt->stat[SOC_STAT_CD].gpio = SHANNON_GPIO_EJECT_0;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA_CD_0";
-		skt->stat[SOC_STAT_RDY].gpio = SHANNON_GPIO_RDY_0;
-		skt->stat[SOC_STAT_RDY].name = "PCMCIA_RDY_0";
+		skt->stat[SOC_STAT_CD].name = "pcmcia0-detect";
+		skt->stat[SOC_STAT_RDY].name = "pcmcia0-ready";
 	} else {
-		skt->stat[SOC_STAT_CD].gpio = SHANNON_GPIO_EJECT_1;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA_CD_1";
-		skt->stat[SOC_STAT_RDY].gpio = SHANNON_GPIO_RDY_1;
-		skt->stat[SOC_STAT_RDY].name = "PCMCIA_RDY_1";
+		skt->stat[SOC_STAT_CD].name = "pcmcia1-detect";
+		skt->stat[SOC_STAT_RDY].name = "pcmcia1-ready";
 	}
 
-	return 0;
+	return soc_pcmcia_request_gpiods(skt);
 }
 
 static void
-- 
2.1.0
