From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 10 Dec 2010 16:28:16 +0000
Subject: [PATCH v3 05/14] picoxcell: add gpio infrastructure
In-Reply-To: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
References: <1291998505-25891-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1291998505-25891-6-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a gpio infrastructure for picoXcell devices. This adds support for
both the ARM GPIO peripheral and the SDGPIO pins that are in the
picoArray domain and accessed through the AXI2CFG. This implements a set
of gpiolib chips and also adds an extension to use the sigma-delta
capabilities of the SDGPIO pins in kernelspace.

v2:
        - Fixup the picoxcell gpio driver to use struct irq_data rather
          than irq numbers in the handlers and accessing irq_desc
          directly.
        - Fixup a typo in the set_type function where we didn't check
          correctly for IRQ_TYPE_EDGE_FALLING.

v3: fixup muxing detection to work with the muxing changes.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/mach-picoxcell/Makefile            |    3 +-
 arch/arm/mach-picoxcell/gpio.c              |  712 +++++++++++++++++++++++++++
 arch/arm/mach-picoxcell/include/mach/gpio.h |  187 +++++++
 arch/arm/mach-picoxcell/picoxcell_core.c    |    5 +
 4 files changed, 906 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/gpio.c
 create mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h

diff --git a/arch/arm/mach-picoxcell/Makefile b/arch/arm/mach-picoxcell/Makefile
index 77801b2..29b52e8 100644
--- a/arch/arm/mach-picoxcell/Makefile
+++ b/arch/arm/mach-picoxcell/Makefile
@@ -1,3 +1,4 @@
 obj-y				:= picoxcell_core.o io.o axi2cfg.o \
 				   time.o \
