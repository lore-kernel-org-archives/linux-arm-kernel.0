From: lost.distance@yahoo.com (Paul Parsons)
Date: Tue, 31 Jan 2012 13:43:09 +0000 (GMT)
Subject: [PATCH v3 1/2] pxa/hx4700: Add PCMCIA/CF support
Message-ID: <1328017389.62099.YahooMailClassic@web29007.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCMCIA/CF support for the HP iPAQ hx4700. Underlying support is provided by
the pcmcia/pxa2xx_hx4700 platform_device implementation which hooks into the
existing pxa2xx-pcmcia driver.

Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
---

V3:
Split into two patches: one for kernel drivers, one for hx4700 platform glue.
Call PXA_GPIO_TO_IRQ() instead of retired IRQ_GPIO().
Rebased to linux-3.3-rc1.

diff -uprN clean-3.3-rc1/drivers/mfd/asic3.c linux-3.3-rc1/drivers/mfd/asic3.c
--- clean-3.3-rc1/drivers/mfd/asic3.c	2012-01-19 23:04:48.000000000 +0000
+++ linux-3.3-rc1/drivers/mfd/asic3.c	2012-01-31 13:21:31.124122619 +0000
@@ -992,6 +992,9 @@ static int __init asic3_probe(struct pla
 
 	asic3_mfd_probe(pdev, pdata, mem);
 
+	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
+		(ASIC3_EXTCF_CF0_BUF_EN|ASIC3_EXTCF_CF0_PWAIT_EN), 1);
+
 	dev_info(asic->dev, "ASIC3 Core driver\n");
 
 	return 0;
@@ -1013,6 +1016,9 @@ static int __devexit asic3_remove(struct
 	int ret;
 	struct asic3 *asic = platform_get_drvdata(pdev);
 
+	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
+		(ASIC3_EXTCF_CF0_BUF_EN|ASIC3_EXTCF_CF0_PWAIT_EN), 0);
+
 	asic3_mfd_remove(pdev);
 
 	ret = asic3_gpio_remove(pdev);
diff -uprN clean-3.3-rc1/drivers/pcmcia/Kconfig linux-3.3-rc1/drivers/pcmcia/Kconfig
--- clean-3.3-rc1/drivers/pcmcia/Kconfig	2012-01-19 23:04:48.000000000 +0000
+++ linux-3.3-rc1/drivers/pcmcia/Kconfig	2012-01-31 13:21:31.124122619 +0000
@@ -212,7 +212,7 @@ config PCMCIA_PXA2XX
 		    || MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
 		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2 \
 		    || MACH_VPAC270 || MACH_BALLOON3 || MACH_COLIBRI \
-		    || MACH_COLIBRI320)
+		    || MACH_COLIBRI320 || MACH_H4700)
 	select PCMCIA_SOC_COMMON
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
diff -uprN clean-3.3-rc1/drivers/pcmcia/Makefile linux-3.3-rc1/drivers/pcmcia/Makefile
--- clean-3.3-rc1/drivers/pcmcia/Makefile	2012-01-19 23:04:48.000000000 +0000
+++ linux-3.3-rc1/drivers/pcmcia/Makefile	2012-01-31 13:21:31.124122619 +0000
@@ -69,6 +69,7 @@ pxa2xx-obj-$(CONFIG_MACH_VPAC270)		+= px
 pxa2xx-obj-$(CONFIG_MACH_BALLOON3)		+= pxa2xx_balloon3.o
 pxa2xx-obj-$(CONFIG_MACH_COLIBRI)		+= pxa2xx_colibri.o
 pxa2xx-obj-$(CONFIG_MACH_COLIBRI320)		+= pxa2xx_colibri.o
+pxa2xx-obj-$(CONFIG_MACH_H4700)			+= pxa2xx_hx4700.o
 
 obj-$(CONFIG_PCMCIA_PXA2XX)			+= pxa2xx_base.o $(pxa2xx-obj-y)
 
diff -uprN clean-3.3-rc1/drivers/pcmcia/pxa2xx_hx4700.c linux-3.3-rc1/drivers/pcmcia/pxa2xx_hx4700.c
--- clean-3.3-rc1/drivers/pcmcia/pxa2xx_hx4700.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-3.3-rc1/drivers/pcmcia/pxa2xx_hx4700.c	2012-01-31 13:23:32.468794422 +0000
@@ -0,0 +1,153 @@
+/*
+ *  Copyright (C) 2011 Paul Parsons <lost.distance@yahoo.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
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
+	{ 0,  PXA_GPIO_TO_IRQ(GPIOD4_CF_nCD),               "CF card detect"  },
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
+	irq_set_irq_type(PXA_GPIO_TO_IRQ(GPIOD4_CF_nCD), IRQ_TYPE_EDGE_BOTH);
+
+	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	if (ret) {
+		gpio_free_array(gpios, ARRAY_SIZE(gpios));
+		goto out;
+	}
+
+	skt->socket.pci_irq = PXA_GPIO_TO_IRQ(GPIO60_HX4700_CF_RNB);
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
