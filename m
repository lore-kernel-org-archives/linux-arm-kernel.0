From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Aug 2015 12:20:04 +0800
Subject: [PATCH v3 3/8] rsb: Linux driver framework for Reduced Serial Bus
 (RSB)
In-Reply-To: <1439958009-14056-1-git-send-email-wens@csie.org>
References: <1439958009-14056-1-git-send-email-wens@csie.org>
Message-ID: <1439958009-14056-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduced Serial Bus (RSB) is an Allwinner proprietery interface
used to communicate with PMICs and other peripheral ICs.

RSB is a two-wire push-pull serial bus that supports 1 master
device and up to 15 active slave devices.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/Kconfig        |   2 +
 drivers/Makefile       |   1 +
 drivers/rsb/Kconfig    |  11 ++
 drivers/rsb/Makefile   |   4 +
 drivers/rsb/rsb-core.c | 511 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/rsb.h    | 144 ++++++++++++++
 6 files changed, 673 insertions(+)
 create mode 100644 drivers/rsb/Kconfig
 create mode 100644 drivers/rsb/Makefile
 create mode 100644 drivers/rsb/rsb-core.c
 create mode 100644 include/linux/rsb.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 6e973b8e3a3b..4ada2d3eb832 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -54,6 +54,8 @@ source "drivers/spi/Kconfig"
 
 source "drivers/spmi/Kconfig"
 
+source "drivers/rsb/Kconfig"
+
 source "drivers/hsi/Kconfig"
 
 source "drivers/pps/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index e4b260ecec15..75e0fc8fe28c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_TARGET_CORE)	+= target/
 obj-$(CONFIG_MTD)		+= mtd/
 obj-$(CONFIG_SPI)		+= spi/
 obj-$(CONFIG_SPMI)		+= spmi/
+obj-$(CONFIG_RSB)		+= rsb/
 obj-y				+= hsi/
 obj-y				+= net/
 obj-$(CONFIG_ATM)		+= atm/
