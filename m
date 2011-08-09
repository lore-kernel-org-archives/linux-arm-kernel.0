From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 09 Aug 2011 16:23:45 +0000
Subject: [PATCH v2] pxa/hx4700: Add PCMCIA/CF support
Message-ID: <E1Qqp5n-0000Rh-8Z@outmx06.plus.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCMCIA/CF support for the HP iPAQ hx4700. Underlying support is provided by
the pcmcia/pxa2xx_hx4700 platform_device implementation which hooks into the
existing pxa2xx-pcmcia driver.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V2: Posted to linux-arm-kernel instead of linux-kernel since this patch extends
the pxa2xx-pcmcia driver. Reworked to disentangle the platform_device
implementation from the mfd/asic3 driver. Added socket_init() and
socket_suspend() bodies. Rebased to linux-3.0.1.

diff -ruN clean-3.0.1/arch/arm/mach-pxa/hx4700.c linux-3.0.1/arch/arm/mach-pxa/hx4700.c
--- clean-3.0.1/arch/arm/mach-pxa/hx4700.c	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/arch/arm/mach-pxa/hx4700.c	2011-08-09 11:08:50.432572948 +0100
@@ -261,7 +261,6 @@
 	ASIC3_GPIOC0_LED0,		/* red */
 	ASIC3_GPIOC1_LED1,		/* green */
 	ASIC3_GPIOC2_LED2,		/* blue */
-	ASIC3_GPIOC4_CF_nCD,
 	ASIC3_GPIOC5_nCIOW,
 	ASIC3_GPIOC6_nCIOR,
 	ASIC3_GPIOC7_nPCE_1,
@@ -275,6 +274,7 @@
 	ASIC3_GPIOC15_nPIOR,
 
 	/* GPIOD: input GPIOs, CF */
+	ASIC3_GPIOD4_CF_nCD,
 	ASIC3_GPIOD11_nCIOIS16,
 	ASIC3_GPIOD12_nCWAIT,
 	ASIC3_GPIOD15_nPIOW,
@@ -801,17 +801,6 @@
 };
 
 /*
- * PCMCIA
- */
-
-static struct platform_device pcmcia = {
-	.name = "hx4700-pcmcia",
-	.dev  = {
-		.parent = &asic3.dev,
-	},
-};
-
-/*
  * Platform devices
  */
 
@@ -826,7 +815,6 @@
 	&gpio_vbus,
 	&power_supply,
 	&strataflash,
-	&pcmcia,
 };
 
 static struct gpio_ress global_gpios[] = {
diff -ruN clean-3.0.1/drivers/mfd/asic3.c linux-3.0.1/drivers/mfd/asic3.c
--- clean-3.0.1/drivers/mfd/asic3.c	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/drivers/mfd/asic3.c	2011-08-09 11:08:50.432572948 +0100
@@ -971,6 +971,9 @@
 
 	asic3_mfd_probe(pdev, pdata, mem);
 
+	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
+		(ASIC3_EXTCF_CF0_BUF_EN|ASIC3_EXTCF_CF0_PWAIT_EN), 1);
+
 	dev_info(asic->dev, "ASIC3 Core driver\n");
 
 	return 0;
@@ -992,6 +995,9 @@
 	int ret;
 	struct asic3 *asic = platform_get_drvdata(pdev);
 
+	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
+		(ASIC3_EXTCF_CF0_BUF_EN|ASIC3_EXTCF_CF0_PWAIT_EN), 0);
+
 	asic3_mfd_remove(pdev);
 
 	ret = asic3_gpio_remove(pdev);
diff -ruN clean-3.0.1/drivers/pcmcia/Kconfig linux-3.0.1/drivers/pcmcia/Kconfig
--- clean-3.0.1/drivers/pcmcia/Kconfig	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/drivers/pcmcia/Kconfig	2011-08-09 11:08:50.432572948 +0100
@@ -216,7 +216,7 @@
 		    || MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
 		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2 \
 		    || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI \
-		    || MACH_COLIBRI320)
+		    || MACH_COLIBRI320 || MACH_H4700)
 	select PCMCIA_SOC_COMMON
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
diff -ruN clean-3.0.1/drivers/pcmcia/Makefile linux-3.0.1/drivers/pcmcia/Makefile
--- clean-3.0.1/drivers/pcmcia/Makefile	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/drivers/pcmcia/Makefile	2011-08-09 11:08:50.432572948 +0100
@@ -73,6 +73,7 @@
 pxa2xx-obj-$(CONFIG_MACH_BALLOON3)		+= pxa2xx_balloon3.o
 pxa2xx-obj-$(CONFIG_MACH_COLIBRI)		+= pxa2xx_colibri.o
 pxa2xx-obj-$(CONFIG_MACH_COLIBRI320)		+= pxa2xx_colibri.o
+pxa2xx-obj-$(CONFIG_MACH_H4700)			+= pxa2xx_hx4700.o
 
 obj-$(CONFIG_PCMCIA_PXA2XX)			+= pxa2xx_base.o $(pxa2xx-obj-y)
 
