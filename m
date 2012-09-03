From: pawel.moll@arm.com (Pawel Moll)
Date: Mon,  3 Sep 2012 17:25:22 +0100
Subject: [PATCH 02/11] misc: Versatile Express config bus infrastructure
In-Reply-To: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1346689531-7212-3-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Versatile Express platform has an elaborated configuration system,
consisting of microcontrollers residing on the mother- and
daughterboards known as Motherboard/Daughterboard Configuration
Controller (MCC and DCC). The controllers are responsible for
the platform initialization (reset generation, flash programming,
FPGA bitfiles loading etc.) but also control clock generators,
voltage regulators, gather environmental data like temperature,
power consumption etc. Even the video output switch (FPGA) is
controlled that way.

Those devices are _not_ visible in the main address space and
the usual communication channel uses some kind of a bridge in
the peripheral block sending commands (requests) to the
controllers and receiving responses. It can take up to
500 microseconds for a transaction to be completed, therefore
it is important to provide a non-blocking interface to it.

This patch adds an abstraction of this infrastructure in a
form of "config bus".

The devices (and their functions) are addressed by: site
number (motherboard is 0, daughterboard sites 1 and 2),
position in the boards stack (eg. logic tiles are often
stacked on top of each other), controller number (boards can
have more then one controller) and the device number (eg.
oscillators 1 to 5, temperature sensors 1 to 3 etc.).

Function number (eg. oscillator is 1, temperature sensor is 4)
is common across all system and is used to bind devices with
respective drivers. Static devices can use defined constants,
devices instantiated from a DT should use appropriate compatible
values that will be translated into numbers during device
creation.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/arm/vexpress.txt |  154 ++++-
 drivers/misc/Kconfig                               |    1 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/vexpress/Kconfig                      |    5 +
 drivers/misc/vexpress/Makefile                     |    1 +
 drivers/misc/vexpress/config_bus.c                 |  596 ++++++++++++++++++++
 include/linux/vexpress.h                           |  120 ++++
 7 files changed, 877 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/vexpress/Kconfig
 create mode 100644 drivers/misc/vexpress/Makefile
 create mode 100644 drivers/misc/vexpress/config_bus.c
 create mode 100644 include/linux/vexpress.h

diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
index ec8b50c..8f69b6b 100644
--- a/Documentation/devicetree/bindings/arm/vexpress.txt
+++ b/Documentation/devicetree/bindings/arm/vexpress.txt
@@ -11,6 +11,10 @@ the motherboard file using a /include/ directive. As the motherboard
 can be initialized in one of two different configurations ("memory
 maps"), care must be taken to include the correct one.
 
+
+Root node
+---------
+
 Required properties in the root node:
 - compatible value:
 	compatible = "arm,vexpress,<model>", "arm,vexpress";
@@ -45,6 +49,10 @@ Optional properties in the root node:
   - Coretile Express A9x4 (V2P-CA9) HBI-0225:
 	arm,hbi = <0x225>;
 
+
+CPU nodes
+---------
+
 Top-level standard "cpus" node is required. It must contain a node
 with device_type = "cpu" property for every available core, eg.:
 
@@ -59,6 +67,10 @@ with device_type = "cpu" property for every available core, eg.:
 		};
 	};
 
+
+Motherboard node
+----------------
+
 The motherboard description file provides a single "motherboard" node
 using 2 address cells corresponding to the Static Memory Bus used
 between the motherboard and the tile. The first cell defines the Chip
@@ -96,7 +108,132 @@ The tile description must define "ranges", "interrupt-map-mask" and
 "interrupt-map" properties to translate the motherboard's address
 and interrupt space into one used by the tile's processor.
 
