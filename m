From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 16 Mar 2018 19:57:10 +0000
Subject: [PATCH 7/8] ARM: sa1100/shannon: convert to generic CF sockets
In-Reply-To: <20180316195552.GS9418@n2100.armlinux.org.uk>
References: <20180316195552.GS9418@n2100.armlinux.org.uk>
Message-ID: <E1ewvTS-0004YO-NZ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert shannon to use the generic CF socket support.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/Kconfig    |   2 +
 arch/arm/mach-sa1100/shannon.c  |  38 +++++++++++++++
 drivers/pcmcia/Makefile         |   1 -
 drivers/pcmcia/sa1100_generic.c |   3 --
 drivers/pcmcia/sa1100_generic.h |   1 -
 drivers/pcmcia/sa1100_shannon.c | 104 ----------------------------------------
 6 files changed, 40 insertions(+), 109 deletions(-)
 delete mode 100644 drivers/pcmcia/sa1100_shannon.c

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 5ca5847d89cc..fde7ef1ab192 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -139,6 +139,8 @@ config SA1100_PLEB
 config SA1100_SHANNON
 	bool "Shannon"
 	select ARM_SA1100_CPUFREQ
+	select REGULATOR
+	select REGULATOR_FIXED_VOLTAGE
 	help
 	  The Shannon (also known as a Tuxscreen, and also as a IS2630) was a
 	  limited edition webphone produced by Philips. The Shannon is a SA1100
diff --git a/arch/arm/mach-sa1100/shannon.c b/arch/arm/mach-sa1100/shannon.c
index 856664c783d9..22f7fe0b809f 100644
--- a/arch/arm/mach-sa1100/shannon.c
+++ b/arch/arm/mach-sa1100/shannon.c
@@ -5,11 +5,14 @@
 
 #include <linux/init.h>
 #include <linux/device.h>
+#include <linux/gpio/machine.h>
 #include <linux/kernel.h>
 #include <linux/platform_data/sa11x0-serial.h>
 #include <linux/tty.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 
 #include <video/sa1100fb.h>
 
@@ -72,8 +75,43 @@ static struct sa1100fb_mach_info shannon_lcd_info = {
 	.lccr3		= LCCR3_ACBsDiv(512),
 };
 
