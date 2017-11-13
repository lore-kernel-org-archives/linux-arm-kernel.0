From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 13 Nov 2017 01:25:22 +0000
Subject: [RFC PATCH 2/3] pinctrl: sunxi: introduce DT-based generic driver
In-Reply-To: <20171113012523.2328-1-andre.przywara@arm.com>
References: <20171113012523.2328-1-andre.przywara@arm.com>
Message-ID: <20171113012523.2328-3-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver (shim) allows to fully describe an Allwinner pin controller
and its GPIO ports in device tree nodes.
It will read some newly introduced properties to build a table
describing the pins and their routing. This table matches those that we
have hardcoded for various SoCs in the kernel so far.
After this table has been created, it will be handed over to the actual
pinctrl driver, which registers it with the pinctrl subsystem.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/pinctrl/sunxi/Makefile           |   1 +
 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c | 412 +++++++++++++++++++++++++++++++
 2 files changed, 413 insertions(+)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c

diff --git a/drivers/pinctrl/sunxi/Makefile b/drivers/pinctrl/sunxi/Makefile
index 12a752e836ef..06f9d924b9cf 100644
--- a/drivers/pinctrl/sunxi/Makefile
+++ b/drivers/pinctrl/sunxi/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_PINCTRL_SUN8I_V3S)		+= pinctrl-sun8i-v3s.o
 obj-$(CONFIG_PINCTRL_SUN50I_H5)		+= pinctrl-sun50i-h5.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80)		+= pinctrl-sun9i-a80.o
 obj-$(CONFIG_PINCTRL_SUN9I_A80_R)	+= pinctrl-sun9i-a80-r.o