diff --git a/drivers/rsb/Kconfig b/drivers/rsb/Kconfig
new file mode 100644
index 000000000000..6642e1db6d98
--- /dev/null
+++ b/drivers/rsb/Kconfig
@@ -0,0 +1,11 @@
+#
+# RSB driver configuration
+#
+menuconfig RSB
+	tristate "RSB support"
+	help
+	  RSB (Reduced Serial Bus) is a two-wire serial interface between
+	  baseband and application processors and Power Management
+	  Integrated Circuits (PMIC) or other peripherals.
+
+	  These are commonly seen on newer Allwinner SoCs and X-Powers ICs.
diff --git a/drivers/rsb/Makefile b/drivers/rsb/Makefile
new file mode 100644
index 000000000000..6fe56526fbf3
--- /dev/null
+++ b/drivers/rsb/Makefile
@@ -0,0 +1,4 @@
+#
+# Makefile for kernel RSB framework.
+#
+obj-$(CONFIG_RSB)	+= rsb-core.o
diff --git a/drivers/rsb/rsb-core.c b/drivers/rsb/rsb-core.c
new file mode 100644
index 000000000000..6682d827aebb
--- /dev/null
+++ b/drivers/rsb/rsb-core.c
@@ -0,0 +1,511 @@
+/*
+ * Copyright (c) 2015, Chen-Yu Tsai
+ *
+ * Chen-Yu Tsai <wens@csie.org>
+ *
+ * Allwinner Reduced Serial Bus (RSB) driver
+ *
+ * based on spmi/spmi.c
+ *
+ * Copyright (c) 2012-2015, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk/clk-conf.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/rsb.h>
+#include <linux/slab.h>
+
+static DEFINE_IDA(ctrl_ida);
+
+static void rsb_dev_release(struct device *dev)
+{
+	struct rsb_device *rdev = to_rsb_device(dev);
+
+	kfree(rdev);
+}
+
+static const struct device_type rsb_dev_type = {
+	.release	= rsb_dev_release,
+};
+
+static void rsb_ctrl_release(struct device *dev)
+{
+	struct rsb_controller *ctrl = to_rsb_controller(dev);
+
+	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	kfree(ctrl);
+}
+
+static const struct device_type rsb_ctrl_type = {
+	.release	= rsb_ctrl_release,
+};
+
+static int rsb_device_match(struct device *dev, struct device_driver *drv)
+{
+	if (of_driver_match_device(dev, drv))
+		return 1;
+
+	return strcmp(dev_name(dev), drv->name) == 0;
+}
+
+static inline int rsb_init_cmd(struct rsb_controller *ctrl)
+{
+	int ret;
+
+	if (!ctrl || !ctrl->init_cmd || ctrl->dev.type != &rsb_ctrl_type)
+		return -EINVAL;
+
+	mutex_lock(&ctrl->lock);
+	ret = ctrl->init_cmd(ctrl);
+	mutex_unlock(&ctrl->lock);
+
+	return ret;
+}
+
+static inline int rsb_rtsaddr_cmd(struct rsb_controller *ctrl, u16 hwaddr,
+				  u8 rtaddr)
+{
+	int ret;
+
+	if (!ctrl || !ctrl->rtsaddr_cmd || ctrl->dev.type != &rsb_ctrl_type)
+		return -EINVAL;
+
+	mutex_lock(&ctrl->lock);
+	ret = ctrl->rtsaddr_cmd(ctrl, hwaddr, rtaddr);
+	mutex_unlock(&ctrl->lock);
+
+	return ret;
+}
+
+static inline int rsb_read_cmd(struct rsb_controller *ctrl, u8 rtaddr,
+			       u8 addr, u32 *buf, size_t len)
+{
+	int ret;
+
+	if (!ctrl || !ctrl->read_cmd || ctrl->dev.type != &rsb_ctrl_type)
+		return -EINVAL;
+
+	mutex_lock(&ctrl->lock);
+	ret = ctrl->read_cmd(ctrl, rtaddr, addr, buf, len);
+	mutex_unlock(&ctrl->lock);
+
+	return ret;
+}
+
+static inline int rsb_write_cmd(struct rsb_controller *ctrl, u8 rtaddr,
+				u8 addr, const u32 *buf, size_t len)
+{
+	int ret;
+
+	if (!ctrl || !ctrl->write_cmd || ctrl->dev.type != &rsb_ctrl_type)
+		return -EINVAL;
+
+	mutex_lock(&ctrl->lock);
+	ret = ctrl->write_cmd(ctrl, rtaddr, addr, buf, len);
+	mutex_unlock(&ctrl->lock);
+
+	return ret;
+}
+
+/**
+ * rsb_register_read() - register read
+ * @rdev:	RSB device.
+ * @addr:	slave register address.
+ * @buf:	buffer to be populated with data from the Slave.
+ * @size:	width of the slave register in bytes
+ *
+ * Reads data from a Slave device register.
+ */
+int rsb_register_read(struct rsb_device *rdev, u8 addr, u32 *buf, int size)
+{
+	switch (size) {
+	case 1:
+	case 2:
+	case 4:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rsb_read_cmd(rdev->ctrl, rdev->rtaddr, addr, buf, size);
+}
+EXPORT_SYMBOL_GPL(rsb_register_read);
+
+/**
+ * rsb_register_write() - register write
+ * @rdev:	RSB device
+ * @addr:	slave register address.
+ * @data:	buffer containing the data to be transferred to the Slave.
+ * @size:	width of the slave register in bytes
+ *
+ * Writes data to a Slave device register.
+ */
+int rsb_register_write(struct rsb_device *rdev, u8 addr, u32 data, int size)
+{
+	switch (size) {
+	case 1:
+	case 2:
+	case 4:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return rsb_write_cmd(rdev->ctrl, rdev->rtaddr, addr, &data, size);
+}
+EXPORT_SYMBOL_GPL(rsb_register_write);
+
+static struct bus_type rsb_bus_type;
+
+static int rsb_device_probe(struct device *dev)
+{
+	const struct rsb_driver *drv = to_rsb_driver(dev->driver);
+	struct rsb_device *rsb = to_rsb_device(dev);
+	int ret;
+
+	if (dev->type != &rsb_dev_type)
+		return 0;
+
+	if (!drv->probe)
+		return -ENODEV;
+
+	if (!rsb->irq) {
+		int irq = -ENOENT;
+
+		if (dev->of_node)
+			irq = of_irq_get(dev->of_node, 0);
+
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		if (irq < 0)
+			irq = 0;
+
+		rsb->irq = irq;
+	}
+
+	ret = of_clk_set_defaults(dev->of_node, false);
+	if (ret < 0)
+		return ret;
+
+	return drv->probe(rsb);
+}
+
+static int rsb_device_remove(struct device *dev)
+{
+	const struct rsb_driver *drv = to_rsb_driver(dev->driver);
+
+	if (dev->type != &rsb_dev_type)
+		return 0;
+
+	return drv->remove(to_rsb_device(dev));
+}
+
+static struct bus_type rsb_bus_type = {
+	.name		= "rsb",
+	.match		= rsb_device_match,
+	.probe		= rsb_device_probe,
+	.remove		= rsb_device_remove,
+};
+
+/**
+ * rsb_device_alloc() - Allocate a new RSB device
+ * @ctrl:	associated controller
+ *
+ * Caller is responsible for either calling rsb_device_add() to add the
+ * newly allocated controller, or calling rsb_device_put() to discard it.
+ */
+static struct rsb_device *rsb_device_alloc(struct rsb_controller *ctrl)
+{
+	struct rsb_device *rdev;
+
+	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
+	if (!rdev)
+		return NULL;
+
+	rdev->ctrl = ctrl;
+	device_initialize(&rdev->dev);
+	rdev->dev.parent = &ctrl->dev;
+	rdev->dev.bus = &rsb_bus_type;
+	rdev->dev.type = &rsb_dev_type;
+	return rdev;
+}
+
+static inline void rsb_device_put(struct rsb_device *rdev)
+{
+	if (rdev)
+		put_device(&rdev->dev);
+}
+
+/* 15 valid runtime addresses for RSB slaves */
+static const u8 rsb_valid_rtaddr[] = {
+	0x17, 0x2d, 0x3a, 0x4e, 0x59, 0x63, 0x74, 0x8b,
+	0x9c, 0xa6, 0xb1, 0xc5, 0xd2, 0xe8, 0xff,
+};
+
+static inline int rsb_check_rt_addr(u8 addr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(rsb_valid_rtaddr); i++)
+		if (addr == rsb_valid_rtaddr[i])
+			return 0;
+
+	return -EINVAL;
+}
+
+/**
+ * rsb_device_add() - add a device previously constructed via rsb_device_alloc()
+ * @rdev:	rsb_device to be added
+ */
+static int rsb_device_add(struct rsb_device *rdev)
+{
+	struct rsb_controller *ctrl = rdev->ctrl;
+	int err;
+
+	dev_set_name(&rdev->dev, "%d-%02x", ctrl->nr, rdev->rtaddr);
+
+	err = device_add(&rdev->dev);
+	if (err < 0) {
+		dev_err(&rdev->dev, "Can't add %s, status %d\n",
+			dev_name(&rdev->dev), err);
+		goto err_device_add;
+	}
+
+	dev_dbg(&rdev->dev, "device %s registered\n", dev_name(&rdev->dev));
+
+err_device_add:
+	return err;
+}
+
+/**
+ * rsb_device_unregister(): unregister an RSB device
+ * @rdev:	rsb_device to be removed
+ */
+static void rsb_device_unregister(struct rsb_device *rdev)
+{
+	device_unregister(&rdev->dev);
+}
+
+/**
+ * rsb_controller_alloc() - Allocate a new RSB controller
+ * @parent:	parent device
+ * @size:	size of private data
+ *
+ * Caller is responsible for either calling rsb_controller_add() to add the
+ * newly allocated controller, or calling rsb_controller_put() to discard it.
+ * The allocated private data region may be accessed via
+ * rsb_controller_get_drvdata()
+ */
+struct rsb_controller *rsb_controller_alloc(struct device *parent, size_t size)
+{
+	struct rsb_controller *ctrl;
+	int id;
+
+	if (WARN_ON(!parent))
+		return NULL;
+
+	ctrl = kzalloc(sizeof(*ctrl) + size, GFP_KERNEL);
+	if (!ctrl)
+		return NULL;
+
+	device_initialize(&ctrl->dev);
+	mutex_init(&ctrl->lock);
+	ctrl->dev.type = &rsb_ctrl_type;
+	ctrl->dev.bus = &rsb_bus_type;
+	ctrl->dev.parent = parent;
+	ctrl->dev.of_node = parent->of_node;
+	rsb_controller_set_drvdata(ctrl, &ctrl[1]);
+
+	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		dev_err(parent,
+			"unable to allocate RSB controller identifier.\n");
+		rsb_controller_put(ctrl);
+		return NULL;
+	}
+
+	ctrl->nr = id;
+	dev_set_name(&ctrl->dev, "rsb-%d", id);
+	dev_dbg(&ctrl->dev, "allocated controller 0x%p id %d\n", ctrl, id);
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(rsb_controller_alloc);
+
+static void of_rsb_register_devices(struct rsb_controller *ctrl)
+{
+	struct device_node *node;
+	int err;
+	u32 reg[2];
+
+	if (!ctrl->dev.of_node)
+		return;
+
+	/* Runtime addresses for all slaves should be set first */
+	for_each_available_child_of_node(ctrl->dev.of_node, node) {
+		dev_dbg(&ctrl->dev, "setting child %s runtime address\n",
+			node->full_name);
+
+		err = of_property_read_u32_array(node, "reg", reg, 2);
+		if (err) {
+			dev_err(&ctrl->dev,
+				"node %s err (%d) does not have 'reg' property\n",
+				node->full_name, err);
+			continue;
+		}
+
+		if (reg[0] > 0xff || rsb_check_rt_addr(reg[0]) < 0) {
+			dev_err(&ctrl->dev,
+				"invalid runtime address on node %s\n",
+				node->full_name);
+			continue;
+		}
+
+		/* This fails if the slave device was already initialized */
+		err = rsb_rtsaddr_cmd(ctrl, (u16)reg[1], (u8)reg[0]);
+		if (err)
+			dev_info(&ctrl->dev,
+				 "failed to set runtime address: %d\n", err);
+	}
+
+	for_each_available_child_of_node(ctrl->dev.of_node, node) {
+		struct rsb_device *rdev;
+
+		dev_dbg(&ctrl->dev, "adding child %s\n", node->full_name);
+
+		err = of_property_read_u32_array(node, "reg", reg, 2);
+		if (err)
+			continue;
+
+		if (reg[0] > 0xff || rsb_check_rt_addr(reg[0]) < 0)
+			continue;
+
+		rdev = rsb_device_alloc(ctrl);
+		if (!rdev)
+			continue;
+
+		rdev->dev.of_node = node;
+		rdev->rtaddr = (u8)reg[0];
+		rdev->hwaddr = (u16)reg[1];
+
+		err = rsb_device_add(rdev);
+		if (err) {
+			dev_err(&rdev->dev, "failed to add device: %d\n", err);
+			rsb_device_put(rdev);
+		}
+	}
+}
+
+/**
+ * rsb_controller_add() - Add an RSB controller
+ * @ctrl:	controller to be registered.
+ *
+ * Register a controller previously allocated via rsb_controller_alloc() with
+ * the RSB core.
+ */
+int rsb_controller_add(struct rsb_controller *ctrl)
+{
+	int ret;
+
+	/* Can't register until after driver model init */
+	if (WARN_ON(!rsb_bus_type.p))
+		return -EAGAIN;
+
+	ret = device_add(&ctrl->dev);
+	if (ret)
+		return ret;
+
+	/*
+	 * Send RSB init sequence on the bus. This fails if the bus was
+	 * already initialized.
+	 */
+	ret = rsb_init_cmd(ctrl);
+	if (ret)
+		dev_info(&ctrl->dev, "RSB init sequence failed: %d\n", ret);
+
+	if (IS_ENABLED(CONFIG_OF))
+		of_rsb_register_devices(ctrl);
+
+	dev_dbg(&ctrl->dev, "rsb-%d registered: dev:%p\n",
+		ctrl->nr, &ctrl->dev);
+
+	return 0;
+};
+EXPORT_SYMBOL_GPL(rsb_controller_add);
+
+/* Remove a device associated with a controller */
+static int rsb_ctrl_remove_device(struct device *dev, void *data)
+{
+	struct rsb_device *rsb = to_rsb_device(dev);
+
+	if (dev->type == &rsb_dev_type)
+		rsb_device_unregister(rsb);
+	return 0;
+}
+
+/**
+ * rsb_controller_remove(): remove an RSB controller
+ * @ctrl:	controller to remove
+ *
+ * Remove a RSB controller.  Caller is responsible for calling
+ * rsb_controller_put() to discard the allocated controller.
+ */
+void rsb_controller_remove(struct rsb_controller *ctrl)
+{
+	int dummy;
+
+	if (!ctrl)
+		return;
+
+	dummy = device_for_each_child(&ctrl->dev, NULL,
+				      rsb_ctrl_remove_device);
+	mutex_destroy(&ctrl->lock);
+	device_del(&ctrl->dev);
+}
+EXPORT_SYMBOL_GPL(rsb_controller_remove);
+
+/**
+ * rsb_driver_register() - Register device driver with RSB core
+ * @rdrv:	device driver to be associated with slave-device.
+ *
+ * This API will register the client driver with the RSB framework.
+ * It is typically called from the driver's module-init function.
+ */
+int rsb_driver_register(struct rsb_driver *rdrv)
+{
+	rdrv->driver.bus = &rsb_bus_type;
+	return driver_register(&rdrv->driver);
+}
+EXPORT_SYMBOL_GPL(rsb_driver_register);
+
+static void __exit rsb_exit(void)
+{
+	bus_unregister(&rsb_bus_type);
+}
+module_exit(rsb_exit);
+
+static int __init rsb_init(void)
+{
+	return bus_register(&rsb_bus_type);
+}
+postcore_initcall(rsb_init);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Reduce Serial Bus (RSB) core module");
+MODULE_ALIAS("platform:rsb");
diff --git a/include/linux/rsb.h b/include/linux/rsb.h
new file mode 100644
index 000000000000..51a53468f547
--- /dev/null
+++ b/include/linux/rsb.h
@@ -0,0 +1,144 @@
+/* Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef _LINUX_RSB_H
+#define _LINUX_RSB_H
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+/**
+ * struct rsb_device - Basic representation of an RSB device
+ * @dev:	Driver model representation of the device.
+ * @ctrl:	RSB controller managing the bus hosting this device.
+ * @rtaddr:	This device's runtime address
+ * @hwaddr:	This device's hardware address
+ */
+struct rsb_device {
+	struct device		dev;
+	struct rsb_controller	*ctrl;
+	int			irq;
+	u8			rtaddr;
+	u16			hwaddr;
+};
+
+static inline struct rsb_device *to_rsb_device(struct device *d)
+{
+	return container_of(d, struct rsb_device, dev);
+}
+
+static inline void *rsb_device_get_drvdata(const struct rsb_device *rdev)
+{
+	return dev_get_drvdata(&rdev->dev);
+}
+
+static inline void rsb_device_set_drvdata(struct rsb_device *rdev, void *data)
+{
+	dev_set_drvdata(&rdev->dev, data);
+}
+
+/**
+ * struct rsb_controller - interface to the RSB master controller
+ * @dev:	Driver model representation of the device.
+ * @nr:		board-specific number identifier for this controller/bus
+ * @init_cmd:	sends a device initialization command sequence on the bus.
+ * @rtsaddr_cmd: sends a "set runtime address" command sequence on the bus.
+ * @read_cmd:	sends a register read command sequence on the RSB bus.
+ * @write_cmd:	sends a register write command sequence on the RSB bus.
+ */
+struct rsb_controller {
+	struct device		dev;
+	unsigned int		nr;
+	struct mutex		lock; /* serialize access to the bus */
+	int	(*init_cmd)(struct rsb_controller *ctrl);
+	int	(*rtsaddr_cmd)(struct rsb_controller *ctrl,
+			       u16 hwaddr, u8 rtaddr);
+	int	(*read_cmd)(struct rsb_controller *ctrl, u8 rtaddr,
+			    u8 addr, u32 *buf, size_t len);
+	int	(*write_cmd)(struct rsb_controller *ctrl, u8 rtaddr,
+			     u8 addr, const u32 *buf, size_t len);
+};
+
+static inline struct rsb_controller *to_rsb_controller(struct device *d)
+{
+	return container_of(d, struct rsb_controller, dev);
+}
+
+static inline
+void *rsb_controller_get_drvdata(const struct rsb_controller *ctrl)
+{
+	return dev_get_drvdata(&ctrl->dev);
+}
+
+static inline void rsb_controller_set_drvdata(struct rsb_controller *ctrl,
+					      void *data)
+{
+	dev_set_drvdata(&ctrl->dev, data);
+}
+
+struct rsb_controller *rsb_controller_alloc(struct device *parent,
+					    size_t size);
+
+/**
+ * rsb_controller_put() - decrement controller refcount
+ * @ctrl	RSB controller.
+ */
+static inline void rsb_controller_put(struct rsb_controller *ctrl)
+{
+	if (ctrl) {
+		mutex_destroy(&ctrl->lock);
+		put_device(&ctrl->dev);
+	}
+}
+
+int rsb_controller_add(struct rsb_controller *ctrl);
+void rsb_controller_remove(struct rsb_controller *ctrl);
+
+/**
+ * struct rsb_driver - RSB slave device driver
+ * @driver:	RSB device drivers should initialize name and owner field of
+ *		this structure.
+ * @probe:	binds this driver to a RSB device.
+ * @remove:	unbinds this driver from the RSB device.
+ */
+struct rsb_driver {
+	struct device_driver driver;
+	int (*probe)(struct rsb_device *rdev);
+	int (*remove)(struct rsb_device *rdev);
+};
+
+static inline struct rsb_driver *to_rsb_driver(struct device_driver *d)
+{
+	return container_of(d, struct rsb_driver, driver);
+}
+
+int rsb_driver_register(struct rsb_driver *rdrv);
+
+/**
+ * rsb_driver_unregister() - unregister an RSB client driver
+ * @rdrv:	the driver to unregister
+ */
+static inline void rsb_driver_unregister(struct rsb_driver *rdrv)
+{
+	if (rdrv)
+		driver_unregister(&rdrv->driver);
+}
+
+#define module_rsb_driver(__rsb_driver) \
+	module_driver(__rsb_driver, rsb_driver_register, \
+			rsb_driver_unregister)
+
+int rsb_register_read(struct rsb_device *rdev, u8 addr, u32 *buf, int size);
+int rsb_register_write(struct rsb_device *rdev, u8 addr, u32 data, int size);
+
+#endif
-- 
2.5.0
