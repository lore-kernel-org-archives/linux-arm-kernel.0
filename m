From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Fri, 16 Mar 2018 19:56:50 +0000
Subject: [PATCH 3/8] ARM: sa1100/assabet: convert to generic CF sockets
In-Reply-To: <20180316195552.GS9418@n2100.armlinux.org.uk>
References: <20180316195552.GS9418@n2100.armlinux.org.uk>
Message-ID: <E1ewvT8-0004Xo-8a@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert Assabet to use the generic CF socket support.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/Kconfig                |   2 +
 arch/arm/mach-sa1100/assabet.c              |  39 ++++++++++-
 arch/arm/mach-sa1100/include/mach/assabet.h |   6 --
 drivers/pcmcia/Makefile                     |   1 -
 drivers/pcmcia/sa1100_assabet.c             | 100 ----------------------------
 drivers/pcmcia/sa1100_generic.c             |   3 -
 drivers/pcmcia/sa1100_generic.h             |   1 -
 7 files changed, 40 insertions(+), 112 deletions(-)
 delete mode 100644 drivers/pcmcia/sa1100_assabet.c

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 07df3a59b13f..5ca5847d89cc 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -6,6 +6,8 @@ config SA1100_ASSABET
 	bool "Assabet"
 	select ARM_SA1110_CPUFREQ
 	select GPIO_REG
+	select REGULATOR
+	select REGULATOR_FIXED_VOLTAGE
 	help
 	  Say Y here if you are using the Intel(R) StrongARM(R) SA-1110
 	  Microprocessor Development Board (also known as the Assabet).
diff --git a/arch/arm/mach-sa1100/assabet.c b/arch/arm/mach-sa1100/assabet.c
index f68241d995f2..575ec085cffa 100644
--- a/arch/arm/mach-sa1100/assabet.c
+++ b/arch/arm/mach-sa1100/assabet.c
@@ -14,8 +14,11 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/gpio/gpio-reg.h>
+#include <linux/gpio/machine.h>
 #include <linux/ioport.h>
 #include <linux/platform_data/sa11x0-serial.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/ucb1x00.h>
@@ -445,6 +448,29 @@ static struct resource neponset_resources[] = {
 };
 #endif
 