diff -ruN clean-3.0.1/drivers/pcmcia/pxa2xx_hx4700.c linux-3.0.1/drivers/pcmcia/pxa2xx_hx4700.c
--- clean-3.0.1/drivers/pcmcia/pxa2xx_hx4700.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-3.0.1/drivers/pcmcia/pxa2xx_hx4700.c	2011-08-09 11:08:50.432572948 +0100
@@ -0,0 +1,152 @@
+/*
+ *  Copyright (C) 2011 Paul Parsons <lost.distance@yahoo.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+
+#include <asm/mach-types.h>
+#include <mach/hx4700.h>
+
+#include "soc_common.h"
+
+static struct gpio gpios[] = {
+	{ GPIO60_HX4700_CF_RNB,       GPIOF_DIR_IN,         "CF ready"        },
+	{ GPIO114_HX4700_CF_RESET,    GPIOF_OUT_INIT_LOW,   "CF reset"        },
+	{ GPIOD4_CF_nCD,              GPIOF_DIR_IN,         "CF card detect"  },
+	{ EGPIO4_CF_3V3_ON,           GPIOF_OUT_INIT_LOW,   "CF 3.3V enable"  },
+};
+
+static struct pcmcia_irqs irqs[] = {
+	{ 0,  IRQ_GPIO(GPIOD4_CF_nCD),              "CF card detect"  },
+};
+
+static int hw_init(struct soc_pcmcia_socket *skt)
+{
+	int ret;
+
+	ret = gpio_request_array(gpios, ARRAY_SIZE(gpios));
+	if (ret)
+		goto out;
+
+	irq_set_irq_type(IRQ_GPIO(GPIOD4_CF_nCD), IRQ_TYPE_EDGE_BOTH);
+
+	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	if (ret) {
+		gpio_free_array(gpios, ARRAY_SIZE(gpios));
+		goto out;
+	}
+
+	skt->socket.pci_irq = IRQ_GPIO(GPIO60_HX4700_CF_RNB);
+
+out:
+	return ret;
+}
+
+static void hw_shutdown(struct soc_pcmcia_socket *skt)
+{
+	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+
+	gpio_free_array(gpios, ARRAY_SIZE(gpios));
+}
+
+static void socket_state(struct soc_pcmcia_socket *skt,
+	struct pcmcia_state *state)
+{
+	state->detect = (gpio_get_value(GPIOD4_CF_nCD) == 0);
+	state->ready = (gpio_get_value(GPIO60_HX4700_CF_RNB) != 0);
+	state->bvd1 = 1;
+	state->bvd2 = 1;
+	state->wrprot = 0;
+	state->vs_3v = 1;
+	state->vs_Xv = 0;
+}
+
+static int configure_socket(struct soc_pcmcia_socket *skt,
+	const socket_state_t *state)
+{
+	switch (state->Vcc) {
+	case 0:
+		gpio_set_value(EGPIO4_CF_3V3_ON, 0);
+		break;
+	case 33:
+		gpio_set_value(EGPIO4_CF_3V3_ON, 1);
+		break;
+	default:
+		printk(KERN_ERR "pcmcia: Unsupported Vcc: %d\n", state->Vcc);
+		return -EINVAL;
+	}
+
+	gpio_set_value(GPIO114_HX4700_CF_RESET, (state->flags & SS_RESET) != 0);
+
+	return 0;
+}
+
+static void socket_init(struct soc_pcmcia_socket *skt)
+{
+	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
+}
+
+static void socket_suspend(struct soc_pcmcia_socket *skt)
+{
+	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
+}
+
+static struct pcmcia_low_level hx4700_pcmcia_ops = {
+	.owner          = THIS_MODULE,
+	.nr             = 1,
+	.hw_init        = hw_init,
+	.hw_shutdown    = hw_shutdown,
+	.socket_state   = socket_state,
+	.configure_socket = configure_socket,
+	.socket_init    = socket_init,
+	.socket_suspend = socket_suspend,
+};
+
+static struct platform_device *hx4700_pcmcia_device;
+
+static int __init hx4700_pcmcia_init(void)
+{
+	struct platform_device *pdev;
+	int ret;
+
+	if (!machine_is_h4700())
+		return -ENODEV;
+
+	pdev = platform_device_alloc("pxa2xx-pcmcia", -1);
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = platform_device_add_data(pdev,
+		&hx4700_pcmcia_ops, sizeof(hx4700_pcmcia_ops));
+	if (ret)
+		goto out;
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto out;
+
+	hx4700_pcmcia_device = pdev;
+	return 0;
+
+out:
+	platform_device_put(pdev);
+	return ret;
+}
+
+static void __exit hx4700_pcmcia_exit(void)
+{
+	platform_device_unregister(hx4700_pcmcia_device);
+}
+
+module_init(hx4700_pcmcia_init);
+module_exit(hx4700_pcmcia_exit);
+
+MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
+MODULE_DESCRIPTION("HP iPAQ hx4700 PCMCIA driver");
+MODULE_LICENSE("GPL");
diff -ruN clean-3.0.1/include/linux/mfd/asic3.h linux-3.0.1/include/linux/mfd/asic3.h
--- clean-3.0.1/include/linux/mfd/asic3.h	2011-08-05 05:59:21.000000000 +0100
+++ linux-3.0.1/include/linux/mfd/asic3.h	2011-08-09 11:08:50.432572948 +0100
@@ -138,6 +138,7 @@
 #define ASIC3_GPIOC13_nPWAIT		ASIC3_CONFIG_GPIO(45, 1, 1, 0)
 #define ASIC3_GPIOC14_nPIOIS16		ASIC3_CONFIG_GPIO(46, 1, 1, 0)
 #define ASIC3_GPIOC15_nPIOR		ASIC3_CONFIG_GPIO(47, 1, 0, 0)
+#define ASIC3_GPIOD4_CF_nCD		ASIC3_CONFIG_GPIO(52, 1, 0, 0)
 #define ASIC3_GPIOD11_nCIOIS16		ASIC3_CONFIG_GPIO(59, 1, 0, 0)
 #define ASIC3_GPIOD12_nCWAIT		ASIC3_CONFIG_GPIO(60, 1, 0, 0)
 #define ASIC3_GPIOD15_nPIOW		ASIC3_CONFIG_GPIO(63, 1, 0, 0)
