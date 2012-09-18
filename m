From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 18 Sep 2012 15:17:49 +0100
Subject: [PATCH v2 07/13] misc: Versatile Express config infrastructure
In-Reply-To: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1347977875-16855-8-git-send-email-pawel.moll@arm.com>
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

This patch adds an abstraction of this infrastructure. Bridge
drivers can register themselves with the framework. Then,
a driver of a device can request an abstract "function" - the
request will be redirected to a bridge referred by thedd
"arm,vexpress,config-bridge" property of the device tree node.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 Documentation/devicetree/bindings/arm/vexpress.txt |   68 ++++-
 drivers/misc/Kconfig                               |    6 +
 drivers/misc/Makefile                              |    1 +
 drivers/misc/vexpress-config.c                     |  276 ++++++++++++++++++++
 include/linux/vexpress.h                           |   64 +++++
 5 files changed, 414 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/vexpress-config.c
 create mode 100644 include/linux/vexpress.h

Hi Arnd,

As it doesn't seem to be a "bus" any more, I left it in in misc for
now... It looks to me like there should be some kind of place for
"system/soc control" drivers. Or maybe there is, and I just missed
it?

Cheers!

Pawel

diff --git a/Documentation/devicetree/bindings/arm/vexpress.txt b/Documentation/devicetree/bindings/arm/vexpress.txt
index ec8b50c..5d9996b 100644
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
 
@@ -59,6 +67,52 @@ with device_type = "cpu" property for every available core, eg.:
 		};
 	};
 
+
+Configuration infrastructure
+----------------------------
+
+The platform has an elaborated configuration system, consisting of
+microcontrollers residing on the mother- and daughterboards known
+as Motherboard/Daughterboard Configuration Controller (MCC and DCC).
+The controllers are responsible for the platform initialization
+(reset generation, flash programming, FPGA bitfiles loading etc.)
+but also control clock generators, voltage regulators, gather
+environmental data like temperature, power consumption etc. Even
+the video output switch (FPGA) is controlled that way.
+
+Nodes describing devices controlled by this infrastructure should
+point at the bridge device node:
+- bridge phandle:
+	arm,vexpress,config-bridge = <phandle>;
+This property can be also defined in a parent node (eg. for a DCC)
+and is effective for all children.
+
+
+Platform topology
+-----------------
+
+As Versatile Express can be configured in number of physically
+different setups, the device tree should describe platform topology.
+Root node and main motherboard node must define the following
+property, describing physical location of the children nodes:
+- site number:
+	arm,vexpress,site = <number>;
+  where 0 means motherboard, 1 or 2 are daugtherboard sites,
+  0xf means "master" site (site containing main CPU tile)
+- when daughterboards are stacked on one site, their position
+  in the stack be be described with:
+	arm,vexpress,position = <number>;
+- when describing tiles consisting more than one DCC, its number
+  can be described with:
+	arm,vexpress,dcc = <number>;
+
+Any of the numbers above defaults to zero if not defined in
+the node or any of its parent.
+
+
+Motherboard
+-----------
+
 The motherboard description file provides a single "motherboard" node
 using 2 address cells corresponding to the Static Memory Bus used
 between the motherboard and the tile. The first cell defines the Chip
@@ -96,13 +150,16 @@ The tile description must define "ranges", "interrupt-map-mask" and
 "interrupt-map" properties to translate the motherboard's address
 and interrupt space into one used by the tile's processor.
 
-Abbreviated example:
+
+Example of a VE tile description (simplified)
+---------------------------------------------
 
 /dts-v1/;
 
 / {
 	model = "V2P-CA5s";
 	arm,hbi = <0x225>;
+	arm,vexpress,site = <0xf>;
 	compatible = "arm,vexpress-v2p-ca5s", "arm,vexpress";
 	interrupt-parent = <&gic>;
 	#address-cells = <1>;
@@ -134,6 +191,15 @@ Abbreviated example:
 		      <0x2c000100 0x100>;
 	};
 