-				   mux.o
+				   mux.o \
+				   gpio.o
diff --git a/arch/arm/mach-picoxcell/gpio.c b/arch/arm/mach-picoxcell/gpio.c
new file mode 100644
index 0000000..c30cd87
--- /dev/null
+++ b/arch/arm/mach-picoxcell/gpio.c
@@ -0,0 +1,712 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * All enquiries to support at picochip.com
+ */
+#define pr_fmt(fmt) "picoxcellgpio: " fmt
+
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <mach/hardware.h>
+
+#include "mux.h"
+
+static struct {
+	void __iomem	*armgpio_virt;
+	int		armgpio_base;
+	int		sdgpio_base;
+	int		nr_sdgpio;
+} gpio_info;
+
+static DECLARE_BITMAP(pin_status, ARCH_NR_GPIOS);
+static DEFINE_SPINLOCK(armgpio_lock);
+
+static int armgpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	enum mux_setting mux;
+
+	if (test_and_set_bit(offset + chip->base, pin_status))
+		return -EBUSY;
+
+	/* Check the pin has been correctly multiplexed. */
+	mux = picoxcell_pin_get_mux_bygpio(offset + chip->base);
+	if (!(mux == MUX_ARM || mux == MUX_UNMUXED)) {
+		/* The pin has an inconsistent mux setting. */
+		pr_warning("attempt to request armgpio%u which is not correctly multiplexed\n",
+			   chip->base + offset);
+		clear_bit(offset + chip->base, pin_status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void armgpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	clear_bit(offset + chip->base, pin_status);
+}
+
+#define GPIO_SW_PORT_A_EXT_REG_OFFSET	GPIO_EXT_PORT_A_REG_OFFSET
+#define GPIO_SW_PORT_B_EXT_REG_OFFSET	GPIO_EXT_PORT_B_REG_OFFSET
+#define GPIO_SW_PORT_D_EXT_REG_OFFSET	GPIO_EXT_PORT_D_REG_OFFSET
+
+static inline int armgpio_block_nr(unsigned gpio_nr)
+{
+	return gpio_nr - gpio_info.armgpio_base;
+}
+
+#define __ARMGPIO_REG(_gpio_base, _reg)					    \
+	({								    \
+		void __iomem *ret = NULL;				    \
+		int __gpio_nr = armgpio_block_nr(_gpio_base);		    \
+		if (__gpio_nr < 8)					    \
+			ret = (gpio_info.armgpio_virt +			    \
+				GPIO_SW_PORT_A_##_reg##_REG_OFFSET);	    \
+		else if (__gpio_nr < 24)				    \
+			ret = (gpio_info.armgpio_virt +			    \
+				GPIO_SW_PORT_B_##_reg##_REG_OFFSET);	    \
+		else							    \
+			ret = (gpio_info.armgpio_virt +			    \
+				GPIO_SW_PORT_D_##_reg##_REG_OFFSET);	    \
+		ret;							    \
+	})
+
+#define ARMGPIO_DR(_gpio_base)	    __ARMGPIO_REG(_gpio_base, DR)
+#define ARMGPIO_DDR(_gpio_base)	    __ARMGPIO_REG(_gpio_base, DDR)
+#define ARMGPIO_CTL(_gpio_base)	    __ARMGPIO_REG(_gpio_base, CTL)
+#define ARMGPIO_EXT(_gpio_base)	    __ARMGPIO_REG(_gpio_base, EXT)
+
+static inline unsigned armgpio_offset(unsigned offset)
+{
+	/*
+	 * The arm gpios are controlled via three sets of registers. The
+	 * register addressing is already taken care of by the __ARMGPIO_REG
+	 * macro, this takes care of the bit offsets within each register.
+	 */
+	if (offset < 8) /* GPIO Port A*/
+		return offset;
+	else if (offset < 24) /* GPIO Port B */
+		return offset - 8;
+	else /* GPIO Port D */
+		return offset - 24;
+}
+
+static int armgpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	void __iomem *ddr = ARMGPIO_DDR(chip->base + offset);
+	void __iomem *cr = ARMGPIO_CTL(chip->base + offset);
+	unsigned long flags, val, bit_offset = armgpio_offset(offset);
+
+	spin_lock_irqsave(&armgpio_lock, flags);
+	/* Mark the pin as an output. */
+	val = readl(ddr);
+	val &= ~(1 << bit_offset);
+	writel(val, ddr);
+
+	/* Set the pin as software controlled. */
+	val = readl(cr);
+	val &= ~(1 << bit_offset);
+	writel(val, cr);
+	spin_unlock_irqrestore(&armgpio_lock, flags);
+
+	return 0;
+}
+
+static void armgpio_set(struct gpio_chip *chip, unsigned offset, int value);
+
+static int armgpio_direction_output(struct gpio_chip *chip, unsigned offset,
+				    int value)
+{
+	void __iomem *ddr = ARMGPIO_DDR(chip->base + offset);
+	void __iomem *cr = ARMGPIO_CTL(chip->base + offset);
+	unsigned long flags, val, bit_offset = armgpio_offset(offset);
+
+	/* Set the value first so we don't glitch. */
+	armgpio_set(chip, offset, value);
+
+	spin_lock_irqsave(&armgpio_lock, flags);
+	/* Mark the pin as an output. */
+	val = readl(ddr);
+	val |= (1 << bit_offset);
+	writel(val, ddr);
+
+	/* Set the pin as software controlled. */
+	val = readl(cr);
+	val &= ~(1 << bit_offset);
+	writel(val, cr);
+	spin_unlock_irqrestore(&armgpio_lock, flags);
+
+	return 0;
+}
+
+static int armgpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	void __iomem *ext = ARMGPIO_EXT(chip->base + offset);
+	unsigned long bit_offset = armgpio_offset(offset);
+
+	return !!(readl(ext) & (1 << bit_offset));
+}
+
+static void armgpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	void __iomem *dr = ARMGPIO_DR(chip->base + offset);
+	unsigned long val, flags, bit_offset = armgpio_offset(offset);
+
+	spin_lock_irqsave(&armgpio_lock, flags);
+	val = readl(dr);
+	val &= ~(1 << bit_offset);
+	val |= (!!value << bit_offset);
+	writel(val, dr);
+	spin_unlock_irqrestore(&armgpio_lock, flags);
+}
+
+static int armgpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	if (offset < gpio_info.armgpio_base + 8)
+		return IRQ_GPIO0 + offset;
+	return -EINVAL;
+}
+
+#define INT_EN_REG	    (gpio_info.armgpio_virt + GPIO_INT_EN_REG_OFFSET)
+#define INT_MASK_REG	    (gpio_info.armgpio_virt + GPIO_INT_MASK_REG_OFFSET)
+#define INT_TYPE_REG	    (gpio_info.armgpio_virt + \
+			     GPIO_INT_TYPE_LEVEL_REG_OFFSET)
+#define INT_POLARITY_REG    (gpio_info.armgpio_virt + \
+			     GPIO_INT_POLARITY_REG_OFFSET)
+#define INT_STATUS_REG	    (gpio_info.armgpio_virt + \
+			     GPIO_INT_STATUS_REG_OFFSET)
+#define EOI_REG		    (gpio_info.armgpio_virt + \
+			     GPIO_PORT_A_EOI_REG_OFFSET)
+
+static void armgpio_irq_enable(struct irq_data *data)
+{
+	int gpio = irq_to_gpio(data->irq);
+	void __iomem *port_inten = INT_EN_REG;
+	unsigned long val;
+
+	val = readl(port_inten);
+	val |= (1 << gpio);
+	writel(val, port_inten);
+}
+
+static void armgpio_irq_disable(struct irq_data *data)
+{
+	int gpio = irq_to_gpio(data->irq);
+	void __iomem *port_inten = INT_EN_REG;
+	unsigned long val;
+
+	val = readl(port_inten);
+	val &= ~(1 << gpio);
+	writel(val, port_inten);
+}
+
+static void armgpio_irq_mask(struct irq_data *data)
+{
+	int gpio = irq_to_gpio(data->irq);
+	void __iomem *port_mask = INT_MASK_REG;
+	unsigned long val;
+
+	val = readl(port_mask);
+	val |= (1 << gpio);
+	writel(val, port_mask);
+}
+
+static void armgpio_irq_ack(struct irq_data *data)
+{
+	int gpio = irq_to_gpio(data->irq);
+	void __iomem *port_intmask = INT_MASK_REG;
+	void __iomem *port_eoi = EOI_REG;
+	void __iomem *port_inttype_level = INT_TYPE_REG;
+	unsigned long val;
+
+	val = readl(port_inttype_level);
+
+	if (val & (1 << gpio)) {
+		/* Edge-sensitive */
+		val = readl(port_eoi);
+		val |= (1 << gpio);
+		writel(val, port_eoi);
+	} else {
+		/* Level-sensitive */
+		val = readl(port_intmask);
+		val |= (1 << gpio);
+		writel(val, port_intmask);
+	}
+}
+
+static void armgpio_irq_unmask(struct irq_data *data)
+{
+	int gpio = irq_to_gpio(data->irq);
+	void __iomem *port_intmask = INT_MASK_REG;
+	unsigned long val;
+
+	val = readl(port_intmask);
+	val &= ~(1 << gpio);
+	writel(val, port_intmask);
+}
+
+static int armgpio_irq_set_type(struct irq_data *data, unsigned int trigger)
+{
+	int gpio = irq_to_gpio(data->irq);
+	void __iomem *port_inttype_level = INT_TYPE_REG;
+	void __iomem *port_int_polarity = INT_POLARITY_REG;
+	unsigned long level, polarity;
+
+	if (trigger & ~(IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING |
+			IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+		return -EINVAL;
+
+	level = readl(port_inttype_level);
+	polarity = readl(port_int_polarity);
+
+	if (trigger & IRQ_TYPE_EDGE_RISING) {
+		level	    |= (1 << gpio);
+		polarity    |= (1 << gpio);
+	} else if (trigger & IRQ_TYPE_EDGE_FALLING) {
+		level	    |= (1 << gpio);
+		polarity    &= ~(1 << gpio);
+	} else if (trigger & IRQ_TYPE_LEVEL_HIGH) {
+		level	    &= ~(1 << gpio);
+		polarity    |= (1 << gpio);
+	} else if (trigger & IRQ_TYPE_LEVEL_LOW) {
+		level	    &= ~(1 << gpio);
+		polarity    &= ~(1 << gpio);
+	}
+
+	writel(level, port_inttype_level);
+	writel(polarity, port_int_polarity);
+
+	if ((trigger & IRQ_TYPE_EDGE_RISING) ||
+	    (trigger & IRQ_TYPE_EDGE_FALLING))
+		set_irq_handler(data->irq, handle_edge_irq);
+	else
+		set_irq_handler(data->irq, handle_level_irq);
+
+	return 0;
+}
+
+struct irq_chip armgpio_irqchip = {
+	.name			= "armgpio",
+	.irq_ack		= armgpio_irq_ack,
+	.irq_mask		= armgpio_irq_mask,
+	.irq_unmask		= armgpio_irq_unmask,
+	.irq_enable		= armgpio_irq_enable,
+	.irq_disable		= armgpio_irq_disable,
+	.irq_set_type		= armgpio_irq_set_type,
+};
+
+static struct gpio_chip armgpio_chip = {
+	.owner			= THIS_MODULE,
+	.label			= "armgpio",
+	.request		= armgpio_request,
+	.free			= armgpio_free,
+	.direction_input	= armgpio_direction_input,
+	.direction_output	= armgpio_direction_output,
+	.get			= armgpio_get,
+	.set			= armgpio_set,
+	.to_irq			= armgpio_to_irq,
+};
+
+/* The base address of SD-GPIO config registers in the AXI2Pico. */
+#define SD_PIN_CONFIG_BASE		0x9800
+/* The base address of SD-GPIO analogue value registers in the AXI2Pico. */
+#define SD_PIN_ANALOGUE_VALUE_BASE	0x9801
+/* The base address of SD-GPIO analogue rate registers in the AXI2Pico. */
+#define SD_PIN_ANALOGUE_RATE_BASE	0x9802
+/* The address of the control value register in the AXI2Pico. */
+#define SD_CONTROL_VAL_REG		0x9882
+/* The address of the control value high register in the AXI2Pico (pc3x3). */
+#define SD_CONTROL_VAL_HI_REG		0x9883
+/* The address of the output value register in the AXI2Pico. */
+#define SD_OUTPUT_VAL_REG		0x9884
+/* The address of the output value high register in the AXI2Pico (pc3x3). */
+#define SD_OUTPUT_HI_VAL_REG		0x9885
+/* The address of the input value register in the AXI2Pico. */
+#define SD_INPUT_VAL_REG		0x9880
+/* The address of the input value high register in the AXI2Pico (pc3x3). */
+#define SD_INPUT_VAL_HI_REG		0x9880
+/* The address of the sleep register in the AXI2Pico. */
+#define PICOXCELL_AXI2PICO_SLEEP_REG	0xA060
+/* The spacing between SD-GPIO config registers. */
+#define SD_PIN_CONFIG_SPACING		4
+/* Control source bit. */
+#define SD_CONFIG_CS_MASK		(~(1 << 15))
+/* Analogue not digital bit. */
+#define SD_CONFIG_AND			(1 << 14)
+/* The mask for analogue converter size in the config register. */
+#define SD_CONV_SZ_MASK			0xF
+/* Soft reset lock bit. */
+#define SD_CONFIG_SR_LOCK		(1 << 13)
+/* PICOXCELL AXI2Pico CAEID. */
+#define PICOXCELL_AXI2PICO_CAEID	0x9000
+
+/*
+ * Get the address of a config register for a SD-GPIO pin.
+ *
+ * @_n The SD-GPIO pin number.
+ *
+ * Returns the base address of the register.
+ */
+#define SD_PIN_CONFIG(_n) \
+	(SD_PIN_CONFIG_BASE + ((_n) * SD_PIN_CONFIG_SPACING))
+
+/*
+ * Get the address of a analogue rate register for a SD-GPIO pin.
+ *
+ * @_n The SD-GPIO pin number.
+ *
+ * Returns the base address of the register.
+ */
+#define SD_PIN_ANALOGUE_RATE(_n) \
+	(SD_PIN_ANALOGUE_RATE_BASE + ((_n) * SD_PIN_CONFIG_SPACING))
+
+/*
+ * Get the address of a analogue value register for a SD-GPIO pin.
+ *
+ * @_n The SD-GPIO pin number.
+ *
+ * Returns the base address of the register.
+ */
+#define SD_PIN_ANALOGUE_VAL(_n) \
+	(SD_PIN_ANALOGUE_VALUE_BASE + ((_n) * SD_PIN_CONFIG_SPACING))
+
+static int sdgpio_reset_config(unsigned block_pin, int value)
+{
+	int ret;
+	u16 data;
+
+	ret = axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID,
+				  SD_PIN_CONFIG(block_pin), &data, 1);
+	if (1 != ret) {
+		pr_err("failed to read config register for SDGPIO pin %u\n",
+		       block_pin);
+		return -EIO;
+	}
+
+	if (value)
+		data |= SD_CONFIG_SR_LOCK;
+	else
+		data &= ~SD_CONFIG_SR_LOCK;
+
+	axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID,
+			     SD_PIN_CONFIG(block_pin), &data, 1);
+
+	return 0;
+}
+
+static inline int sdgpio_block_nr(unsigned gpio_nr)
+{
+	return gpio_nr - gpio_info.sdgpio_base;
+}
+
+static int sdgpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	unsigned block_pin = sdgpio_block_nr(chip->base + offset);
+	enum mux_setting mux;
+
+	if (test_and_set_bit(offset + chip->base, pin_status))
+		return -EBUSY;
+
+	if (sdgpio_reset_config(block_pin, 1)) {
+		clear_bit(offset + chip->base, pin_status);
+		return -EIO;
+	}
+
+	/* Check the pin has been correctly multiplexed. */
+	mux = picoxcell_pin_get_mux_bygpio(offset + chip->base);
+	if (!(mux == MUX_SD || mux == MUX_UNMUXED)) {
+		/* The pin has an inconsistent mux setting. */
+		pr_warning("attempt to request sdgpio%u which is not correctly multiplexed\n",
+			   block_pin);
+		clear_bit(offset + chip->base, pin_status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void sdgpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	clear_bit(offset + chip->base, pin_status);
+	picoxcell_gpio_configure_dac(chip->base + offset, 0, 0);
+}
+
+/*
+ * Create a map of which pins are analogue and not digital. We have a separate
+ * function for configuring pins as analogue. When we set analogue pins, we
+ * don't treat the int parameter as a boolean anymore.
+ */
+static DECLARE_BITMAP(a_not_d_map, ARCH_NR_GPIOS);
+
+static int sdgpio_get_digital_out_status(u32 *v)
+{
+	u16 data[2] = { 0, 0 };
+
+	if (1 != axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID,
+				     SD_OUTPUT_VAL_REG, &data[0], 1))
+		return -EIO;
+
+	if (gpio_info.nr_sdgpio > 16) {
+		if (1 != axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID,
+					SD_OUTPUT_HI_VAL_REG, &data[1], 1))
+			return -EIO;
+	}
+
+	*v = data[0] | (data[1] << 16);
+
+	return 0;
+}
+
+static void sdgpio_set_digital_out_status(u32 v)
+{
+	u16 data[2] = { (u16)(v & 0xFFFF), (u16)((v >> 16) & 0xFFFF) };
+
+	axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID, SD_OUTPUT_VAL_REG,
+			     &data[0], 1);
+
+	if (gpio_info.nr_sdgpio > 16) {
+		axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID,
+				     SD_OUTPUT_HI_VAL_REG, &data[1], 1);
+	}
+}
+
+static void sdgpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	u16 data;
+	unsigned block_pin = sdgpio_block_nr(chip->base + offset);
+
+	if (!test_bit(chip->base + offset, a_not_d_map)) {
+		u32 status;
+
+		if (sdgpio_get_digital_out_status(&status)) {
+			pr_err("failed to read SDGPIO output value reg\n");
+			return;
+		}
+
+		status &= ~(1 << block_pin);
+		status |= (!!value) << block_pin;
+
+		sdgpio_set_digital_out_status(status);
+	} else {
+		/* Analogue mode */
+		data = (u16)value;
+		axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID,
+				     SD_PIN_ANALOGUE_VAL(block_pin), &data, 1);
+	}
+}
+
+static int sdgpio_get_digital_in_status(u32 *v)
+{
+	u16 data[2] = { 0, 0 };
+
+	if (1 != axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID, SD_INPUT_VAL_REG,
+				     &data[0], 1))
+		return -EIO;
+
+	if (gpio_info.nr_sdgpio > 16) {
+		if (1 != axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID,
+					     SD_INPUT_VAL_HI_REG, &data[1], 1))
+			return -EIO;
+	}
+
+	*v = data[0] | (data[1] << 16);
+
+	return 0;
+}
+
+static int sdgpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	int ret;
+	u16 data;
+	unsigned block_pin = sdgpio_block_nr(chip->base + offset);
+
+	if (!test_bit(chip->base + offset, a_not_d_map)) {
+		u32 status;
+
+		if (sdgpio_get_digital_in_status(&status))
+			return -EIO;
+
+		return !!(status & (1 << block_pin));
+	} else {
+		/* Analogue mode */
+		ret = axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID,
+					  SD_PIN_ANALOGUE_VAL(block_pin),
+					  &data, 1);
+		if (1 != ret) {
+			pr_err("failed to read the analogue value register for SDGPIO pin %u\n",
+			       block_pin);
+			return -EIO;
+		}
+
+		return (int)data;
+	}
+}
+
+static int sdgpio_set_direction(unsigned block_pin, int input)
+{
+	int ret;
+	u16 data;
+
+	ret = axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID,
+				  SD_PIN_CONFIG(block_pin), &data, 1);
+	if (1 != ret) {
+		pr_err("failed to read config register for SDGPIO pin %u\n",
+		       block_pin);
+		return -EIO;
+	}
+
+	data &= SD_CONFIG_CS_MASK;
+	axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID,
+			     SD_PIN_CONFIG(block_pin), &data, 1);
+
+	/* Configure the pin to drive or not drive the output as appropriate. */
+	ret = axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID,
+				  SD_CONTROL_VAL_REG, &data, 1);
+	if (1 != ret) {
+		pr_err("failed to read SDGPIO control value register\n");
+		return -EIO;
+	}
+
+	if (input)
+		data &= ~(1 << block_pin);
+	else
+		data |= (1 << block_pin);
+
+	axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID, SD_CONTROL_VAL_REG,
+			     &data, 1);
+
+	return 0;
+}
+
+static int sdgpio_direction_output(struct gpio_chip *chip, unsigned offset,
+				   int value)
+{
+	unsigned block_pin = sdgpio_block_nr(chip->base + offset);
+	int ret = sdgpio_set_direction(block_pin, 0);
+
+	if (ret)
+		return ret;
+
+	sdgpio_set(chip, offset, value);
+
+	return 0;
+}
+
+static int sdgpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	unsigned block_pin = sdgpio_block_nr(chip->base + offset);
+
+	return sdgpio_set_direction(block_pin, 1);
+}
+
+int picoxcell_gpio_configure_dac(unsigned gpio, u8 converter_size,
+				 u16 analogue_rate)
+{
+	int ret;
+	u16 data;
+	unsigned block_pin = sdgpio_block_nr(gpio);
+
+	ret = axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID,
+				  SD_PIN_CONFIG(block_pin), &data, 1);
+	if (1 != ret) {
+		pr_err("failed to read config register for SDGPIO pin %u\n",
+		       block_pin);
+		return -EIO;
+	}
+
+	data &= SD_CONFIG_CS_MASK | ~SD_CONV_SZ_MASK;
+	if (!analogue_rate && !converter_size)
+		data &= ~SD_CONFIG_AND;
+	else
+		data |= SD_CONFIG_AND;
+	data |= (converter_size & SD_CONV_SZ_MASK);
+
+	axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID,
+			     SD_PIN_CONFIG(block_pin), &data, 1);
+
+	/* Configure the pin to drive the output. */
+	ret = axi2cfg_config_read(PICOXCELL_AXI2PICO_CAEID, SD_CONTROL_VAL_REG,
+				  &data, 1);
+	if (1 != ret) {
+		pr_err("failed to read SDGPIO control value register\n");
+		return -EIO;
+	}
+
+	data |= (1 << block_pin);
+
+	axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID, SD_CONTROL_VAL_REG,
+			     &data, 1);
+
+	/* Write the analogue rate register */
+	data = analogue_rate;
+	axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID,
+			     SD_PIN_ANALOGUE_RATE(block_pin), &data, 1);
+
+	if (analogue_rate || converter_size)
+		set_bit(gpio, a_not_d_map);
+	else
+		clear_bit(gpio, a_not_d_map);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(picoxcell_gpio_configure_dac);
+
+static struct gpio_chip sdgpio_chip = {
+	.owner		    = THIS_MODULE,
+	.label		    = "sdgpio",
+	.request	    = sdgpio_request,
+	.free		    = sdgpio_free,
+	.direction_input    = sdgpio_direction_input,
+	.direction_output   = sdgpio_direction_output,
+	.get		    = sdgpio_get,
+	.set		    = sdgpio_set,
+};
+
+int __init picoxcell_gpio_init(const char * const armgpio_pins[],
+			       int nr_armgpio, int armgpio_base,
+			       const char * const sdgpio_pins[],
+			       int nr_sdgpio, int sdgpio_base)
+{
+	int ret = 0;
+	u16 data = 0;
+
+	/*
+	 * Make sure that the AXI2Pico is awake for the SDGPIO transactions.
+	 */
+	axi2cfg_config_write(PICOXCELL_AXI2PICO_CAEID,
+			     PICOXCELL_AXI2PICO_SLEEP_REG, &data, 1);
+
+	gpio_info.armgpio_virt	= ioremap(PICOXCELL_GPIO_BASE, SZ_4K);
+	gpio_info.armgpio_base	= armgpio_base;
+	gpio_info.sdgpio_base	= sdgpio_base;
+	gpio_info.nr_sdgpio	= nr_sdgpio;
+
+	armgpio_chip.ngpio	= nr_armgpio;
+	armgpio_chip.names	= armgpio_pins;
+	armgpio_chip.base	= armgpio_base;
+	sdgpio_chip.ngpio	= nr_sdgpio;
+	sdgpio_chip.names	= sdgpio_pins;
+	sdgpio_chip.base	= sdgpio_base;
+
+	ret = gpiochip_add(&armgpio_chip);
+	if (ret) {
+		pr_err("failed to register %s\n", armgpio_chip.label);
+		goto out;
+	}
+
+	ret = gpiochip_add(&sdgpio_chip);
+	if (ret) {
+		pr_err("failed to register %s\n", sdgpio_chip.label);
+		goto out;
+	}
+
+out:
+	return ret;
+}
diff --git a/arch/arm/mach-picoxcell/include/mach/gpio.h b/arch/arm/mach-picoxcell/include/mach/gpio.h
new file mode 100644
index 0000000..ce55c3d
--- /dev/null
+++ b/arch/arm/mach-picoxcell/include/mach/gpio.h
@@ -0,0 +1,187 @@
+/*
+ * Copyright (c) 2010 Picochip Ltd., Jamie Iles
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#ifndef __MACH_GPIO_H__
+#define __MACH_GPIO_H__
+
+#ifdef __KERNEL__
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+
+#include <asm-generic/gpio.h>
+
+int __init picoxcell_gpio_init(const char * const armgpio_pins[],
+			       int nr_armgpio, int armgpio_base,
+			       const char * const sdgpio_pins[],
+			       int nr_sdgpio, int sdgpio_base);
+
+extern struct irq_chip armgpio_irqchip;
+
+#endif /* __KERNEL__ */
+
+enum {
+	PC3X2_GPIO_PIN_ARM_0,
+	PC3X2_GPIO_PIN_ARM_1,
+	PC3X2_GPIO_PIN_ARM_2,
+	PC3X2_GPIO_PIN_ARM_3,
+	PC3X2_GPIO_PIN_ARM_4,
+	PC3X2_GPIO_PIN_ARM_5,
+	PC3X2_GPIO_PIN_ARM_6,
+	PC3X2_GPIO_PIN_ARM_7,
+	PC3X2_GPIO_PIN_ARM_8,
+	PC3X2_GPIO_PIN_ARM_9,
+	PC3X2_GPIO_PIN_ARM_10,
+	PC3X2_GPIO_PIN_ARM_11,
+	PC3X2_GPIO_PIN_ARM_12,
+	PC3X2_GPIO_PIN_ARM_13,
+	PC3X2_GPIO_PIN_ARM_14,
+	PC3X2_GPIO_PIN_ARM_15,
+	PC3X2_GPIO_PIN_SDGPIO_0,
+	PC3X2_GPIO_PIN_SDGPIO_1,
+	PC3X2_GPIO_PIN_SDGPIO_2,
+	PC3X2_GPIO_PIN_SDGPIO_3,
+	PC3X2_GPIO_PIN_SDGPIO_4,
+	PC3X2_GPIO_PIN_SDGPIO_5,
+	PC3X2_GPIO_PIN_SDGPIO_6,
+	PC3X2_GPIO_PIN_SDGPIO_7,
+	PC3X2_GPIO_PIN_SDGPIO_8,
+	PC3X2_GPIO_PIN_SDGPIO_9,
+	PC3X2_GPIO_PIN_SDGPIO_10,
+	PC3X2_GPIO_PIN_SDGPIO_11,
+	PC3X2_GPIO_PIN_SDGPIO_12,
+	PC3X2_GPIO_PIN_SDGPIO_13,
+	PC3X2_GPIO_PIN_SDGPIO_14,
+	PC3X2_GPIO_PIN_SDGPIO_15,
+};
+
+enum {
+	PC3X3_GPIO_PIN_ARM_0,
+	PC3X3_GPIO_PIN_ARM_1,
+	PC3X3_GPIO_PIN_ARM_2,
+	PC3X3_GPIO_PIN_ARM_3,
+	PC3X3_GPIO_PIN_ARM_4,
+	PC3X3_GPIO_PIN_ARM_5,
+	PC3X3_GPIO_PIN_ARM_6,
+	PC3X3_GPIO_PIN_ARM_7,
+	PC3X3_GPIO_PIN_ARM_8,
+	PC3X3_GPIO_PIN_ARM_9,
+	PC3X3_GPIO_PIN_ARM_10,
+	PC3X3_GPIO_PIN_ARM_11,
+	PC3X3_GPIO_PIN_ARM_12,
+	PC3X3_GPIO_PIN_ARM_13,
+	PC3X3_GPIO_PIN_ARM_14,
+	PC3X3_GPIO_PIN_ARM_15,
+	PC3X3_GPIO_PIN_ARM_16,
+	PC3X3_GPIO_PIN_ARM_17,
+	PC3X3_GPIO_PIN_ARM_18,
+	PC3X3_GPIO_PIN_ARM_19,
+	PC3X3_GPIO_PIN_ARM_20,
+	PC3X3_GPIO_PIN_ARM_21,
+	PC3X3_GPIO_PIN_ARM_22,
+	PC3X3_GPIO_PIN_ARM_23,
+	PC3X3_GPIO_PIN_ARM_24,
+	PC3X3_GPIO_PIN_ARM_25,
+	PC3X3_GPIO_PIN_ARM_26,
+	PC3X3_GPIO_PIN_ARM_27,
+	PC3X3_GPIO_PIN_ARM_28,
+	PC3X3_GPIO_PIN_ARM_29,
+	PC3X3_GPIO_PIN_ARM_30,
+	PC3X3_GPIO_PIN_ARM_31,
+	PC3X3_GPIO_PIN_ARM_32,
+	PC3X3_GPIO_PIN_ARM_33,
+	PC3X3_GPIO_PIN_ARM_34,
+	PC3X3_GPIO_PIN_ARM_35,
+	PC3X3_GPIO_PIN_ARM_36,
+	PC3X3_GPIO_PIN_ARM_37,
+	PC3X3_GPIO_PIN_ARM_38,
+	PC3X3_GPIO_PIN_ARM_39,
+	PC3X3_GPIO_PIN_ARM_40,
+	PC3X3_GPIO_PIN_ARM_41,
+	PC3X3_GPIO_PIN_ARM_42,
+	PC3X3_GPIO_PIN_ARM_43,
+	PC3X3_GPIO_PIN_ARM_44,
+	PC3X3_GPIO_PIN_ARM_45,
+	PC3X3_GPIO_PIN_ARM_46,
+	PC3X3_GPIO_PIN_ARM_47,
+	PC3X3_GPIO_PIN_ARM_48,
+	PC3X3_GPIO_PIN_ARM_49,
+	PC3X3_GPIO_PIN_ARM_50,
+	PC3X3_GPIO_PIN_ARM_51,
+	PC3X3_GPIO_PIN_ARM_52,
+	PC3X3_GPIO_PIN_ARM_53,
+	PC3X3_GPIO_PIN_SDGPIO_0,
+	PC3X3_GPIO_PIN_SDGPIO_1,
+	PC3X3_GPIO_PIN_SDGPIO_2,
+	PC3X3_GPIO_PIN_SDGPIO_3,
+	PC3X3_GPIO_PIN_SDGPIO_4,
+	PC3X3_GPIO_PIN_SDGPIO_5,
+	PC3X3_GPIO_PIN_SDGPIO_6,
+	PC3X3_GPIO_PIN_SDGPIO_7,
+	PC3X3_GPIO_PIN_SDGPIO_8,
+	PC3X3_GPIO_PIN_SDGPIO_9,
+	PC3X3_GPIO_PIN_SDGPIO_10,
+	PC3X3_GPIO_PIN_SDGPIO_11,
+	PC3X3_GPIO_PIN_SDGPIO_12,
+	PC3X3_GPIO_PIN_SDGPIO_13,
+	PC3X3_GPIO_PIN_SDGPIO_14,
+	PC3X3_GPIO_PIN_SDGPIO_15,
+	PC3X3_GPIO_PIN_SDGPIO_16,
+	PC3X3_GPIO_PIN_SDGPIO_17,
+	PC3X3_GPIO_PIN_SDGPIO_18,
+	PC3X3_GPIO_PIN_SDGPIO_19,
+	PC3X3_GPIO_PIN_SDGPIO_20,
+	PC3X3_GPIO_PIN_SDGPIO_21,
+	PC3X3_GPIO_PIN_SDGPIO_22,
+	PC3X3_GPIO_PIN_SDGPIO_23,
+};
+
+#ifdef __KERNEL__
+
+static inline int gpio_get_value(unsigned gpio)
+{
+	return __gpio_get_value(gpio);
+}
+
+static inline void gpio_set_value(unsigned gpio, int value)
+{
+	__gpio_set_value(gpio, value);
+}
+
+static inline int gpio_cansleep(unsigned gpio)
+{
+	return 0;
+}
+
+static inline int gpio_to_irq(unsigned gpio)
+{
+	return __gpio_to_irq(gpio);
+}
+
+static inline int irq_to_gpio(unsigned irq)
+{
+	if (irq > IRQ_GPIO7)
+		return -EINVAL;
+	return irq - IRQ_GPIO0;
+}
+
+extern int picoxcell_gpio_configure_dac(unsigned gpio, u8 converter_size,
+					u16 analogue_rate);
+
+#endif /* __KERNEL__ */
+
+#endif /* __MACH_GPIO_H__ */
diff --git a/arch/arm/mach-picoxcell/picoxcell_core.c b/arch/arm/mach-picoxcell/picoxcell_core.c
index 12107d5..a8f6056 100644
--- a/arch/arm/mach-picoxcell/picoxcell_core.c
+++ b/arch/arm/mach-picoxcell/picoxcell_core.c
@@ -8,6 +8,7 @@
  * All enquiries to support at picochip.com
  */
 #include <linux/debugfs.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -260,6 +261,10 @@ void __init picoxcell_core_init(void)
 	/* Initialise the pin muxing and gpio infrastructure. */
 	picoxcell_muxing_init(soc);
 
+	picoxcell_gpio_init(soc->armgpio_pins, soc->nr_armgpio,
+			    soc->armgpio_base, soc->sdgpio_pins,
+			    soc->nr_sdgpio, soc->sdgpio_base);
+
 	/* Add handlers for the AXI bus snooping. */
 	picoxcell_axi_bus_error_init();
 }
-- 
1.7.2.3
