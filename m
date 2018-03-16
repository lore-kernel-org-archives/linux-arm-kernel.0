From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 16 Mar 2018 19:57:05 +0000
Subject: [PATCH 6/8] ARM: sa1100/nanoengine: convert to generic CF sockets
In-Reply-To: <20180316195552.GS9418@n2100.armlinux.org.uk>
References: <20180316195552.GS9418@n2100.armlinux.org.uk>
Message-ID: <E1ewvTN-0004YH-Jh@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert nanoengine to use the generic CF socket support.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/nanoengine.c  |  23 +++++++
 drivers/pcmcia/sa1100_generic.c    |   3 -
 drivers/pcmcia/sa1100_generic.h    |   1 -
 drivers/pcmcia/sa1100_nanoengine.c | 133 -------------------------------------
 4 files changed, 23 insertions(+), 137 deletions(-)
 delete mode 100644 drivers/pcmcia/sa1100_nanoengine.c

diff --git a/arch/arm/mach-sa1100/nanoengine.c b/arch/arm/mach-sa1100/nanoengine.c
index f1cb3784d525..4d35258a7b32 100644
--- a/arch/arm/mach-sa1100/nanoengine.c
+++ b/arch/arm/mach-sa1100/nanoengine.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/gpio/machine.h>
 #include <linux/kernel.h>
 #include <linux/platform_data/sa11x0-serial.h>
 #include <linux/mtd/mtd.h>
@@ -99,8 +100,30 @@ static void __init nanoengine_map_io(void)
 	Ser2HSCR0 = 0;
 }
 