-Abbreviated example:
+
+Configuration bus
+-----------------
+
+Versatile Express platform has an elaborated configuration system,
+consisting of microcontrollers residing on the mother- and
+daughterboards known as Motherboard/Daughterboard Configuration
+Controller (MCC and DCC). The controllers are responsible for
+the platform initialization (reset generation, flash programming,
+FPGA bitfiles loading etc.) but also control clock generators,
+voltage regulators, gather environmental data like temperature,
+power consumption etc. Even the video output switch (FPGA) is
+controlled that way.
+
+Those devices are _not_ visible in the main address space and
+are addressed by: site number (motherboard is 0, daughterboard
+sites 1 and 2), position in the boards stack (eg. logic tiles
+are often stacked on top of each other), controller number
+(boards can have more then one controller) and the device number
+(eg.  oscillators 1 to 5, temperature sensors 1 to 3 etc.).
+
+They should be by a separate node of the device tree, called
+"dcc" or "mcc", with the following required properties:
+- site number:
+	arm,vexpress,site = <number>;
+  where 0 means motherboard, 1 or 2 are daugtherboard sites,
+  0xff means "master" site (site containing main CPU tile)
+- address and size cells for the children
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+Optional properties:
+- position and/or controller number:
+	arm,vexpress,position = <number>;
+	arm,vexpress,dcc = <number>;
+  if not defined, the numbers default to zero.
+
+The controller's node children define functions of all
+devices available through the controller. The compatible
+value defines the function, the reg value defines the
+device number.
+
+- clock generators:
+	osc@<device> {
+		compatible = "arm,vexpress-config,osc";
+		reg = <device>;
+		freq-range = <freq_min freq_max>;
+		#clock-cells = <0>;
+		clock-output-names = "<name>";
+	};
+
+- voltage regulators:
+	volt@<device> {
+		compatible = "arm,vexpress-config,volt";
+		reg = <device>;
+		regulator-name = "<name>";
+		regulator-always-on;
+	};
+
+- current meters:
+	amp@<device> {
+		compatible = "arm,vexpress-config,amp";
+		reg = <device>;
+		label = "<name>";
+	};
+
+- temperature sensors:
+	temp@<device> {
+		compatible = "arm,vexpress-config,temp";
+		reg = <device>;
+		label = "<name>";
+	};
+
+- reset generator:
+	reset@<device> {
+		compatible = "arm,vexpress-config,reset";
+		reg = <device>;
+	};
+
+- SCC registers access:
+	scc@<device> {
+		compatible = "arm,vexpress-config,scc";
+		reg = <device>;
+	};
+
+- DVI muxing (switching) FPGAs:
+	muxfpga@<device> {
+		compatible = "arm,vexpress-config,muxfpga";
+		reg = <device>;
+	};
+
+- power supply control:
+	shutdown@<device> {
+		compatible = "arm,vexpress-config,shutdown";
+		reg = <0>;
+	};
+	reboot@<device> {
+		compatible = "arm,vexpress-config,reboot";
+		reg = <device>;
+	};
+
+- DVI formatter mode control:
+	dvimode@<device> {
+		compatible = "arm,vexpress-config,dvimode";
+		reg = <device>;
+	};
+
+- instant power monitors:
+	power@<device> {
+		compatible = "arm,vexpress-config,power";
+		reg = <device>;
+		label = "<name>";
+	};
+
+- continuous energy consumption monitors:
+	energy@<device> {
+		compatible = "arm,vexpress-config,energy";
+		reg = <device>;
+		label = "<name>";
+	};
+  Note: Amount of the consumed energy is available as a 64-bit
+  value, in two consecutive registers.
+
+
+Example of a VE tile description (simplified)
+---------------------------------------------
 
 /dts-v1/;
 
@@ -141,6 +278,21 @@ Abbreviated example:
 		/* Active high IRQ 0 is connected to GIC's SPI0 */
 		interrupt-map = <0 0 0 &gic 0 0 4>;
 	};
+
+	dcc at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <0>;
+		arm,vexpress,site = <0xff>; /* Master site */
+
+		osc at 0 {
+			compatible = "arm,vexpress-config,osc";
+			reg = <0>;
+			freq-range = <50000000 100000000>;
+			#clock-cells = <1>;
+			clock-output-names = "oscclk0";
+		};
+	};
 };
 
 /include/ "vexpress-v2m-rs1.dtsi"
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 98a442d..2a9434a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -517,4 +517,5 @@ source "drivers/misc/lis3lv02d/Kconfig"
 source "drivers/misc/carma/Kconfig"
 source "drivers/misc/altera-stapl/Kconfig"
 source "drivers/misc/mei/Kconfig"
+source "drivers/misc/vexpress/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b88df7a..49964fd 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -50,3 +50,4 @@ obj-y				+= carma/
 obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
 obj-$(CONFIG_INTEL_MEI)		+= mei/
