From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 16 Mar 2018 19:56:55 +0000
Subject: [PATCH 4/8] ARM: sa1100/cerf: convert to generic CF sockets
In-Reply-To: <20180316195552.GS9418@n2100.armlinux.org.uk>
References: <20180316195552.GS9418@n2100.armlinux.org.uk>
Message-ID: <E1ewvTD-0004Y3-BW@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Cerf to use the generic CF socket support.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/cerf.c     | 18 +++++++--
 drivers/pcmcia/Makefile         |  1 -
 drivers/pcmcia/sa1100_cerf.c    | 86 -----------------------------------------
 drivers/pcmcia/sa1100_generic.c |  3 --
 drivers/pcmcia/sa1100_generic.h |  1 -
 5 files changed, 15 insertions(+), 94 deletions(-)
 delete mode 100644 drivers/pcmcia/sa1100_cerf.c

diff --git a/arch/arm/mach-sa1100/cerf.c b/arch/arm/mach-sa1100/cerf.c
index 2d25ececb415..b2a4b41626ef 100644
--- a/arch/arm/mach-sa1100/cerf.c
+++ b/arch/arm/mach-sa1100/cerf.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/gpio/machine.h>
 #include <linux/kernel.h>
 #include <linux/tty.h>
 #include <linux/platform_data/sa11x0-serial.h>
@@ -45,6 +46,19 @@ static struct platform_device cerfuart2_device = {
 	.resource	= cerfuart2_resources,
 };
 
+/* Compact Flash */
+static struct gpiod_lookup_table cerf_cf_gpio_table = {
+	.dev_id = "sa11x0-pcmcia.1",
+	.table = {
+		GPIO_LOOKUP("gpio", 19, "bvd2", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 20, "bvd1", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 21, "reset", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 22, "ready", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 23, "detect", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
 /* LEDs */
 struct gpio_led cerf_gpio_leds[] = {
 	{
@@ -151,9 +165,6 @@ static void __init cerf_map_io(void)
 	sa1100_register_uart(0, 3);
 	sa1100_register_uart(1, 2); /* disable this and the uart2 device for sa1100_fir */
 	sa1100_register_uart(2, 1);
-
-	/* set some GPDR bits here while it's safe */
-	GPDR |= CERF_GPIO_CF_RESET;
 }
 
 static struct mcp_plat_data cerf_mcp_data = {
@@ -167,6 +178,7 @@ static void __init cerf_init(void)
 	platform_add_devices(cerf_devices, ARRAY_SIZE(cerf_devices));
 	sa11x0_register_mtd(&cerf_flash_data, &cerf_flash_resource, 1);
 	sa11x0_register_mcp(&cerf_mcp_data);
+	sa11x0_register_pcmcia(1, &cerf_cf_gpio_table);
 }
 
 MACHINE_START(CERF, "Intrinsyc CerfBoard/CerfCube")
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 130a06649b41..da31af9b3158 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -46,7 +46,6 @@ sa1111_cs-$(CONFIG_SA1100_JORNADA720)		+= sa1111_jornada720.o
 sa1111_cs-$(CONFIG_ARCH_LUBBOCK)		+= sa1111_lubbock.o
 
 sa1100_cs-y					+= sa1100_generic.o
-sa1100_cs-$(CONFIG_SA1100_CERF)			+= sa1100_cerf.o
 sa1100_cs-$(CONFIG_SA1100_COLLIE)		+= pxa2xx_sharpsl.o
 sa1100_cs-$(CONFIG_SA1100_H3100)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
diff --git a/drivers/pcmcia/sa1100_cerf.c b/drivers/pcmcia/sa1100_cerf.c
deleted file mode 100644
index 2a54081d161d..000000000000
--- a/drivers/pcmcia/sa1100_cerf.c
+++ /dev/null
@@ -1,86 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * drivers/pcmcia/sa1100_cerf.c
- *
- * PCMCIA implementation routines for CerfBoard
- * Based off the Assabet.
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/gpio.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/irq.h>
-#include <mach/cerf.h>
-#include "sa1100_generic.h"
-
-#define CERF_SOCKET	1
-
-static int cerf_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
-{
-	int ret;
-
-	ret = gpio_request_one(CERF_GPIO_CF_RESET, GPIOF_OUT_INIT_LOW, "CF_RESET");
-	if (ret)
-		return ret;
-
-	skt->stat[SOC_STAT_CD].gpio = CERF_GPIO_CF_CD;
-	skt->stat[SOC_STAT_CD].name = "CF_CD";
-	skt->stat[SOC_STAT_BVD1].gpio = CERF_GPIO_CF_BVD1;
-	skt->stat[SOC_STAT_BVD1].name = "CF_BVD1";
-	skt->stat[SOC_STAT_BVD2].gpio = CERF_GPIO_CF_BVD2;
-	skt->stat[SOC_STAT_BVD2].name = "CF_BVD2";
-	skt->stat[SOC_STAT_RDY].gpio = CERF_GPIO_CF_IRQ;
-	skt->stat[SOC_STAT_RDY].name = "CF_IRQ";
-
-	return 0;
-}
-
-static void cerf_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	gpio_free(CERF_GPIO_CF_RESET);
-}
-
-static int
-cerf_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
-			     const socket_state_t *state)
-{
-	switch (state->Vcc) {
-	case 0:
-	case 50:
-	case 33:
-		break;
-
-	default:
-		printk(KERN_ERR "%s(): unrecognized Vcc %u\n",
-			__func__, state->Vcc);
-		return -1;
-	}
-
-	gpio_set_value(CERF_GPIO_CF_RESET, !!(state->flags & SS_RESET));
-
-	return 0;
-}
-
-static struct pcmcia_low_level cerf_pcmcia_ops = { 
-	.owner			= THIS_MODULE,
-	.hw_init		= cerf_pcmcia_hw_init,
-	.hw_shutdown		= cerf_pcmcia_hw_shutdown,
-	.socket_state		= soc_common_cf_socket_state,
-	.configure_socket	= cerf_pcmcia_configure_socket,
-};
-
-int pcmcia_cerf_init(struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_cerf())
-		ret = sa11xx_drv_pcmcia_probe(dev, &cerf_pcmcia_ops, CERF_SOCKET, 1);
-
-	return ret;
-}
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 1987d94361e9..110365e998b8 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -98,9 +98,6 @@ static struct pcmcia_low_level sa11x0_cf_ops = {
 int __init pcmcia_collie_init(struct device *dev);
 
 static int (*sa11x0_pcmcia_legacy_hw_init[])(struct device *dev) = {
-#ifdef CONFIG_SA1100_CERF
-	pcmcia_cerf_init,
-#endif
 #if defined(CONFIG_SA1100_H3100) || defined(CONFIG_SA1100_H3600)
 	pcmcia_h3600_init,
 #endif
diff --git a/drivers/pcmcia/sa1100_generic.h b/drivers/pcmcia/sa1100_generic.h
index 597c796f7dad..bce9e73a4651 100644
--- a/drivers/pcmcia/sa1100_generic.h
+++ b/drivers/pcmcia/sa1100_generic.h
@@ -7,7 +7,6 @@
  */
 extern int pcmcia_adsbitsy_init(struct device *);
 extern int pcmcia_badge4_init(struct device *);
-extern int pcmcia_cerf_init(struct device *);
 extern int pcmcia_flexanet_init(struct device *);
 extern int pcmcia_freebird_init(struct device *);
 extern int pcmcia_gcplus_init(struct device *);
-- 
2.7.4