+obj-y					+= pinctrl-sunxi-dt.o
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
new file mode 100644
index 000000000000..46a7bfbefee1
--- /dev/null
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
@@ -0,0 +1,412 @@
+/*
+ * Generic Allwinner pinctrl driver DT shim
+ * Read all the information required by the pinctrl subsystem from the DT
+ * and build a table describing each pin. Hand this table over to the actual
+ * pinctrl driver.
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ * Author: Andre Przywara <andre.przywara@arm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/export.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "pinctrl-sunxi.h"
+
+#define INVALID_MUX	0xff
+
+/*
+ * Return the "index"th element from the "pinmux" property. If the property
+ * does not hold enough entries, return the last one instead.
+ * For almost every group the pinmux value is actually the same, so this
+ * allows to just list it once in the property.
+ */
+static u8 sunxi_pinctrl_dt_read_pinmux(const struct device_node *node,
+				       int index)
+{
+	int ret, num_elems;
+	u32 value;
+
+	ret = of_property_read_u32_index(node, "pinmux", index, &value);
+	if (!ret)
+		return value;
+	if (ret != -EOVERFLOW)
+		return INVALID_MUX;
+
+	num_elems = of_property_count_u32_elems(node, "pinmux");
+	if (num_elems <= 0)
+		return INVALID_MUX;
+
+	ret = of_property_read_u32_index(node, "pinmux", num_elems - 1, &value);
+	if (ret)
+		return INVALID_MUX;
+
+	return value;
+}
+
+/*
+ * Allocate a table with a sunxi_desc_pin structure for every pin needed.
+ * Fills in the respective pin names ("PA0") and their pin numbers.
+ * Returns the number of pins allocated.
+ */
+static int build_pins_table(struct device *dev, struct device_node *node,
+			    int port_base, struct sunxi_desc_pin **table)
+{
+	struct sunxi_desc_pin *pins, *cur_pin;
+	struct property *prop;
+	const __be32 *cur;
+	u32 pin_count;
+	int name_size = 0, npins = 0, nports = 0;
+	char *pin_names, *cur_name;
+	int i, j;
+
+	/*
+	 * Find the total number of pins.
+	 * Also work out how much memory we need to store all the pin names.
+	 */
+	of_property_for_each_u32(node, "allwinner,gpio-pins", prop,
+				 cur, pin_count) {
+		npins += pin_count;
+		if (pin_count < 10) {
+			name_size += pin_count * 4; /* 4 bytes for "PXy\0" */
+		} else {
+			/* 4 bytes for each "PXy\0" */
+			name_size += 10 * 4;
+
+			/* 5 bytes for each "PXyy\0" */
+			name_size += (pin_count - 10) * 5;
+		}
+		nports++;
+	}
+
+	if (!nports || !npins) {
+		dev_warn(dev, "%s: no pins defined\n", of_node_full_name(node));
+		return -EINVAL;
+	}
+
+	pins = devm_kzalloc(dev, npins * sizeof(*pins), GFP_KERNEL);
+	if (!pins)
+		return -ENOMEM;
+
+	/* Allocate memory to store the name for every pin. */
+	pin_names = devm_kmalloc(dev, name_size, GFP_KERNEL);
+	if (!pin_names)
+		return -ENOMEM;
+
+	/* Fill the pins array with the name and the number for each pin. */
+	cur_name = pin_names;
+	cur_pin = pins;
+	for (i = 0; i < nports; i++) {
+		of_property_read_u32_index(node, "allwinner,gpio-pins", i,
+					   &pin_count);
+		for (j = 0; j < pin_count; j++, cur_pin++) {
+			int nchars = sprintf(cur_name, "P%c%d",
+					     port_base + 'A' + i, j);
+
+			cur_pin->pin.number = (port_base + i) * 32 + j;
+			cur_pin->pin.name = cur_name;
+			cur_name += nchars + 1;
+		}
+	}
+
+	*table = pins;
+
+	return npins;
+}
+
+/* Check whether this pin can trigger interrupts. */
+static bool get_irq_pin(struct device_node *pnode,
+			struct pinctrl_pin_desc *pin,
+			u8 *irq_port, u8 *irq_pin, u8 *muxval)
+{
+	u32 gpio_firstpin, length, reg;
+	int i;
+
+	for (i = 0; ; i++) {
+		if (of_property_read_u32_index(pnode, "allwinner,irq-pin-map",
+					       i * 6 + 2, &reg))
+			break;
+
+		if (reg != pin->number / 32)
+			continue;
+
+		of_property_read_u32_index(pnode, "allwinner,irq-pin-map",
+					   i * 6 + 3, &gpio_firstpin);
+		of_property_read_u32_index(pnode, "allwinner,irq-pin-map",
+					   i * 6 + 5, &length);
+		if ((gpio_firstpin > pin->number % 32) ||
+		    (gpio_firstpin + length <= pin->number % 32))
+			continue;
+
+		if (irq_port) {
+			of_property_read_u32_index(pnode,
+						   "allwinner,irq-pin-map",
+						   i * 6 + 0, &reg);
+			*irq_port = reg;
+		}
+		if (irq_pin) {
+			of_property_read_u32_index(pnode,
+						   "allwinner,irq-pin-map",
+						   i * 6 + 1, &reg);
+			*irq_pin = reg + (pin->number % 32) - gpio_firstpin;
+		}
+		if (muxval) {
+			of_property_read_u32_index(pnode,
+						   "allwinner,irq-pin-map",
+						   i * 6 + 4, &reg);
+			*muxval = reg;
+		}
+
+
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * Work out the number of functions each pin has. Provide memory to hold
+ * the per-function information and assign it to the pin table.
+ * Fill in the GPIO in/out functions every pin has, also add an "irq"
+ * function for those pins in IRQ-capable ports.
+ */
+static int prepare_function_table(struct device *dev, struct device_node *pnode,
+				  struct sunxi_desc_pin *pins, int npins)
+{
+	struct device_node *node;
+	struct property *prop;
+	struct sunxi_desc_function *func;
+	int num_funcs, i;
+
+	/*
+	 * We need at least three functions per pin:
+	 * - one for GPIO in
+	 * - one for GPIO out
+	 * - one for the sentinel signalling the end of the list
+	 */
+	num_funcs = 3 * npins;
+
+	/* Add a function for each pin in a port supporting interrupts. */
+	for (i = 0; i < npins; i++) {
+		if (get_irq_pin(pnode, &pins[i].pin, NULL, NULL, NULL)) {
+			pins[i].variant++;
+			num_funcs++;
+		}
+	}
+
+	/*
+	 * Go over each pin group (every child of the pinctrl DT node) and
+	 * add the number of special functions each pins has. Also update the
+	 * total number of functions required.
+	 * We might slightly overshoot here in case of double definitions.
+	 */
+	for_each_child_of_node(pnode, node) {
+		const char *name;
+
+		of_property_for_each_string(node, "pins", prop, name) {
+			for (i = 0; i < npins; i++) {
+				if (strcmp(pins[i].pin.name, name))
+					continue;
+
+				pins[i].variant++;
+				num_funcs++;
+				break;
+			}
+		}
+	}
+
+	/*
+	 * Allocate the memory needed for the functions in one table.
+	 * We later use pointers into this table to mark each pin.
+	 */
+	func = devm_kzalloc(dev, num_funcs * sizeof(*func), GFP_KERNEL);
+	if (!func)
+		return -ENOMEM;
+
+	/* Assign the functions memory and fill in GPIOs, IRQ and a sentinel. */
+	for (i = 0; i < npins; i++) {
+		int lastfunc = pins[i].variant + 1;
+
+		func[0].name = "gpio_in";
+		func[0].muxval = 0;
+		func[1].name = "gpio_out";
+		func[1].muxval = 1;
+
+		if (get_irq_pin(pnode, &pins[i].pin,
+				&func[lastfunc].irqbank,
+				&func[lastfunc].irqnum,
+				&func[lastfunc].muxval))
+			func[lastfunc].name = "irq";
+
+		pins[i].functions = func;
+
+		/* Skip over the other needed functions and the sentinel. */
+		func += pins[i].variant + 3;
+
+		/*
+		 * Reset the value for filling in the remaining functions
+		 * behind the GPIOs later.
+		 */
+		pins[i].variant = 2;
+	}
+
+	return 0;
+}
+
+/*
+ * Iterate over all pins in this group and add the function name and its
+ * mux value to the respective pin.
+ */
+static void fill_pin_function(struct device *dev, struct device_node *node,
+			      struct sunxi_desc_pin *pins, int npins)
+{
+	const char *name, *funcname;
+	struct sunxi_desc_function *func;
+	struct property *prop;
+	int pin, i;
+	u8 muxval;
+
+	if (of_property_read_string(node, "function", &funcname)) {
+		dev_warn(dev, "missing \"function\" property\n");
+		return;
+	}
+
+	of_property_for_each_string(node, "pins", prop, name) {
+		/* Find the index of this pin in our table. */
+		for (pin = 0; pin < npins; pin++)
+			if (!strcmp(pins[pin].pin.name, name))
+				break;
+		if (pin == npins) {
+			dev_warn(dev, "%s: cannot find pin %s\n",
+				 of_node_full_name(node), name);
+			continue;
+		}
+
+		/* Read the associated mux value. */
+		muxval = sunxi_pinctrl_dt_read_pinmux(node, pin);
+		if (muxval == INVALID_MUX) {
+			dev_warn(dev, "%s: invalid mux value for pin %s\n",
+				 of_node_full_name(node), name);
+			continue;
+		}
+
+		/*
+		 * Check for double definitions by comparing the to-be-added
+		 * function with already assigned ones.
+		 * Ignore identical pairs (function name and mux value the
+		 * same), but warn about conflicting assignments.
+		 */
+		for (i = 2; i < pins[pin].variant; i++) {
+			func = &pins[pin].functions[i];
+
+			/* Skip over totally unrelated functions. */
+			if (strcmp(func->name, funcname) &&
+			    func->muxval != muxval)
+				continue;
+
+			/* Ignore (but skip below) any identical functions. */
+			if (!strcmp(func->name, funcname) &&
+			    muxval == func->muxval)
+				break;
+
+			dev_warn(dev,
+				 "pin %s: function %s redefined to mux %d\n",
+				 name, funcname, muxval);
+			break;
+		}
+
+		/* Skip any pins with that function already assigned. */
+		if (i < pins[pin].variant)
+			continue;
+
+		/* Assign function and muxval to the next free slot. */
+		func = &pins[pin].functions[pins[pin].variant];
+		func->muxval = muxval;
+		func->name = funcname;
+
+		pins[pin].variant++;
+	}
+}
+
+/* Iterate over all IRQ pin maps and find out the number of distinct ports. */
+static int count_nr_irq_banks(struct device_node *node)
+{
+	u32 port_mask = 0, irq_port;
+	int i = 0;
+
+	for (i = 0;
+	     !of_property_read_u32_index(node, "allwinner,irq-pin-map",
+					 i * 6 + 0, &irq_port);
+	     i++)
+		port_mask |= BIT(irq_port);
+
+	return hweight32(port_mask);
+}
+
+static int sunxi_generic_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *pnode = pdev->dev.of_node, *node;
+	struct sunxi_pinctrl_desc *desc;
+	struct sunxi_desc_pin *pins;
+	u32 port_base = 0;
+	int npins, ret, i;
+
+	of_property_read_u32(pnode, "allwinner,port-base", &port_base);
+	npins = build_pins_table(&pdev->dev, pnode, port_base, &pins);
+	if (npins < 0)
+		return npins;
+
+	ret = prepare_function_table(&pdev->dev, pnode, pins, npins);
+	if (ret)
+		return ret;
+
+	/*
+	 * Now iterate over all groups and add the respective function name
+	 * and mux values to each pin listed within.
+	 */
+	for_each_child_of_node(pnode, node)
+		fill_pin_function(&pdev->dev, node, pins, npins);
+
+	/* Clear the temporary storage. */
+	for (i = 0; i < npins; i++)
+		pins[i].variant = 0;
+
+	desc = devm_kzalloc(&pdev->dev, sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		return -ENOMEM;
+
+	desc->pins = pins;
+	desc->npins = npins;
+	desc->pin_base = port_base * 32;
+
+	desc->irq_banks = count_nr_irq_banks(pnode);
+	of_property_read_u32(pnode, "allwinner,irq-bank-base",
+			     &desc->irq_bank_base);
+	if (of_property_read_bool(pnode, "allwinner,irq_read_needs_mux"))
+		desc->irq_read_needs_mux = true;
+
+	return sunxi_pinctrl_init_with_variant(pdev, desc, 0);
+}
+
+static const struct of_device_id sunxi_pinctrl_match[] = {
+	{ .compatible = "allwinner,sunxi-pinctrl", },
+	{ },
+};
+
+static struct platform_driver sunxi_pinctrl_driver = {
+	.probe  = sunxi_generic_pinctrl_probe,
+	.driver = {
+		.name           = "sunxi-pinctrl",
+		.of_match_table = sunxi_pinctrl_match,
+	},
+};
+builtin_platform_driver(sunxi_pinctrl_driver);
-- 
2.14.1