+static struct gpiod_lookup_table shannon_pcmcia0_gpio_table = {
+	.dev_id = "sa11x0-pcmcia.0",
+	.table = {
+		GPIO_LOOKUP("gpio", 24, "detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", 26, "ready", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table shannon_pcmcia1_gpio_table = {
+	.dev_id = "sa11x0-pcmcia.1",
+	.table = {
+		GPIO_LOOKUP("gpio", 25, "detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", 27, "ready", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static struct regulator_consumer_supply shannon_cf_vcc_consumers[] = {
+	REGULATOR_SUPPLY("vcc", "sa11x0-pcmcia.0"),
+	REGULATOR_SUPPLY("vcc", "sa11x0-pcmcia.1"),
+};
+
+static struct fixed_voltage_config shannon_cf_vcc_pdata __initdata = {
+	.supply_name = "cf-power",
+	.microvolts = 3300000,
+	.enabled_at_boot = 1,
+	.gpio = -EINVAL,
+};
+
 static void __init shannon_init(void)
 {
+	sa11x0_register_fixed_regulator(0, &shannon_cf_vcc_pdata,
+					shannon_cf_vcc_consumers,
+					ARRAY_SIZE(shannon_cf_vcc_consumers));
+	sa11x0_register_pcmcia(0, &shannon_pcmcia0_gpio_table);
+	sa11x0_register_pcmcia(1, &shannon_pcmcia1_gpio_table);
 	sa11x0_ppc_configure_mcp();
 	sa11x0_register_lcd(&shannon_lcd_info);
 	sa11x0_register_mtd(&shannon_flash_data, &shannon_flash_resource, 1);
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index da31af9b3158..e7689e999727 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -50,7 +50,6 @@ sa1100_cs-$(CONFIG_SA1100_COLLIE)		+= pxa2xx_sharpsl.o
 sa1100_cs-$(CONFIG_SA1100_H3100)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_H3600)		+= sa1100_h3600.o
 sa1100_cs-$(CONFIG_SA1100_NANOENGINE)		+= sa1100_nanoengine.o
-sa1100_cs-$(CONFIG_SA1100_SHANNON)		+= sa1100_shannon.o
 sa1100_cs-$(CONFIG_SA1100_SIMPAD)		+= sa1100_simpad.o
 
 pxa2xx_cm_x2xx_cs-y				+= pxa2xx_cm_x2xx.o pxa2xx_cm_x255.o pxa2xx_cm_x270.o
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 59a670f330b7..47b060c57418 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -101,9 +101,6 @@ static int (*sa11x0_pcmcia_legacy_hw_init[])(struct device *dev) = {
 #if defined(CONFIG_SA1100_H3100) || defined(CONFIG_SA1100_H3600)
 	pcmcia_h3600_init,
 #endif
-#ifdef CONFIG_SA1100_SHANNON
-	pcmcia_shannon_init,
-#endif
 #ifdef CONFIG_SA1100_SIMPAD
 	pcmcia_simpad_init,
 #endif
diff --git a/drivers/pcmcia/sa1100_generic.h b/drivers/pcmcia/sa1100_generic.h
index 1e255c173cd8..7b7cdcd20187 100644
--- a/drivers/pcmcia/sa1100_generic.h
+++ b/drivers/pcmcia/sa1100_generic.h
@@ -14,7 +14,6 @@ extern int pcmcia_graphicsmaster_init(struct device *);
 extern int pcmcia_h3600_init(struct device *);
 extern int pcmcia_pangolin_init(struct device *);
 extern int pcmcia_pfs168_init(struct device *);
-extern int pcmcia_shannon_init(struct device *);
 extern int pcmcia_simpad_init(struct device *);
 extern int pcmcia_stork_init(struct device *);
 extern int pcmcia_system3_init(struct device *);
diff --git a/drivers/pcmcia/sa1100_shannon.c b/drivers/pcmcia/sa1100_shannon.c
deleted file mode 100644
index 0e52a575986e..000000000000
--- a/drivers/pcmcia/sa1100_shannon.c
+++ /dev/null
@@ -1,104 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * drivers/pcmcia/sa1100_shannon.c
- *
- * PCMCIA implementation routines for Shannon
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <mach/shannon.h>
-#include <asm/irq.h>
-#include "sa1100_generic.h"
-
-static int shannon_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
-{
-	/* All those are inputs */
-	GAFR &= ~(GPIO_GPIO(SHANNON_GPIO_EJECT_0) |
-		  GPIO_GPIO(SHANNON_GPIO_EJECT_1) |
-		  GPIO_GPIO(SHANNON_GPIO_RDY_0) |
-		  GPIO_GPIO(SHANNON_GPIO_RDY_1));
-
-	if (skt->nr == 0) {
-		skt->stat[SOC_STAT_CD].gpio = SHANNON_GPIO_EJECT_0;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA_CD_0";
-		skt->stat[SOC_STAT_RDY].gpio = SHANNON_GPIO_RDY_0;
-		skt->stat[SOC_STAT_RDY].name = "PCMCIA_RDY_0";
-	} else {
-		skt->stat[SOC_STAT_CD].gpio = SHANNON_GPIO_EJECT_1;
-		skt->stat[SOC_STAT_CD].name = "PCMCIA_CD_1";
-		skt->stat[SOC_STAT_RDY].gpio = SHANNON_GPIO_RDY_1;
-		skt->stat[SOC_STAT_RDY].name = "PCMCIA_RDY_1";
-	}
-
-	return 0;
-}
-
-static void
-shannon_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
-			    struct pcmcia_state *state)
-{
-	switch (skt->nr) {
-	case 0:
-		state->bvd1   = 1; 
-		state->bvd2   = 1; 
-		state->vs_3v  = 1; /* FIXME Can only apply 3.3V on Shannon. */
-		state->vs_Xv  = 0;
-		break;
-
-	case 1:
-		state->bvd1   = 1; 
-		state->bvd2   = 1; 
-		state->vs_3v  = 1; /* FIXME Can only apply 3.3V on Shannon. */
-		state->vs_Xv  = 0;
-		break;
-	}
-}
-
-static int
-shannon_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
-				const socket_state_t *state)
-{
-	switch (state->Vcc) {
-	case 0:	/* power off */
-		printk(KERN_WARNING "%s(): CS asked for 0V, still applying 3.3V..\n", __func__);
-		break;
-	case 50:
-		printk(KERN_WARNING "%s(): CS asked for 5V, applying 3.3V..\n", __func__);
-	case 33:
-		break;
-	default:
-		printk(KERN_ERR "%s(): unrecognized Vcc %u\n",
-		       __func__, state->Vcc);
-		return -1;
-	}
-
-	printk(KERN_WARNING "%s(): Warning, Can't perform reset\n", __func__);
-	
-	/* Silently ignore Vpp, output enable, speaker enable. */
-
-	return 0;
-}
-
-static struct pcmcia_low_level shannon_pcmcia_ops = {
-	.owner			= THIS_MODULE,
-	.hw_init		= shannon_pcmcia_hw_init,
-	.socket_state		= shannon_pcmcia_socket_state,
-	.configure_socket	= shannon_pcmcia_configure_socket,
-};
-
-int pcmcia_shannon_init(struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_shannon())
-		ret = sa11xx_drv_pcmcia_probe(dev, &shannon_pcmcia_ops, 0, 2);
-
-	return ret;
-}
-- 
2.7.4
