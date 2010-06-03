From: vzapolskiy@gmail.com (Vladimir Zapolskiy)
Date: Thu,  3 Jun 2010 17:25:50 +0400
Subject: [PATCH Resend] PCMCIA: add Cogent CSB726 PCMCIA support
Message-ID: <1275571550-24437-1-git-send-email-vzapolskiy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for CompactFlash socket found in CSB726 board.

Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Acked-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Dominik Brodowski<linux@dominikbrodowski.net>
---
 drivers/pcmcia/Kconfig         |    3 +-
 drivers/pcmcia/Makefile        |    1 +
 drivers/pcmcia/pxa2xx_csb726.c |  156 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 1 deletions(-)
 create mode 100644 drivers/pcmcia/pxa2xx_csb726.c

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index 9f3adbd..168219b 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -208,7 +208,8 @@ config PCMCIA_PXA2XX
 	depends on ARM && ARCH_PXA && PCMCIA
 	depends on (ARCH_LUBBOCK || MACH_MAINSTONE || PXA_SHARPSL \
 		    || MACH_ARMCORE || ARCH_PXA_PALM || TRIZEPS_PCMCIA \
-		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2)
+		    || ARCOM_PCMCIA || ARCH_PXA_ESERIES || MACH_STARGATE2 \
+		    || MACH_CSB726)
 	select PCMCIA_SOC_COMMON
 	help
 	  Say Y here to include support for the PXA2xx PCMCIA controller
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 83ff802..efcda3f 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -74,5 +74,6 @@ pxa2xx-obj-$(CONFIG_MACH_PALMTC)		+= pxa2xx_palmtc.o
 pxa2xx-obj-$(CONFIG_MACH_PALMLD)		+= pxa2xx_palmld.o
 pxa2xx-obj-$(CONFIG_MACH_E740)			+= pxa2xx_e740.o
 pxa2xx-obj-$(CONFIG_MACH_STARGATE2)		+= pxa2xx_stargate2.o
+pxa2xx-obj-$(CONFIG_MACH_CSB726)		+= pxa2xx_csb726.o
 
 obj-$(CONFIG_PCMCIA_PXA2XX)			+= pxa2xx_base.o $(pxa2xx-obj-y)
diff --git a/drivers/pcmcia/pxa2xx_csb726.c b/drivers/pcmcia/pxa2xx_csb726.c
new file mode 100644
index 0000000..bd86e90
--- /dev/null
+++ b/drivers/pcmcia/pxa2xx_csb726.c
@@ -0,0 +1,156 @@
+/*
+ * linux/drivers/pcmcia/pxa2xx_csb726.c
+ *
+ * Cogent CSB726 Compact Flash specific routines.
+ *
+ * Copyright 2010 Vladimir Zapolskiy <vzapolskiy@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <pcmcia/ss.h>
+
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+
+#include "soc_common.h"
+
+#define GPIO_CF_RDY     98
+#define GPIO_CF_CD      99
+#define GPIO_CF_RST     103
+
+static struct pcmcia_irqs irqs[] = {
+	{
+		.sock = 0,
+		.irq  = IRQ_GPIO(GPIO_CF_CD),
+		.str  = "PCMCIA0 CD",
+	},
+};
+
+static int csb726_pcmcia_hw_init(struct soc_pcmcia_socket *skt)
+{
+	int ret;
+
+	ret = gpio_request(GPIO_CF_RST, "CF reset");
+	if (ret)
+		return ret;
+	gpio_direction_output(GPIO_CF_RST, 0);
+
+	skt->socket.pci_irq = IRQ_GPIO(GPIO_CF_RDY);
+	ret = soc_pcmcia_request_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	if (!ret)
+		gpio_free(GPIO_CF_RST);
+
+	return ret;
+}
+
+static void csb726_pcmcia_hw_shutdown(struct soc_pcmcia_socket *skt)
+{
+	soc_pcmcia_free_irqs(skt, irqs, ARRAY_SIZE(irqs));
+	gpio_free(GPIO_CF_RST);
+}
+
+static void csb726_pcmcia_socket_state(struct soc_pcmcia_socket *skt,
+				       struct pcmcia_state *state)
+{
+	state->detect = !gpio_get_value(GPIO_CF_CD);
+	state->ready  = !!gpio_get_value(GPIO_CF_RDY);
+	state->bvd1   = 0; /* not available - battery detect on card */
+	state->bvd2   = 0; /* not available */
+	state->vs_3v  = 1; /* not available - voltage detect for card */
+	state->vs_Xv  = 0; /* not available */
+	state->wrprot = 0; /* not available - write protect */
+}
+
+static int csb726_pcmcia_configure_socket(struct soc_pcmcia_socket *skt,
+					  const socket_state_t *state)
+{
+	switch (skt->nr) {
+	case 0:
+		if (state->flags & SS_RESET) {
+			/* reset */
+			gpio_set_value(GPIO_CF_RST, 1);
+			udelay(10);
+			gpio_set_value(GPIO_CF_RST, 0);
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static void csb726_pcmcia_socket_init(struct soc_pcmcia_socket *skt)
+{
+	soc_pcmcia_enable_irqs(skt, irqs, ARRAY_SIZE(irqs));
+}
+
+static void csb726_pcmcia_socket_suspend(struct soc_pcmcia_socket *skt)
+{
+	soc_pcmcia_disable_irqs(skt, irqs, ARRAY_SIZE(irqs));
+}
+
+static struct pcmcia_low_level csb726_pcmcia_ops __initdata = {
+	.owner			= THIS_MODULE,
+	.hw_init		= csb726_pcmcia_hw_init,
+	.hw_shutdown		= csb726_pcmcia_hw_shutdown,
+	.socket_state		= csb726_pcmcia_socket_state,
+	.configure_socket	= csb726_pcmcia_configure_socket,
+	.socket_init		= csb726_pcmcia_socket_init,
+	.socket_suspend		= csb726_pcmcia_socket_suspend,
+	.nr			= 1,
+};
+
+static struct platform_device *csb726_pcmcia_device;
+
+static int __init csb726_pcmcia_init(void)
+{
+	int ret;
+
+	if (!machine_is_csb726())
+		return -ENODEV;
+
+	csb726_pcmcia_device = platform_device_alloc("pxa2xx-pcmcia", -1);
+	if (!csb726_pcmcia_device)
+		return -ENOMEM;
+
+	ret = platform_device_add_data(csb726_pcmcia_device,
+				       &csb726_pcmcia_ops,
+				       sizeof(csb726_pcmcia_ops));
+	if (ret)
+		goto error_put_platform_device;
+
+	ret = platform_device_add(csb726_pcmcia_device);
+	if (ret)
+		goto error_put_platform_device;
+
+	return 0;
+
+error_put_platform_device:
+	platform_device_put(csb726_pcmcia_device);
+
+	return ret;
+}
+
+static void __exit csb726_pcmcia_exit(void)
+{
+	platform_device_unregister(csb726_pcmcia_device);
+}
+
+fs_initcall(csb726_pcmcia_init);
+module_exit(csb726_pcmcia_exit);
+
+MODULE_DESCRIPTION("Cogent CSB726 Compact Flash Driver");
+MODULE_AUTHOR("Vladimir Zapolskiy <vzapolskiy@gmail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:pxa2xx-pcmcia");
-- 
1.7.0.4