+static struct gpiod_lookup_table nanoengine_pcmcia0_gpio_table = {
+	.dev_id = "sa11x0-pcmcia.0",
+	.table = {
+		GPIO_LOOKUP("gpio", 11, "ready", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 13, "detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", 15, "reset", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table nanoengine_pcmcia1_gpio_table = {
+	.dev_id = "sa11x0-pcmcia.1",
+	.table = {
+		GPIO_LOOKUP("gpio", 12, "ready", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 14, "detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", 16, "reset", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void __init nanoengine_init(void)
 {
+	sa11x0_register_pcmcia(0, &nanoengine_pcmcia0_gpio_table);
+	sa11x0_register_pcmcia(1, &nanoengine_pcmcia1_gpio_table);
 	sa11x0_register_mtd(&nanoengine_flash_data, nanoengine_flash_resources,
 		ARRAY_SIZE(nanoengine_flash_resources));
 }
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 110365e998b8..59a670f330b7 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -101,9 +101,6 @@ static int (*sa11x0_pcmcia_legacy_hw_init[])(struct device *dev) = {
 #if defined(CONFIG_SA1100_H3100) || defined(CONFIG_SA1100_H3600)
 	pcmcia_h3600_init,
 #endif
-#ifdef CONFIG_SA1100_NANOENGINE
-	pcmcia_nanoengine_init,
-#endif
 #ifdef CONFIG_SA1100_SHANNON
 	pcmcia_shannon_init,
 #endif
diff --git a/drivers/pcmcia/sa1100_generic.h b/drivers/pcmcia/sa1100_generic.h
index bce9e73a4651..1e255c173cd8 100644
--- a/drivers/pcmcia/sa1100_generic.h
+++ b/drivers/pcmcia/sa1100_generic.h
@@ -12,7 +12,6 @@ extern int pcmcia_freebird_init(struct device *);
 extern int pcmcia_gcplus_init(struct device *);
 extern int pcmcia_graphicsmaster_init(struct device *);
 extern int pcmcia_h3600_init(struct device *);
-extern int pcmcia_nanoengine_init(struct device *);
 extern int pcmcia_pangolin_init(struct device *);
 extern int pcmcia_pfs168_init(struct device *);
 extern int pcmcia_shannon_init(struct device *);
diff --git a/drivers/pcmcia/sa1100_nanoengine.c b/drivers/pcmcia/sa1100_nanoengine.c
deleted file mode 100644
index 35c30ff41e81..000000000000
--- a/drivers/pcmcia/sa1100_nanoengine.c
+++ /dev/null
@@ -1,133 +0,0 @@
-/*
- * drivers/pcmcia/sa1100_nanoengine.c
- *
- * PCMCIA implementation routines for BSI nanoEngine.
- *
- * In order to have a fully functional pcmcia subsystem in a BSE nanoEngine
- * board you should carefully read this:
- * http://cambuca.ldhs.cetuc.puc-rio.br/nanoengine/
- *
- * Copyright (C) 2010 Marcelo Roberto Jimenez <mroberto@cpti.cetuc.puc-rio.br>
- *
- * Based on original work for kernel 2.4 by
- * Miguel Freitas <miguel@cpti.cetuc.puc-rio.br>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-#include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-
-#include <asm/mach-types.h>
-#include <asm/irq.h>
-
-#include <mach/hardware.h>
-#include <mach/nanoengine.h>
-
-#include "sa1100_generic.h"
-
-struct nanoengine_pins {
-	unsigned output_pins;
-	unsigned clear_outputs;
-	int gpio_rst;
-	int gpio_cd;
-	int gpio_rdy;
-};
-
-static struct nanoengine_pins nano_skts[] = {
-	{
-		.gpio_rst		= GPIO_PC_RESET0,
-		.gpio_cd		= GPIO_PC_CD0,
-		.gpio_rdy		= GPIO_PC_READY0,
-	}, {
-		.gpio_rst		= GPIO_PC_RESET1,
-		.gpio_cd		= GPIO_PC_CD1,
-		.gpio_rdy		= GPIO_PC_READY1,
-	}
-};
-
-unsigned num_nano_pcmcia_sockets = ARRAY_SIZE(nano_skts);
-
-static int nanoengine_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
-{
-	unsigned i = skt->nr;
-	int ret;
-
-	if (i >= num_nano_pcmcia_sockets)
-		return -ENXIO;
-
-	ret = gpio_request_one(nano_skts[i].gpio_rst, GPIOF_OUT_INIT_LOW,
-		i ? "PC RST1" : "PC RST0");
-	if (ret)
-		return ret;
-
-	skt->stat[SOC_STAT_CD].gpio = nano_skts[i].gpio_cd;
-	skt->stat[SOC_STAT_CD].name = i ? "PC CD1" : "PC CD0";
-	skt->stat[SOC_STAT_RDY].gpio = nano_skts[i].gpio_rdy;
-	skt->stat[SOC_STAT_RDY].name = i ? "PC RDY1" : "PC RDY0";
-
-	return 0;
-}
-
-static void nanoengine_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
-{
-	gpio_free(nano_skts[skt->nr].gpio_rst);
-}
-
-static int nanoengine_pcmcia_configure_socket(
-	struct soc_pcmcia_socket *skt, const socket_state_t *state)
-{
-	unsigned i = skt->nr;
-
-	if (i >= num_nano_pcmcia_sockets)
-		return -ENXIO;
-
-	gpio_set_value(nano_skts[skt->nr].gpio_rst, !!(state->flags & SS_RESET));
-
-	return 0;
-}
-
-static void nanoengine_pcmcia_socket_state(
-	struct soc_pcmcia_socket *skt, struct pcmcia_state *state)
-{
-	unsigned i = skt->nr;
-
-	if (i >= num_nano_pcmcia_sockets)
-		return;
-
-	state->bvd1 = 1;
-	state->bvd2 = 1;
-	state->vs_3v = 1; /* Can only apply 3.3V */
-	state->vs_Xv = 0;
-}
-
-static struct pcmcia_low_level nanoengine_pcmcia_ops = {
-	.owner			= THIS_MODULE,
-
-	.hw_init		= nanoengine_pcmcia_hw_init,
-	.hw_shutdown		= nanoengine_pcmcia_hw_shutdown,
-
-	.configure_socket	= nanoengine_pcmcia_configure_socket,
-	.socket_state		= nanoengine_pcmcia_socket_state,
-};
-
-int pcmcia_nanoengine_init(struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_nanoengine())
-		ret = sa11xx_drv_pcmcia_probe(
-			dev, &nanoengine_pcmcia_ops, 0, 2);
-
-	return ret;
-}
-
-- 
2.7.4
