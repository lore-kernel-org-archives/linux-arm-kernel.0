From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 13 Dec 2010 20:55:01 +0800
Subject: [PATCH v6 07/15] ARM: mxs: Add gpio support
In-Reply-To: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
References: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1292244903-30392-5-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MXS-based SoCs implement gpio support in block PINCTRL.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>

Changes for v6:
 - Use __mxs_setl() and __mxs_clrl() for bit set/clear
 - Rename functions for not using leading underscore
 - Add mxs_ to some functions name to align naming scheme
 - Introduce variables pin_mask and pin_addr to make code look better
 - Remove PINCTRL_PIN2IRQ from irq_stat assignment
 - Add comment for clearing status bit in IRQSTAT
 - Set up irq handler before registering gpio chip

Changes for v5:
 - Leave PIN2IRQ set when disabling gpio IRQ to avoid
   losting interrupt

Changes for v3:
 - include/mach/gpio.h: remove the inclusion of hardware.h
 - gpio.c: change inclusion of hardware.h to mx23.h plus mx28.h
 - Remove spinlock totally since SET/CLE can be used in all the
   gpio register access

Changes for v2:
 - Create arch/arm/mach-mxs/gpio.h to accommodate stuff private for mach-mxs
 - Use GPIO_INT_LEV_MASK and GPIO_INT_POL_MASK instead of constant
 - Remove both edges IRQ support which is not needed
 - Use SET and CLR register of PINCTRL_DOE in _set_gpio_direction()
 - Use pr_info over printk(KERN_INFO)
---
 arch/arm/mach-mxs/gpio.c              |  315 +++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/gpio.h              |   33 ++++
 arch/arm/mach-mxs/include/mach/gpio.h |   34 ++++
 3 files changed, 382 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/gpio.c
 create mode 100644 arch/arm/mach-mxs/gpio.h
 create mode 100644 arch/arm/mach-mxs/include/mach/gpio.h