+	dcc {
+		compatible = "simple-bus";
+		arm,vexpress,config-bridge = <&v2m_sysreg>;
+
+		osc at 0 {
+			compatible = "arm,vexpress-osc";
+		};
+	};
+
 	motherboard {
 		/* CS0 is visible at 0x08000000 */
 		ranges = <0 0 0x08000000 0x04000000>;
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 98a442d..77274c9d 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -509,6 +509,12 @@ config USB_SWITCH_FSA9480
 	  stereo and mono audio, video, microphone and UART data to use
 	  a common connector port.
 
+config VEXPRESS_CONFIG
+	bool
+	help
+	  Platform configuration infrastructure for the ARM Ltd.
+	  Versatile Express.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b88df7a..dc180c6 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -50,3 +50,4 @@ obj-y				+= carma/
 obj-$(CONFIG_USB_SWITCH_FSA9480) += fsa9480.o
 obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
 obj-$(CONFIG_INTEL_MEI)		+= mei/
+obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
diff --git a/drivers/misc/vexpress-config.c b/drivers/misc/vexpress-config.c
new file mode 100644
index 0000000..340cb2d
--- /dev/null
+++ b/drivers/misc/vexpress-config.c
@@ -0,0 +1,276 @@
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
+#define VEXPRESS_CONFIG_MAX_BRIDGES 2
+
+struct vexpress_config_bridge {
+	struct device_node *node;
+	struct vexpress_config_bridge_info *info;
+	struct list_head transactions;
+	spinlock_t transactions_lock;
+} vexpress_config_bridges[VEXPRESS_CONFIG_MAX_BRIDGES];
+
+static DECLARE_BITMAP(vexpress_config_bridges_map,
+		ARRAY_SIZE(vexpress_config_bridges));
+static DEFINE_MUTEX(vexpress_config_bridges_mutex);
+
+struct vexpress_config_bridge *vexpress_config_bridge_register(
+		struct device_node *node,
+		struct vexpress_config_bridge_info *info)
+{
+	struct vexpress_config_bridge *bridge;
+	int i;
+
+	pr_debug("Registering bridge '%s'\n", info->name);
+
+	mutex_lock(&vexpress_config_bridges_mutex);
+	i = find_first_zero_bit(vexpress_config_bridges_map,
+			ARRAY_SIZE(vexpress_config_bridges));
+	if (i >= ARRAY_SIZE(vexpress_config_bridges)) {
+		pr_err("Can't register more bridges!\n");
+		mutex_unlock(&vexpress_config_bridges_mutex);
+		return NULL;
+	}
+	__set_bit(i, vexpress_config_bridges_map);
+	bridge = &vexpress_config_bridges[i];
+
+	bridge->node = node;
+	bridge->info = info;
+	INIT_LIST_HEAD(&bridge->transactions);
+	spin_lock_init(&bridge->transactions_lock);
+
+	mutex_unlock(&vexpress_config_bridges_mutex);
+
+	return bridge;
+}
+
+void vexpress_config_bridge_unregister(struct vexpress_config_bridge *bridge)
+{
+	struct vexpress_config_bridge __bridge = *bridge;
+	int i;
+
+	mutex_lock(&vexpress_config_bridges_mutex);
+	for (i = 0; i < ARRAY_SIZE(vexpress_config_bridges); i++)
+		if (&vexpress_config_bridges[i] == bridge)
+			__clear_bit(i, vexpress_config_bridges_map);
+	mutex_unlock(&vexpress_config_bridges_mutex);
+
+	WARN_ON(!list_empty(&__bridge.transactions));
+	while (!list_empty(&__bridge.transactions))
+		cpu_relax();
+}
+
+
+struct vexpress_config_func {
+	struct vexpress_config_bridge *bridge;
+	void *func;
+};
+
+struct vexpress_config_func *__vexpress_config_func_get(struct device *dev,
+		struct device_node *node)
+{
+	struct device_node *bridge_node;
+	struct vexpress_config_func *func;
+	int i;
+
+	if (WARN_ON(dev && node && dev->of_node != node))
+		return NULL;
+	if (dev && !node)
+		node = dev->of_node;
+
+	func = kzalloc(sizeof(*func), GFP_KERNEL);
+	if (!func)
+		return NULL;
+
+	bridge_node = of_node_get(node);
+	while (bridge_node) {
+		const __be32 *prop = of_get_property(bridge_node,
+				"arm,vexpress,config-bridge", NULL);
+
+		if (prop) {
+			bridge_node = of_find_node_by_phandle(
+					be32_to_cpup(prop));
+			break;
+		}
+
+		bridge_node = of_get_next_parent(bridge_node);
+	}
+
+	mutex_lock(&vexpress_config_bridges_mutex);
+	for (i = 0; i < ARRAY_SIZE(vexpress_config_bridges); i++) {
+		struct vexpress_config_bridge *bridge =
+				&vexpress_config_bridges[i];
+
+		if (test_bit(i, vexpress_config_bridges_map) &&
+				bridge->node == bridge_node) {
+			func->bridge = bridge;
+			func->func = bridge->info->func_get(dev, node);
+			break;
+		}
+	}
+	mutex_unlock(&vexpress_config_bridges_mutex);
+
+	if (!func->func) {
+		of_node_put(node);
+		kfree(func);
+		return NULL;
+	}
+
+	return func;
+}
+
+void vexpress_config_func_put(struct vexpress_config_func *func)
+{
+	func->bridge->info->func_put(func->func);
+	of_node_put(func->bridge->node);
+	kfree(func);
+}
+
+
+struct vexpress_config_trans {
+	struct vexpress_config_func *func;
+	int offset;
+	bool write;
+	u32 *data;
+	int status;
+	struct completion completion;
+	struct list_head list;
+};
+
+static void vexpress_config_dump_trans(const char *what,
+		struct vexpress_config_trans *trans)
+{
+	pr_debug("%s %s trans %p func 0x%p offset %d data 0x%x status %d\n",
+			what, trans->write ? "write" : "read", trans,
+			trans->func->func, trans->offset,
+			trans->data ? *trans->data : 0, trans->status);
+}
+
+static int vexpress_config_schedule(struct vexpress_config_trans *trans)
+{
+	int res;
+	struct vexpress_config_bridge *bridge = trans->func->bridge;
+	unsigned long flags;
+
+	init_completion(&trans->completion);
+	trans->status = -EFAULT;
+
+	spin_lock_irqsave(&bridge->transactions_lock, flags);
+
+	vexpress_config_dump_trans("Executing", trans);
+
+	if (list_empty(&bridge->transactions))
+		res = bridge->info->func_exec(trans->func->func, trans->offset,
+				trans->write, trans->data);
+	else
+		res = VEXPRESS_CONFIG_EXEC_WAIT;
+
+	switch (res) {
+	case VEXPRESS_CONFIG_EXEC_DONE:
+		vexpress_config_dump_trans("Finished", trans);
+		res = trans->status;
+		break;
+	case VEXPRESS_CONFIG_EXEC_WAIT:
+		list_add_tail(&trans->list, &bridge->transactions);
+		break;
+	}
+
+	spin_unlock_irqrestore(&bridge->transactions_lock, flags);
+
+	return res;
+}
+
+void vexpress_config_complete(struct vexpress_config_bridge *bridge,
+		int status)
+{
+	struct vexpress_config_trans *trans;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bridge->transactions_lock, flags);
+
+	trans = list_first_entry(&bridge->transactions,
+			struct vexpress_config_trans, list);
+	vexpress_config_dump_trans("Completed", trans);
+
+	trans->status = status;
+	list_del(&trans->list);
+
+	if (!list_empty(&bridge->transactions)) {
+		vexpress_config_dump_trans("Pending", trans);
+
+		bridge->info->func_exec(trans->func->func, trans->offset,
+				trans->write, trans->data);
+	}
+	spin_unlock_irqrestore(&bridge->transactions_lock, flags);
+
+	complete(&trans->completion);
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
+int vexpress_config_read(struct vexpress_config_func *func, int offset,
+		u32 *data)
+{
+	struct vexpress_config_trans trans = {
+		.func = func,
+		.offset = offset,
+		.write = false,
+		.data = data,
+		.status = 0,
+	};
+	int res = vexpress_config_schedule(&trans);
+
+	if (res == VEXPRESS_CONFIG_EXEC_WAIT)
+		res = vexpress_config_wait(&trans);
+
+	return res;
+}
+EXPORT_SYMBOL(vexpress_config_read);
+
+int vexpress_config_write(struct vexpress_config_func *func, int offset,
+		u32 data)
+{
+	struct vexpress_config_trans trans = {
+		.func = func,
+		.offset = offset,
+		.write = true,
+		.data = &data,
+		.status = 0,
+	};
+	int res = vexpress_config_schedule(&trans);
+
+	if (res == VEXPRESS_CONFIG_EXEC_WAIT)
+		res = vexpress_config_wait(&trans);
+
+	return res;
+}
+EXPORT_SYMBOL(vexpress_config_write);
diff --git a/include/linux/vexpress.h b/include/linux/vexpress.h
new file mode 100644
index 0000000..b4acb20
--- /dev/null
+++ b/include/linux/vexpress.h
@@ -0,0 +1,64 @@
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
+#define VEXPRESS_SITE_MB		0
+#define VEXPRESS_SITE_DB1		1
+#define VEXPRESS_SITE_DB2		2
+#define VEXPRESS_SITE_MASTER		0xf
+
+#define VEXPRESS_CONFIG_EXEC_DONE	0
+#define VEXPRESS_CONFIG_EXEC_WAIT	1
+
+/* Config bridge API */
+
+struct vexpress_config_bridge_info {
+	const char *name;
+	void *(*func_get)(struct device *dev, struct device_node *node);
+	void (*func_put)(void *func);
+	int (*func_exec)(void *func, int offset, bool write, u32 *data);
+};
+
+struct vexpress_config_bridge;
+
+struct vexpress_config_bridge *vexpress_config_bridge_register(
+		struct device_node *node,
+		struct vexpress_config_bridge_info *info);
+void vexpress_config_bridge_unregister(struct vexpress_config_bridge *bridge);
+
+void vexpress_config_complete(struct vexpress_config_bridge *bridge,
+		int status);
+
+/* Config function API */
+
+struct vexpress_config_func;
+
+struct vexpress_config_func *__vexpress_config_func_get(struct device *dev,
+		struct device_node *node);
+#define vexpress_config_func_get_by_dev(dev) \
+		__vexpress_config_func_get(dev, NULL)
+#define vexpress_config_func_get_by_node(node) \
+		__vexpress_config_func_get(NULL, node)
+void vexpress_config_func_put(struct vexpress_config_func *func);
+
+/* Both may sleep! */
+int vexpress_config_read(struct vexpress_config_func *func, int offset,
+		u32 *data);
+int vexpress_config_write(struct vexpress_config_func *func, int offset,
+		u32 data);
+
+#endif
-- 
1.7.9.5
