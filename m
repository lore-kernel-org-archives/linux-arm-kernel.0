From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 19 Feb 2013 12:35:26 +0100
Subject: [PATCH v3 2/8] reset: Add reset controller API
In-Reply-To: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
References: <1361273732-23357-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1361273732-23357-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a simple API for devices to request being reset
by separate reset controller hardware and implements the
reset signal device tree binding.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
---
Changes since v2:
 - Added ARCH_HAS_RESET_CONTROLLER.
 - Fixed kerneldoc comments.
 - Export reset_controller_(un)register
 - Simplified reset_control_get
 - Call reset_control_put in device_reset
---
 drivers/Kconfig                  |    2 +
 drivers/Makefile                 |    3 +
 drivers/reset/Kconfig            |   13 +++
 drivers/reset/Makefile           |    1 +
 drivers/reset/core.c             |  220 ++++++++++++++++++++++++++++++++++++++
 include/linux/reset-controller.h |   43 ++++++++
 include/linux/reset.h            |   17 +++
 7 files changed, 299 insertions(+)
 create mode 100644 drivers/reset/Kconfig
 create mode 100644 drivers/reset/Makefile
 create mode 100644 drivers/reset/core.c
 create mode 100644 include/linux/reset-controller.h
 create mode 100644 include/linux/reset.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 202fa6d..847f8e3 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -162,4 +162,6 @@ source "drivers/irqchip/Kconfig"
 
 source "drivers/ipack/Kconfig"
 
+source "drivers/reset/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 4af933d..682fb7c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -42,6 +42,9 @@ ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
 obj-y				+= clocksource/
 endif
 