diff --git a/arch/arm/mach-mxs/gpio.c b/arch/arm/mach-mxs/gpio.c
new file mode 100644
index 0000000..16d9fb0
--- /dev/null
+++ b/arch/arm/mach-mxs/gpio.c
@@ -0,0 +1,315 @@
+/*
+ * MXC GPIO support. (c) 2008 Daniel Mack <daniel@caiaq.de>
+ * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ *
+ * Based on code from Freescale,
+ * Copyright (C) 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <asm-generic/bug.h>
+
+#include "gpio.h"
+
+static struct mxs_gpio_port *mxs_gpio_ports;
+static int gpio_table_size;
+
+#define PINCTRL_DOUT(n)		((cpu_is_mx23() ? 0x0500 : 0x0700) + (n) * 0x10)
+#define PINCTRL_DIN(n)		((cpu_is_mx23() ? 0x0600 : 0x0900) + (n) * 0x10)
+#define PINCTRL_DOE(n)		((cpu_is_mx23() ? 0x0700 : 0x0b00) + (n) * 0x10)
+#define PINCTRL_PIN2IRQ(n)	((cpu_is_mx23() ? 0x0800 : 0x1000) + (n) * 0x10)
+#define PINCTRL_IRQEN(n)	((cpu_is_mx23() ? 0x0900 : 0x1100) + (n) * 0x10)
+#define PINCTRL_IRQLEV(n)	((cpu_is_mx23() ? 0x0a00 : 0x1200) + (n) * 0x10)
+#define PINCTRL_IRQPOL(n)	((cpu_is_mx23() ? 0x0b00 : 0x1300) + (n) * 0x10)
+#define PINCTRL_IRQSTAT(n)	((cpu_is_mx23() ? 0x0c00 : 0x1400) + (n) * 0x10)
+
+#define GPIO_INT_FALL_EDGE	0x0
+#define GPIO_INT_LOW_LEV	0x1
+#define GPIO_INT_RISE_EDGE	0x2
+#define GPIO_INT_HIGH_LEV	0x3
+#define GPIO_INT_LEV_MASK	(1 << 0)
+#define GPIO_INT_POL_MASK	(1 << 1)
+
+/* Note: This driver assumes 32 GPIOs are handled in one register */
+
+static void clear_gpio_irqstatus(struct mxs_gpio_port *port, u32 index)
+{
+	__mxs_clrl(1 << index, port->base + PINCTRL_IRQSTAT(port->id));
+}
+
+static void set_gpio_irqenable(struct mxs_gpio_port *port, u32 index,
+				int enable)
+{
+	if (enable) {
+		__mxs_setl(1 << index, port->base + PINCTRL_IRQEN(port->id));
+		__mxs_setl(1 << index, port->base + PINCTRL_PIN2IRQ(port->id));
+	} else {
+		__mxs_clrl(1 << index, port->base + PINCTRL_IRQEN(port->id));
+	}
+}
+
+static void mxs_gpio_ack_irq(u32 irq)
+{
+	u32 gpio = irq_to_gpio(irq);
+	clear_gpio_irqstatus(&mxs_gpio_ports[gpio / 32], gpio & 0x1f);
+}
+
+static void mxs_gpio_mask_irq(u32 irq)
+{
+	u32 gpio = irq_to_gpio(irq);
+	set_gpio_irqenable(&mxs_gpio_ports[gpio / 32], gpio & 0x1f, 0);
+}
+
+static void mxs_gpio_unmask_irq(u32 irq)
+{
+	u32 gpio = irq_to_gpio(irq);
+	set_gpio_irqenable(&mxs_gpio_ports[gpio / 32], gpio & 0x1f, 1);
+}
+
+static int mxs_gpio_get(struct gpio_chip *chip, unsigned offset);
+
+static int mxs_gpio_set_irq_type(u32 irq, u32 type)
+{
+	u32 gpio = irq_to_gpio(irq);
+	u32 pin_mask = 1 << (gpio & 31);
+	struct mxs_gpio_port *port = &mxs_gpio_ports[gpio / 32];
+	void __iomem *pin_addr;
+	int edge;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		edge = GPIO_INT_RISE_EDGE;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		edge = GPIO_INT_FALL_EDGE;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		edge = GPIO_INT_LOW_LEV;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		edge = GPIO_INT_HIGH_LEV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* set level or edge */
+	pin_addr = port->base + PINCTRL_IRQLEV(port->id);
+	if (edge & GPIO_INT_LEV_MASK)
+		__mxs_setl(pin_mask, pin_addr);
+	else
+		__mxs_clrl(pin_mask, pin_addr);
+
+	/* set polarity */
+	pin_addr = port->base + PINCTRL_IRQPOL(port->id);
+	if (edge & GPIO_INT_POL_MASK)
+		__mxs_setl(pin_mask, pin_addr);
+	else
+		__mxs_clrl(pin_mask, pin_addr);
+
+	clear_gpio_irqstatus(port, gpio & 0x1f);
+
+	return 0;
+}
+
+/* MXS has one interrupt *per* gpio port */
+static void mxs_gpio_irq_handler(u32 irq, struct irq_desc *desc)
+{
+	u32 irq_stat;
+	struct mxs_gpio_port *port = (struct mxs_gpio_port *)get_irq_data(irq);
+	u32 gpio_irq_no_base = port->virtual_irq_start;
+
+	irq_stat = __raw_readl(port->base + PINCTRL_IRQSTAT(port->id)) &
+			__raw_readl(port->base + PINCTRL_IRQEN(port->id));
+
+	while (irq_stat != 0) {
+		int irqoffset = fls(irq_stat) - 1;
+		generic_handle_irq(gpio_irq_no_base + irqoffset);
+		irq_stat &= ~(1 << irqoffset);
+	}
+}
+
+/*
+ * Set interrupt number "irq" in the GPIO as a wake-up source.
+ * While system is running, all registered GPIO interrupts need to have
+ * wake-up enabled. When system is suspended, only selected GPIO interrupts
+ * need to have wake-up enabled.
+ * @param  irq          interrupt source number
+ * @param  enable       enable as wake-up if equal to non-zero
+ * @return       This function returns 0 on success.
+ */
+static int mxs_gpio_set_wake_irq(u32 irq, u32 enable)
+{
+	u32 gpio = irq_to_gpio(irq);
+	u32 gpio_idx = gpio & 0x1f;
+	struct mxs_gpio_port *port = &mxs_gpio_ports[gpio / 32];
+
+	if (enable) {
+		if (port->irq_high && (gpio_idx >= 16))
+			enable_irq_wake(port->irq_high);
+		else
+			enable_irq_wake(port->irq);
+	} else {
+		if (port->irq_high && (gpio_idx >= 16))
+			disable_irq_wake(port->irq_high);
+		else
+			disable_irq_wake(port->irq);
+	}
+
+	return 0;
+}
+
+static struct irq_chip gpio_irq_chip = {
+	.ack = mxs_gpio_ack_irq,
+	.mask = mxs_gpio_mask_irq,
+	.unmask = mxs_gpio_unmask_irq,
+	.set_type = mxs_gpio_set_irq_type,
+	.set_wake = mxs_gpio_set_wake_irq,
+};
+
+static void mxs_set_gpio_direction(struct gpio_chip *chip, unsigned offset,
+				int dir)
+{
+	struct mxs_gpio_port *port =
+		container_of(chip, struct mxs_gpio_port, chip);
+	void __iomem *pin_addr = port->base + PINCTRL_DOE(port->id);
+
+	if (dir)
+		__mxs_setl(1 << offset, pin_addr);
+	else
+		__mxs_clrl(1 << offset, pin_addr);
+}
+
+static void mxs_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct mxs_gpio_port *port =
+		container_of(chip, struct mxs_gpio_port, chip);
+	void __iomem *pin_addr = port->base + PINCTRL_DOUT(port->id);
+
+	if (value)
+		__mxs_setl(1 << offset, pin_addr);
+	else
+		__mxs_clrl(1 << offset, pin_addr);
+}
+
+static int mxs_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct mxs_gpio_port *port =
+		container_of(chip, struct mxs_gpio_port, chip);
+
+	return (__raw_readl(port->base + PINCTRL_DIN(port->id)) >> offset) & 1;
+}
+
+static int mxs_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	mxs_set_gpio_direction(chip, offset, 0);
+	return 0;
+}
+
+static int mxs_gpio_direction_output(struct gpio_chip *chip,
+				     unsigned offset, int value)
+{
+	mxs_gpio_set(chip, offset, value);
+	mxs_set_gpio_direction(chip, offset, 1);
+	return 0;
+}
+
+int __init mxs_gpio_init(struct mxs_gpio_port *port, int cnt)
+{
+	int i, j;
+
+	/* save for local usage */
+	mxs_gpio_ports = port;
+	gpio_table_size = cnt;
+
+	pr_info("MXS GPIO hardware\n");
+
+	for (i = 0; i < cnt; i++) {
+		/* disable the interrupt and clear the status */
+		__raw_writel(0, port[i].base + PINCTRL_PIN2IRQ(i));
+		__raw_writel(0, port[i].base + PINCTRL_IRQEN(i));
+
+		/* clear address has to be used to clear IRQSTAT bits */
+		__mxs_clrl(~0U, port[i].base + PINCTRL_IRQSTAT(i));
+
+		for (j = port[i].virtual_irq_start;
+			j < port[i].virtual_irq_start + 32; j++) {
+			set_irq_chip(j, &gpio_irq_chip);
+			set_irq_handler(j, handle_level_irq);
+			set_irq_flags(j, IRQF_VALID);
+		}
+
+		/* setup one handler for each entry */
+		set_irq_chained_handler(port[i].irq, mxs_gpio_irq_handler);
+		set_irq_data(port[i].irq, &port[i]);
+
+		/* register gpio chip */
+		port[i].chip.direction_input = mxs_gpio_direction_input;
+		port[i].chip.direction_output = mxs_gpio_direction_output;
+		port[i].chip.get = mxs_gpio_get;
+		port[i].chip.set = mxs_gpio_set;
+		port[i].chip.base = i * 32;
+		port[i].chip.ngpio = 32;
+
+		/* its a serious configuration bug when it fails */
+		BUG_ON( gpiochip_add(&port[i].chip) < 0 );
+	}
+
+	return 0;
+}
+
+#define DEFINE_MXS_GPIO_PORT(soc, _id)					\
+	{								\
+		.chip.label = "gpio-" #_id,				\
+		.id = _id,						\
+		.irq = soc ## _INT_GPIO ## _id,				\
+		.base = soc ## _IO_ADDRESS(				\
+				soc ## _PINCTRL ## _BASE_ADDR),		\
+		.virtual_irq_start = MXS_GPIO_IRQ_START + (_id) * 32,	\
+	}
+
+#define DEFINE_REGISTER_FUNCTION(prefix)				\
+int __init prefix ## _register_gpios(void)				\
+{									\
+	return mxs_gpio_init(prefix ## _gpio_ports,			\
+			ARRAY_SIZE(prefix ## _gpio_ports));		\
+}
+
+#ifdef CONFIG_SOC_IMX23
+static struct mxs_gpio_port mx23_gpio_ports[] = {
+	DEFINE_MXS_GPIO_PORT(MX23, 0),
+	DEFINE_MXS_GPIO_PORT(MX23, 1),
+	DEFINE_MXS_GPIO_PORT(MX23, 2),
+};
+DEFINE_REGISTER_FUNCTION(mx23)
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+static struct mxs_gpio_port mx28_gpio_ports[] = {
+	DEFINE_MXS_GPIO_PORT(MX28, 0),
+	DEFINE_MXS_GPIO_PORT(MX28, 1),
+	DEFINE_MXS_GPIO_PORT(MX28, 2),
+	DEFINE_MXS_GPIO_PORT(MX28, 3),
+	DEFINE_MXS_GPIO_PORT(MX28, 4),
+};
+DEFINE_REGISTER_FUNCTION(mx28)
+#endif
diff --git a/arch/arm/mach-mxs/gpio.h b/arch/arm/mach-mxs/gpio.h
new file mode 100644
index 0000000..49ed668
--- /dev/null
+++ b/arch/arm/mach-mxs/gpio.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __MXS_GPIO_H__
+#define __MXS_GPIO_H__
+
+struct mxs_gpio_port {
+	void __iomem *base;
+	int id;
+	int irq;
+	int irq_high;
+	int virtual_irq_start;
+	struct gpio_chip chip;
+};
+
+int mxs_gpio_init(struct mxs_gpio_port*, int);
+
+#endif /* __MXS_GPIO_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/gpio.h b/arch/arm/mach-mxs/include/mach/gpio.h
new file mode 100644
index 0000000..0a80c32
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/gpio.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2008 Juergen Beisert, kernel@pengutronix.de
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __MACH_MXS_GPIO_H__
+#define __MACH_MXS_GPIO_H__
+
+#include <asm-generic/gpio.h>
+
+#define MXS_GPIO_NR(bank, nr)	((bank) * 32 + (nr))
+
+/* use gpiolib dispatchers */
+#define gpio_get_value		__gpio_get_value
+#define gpio_set_value		__gpio_set_value
+#define gpio_cansleep		__gpio_cansleep
+
+#define gpio_to_irq(gpio)	(MXS_GPIO_IRQ_START + (gpio))
+#define irq_to_gpio(irq)	((irq) - MXS_GPIO_IRQ_START)
+
+#endif /* __MACH_MXS_GPIO_H__ */
-- 
1.7.1
