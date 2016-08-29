From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 29 Aug 2016 11:26:08 +0100
Subject: [PATCH 24/33] ARM: sa1100/h3xxx: switch h3xxx PCMCIA to use gpiod APIs
In-Reply-To: <20160829102328.GA28796@n2100.armlinux.org.uk>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
Message-ID: <E1beJlY-0000o3-Gx@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch h3xxx's PCMCIA implementation to use the gpiod APIs where
possible.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/h3xxx.c  | 17 +++++++++++++++++
 drivers/pcmcia/sa1100_h3600.c | 16 +++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index b1d4faa12f9a..31035ab3c095 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
@@ -264,8 +265,24 @@ static struct platform_device *h3xxx_devices[] = {
 	&h3xxx_micro_asic,
 };
 
+static struct gpiod_lookup_table h3xxx_pcmcia_gpio_table = {
+	.dev_id = "sa11x0-pcmcia",
+	.table = {
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_PCMCIA_CD0,
+			    "pcmcia0-detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_PCMCIA_IRQ0,
+			    "pcmcia0-ready", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_PCMCIA_CD1,
+			    "pcmcia1-detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", H3XXX_GPIO_PCMCIA_IRQ1,
+			    "pcmcia1-ready", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 void __init h3xxx_mach_init(void)
 {
+	gpiod_add_lookup_table(&h3xxx_pcmcia_gpio_table);
 	sa1100_register_uart_fns(&h3xxx_port_fns);
 	sa11x0_register_mtd(&h3xxx_flash_data, &h3xxx_flash_resource, 1);
 	platform_add_devices(h3xxx_devices, ARRAY_SIZE(h3xxx_devices));
diff --git a/drivers/pcmcia/sa1100_h3600.c b/drivers/pcmcia/sa1100_h3600.c
index 431d8b07cbaf..5a1ebcc1ee22 100644
--- a/drivers/pcmcia/sa1100_h3600.c
+++ b/drivers/pcmcia/sa1100_h3600.c
@@ -23,13 +23,15 @@ static int h3600_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 {
 	int err;
 
+	skt->stat[SOC_STAT_CD].name = skt->nr ? "pcmcia1-detect" : "pcmcia0-detect";
+	skt->stat[SOC_STAT_RDY].name = skt->nr ? "pcmcia1-ready" : "pcmcia0-ready";
+
+	err = soc_pcmcia_request_gpiods(skt);
+	if (err)
+		return err;
+
 	switch (skt->nr) {
 	case 0:
-		skt->stat[SOC_STAT_CD].gpio = H3XXX_GPIO_PCMCIA_CD0;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA CD0";
-		skt->stat[SOC_STAT_RDY].gpio = H3XXX_GPIO_PCMCIA_IRQ0;
-		skt->stat[SOC_STAT_RDY].name = "PCMCIA IRQ0";
-
 		err = gpio_request(H3XXX_EGPIO_OPT_NVRAM_ON, "OPT NVRAM ON");
 		if (err)
 			goto err01;
@@ -56,10 +58,6 @@ static int h3600_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
 			goto err06;
 		break;
 	case 1:
-		skt->stat[SOC_STAT_CD].gpio = H3XXX_GPIO_PCMCIA_CD1;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA CD1";
-		skt->stat[SOC_STAT_RDY].gpio = H3XXX_GPIO_PCMCIA_IRQ1;
-		skt->stat[SOC_STAT_RDY].name = "PCMCIA IRQ1";
 		break;
 	}
 	return 0;
-- 
2.1.0