+static struct gpiod_lookup_table assabet_cf_gpio_table = {
+	.dev_id = "sa11x0-pcmcia.1",
+	.table = {
+		GPIO_LOOKUP("gpio", 21, "ready", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 22, "detect", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("gpio", 24, "bvd2", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("gpio", 25, "bvd1", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("assabet", 1, "reset", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("assabet", 7, "bus-enable", GPIO_ACTIVE_LOW),
+		{ },
+	},
+};
+
+static struct regulator_consumer_supply assabet_cf_vcc_consumers[] = {
+	REGULATOR_SUPPLY("vcc", "sa11x0-pcmcia.1"),
+};
+
+static struct fixed_voltage_config assabet_cf_vcc_pdata __initdata = {
+	.supply_name = "cf-power",
+	.microvolts = 3300000,
+	.enable_high = 1,
+};
+
 static void __init assabet_init(void)
 {
 	/*
@@ -490,6 +516,11 @@ static void __init assabet_init(void)
 		platform_device_register_simple("neponset", 0,
 			neponset_resources, ARRAY_SIZE(neponset_resources));
 #endif
+	} else {
+		sa11x0_register_fixed_regulator(0, &assabet_cf_vcc_pdata,
+					 assabet_cf_vcc_consumers,
+					 ARRAY_SIZE(assabet_cf_vcc_consumers));
+
 	}
 
 #ifndef ASSABET_PAL_VIDEO
@@ -501,6 +532,9 @@ static void __init assabet_init(void)
 			    ARRAY_SIZE(assabet_flash_resources));
 	sa11x0_register_irda(&assabet_irda_data);
 	sa11x0_register_mcp(&assabet_mcp_data);
+
+	if (!machine_has_neponset())
+		sa11x0_register_pcmcia(1, &assabet_cf_gpio_table);
 }
 
 /*
@@ -768,6 +802,7 @@ fs_initcall(assabet_leds_init);
 
 void __init assabet_init_irq(void)
 {
+	unsigned int assabet_gpio_base;
 	u32 def_val;
 
 	sa1100_init_irq();
@@ -782,7 +817,9 @@ void __init assabet_init_irq(void)
 	 *
 	 * This must precede any driver calls to BCR_set() or BCR_clear().
 	 */
-	assabet_init_gpio((void *)&ASSABET_BCR, def_val);
+	assabet_gpio_base = assabet_init_gpio((void *)&ASSABET_BCR, def_val);
+
+	assabet_cf_vcc_pdata.gpio = assabet_gpio_base + 0;
 }
 
 MACHINE_START(ASSABET, "Intel-Assabet")
diff --git a/arch/arm/mach-sa1100/include/mach/assabet.h b/arch/arm/mach-sa1100/include/mach/assabet.h
index 558b45323a2d..641a961653af 100644
--- a/arch/arm/mach-sa1100/include/mach/assabet.h
+++ b/arch/arm/mach-sa1100/include/mach/assabet.h
@@ -96,10 +96,4 @@ extern void assabet_uda1341_reset(int set);
 #define ASSABET_GPIO_BATT_LOW		GPIO_GPIO (26)	/* Low battery */
 #define ASSABET_GPIO_RCLK		GPIO_GPIO (26)	/* CCLK/2  */
 
-/* These are gpiolib GPIO numbers, not bitmasks */
-#define ASSABET_GPIO_CF_IRQ		21	/* CF IRQ */
-#define ASSABET_GPIO_CF_CD		22	/* CF CD  */
-#define ASSABET_GPIO_CF_BVD2		24	/* CF BVD / IOSPKR */
-#define ASSABET_GPIO_CF_BVD1		25	/* CF BVD / IOSTSCHG */
-
 #endif
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index e7dae16b9a43..130a06649b41 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -46,7 +46,6 @@ sa1111_cs-$(CONFIG_SA1100_JORNADA720)		+= sa1111_jornada720.o
 sa1111_cs-$(CONFIG_ARCH_LUBBOCK)		+= sa1111_lubbock.o
 
 sa1100_cs-y					+= sa1100_generic.o
-sa1100_cs-$(CONFIG_SA1100_ASSABET)		+= sa1100_assabet.o
 sa1100_cs-$(CONFIG_SA1100_CERF)			+= sa1100_cerf.o
 sa1100_cs-$(CONFIG_SA1100_COLLIE)		+= pxa2xx_sharpsl.o
 sa1100_cs-$(CONFIG_SA1100_H3100)		+= sa1100_h3600.o
diff --git a/drivers/pcmcia/sa1100_assabet.c b/drivers/pcmcia/sa1100_assabet.c
deleted file mode 100644
index 78ad2bba76db..000000000000
--- a/drivers/pcmcia/sa1100_assabet.c
+++ /dev/null
@@ -1,100 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * drivers/pcmcia/sa1100_assabet.c
- *
- * PCMCIA implementation routines for Assabet
- *
- */
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/gpio.h>
-
-#include <asm/mach-types.h>
-#include <mach/assabet.h>
-
-#include "sa1100_generic.h"
-
-static int assabet_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
-{
-	skt->stat[SOC_STAT_CD].gpio = ASSABET_GPIO_CF_CD;
-	skt->stat[SOC_STAT_CD].name = "CF CD";
-	skt->stat[SOC_STAT_BVD1].gpio = ASSABET_GPIO_CF_BVD1;
-	skt->stat[SOC_STAT_BVD1].name = "CF BVD1";
-	skt->stat[SOC_STAT_BVD2].gpio = ASSABET_GPIO_CF_BVD2;
-	skt->stat[SOC_STAT_BVD2].name = "CF BVD2";
-	skt->stat[SOC_STAT_RDY].gpio = ASSABET_GPIO_CF_IRQ;
-	skt->stat[SOC_STAT_RDY].name = "CF RDY";
-
-	return 0;
-}
-
-static int
-assabet_pcmcia_configure_socket(struct soc_pcmcia_socket *skt, const socket_state_t *state)
-{
-	unsigned int mask;
-
-	switch (state->Vcc) {
-	case 0:
-		mask = 0;
-		break;
-
-	case 50:
-		printk(KERN_WARNING "%s(): CS asked for 5V, applying 3.3V...\n",
-			__func__);
-
-	case 33:  /* Can only apply 3.3V to the CF slot. */
-		mask = ASSABET_BCR_CF_PWR;
-		break;
-
-	default:
-		printk(KERN_ERR "%s(): unrecognized Vcc %u\n", __func__,
-			state->Vcc);
-		return -1;
-	}
-
-	/* Silently ignore Vpp, speaker enable. */
-
-	if (state->flags & SS_RESET)
-		mask |= ASSABET_BCR_CF_RST;
-	if (!(state->flags & SS_OUTPUT_ENA))
-		mask |= ASSABET_BCR_CF_BUS_OFF;
-
-	ASSABET_BCR_frob(ASSABET_BCR_CF_RST | ASSABET_BCR_CF_PWR |
-			ASSABET_BCR_CF_BUS_OFF, mask);
-
-	return 0;
-}
-
-/*
- * Disable card status IRQs on suspend.
- */
-static void assabet_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
-{
-	/*
-	 * Tristate the CF bus signals.  Also assert CF
-	 * reset as per user guide page 4-11.
-	 */
-	ASSABET_BCR_set(ASSABET_BCR_CF_BUS_OFF | ASSABET_BCR_CF_RST);
-}
-
-static struct pcmcia_low_level assabet_pcmcia_ops = { 
-	.owner			= THIS_MODULE,
-	.hw_init		= assabet_pcmcia_hw_init,
-	.socket_state		= soc_common_cf_socket_state,
-	.configure_socket	= assabet_pcmcia_configure_socket,
-	.socket_suspend		= assabet_pcmcia_socket_suspend,
-};
-
-int pcmcia_assabet_init(struct device *dev)
-{
-	int ret = -ENODEV;
-
-	if (machine_is_assabet() && !machine_has_neponset())
-		ret = sa11xx_drv_pcmcia_probe(dev, &assabet_pcmcia_ops, 1, 1);
-
-	return ret;
-}
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index 324e3e631353..1987d94361e9 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -98,9 +98,6 @@ static struct pcmcia_low_level sa11x0_cf_ops = {
 int __init pcmcia_collie_init(struct device *dev);
 
 static int (*sa11x0_pcmcia_legacy_hw_init[])(struct device *dev) = {
-#ifdef CONFIG_SA1100_ASSABET
-	pcmcia_assabet_init,
-#endif
 #ifdef CONFIG_SA1100_CERF
 	pcmcia_cerf_init,
 #endif
diff --git a/drivers/pcmcia/sa1100_generic.h b/drivers/pcmcia/sa1100_generic.h
index a5f1f1dd63cb..597c796f7dad 100644
--- a/drivers/pcmcia/sa1100_generic.h
+++ b/drivers/pcmcia/sa1100_generic.h
@@ -6,7 +6,6 @@
  * Declaration for all machine specific init/exit functions.
  */
 extern int pcmcia_adsbitsy_init(struct device *);
-extern int pcmcia_assabet_init(struct device *);
 extern int pcmcia_badge4_init(struct device *);
 extern int pcmcia_cerf_init(struct device *);
 extern int pcmcia_flexanet_init(struct device *);
-- 
2.7.4