+# reset controllers early, since gpu drivers might rely on them to initialize
+obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
+
 # tty/ comes before char/ so that the VT console is the boot-time
 # default.
 obj-y				+= tty/
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
new file mode 100644
index 0000000..c9d04f7
--- /dev/null
+++ b/drivers/reset/Kconfig
@@ -0,0 +1,13 @@
+config ARCH_HAS_RESET_CONTROLLER
+	bool
+
+menuconfig RESET_CONTROLLER
+	bool "Reset Controller Support"
+	default y if ARCH_HAS_RESET_CONTROLLER
+	help
+	  Generic Reset Controller support.
+
+	  This framework is designed to abstract reset handling of devices
+	  via GPIOs or SoC-internal reset controller modules.
+
+	  If unsure, say no.
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
new file mode 100644
index 0000000..1e2d83f
--- /dev/null
+++ b/drivers/reset/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_RESET_CONTROLLER) += core.o
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
new file mode 100644
index 0000000..d2fe357
--- /dev/null
+++ b/drivers/reset/core.c
@@ -0,0 +1,220 @@
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(reset_controller_list_mutex);
+static LIST_HEAD(reset_controller_list);
+
+/**
+ * struct reset_control - a reset control
+ * @rcdev: a pointer to the reset controller device
+ *         this reset control belongs to
+ * @id: ID of the reset controller in the reset
+ *      controller device
+ */
+struct reset_control {
+	struct reset_controller_dev *rcdev;
+	unsigned int id;
+};
+
+/**
+ * reset_controller_register - register a reset controller device
+ * @rcdev: a pointer to the initialized reset controller device
+ */
+int reset_controller_register(struct reset_controller_dev *rcdev)
+{
+	mutex_lock(&reset_controller_list_mutex);
+	list_add(&rcdev->list, &reset_controller_list);
+	mutex_unlock(&reset_controller_list_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_controller_register);
+
+/**
+ * reset_controller_unregister - unregister a reset controller device
+ * @rcdev: a pointer to the reset controller device
+ */
+void reset_controller_unregister(struct reset_controller_dev *rcdev)
+{
+	mutex_lock(&reset_controller_list_mutex);
+	list_del(&rcdev->list);
+	mutex_unlock(&reset_controller_list_mutex);
+}
+EXPORT_SYMBOL_GPL(reset_controller_unregister);
+
+/**
+ * reset_control_reset - reset the controlled device
+ * @rstc: reset controller
+ */
+int reset_control_reset(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->reset)
+		return rstc->rcdev->ops->reset(rstc->rcdev, rstc->id);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(reset_control_reset);
+
+/**
+ * reset_control_assert - asserts the reset line
+ * @rstc: reset controller
+ */
+int reset_control_assert(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->assert)
+		return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(reset_control_assert);
+
+/**
+ * reset_control_deassert - deasserts the reset line
+ * @rstc: reset controller
+ */
+int reset_control_deassert(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->deassert)
+		return rstc->rcdev->ops->deassert(rstc->rcdev, rstc->id);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(reset_control_deassert);
+
+/**
+ * reset_control_get - Lookup and obtain a reference to a reset controller.
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ *
+ * Use of id names is optional.
+ */
+struct reset_control *reset_control_get(struct device *dev, const char *id)
+{
+	struct reset_control *rstc = ERR_PTR(-EPROBE_DEFER);
+	struct reset_controller_dev *r, *rcdev;
+	struct of_phandle_args args;
+	int index = 0;
+	int ret;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	if (id)
+		index = of_property_match_string(dev->of_node,
+						 "reset-names", id);
+	ret = of_parse_phandle_with_args(dev->of_node, "resets", "#reset-cells",
+					 index, &args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&reset_controller_list_mutex);
+	rcdev = NULL;
+	list_for_each_entry(r, &reset_controller_list, list) {
+		if (args.np == r->of_node) {
+			rcdev = r;
+			break;
+		}
+	}
+	mutex_unlock(&reset_controller_list_mutex);
+	of_node_put(args.np);
+
+	if (!rcdev)
+		return ERR_PTR(-ENODEV);
+
+	try_module_get(rcdev->owner);
+
+	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
+	if (!rstc)
+		return ERR_PTR(-ENOMEM);
+
+	rstc->rcdev = rcdev;
+	rstc->id = args.args[0];
+
+	return rstc;
+}
+EXPORT_SYMBOL_GPL(reset_control_get);
+
+/**
+ * reset_control_put - free the reset controller
+ * @rstc: reset controller
+ */
+
+void reset_control_put(struct reset_control *rstc)
+{
+	if (IS_ERR(rstc))
+		return;
+
+	module_put(rstc->rcdev->owner);
+	kfree(rstc);
+}
+EXPORT_SYMBOL_GPL(reset_control_put);
+
+static void devm_reset_control_release(struct device *dev, void *res)
+{
+	reset_control_put(*(struct reset_control **)res);
+}
+
+/**
+ * devm_reset_control_get - resource managed reset_control_get()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get(). For reset controllers returned from this
+ * function, reset_control_put() is called automatically on driver detach.
+ * See reset_control_get() for more information.
+ */
+struct reset_control *devm_reset_control_get(struct device *dev, const char *id)
+{
+	struct reset_control **ptr, *rstc;
+
+	ptr = devres_alloc(devm_reset_control_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	rstc = reset_control_get(dev, id);
+	if (!IS_ERR(rstc)) {
+		*ptr = rstc;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return rstc;
+}
+EXPORT_SYMBOL_GPL(devm_reset_control_get);
+
+/**
+ * device_reset - find reset controller associated with the device
+ *                and perform reset
+ * @dev: device to be reset by the controller
+ *
+ * Convenience wrapper for reset_control_get() and reset_control_reset().
+ * This is useful for the common case of devices with single, dedicated reset
+ * lines.
+ */
+int device_reset(struct device *dev)
+{
+	struct reset_control *rstc;
+	int ret;
+
+	rstc = reset_control_get(dev, NULL);
+	if (IS_ERR(rstc))
+		return PTR_ERR(rstc);
+
+	ret = reset_control_reset(rstc);
+
+	reset_control_put(rstc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_reset);
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
new file mode 100644
index 0000000..ce5c8c0
--- /dev/null
+++ b/include/linux/reset-controller.h
@@ -0,0 +1,43 @@
+#ifndef _LINUX_RESET_CONTROLLER_H_
+#define _LINUX_RESET_CONTROLLER_H_
+
+#include <linux/list.h>
+
+struct reset_controller_dev;
+
+/**
+ * struct reset_control_ops
+ *
+ * @reset: for self-deasserting resets, does all necessary
+ *         things to reset the device
+ * @assert: manually assert the reset line, if supported
+ * @deassert: manually deassert the reset line, if supported
+ */
+struct reset_control_ops {
+	int (*reset)(struct reset_controller_dev *rcdev, unsigned long id);
+	int (*assert)(struct reset_controller_dev *rcdev, unsigned long id);
+	int (*deassert)(struct reset_controller_dev *rcdev, unsigned long id);
+};
+
+struct module;
+struct device_node;
+
+/**
+ * struct reset_controller_dev - reset controller entity that might
+ *                               provide multiple reset controls
+ * @ops: a pointer to device specific struct reset_control_ops
+ * @owner: kernel module of the reset controller driver
+ * @list: internal list of reset controller devices
+ * @of_node: corresponding device tree node as phandle target
+ */
+struct reset_controller_dev {
+	struct reset_control_ops *ops;
+	struct module *owner;
+	struct list_head list;
+	struct device_node *of_node;
+};
+
+int reset_controller_register(struct reset_controller_dev *rcdev);
+void reset_controller_unregister(struct reset_controller_dev *rcdev);
+
+#endif
diff --git a/include/linux/reset.h b/include/linux/reset.h
new file mode 100644
index 0000000..6082247
--- /dev/null
+++ b/include/linux/reset.h
@@ -0,0 +1,17 @@
+#ifndef _LINUX_RESET_H_
+#define _LINUX_RESET_H_
+
+struct device;
+struct reset_control;
+
+int reset_control_reset(struct reset_control *rstc);
+int reset_control_assert(struct reset_control *rstc);
+int reset_control_deassert(struct reset_control *rstc);
+
+struct reset_control *reset_control_get(struct device *dev, const char *id);
+void reset_control_put(struct reset_control *rstc);
+struct reset_control *devm_reset_control_get(struct device *dev, const char *id);
+
+int device_reset(struct device *dev);
+
+#endif
-- 
1.7.10.4