+obj-y				+= vexpress/
diff --git a/drivers/misc/vexpress/Kconfig b/drivers/misc/vexpress/Kconfig
new file mode 100644
index 0000000..887f103
--- /dev/null
+++ b/drivers/misc/vexpress/Kconfig
@@ -0,0 +1,5 @@
+config VEXPRESS_CONFIG_BUS
+	bool
+	help
+	  Infrastructure for the ARM Ltd. Versatile Expres platform
+	  configuration bus.
diff --git a/drivers/misc/vexpress/Makefile b/drivers/misc/vexpress/Makefile
new file mode 100644
index 0000000..5b1e8fc
--- /dev/null
+++ b/drivers/misc/vexpress/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_VEXPRESS_CONFIG_BUS) += config_bus.o
diff --git a/drivers/misc/vexpress/config_bus.c b/drivers/misc/vexpress/config_bus.c
new file mode 100644
index 0000000..3609987
--- /dev/null
+++ b/drivers/misc/vexpress/config_bus.c
@@ -0,0 +1,596 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#define pr_fmt(fmt) "vexpress-config: " fmt
+
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/vexpress.h>
+
+
+#define ADDR_FMT "%u.%x:%x:%x:%x"
+
+#define ADDR_ARGS(_ptr) \
+		_ptr->func, _ptr->addr.site, _ptr->addr.position, \
+		_ptr->addr.dcc, _ptr->addr.device
+
+#define ADDR_TO_U64(addr) \
+		(((u64)(addr).site << 32) | ((addr).position << 24) | \
+		((addr).dcc << 16) | (addr).device)
+
+static bool vexpress_config_early = true;
+static DEFINE_MUTEX(vexpress_config_early_mutex);
+static LIST_HEAD(vexpress_config_early_drivers);
+static LIST_HEAD(vexpress_config_early_devices);
+
+static int vexpress_config_match(struct device *dev, struct device_driver *drv)
+{
+	struct vexpress_config_device *vecdev = to_vexpress_config_device(dev);
+	struct vexpress_config_driver *vecdrv = to_vexpress_config_driver(drv);
+
+	if (vecdrv->funcs) {
+		const unsigned *func = vecdrv->funcs;
+
+		while (*func) {
+			if (*func == vecdev->func)
+				return 1;
+			func++;
+		}
+	}
+
+	return 0;
+}
+
+static struct device vexpress_config_bus = {
+	.init_name = "vexpress-config",
+};
+
+struct bus_type vexpress_config_bus_type = {
+	.name = "vexpress-config",
+	.match = vexpress_config_match,
+};
+
+static int __init vexpress_config_bus_init(void)
+{
+	int err;
+	struct vexpress_config_driver *vecdrv, *__vecdrv;
+	struct vexpress_config_device *vecdev, *__vecdev;
+
+	err = device_register(&vexpress_config_bus);
+	if (err)
+		return err;
+
+	err = bus_register(&vexpress_config_bus_type);
+	if (err) {
+		device_unregister(&vexpress_config_bus);
+		return err;
+	}
+
+	vexpress_config_early = false;
+
+	list_for_each_entry_safe(vecdrv, __vecdrv,
+			&vexpress_config_early_drivers, early) {
+		err = vexpress_config_driver_register(vecdrv);
+		if (err)
+			pr_err("Failed to re-register early driver '%s'! (%d)\n",
+					vecdrv->driver.name, err);
+		list_del(&vecdrv->early);
+	}
+
+	list_for_each_entry_safe(vecdev, __vecdev,
+			&vexpress_config_early_devices, early) {
+		err = vexpress_config_device_register(vecdev);
+		if (err)
+			pr_err("Failed to re-register early device '%s."
+					ADDR_FMT "'! (%d)\n", vecdev->name,
+					ADDR_ARGS(vecdev), err);
+		list_del(&vecdev->early);
+	}
+
+	return 0;
+}
+arch_initcall(vexpress_config_bus_init);
+
+static void vexpress_config_early_probe(struct vexpress_config_device *vecdev,
+		struct vexpress_config_driver *vecdrv)
+{
+	int err;
+
+	if (!vecdrv->probe) {
+		pr_debug("Skipping early probing of '%s." ADDR_FMT "'\n",
+				vecdev->name, ADDR_ARGS(vecdev));
+		return;
+	}
+
+	err = vecdrv->probe(vecdev);
+	if (err) {
+		pr_err("Failed to probe '%s." ADDR_FMT "! (%d)\n",
+				vecdev->name, ADDR_ARGS(vecdev), err);
+		return;
+	}
+
+	vecdev->status |= VEXPRESS_CONFIG_DEVICE_PROBED_EARLY;
+}
+
+static void vexpress_config_early_bind(void)
+{
+	struct vexpress_config_driver *vecdrv;
+	struct vexpress_config_device *vecdev;
+
+	list_for_each_entry(vecdev, &vexpress_config_early_devices, early)
+		list_for_each_entry(vecdrv, &vexpress_config_early_drivers,
+				early)
+			if (vexpress_config_match(&vecdev->dev,
+					&vecdrv->driver))
+				vexpress_config_early_probe(vecdev, vecdrv);
+}
+
+
+#define VEXPRESS_CONFIG_MAX_BRIDGES 2
+
+struct vexpress_config_bridge {
+	struct vexpress_config_bridge_info *info;
+	struct list_head transactions;
+	spinlock_t transactions_lock;
+	bool transaction_pending;
+	struct list_head list;
+} vexpress_config_bridges[VEXPRESS_CONFIG_MAX_BRIDGES];
+
+DECLARE_BITMAP(vexpress_config_bridges_map,
+		ARRAY_SIZE(vexpress_config_bridges));
+static DEFINE_SPINLOCK(vexpress_config_bridges_lock);
+
+static int vexpress_config_bridge_find(struct device *dev, void *data)
+{
+	struct vexpress_config_device *vecdev = to_vexpress_config_device(dev);
+	u64 dev_addr = ADDR_TO_U64(vecdev->addr);
+	unsigned long best_weight = 65;
+	int i;
+
+	pr_debug("Device '%s." ADDR_FMT "' (%llx)\n",
+			vecdev->name, ADDR_ARGS(vecdev), dev_addr);
+
+	vecdev->bridge = NULL;
+
+	/* Find the best, that is the most specific, bridge */
+	for (i = 0; i < ARRAY_SIZE(vexpress_config_bridges); i++) {
+		struct vexpress_config_bridge *bridge;
+		u64 br_addr, br_mask;
+		unsigned long weight;
+
+		if (!test_bit(i, vexpress_config_bridges_map))
+			continue;
+		bridge = &vexpress_config_bridges[i];
+
+		br_addr = ADDR_TO_U64(bridge->info->addr);
+		br_mask = ADDR_TO_U64(bridge->info->mask);
+		weight = br_mask ? hweight64(br_mask) : 64;
+
+		pr_debug("Bridge '%s' (%llx & %llx), weight %lu\n",
+				bridge->info->name, br_addr, br_mask, weight);
+
+		if ((dev_addr & br_mask) == br_addr && weight < best_weight) {
+			pr_debug("Bridge '%s' best so far\n",
+					bridge->info->name);
+			vecdev->bridge = bridge;
+			best_weight = weight;
+		}
+	}
+
+	return 0;
+}
+
+static void vexpress_config_bridges_assign(void)
+{
+	if (vexpress_config_early) {
+		struct vexpress_config_device *vecdev;
+
+		list_for_each_entry(vecdev, &vexpress_config_early_devices,
+				early)
+			vexpress_config_bridge_find(&vecdev->dev, NULL);
+	} else {
+		bus_for_each_dev(&vexpress_config_bus_type, NULL, NULL,
+				vexpress_config_bridge_find);
+	}
+}
+
+struct vexpress_config_bridge *vexpress_config_bridge_register(
+		struct vexpress_config_bridge_info *info)
+{
+	struct vexpress_config_bridge *bridge;
+	int i;
+
+	pr_debug("Registering bridge '%s'\n", info->name);
+
+	spin_lock(&vexpress_config_bridges_lock);
+
+	i = find_first_zero_bit(vexpress_config_bridges_map,
+			ARRAY_SIZE(vexpress_config_bridges));
+	if (i >= ARRAY_SIZE(vexpress_config_bridges)) {
+		pr_err("Can't register more bridges!\n");
+		spin_unlock(&vexpress_config_bridges_lock);
+		return NULL;
+	}
+	__set_bit(i, vexpress_config_bridges_map);
+	bridge = &vexpress_config_bridges[i];
+
+	bridge->info = info;
+	INIT_LIST_HEAD(&bridge->transactions);
+	spin_lock_init(&bridge->transactions_lock);
+
+	vexpress_config_bridges_assign();
+
+	spin_unlock(&vexpress_config_bridges_lock);
+
+	return bridge;
+}
+
+void vexpress_config_bridge_unregister(struct vexpress_config_bridge *bridge)
+{
+	struct vexpress_config_bridge __bridge = *bridge;
+	int i;
+
+	spin_lock(&vexpress_config_bridges_lock);
+
+	for (i = 0; i < ARRAY_SIZE(vexpress_config_bridges); i++)
+		if (&vexpress_config_bridges[i] == bridge)
+			__clear_bit(i, vexpress_config_bridges_map);
+
+	vexpress_config_bridges_assign();
+
+	spin_unlock(&vexpress_config_bridges_lock);
+
+	WARN_ON(!list_empty(&__bridge.transactions));
+	while (!list_empty(&__bridge.transactions))
+		cpu_relax();
+}
+
+
+static u8 vexpress_config_master_site = VEXPRESS_SITE_MASTER;
+
+void vexpress_config_set_master_site(u8 site)
+{
+	vexpress_config_master_site = site;
+}
+
+u8 vexpress_config_get_master_site(void)
+{
+	return vexpress_config_master_site;
+}
+
+
+#define VEXPRESS_COMPATIBLE_TO_FUNC(_compatible, _func) \
+	{ \
+		.compatible = "arm,vexpress-config," _compatible, \
+		.data = (void *)VEXPRESS_CONFIG_FUNC_##_func \
+	}
+
+static struct of_device_id vexpress_config_devices_matches[] = {
+	VEXPRESS_COMPATIBLE_TO_FUNC("osc", OSC),
+	VEXPRESS_COMPATIBLE_TO_FUNC("volt", VOLT),
+	VEXPRESS_COMPATIBLE_TO_FUNC("amp", AMP),
+	VEXPRESS_COMPATIBLE_TO_FUNC("temp", TEMP),
+	VEXPRESS_COMPATIBLE_TO_FUNC("reset", RESET),
+	VEXPRESS_COMPATIBLE_TO_FUNC("scc", SCC),
+	VEXPRESS_COMPATIBLE_TO_FUNC("muxfpga", MUXFPGA),
+	VEXPRESS_COMPATIBLE_TO_FUNC("shutdown", SHUTDOWN),
+	VEXPRESS_COMPATIBLE_TO_FUNC("reboot", REBOOT),
+	VEXPRESS_COMPATIBLE_TO_FUNC("dvimode", DVIMODE),
+	VEXPRESS_COMPATIBLE_TO_FUNC("power", POWER),
+	VEXPRESS_COMPATIBLE_TO_FUNC("energy", ENERGY),
+	{},
+};
+
+static void vexpress_config_of_device_add(struct device_node *node)
+{
+	int err;
+	struct vexpress_config_device *vecdev;
+	const struct of_device_id *match;
+	u32 value;
+
+	if (!of_device_is_available(node))
+		return;
+
+	vecdev = kzalloc(sizeof(*vecdev), GFP_KERNEL);
+	if (WARN_ON(!vecdev))
+		return;
+
+	vecdev->dev.of_node = of_node_get(node);
+
+	vecdev->name = node->name;
+
+	match = of_match_node(vexpress_config_devices_matches, node);
+	vecdev->func = (unsigned)match->data;
+
+	err = of_property_read_u32(node->parent, "arm,vexpress,site", &value);
+	if (!err)
+		vecdev->addr.site = value;
+
+	err = of_property_read_u32(node->parent, "arm,vexpress,position",
+			&value);
+	if (!err)
+		vecdev->addr.position = value;
+
+	err = of_property_read_u32(node->parent, "arm,vexpress,dcc", &value);
+	if (!err)
+		vecdev->addr.dcc = value;
+
+	err = of_property_read_u32(node, "reg", &value);
+	if (!err) {
+		vecdev->addr.device = value;
+	} else {
+		pr_err("Invalid reg property in '%s'! (%d)\n",
+				node->full_name, err);
+		kfree(vecdev);
+		return;
+	}
+
+	err = vexpress_config_device_register(vecdev);
+	if (err) {
+		pr_err("Failed to add OF device '%s'! (%d)\n",
+				node->full_name, err);
+		kfree(vecdev);
+		return;
+	}
+}
+
+void vexpress_config_of_populate(void)
+{
+	struct device_node *node;
+
+	for_each_matching_node(node, vexpress_config_devices_matches)
+		vexpress_config_of_device_add(node);
+}
+
+
+int vexpress_config_device_register(struct vexpress_config_device *vecdev)
+{
+	pr_debug("Registering %sdevice '%s." ADDR_FMT "'\n",
+			vexpress_config_early ? "early " : "",
+			vecdev->name, ADDR_ARGS(vecdev));
+
+	if (vecdev->addr.site == VEXPRESS_SITE_MASTER)
+		vecdev->addr.site = vexpress_config_get_master_site();
+
+	if (!vecdev->bridge) {
+		spin_lock(&vexpress_config_bridges_lock);
+		vexpress_config_bridge_find(&vecdev->dev, NULL);
+		spin_unlock(&vexpress_config_bridges_lock);
+	}
+
+	if (vexpress_config_early) {
+		list_add(&vecdev->early, &vexpress_config_early_devices);
+		vexpress_config_early_bind();
+
+		return 0;
+	}
+
+	device_initialize(&vecdev->dev);
+	vecdev->dev.bus = &vexpress_config_bus_type;
+	if (!vecdev->dev.parent)
+		vecdev->dev.parent = &vexpress_config_bus;
+
+	dev_set_name(&vecdev->dev, "%s." ADDR_FMT,
+			vecdev->name, ADDR_ARGS(vecdev));
+
+	return device_add(&vecdev->dev);
+}
+EXPORT_SYMBOL(vexpress_config_device_register);
+
+void vexpress_config_device_unregister(struct vexpress_config_device *vecdev)
+{
+	device_del(&vecdev->dev);
+	put_device(&vecdev->dev);
+}
+EXPORT_SYMBOL(vexpress_config_device_unregister);
+
+static int vexpress_config_driver_probe(struct device *dev)
+{
+	struct vexpress_config_device *vecdev = to_vexpress_config_device(dev);
+	struct vexpress_config_driver *vecdrv =
+			to_vexpress_config_driver(dev->driver);
+
+	return vecdrv->probe(vecdev);
+}
+
+static int vexpress_config_driver_remove(struct device *dev)
+{
+	struct vexpress_config_device *vecdev = to_vexpress_config_device(dev);
+	struct vexpress_config_driver *vecdrv =
+			to_vexpress_config_driver(dev->driver);
+
+	return vecdrv->remove(vecdev);
+}
+
+int vexpress_config_driver_register(struct vexpress_config_driver *vecdrv)
+{
+	pr_debug("Registering %sdriver '%s'\n",
+			vexpress_config_early ? "early " : "",
+			vecdrv->driver.name);
+
+	if (vexpress_config_early) {
+		list_add(&vecdrv->early, &vexpress_config_early_drivers);
+		vexpress_config_early_bind();
+
+		return 0;
+	}
+
+	vecdrv->driver.bus = &vexpress_config_bus_type;
+	if (vecdrv->probe)
+		vecdrv->driver.probe = vexpress_config_driver_probe;
+	if (vecdrv->remove)
+		vecdrv->driver.remove = vexpress_config_driver_remove;
+
+	return driver_register(&vecdrv->driver);
+}
+EXPORT_SYMBOL(vexpress_config_driver_register);
+
+void vexpress_config_driver_unregister(struct vexpress_config_driver *vecdrv)
+{
+	driver_unregister(&vecdrv->driver);
+}
+EXPORT_SYMBOL(vexpress_config_driver_unregister);
+
+
+struct vexpress_config_trans {
+	struct vexpress_config_bridge *bridge;
+	bool write;
+	unsigned func;
+	struct vexpress_config_address addr;
+	u32 *data;
+	struct completion completion;
+	int status;
+	struct list_head list;
+};
+
+static void vexpress_config_dump_trans(const char *what,
+		struct vexpress_config_trans *trans)
+{
+	pr_debug("%s %s transaction on " ADDR_FMT ", data 0x%x, status %d\n",
+			what, trans->write ? "write" : "read", ADDR_ARGS(trans),
+			trans->data ? *trans->data : 0, trans->status);
+}
+
+void vexpress_config_complete(struct vexpress_config_bridge *bridge,
+		int status)
+{
+	struct vexpress_config_trans *trans;
+	bool do_command = false;
+	unsigned long flags;
+
+	trans = list_first_entry(&bridge->transactions,
+			struct vexpress_config_trans, list);
+
+	trans->status = status;
+
+	vexpress_config_dump_trans("Completed", trans);
+
+	spin_lock_irqsave(&bridge->transactions_lock, flags);
+	list_del(&trans->list);
+	if (list_empty(&bridge->transactions))
+		bridge->transaction_pending = false;
+	else
+		do_command = true;
+	spin_unlock_irqrestore(&bridge->transactions_lock, flags);
+
+	complete(&trans->completion);
+
+	if (do_command) {
+		vexpress_config_dump_trans("Pending", trans);
+		bridge->info->command(true, trans->write, trans->func,
+				&trans->addr, trans->data);
+	}
+}
+
+static int vexpress_config_schedule(struct vexpress_config_trans *trans)
+{
+	struct vexpress_config_bridge *bridge = trans->bridge;
+	bool do_command = false;
+	unsigned long flags;
+
+	if (WARN_ON(!bridge))
+		return -ENOENT;
+	if (WARN_ON(trans->addr.site == VEXPRESS_SITE_MASTER))
+		return -EINVAL;
+
+	init_completion(&trans->completion);
+	trans->status = -EFAULT;
+
+	spin_lock_irqsave(&bridge->transactions_lock, flags);
+	list_add_tail(&trans->list, &bridge->transactions);
+	if (!bridge->transaction_pending)
+		bridge->transaction_pending = do_command = true;
+	spin_unlock_irqrestore(&bridge->transactions_lock, flags);
+
+	if (do_command) {
+		vexpress_config_dump_trans("New", trans);
+		return bridge->info->command(true, trans->write, trans->func,
+				&trans->addr, trans->data);
+	} else {
+		return 1;
+	}
+}
+
+int vexpress_config_wait(struct vexpress_config_trans *trans)
+{
+	wait_for_completion(&trans->completion);
+
+	return trans->status;
+}
+
+
+int vexpress_config_read(struct vexpress_config_device *vecdev, int offset,
+		u32 *data)
+{
+	int err;
+
+	if (vexpress_config_early) {
+		mutex_lock(&vexpress_config_early_mutex);
+		err = vecdev->bridge->info->command(false, false, vecdev->func,
+				&vecdev->addr, data);
+		mutex_unlock(&vexpress_config_early_mutex);
+	} else {
+		struct vexpress_config_trans trans = {
+			.bridge = vecdev->bridge,
+			.write = false,
+			.func = vecdev->func,
+			.addr = vecdev->addr,
+			.data = data,
+		};
+
+		trans.addr.device += offset;
+
+		err = vexpress_config_schedule(&trans);
+		if (!err)
+			err = vexpress_config_wait(&trans);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(vexpress_config_read);
+
+int vexpress_config_write(struct vexpress_config_device *vecdev, int offset,
+		u32 data)
+{
+	int err;
+
+	if (vexpress_config_early) {
+		mutex_lock(&vexpress_config_early_mutex);
+		err = vecdev->bridge->info->command(false, true, vecdev->func,
+				&vecdev->addr, &data);
+		mutex_unlock(&vexpress_config_early_mutex);
+	} else {
+		struct vexpress_config_trans trans = {
+			.bridge = vecdev->bridge,
+			.write = true,
+			.func = vecdev->func,
+			.addr = vecdev->addr,
+			.data = &data,
+		};
+
+		trans.addr.device += offset;
+
+		err = vexpress_config_schedule(&trans);
+		if (!err)
+			err = vexpress_config_wait(&trans);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(vexpress_config_write);
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
new file mode 100644
index 0000000..f1ed744
--- /dev/null
+++ b/include/linux/vexpress.h
@@ -0,0 +1,120 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#ifndef _LINUX_VEXPRESS_H
+#define _LINUX_VEXPRESS_H
+
+#include <linux/device.h>
+
+#define VEXPRESS_CONFIG_FUNC_OSC	1
+#define VEXPRESS_CONFIG_FUNC_VOLT	2
+#define VEXPRESS_CONFIG_FUNC_AMP	3
+#define VEXPRESS_CONFIG_FUNC_TEMP	4
+#define VEXPRESS_CONFIG_FUNC_RESET	5
+#define VEXPRESS_CONFIG_FUNC_SCC	6
+#define VEXPRESS_CONFIG_FUNC_MUXFPGA	7
+#define VEXPRESS_CONFIG_FUNC_SHUTDOWN	8
+#define VEXPRESS_CONFIG_FUNC_REBOOT	9
+#define VEXPRESS_CONFIG_FUNC_DVIMODE	11
+#define VEXPRESS_CONFIG_FUNC_POWER	12
+#define VEXPRESS_CONFIG_FUNC_ENERGY	13
+
+#define VEXPRESS_SITE_MB		0
+#define VEXPRESS_SITE_DB1		1
+#define VEXPRESS_SITE_DB2		2
+#define VEXPRESS_SITE_MASTER		0xff
+#define VEXPRESS_SITES_NUM		3
+
+extern struct bus_type vexpress_config_bus_type;
+
+struct vexpress_config_address {
+	u8 site;
+	u8 position;
+	u8 dcc;
+	u16 device;
+};
+
+
+struct vexpress_config_bridge_info {
+	const char *name;
+	struct vexpress_config_address addr, mask;
+	int (*command)(bool async, bool write, unsigned func,
+			struct vexpress_config_address *addr, u32 *data);
+};
+
+struct vexpress_config_bridge *vexpress_config_bridge_register(
+		struct vexpress_config_bridge_info *info);
+void vexpress_config_bridge_unregister(struct vexpress_config_bridge *bridge);
+
+void vexpress_config_set_master_site(u8 site);
+u8 vexpress_config_get_master_site(void);
+
+void vexpress_config_complete(struct vexpress_config_bridge *bridge,
+		int status);
+
+
+struct vexpress_config_device {
+	const char *name;
+	unsigned func;
+	struct vexpress_config_address addr;
+	struct device dev;
+#define VEXPRESS_CONFIG_DEVICE_PROBED_EARLY (1 << 0)
+	unsigned status;
+	/* private members */
+	struct vexpress_config_bridge *bridge;
+	struct list_head early;
+};
+
+#define to_vexpress_config_device(x) \
+		container_of((x), struct vexpress_config_device, dev)
+
+void vexpress_config_of_populate(void);
+int vexpress_config_device_register(struct vexpress_config_device *vecdev);
+void vexpress_config_device_unregister(struct vexpress_config_device *vecdev);
+
+
+struct vexpress_config_driver {
+	const unsigned *funcs; /* zero terminated array */
+	int (*probe)(struct vexpress_config_device *vecdev);
+	int (*remove)(struct vexpress_config_device *vecdev);
+	struct device_driver driver;
+	/* private members */
+	struct list_head early;
+};
+
+#define to_vexpress_config_driver(x) \
+		container_of((x), struct vexpress_config_driver, driver)
+
+int vexpress_config_driver_register(struct vexpress_config_driver *vecdrv);
+void vexpress_config_driver_unregister(struct vexpress_config_driver *vecdrv);
+
+static inline void *vexpress_config_get_drvdata(
+		const struct vexpress_config_device *vecdev)
+{
+	return dev_get_drvdata(&vecdev->dev);
+}
+
+static inline void vexpress_config_set_drvdata(
+		struct vexpress_config_device *vecdev, void *data)
+{
+	dev_set_drvdata(&vecdev->dev, data);
+}
+
+
+/* Both may sleep! */
+int vexpress_config_read(struct vexpress_config_device *vecdev, int offset,
+		u32 *data);
+int vexpress_config_write(struct vexpress_config_device *vecdev, int offset,
+		u32 data);
+
+#endif
-- 
1.7.9.5
