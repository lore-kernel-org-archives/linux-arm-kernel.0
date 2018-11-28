From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Wed, 28 Nov 2018 11:11:42 +0000
Subject: [PATCH 2/8] pcmcia: add MAX1600 library
In-Reply-To: <20181128111041.GG30658@n2100.armlinux.org.uk>
Message-ID: <E1gRxks-0001uA-RH@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a library for the MAX1600 PCMCIA power switch device.  This is a
dual-channel device, controlled via four GPIO signals per channel.
Two signals control the Vcc output, and two control the Vpp output.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/pcmcia/Kconfig   |   3 ++
 drivers/pcmcia/Makefile  |   1 +
 drivers/pcmcia/max1600.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/pcmcia/max1600.h |  32 +++++++++++++
 4 files changed, 158 insertions(+)
 create mode 100644 drivers/pcmcia/max1600.c
 create mode 100644 drivers/pcmcia/max1600.h

diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index cbbe4a285b48..1a257a323923 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -63,6 +63,9 @@ config CARDBUS
 
 	  If unsure, say Y.
 
+config PCMCIA_MAX1600
+	tristate
+
 comment "PC-card bridges"
 
 config YENTA
diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
index 28502bd159e0..01779c5c45f3 100644
--- a/drivers/pcmcia/Makefile
+++ b/drivers/pcmcia/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
 obj-$(CONFIG_AT91_CF)				+= at91_cf.o
 obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
 obj-$(CONFIG_PCMCIA_ALCHEMY_DEVBOARD)		+= db1xxx_ss.o
+obj-$(CONFIG_PCMCIA_MAX1600)			+= max1600.o
 
 sa1111_cs-y					+= sa1111_generic.o
 sa1111_cs-$(CONFIG_ASSABET_NEPONSET)		+= sa1111_neponset.o
diff --git a/drivers/pcmcia/max1600.c b/drivers/pcmcia/max1600.c
new file mode 100644
index 000000000000..379875a5e7cd
--- /dev/null
+++ b/drivers/pcmcia/max1600.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MAX1600 PCMCIA power switch library
+ *
+ * Copyright (C) 2016 Russell King
+ */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/gpio/consumer.h>
+#include <linux/slab.h>
+#include "max1600.h"
+
+static const char *max1600_gpio_name[2][MAX1600_GPIO_MAX] = {
+	{ "a0vcc", "a1vcc", "a0vpp", "a1vpp" },
+	{ "b0vcc", "b1vcc", "b0vpp", "b1vpp" },
+};
+
+int max1600_init(struct device *dev, struct max1600 **ptr,
+	unsigned int channel, unsigned int code)
+{
+	struct max1600 *m;
+	int chan;
+	int i;
+
+	switch (channel) {
+	case MAX1600_CHAN_A:
+		chan = 0;
+		break;
+	case MAX1600_CHAN_B:
+		chan = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (code != MAX1600_CODE_LOW && code != MAX1600_CODE_HIGH)
+		return -EINVAL;
+
+	m = devm_kzalloc(dev, sizeof(*m), GFP_KERNEL);
+	if (!m)
+		return -ENOMEM;
+
+	m->dev = dev;
+	m->code = code;
+
+	for (i = 0; i < MAX1600_GPIO_MAX; i++) {
+		const char *name;
+
+		name = max1600_gpio_name[chan][i];
+		if (i != MAX1600_GPIO_0VPP) {
+			m->gpio[i] = devm_gpiod_get(dev, name, GPIOD_OUT_LOW);
+		} else {
+			m->gpio[i] = devm_gpiod_get_optional(dev, name,
+							     GPIOD_OUT_LOW);
+			if (!m->gpio[i])
+				break;
+		}
+		if (IS_ERR(m->gpio[i]))
+			return PTR_ERR(m->gpio[i]);
+	}
+
+	*ptr = m;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(max1600_init);
+
+int max1600_configure(struct max1600 *m, unsigned int vcc, unsigned int vpp)
+{
+	DECLARE_BITMAP(values, MAX1600_GPIO_MAX) = { 0, };
+	int n = MAX1600_GPIO_0VPP;
+
+	if (m->gpio[MAX1600_GPIO_0VPP]) {
+		if (vpp == 0) {
+			__assign_bit(MAX1600_GPIO_0VPP, values, 0);
+			__assign_bit(MAX1600_GPIO_1VPP, values, 0);
+		} else if (vpp == 120) {
+			__assign_bit(MAX1600_GPIO_0VPP, values, 0);
+			__assign_bit(MAX1600_GPIO_1VPP, values, 1);
+		} else if (vpp == vcc) {
+			__assign_bit(MAX1600_GPIO_0VPP, values, 1);
+			__assign_bit(MAX1600_GPIO_1VPP, values, 0);
+		} else {
+			dev_err(m->dev, "unrecognised Vpp %u.%uV\n",
+				vpp / 10, vpp % 10);
+			return -EINVAL;
+		}
+		n = MAX1600_GPIO_MAX;
+	} else if (vpp != vcc && vpp != 0) {
+		dev_err(m->dev, "no VPP control\n");
+		return -EINVAL;
+	}
+
+	if (vcc == 0) {
+		__assign_bit(MAX1600_GPIO_0VCC, values, 0);
+		__assign_bit(MAX1600_GPIO_1VCC, values, 0);
+	} else if (vcc == 33) { /* VY */
+		__assign_bit(MAX1600_GPIO_0VCC, values, 1);
+		__assign_bit(MAX1600_GPIO_1VCC, values, 0);
+	} else if (vcc == 50) { /* VX */
+		__assign_bit(MAX1600_GPIO_0VCC, values, 0);
+		__assign_bit(MAX1600_GPIO_1VCC, values, 1);
+	} else {
+		dev_err(m->dev, "unrecognised Vcc %u.%uV\n",
+			vcc / 10, vcc % 10);
+		return -EINVAL;
+	}
+
+	if (m->code == MAX1600_CODE_HIGH) {
+		/*
+		 * Cirrus mode appears to be the same as Intel mode,
+		 * except the VCC pins are inverted.
+		 */
+		__change_bit(MAX1600_GPIO_0VCC, values);
+		__change_bit(MAX1600_GPIO_1VCC, values);
+	}
+
+	return gpiod_set_array_value_cansleep(n, m->gpio, NULL, values);
+}
+EXPORT_SYMBOL_GPL(max1600_configure);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pcmcia/max1600.h b/drivers/pcmcia/max1600.h
new file mode 100644
index 000000000000..00bf1a09464f
--- /dev/null
+++ b/drivers/pcmcia/max1600.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MAX1600_H
+#define MAX1600_H
+
+struct gpio_desc;
+
+enum {
+	MAX1600_GPIO_0VCC = 0,
+	MAX1600_GPIO_1VCC,
+	MAX1600_GPIO_0VPP,
+	MAX1600_GPIO_1VPP,
+	MAX1600_GPIO_MAX,
+
+	MAX1600_CHAN_A,
+	MAX1600_CHAN_B,
+
+	MAX1600_CODE_LOW,
+	MAX1600_CODE_HIGH,
+};
+
+struct max1600 {
+	struct gpio_desc *gpio[MAX1600_GPIO_MAX];
+	struct device *dev;
+	unsigned int code;
+};
+
+int max1600_init(struct device *dev, struct max1600 **ptr,
+	unsigned int channel, unsigned int code);
+
+int max1600_configure(struct max1600 *, unsigned int vcc, unsigned int vpp);
+
+#endif
-- 
2.7.4
