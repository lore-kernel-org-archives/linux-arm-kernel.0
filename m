From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 16 Jan 2013 17:13:02 +0100
Subject: [PATCH 2/7] reset: Add reset controller API
In-Reply-To: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
References: <1358352787-15441-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1358352787-15441-3-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a simple API for devices to request being reset
by separate reset controller hardware and implements the
reset signal device tree binding.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/Kconfig        |    2 +
 drivers/Makefile       |    2 +
 drivers/reset/Kconfig  |   10 ++
 drivers/reset/Makefile |    2 +
 drivers/reset/core.c   |  241 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 257 insertions(+)
 create mode 100644 drivers/reset/Kconfig
 create mode 100644 drivers/reset/Makefile
 create mode 100644 drivers/reset/core.c

diff --git a/drivers/Kconfig b/drivers/Kconfig
index f5fb072..51f73ae 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -158,4 +158,6 @@ source "drivers/irqchip/Kconfig"
 
 source "drivers/ipack/Kconfig"
 
+source "drivers/reset/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 346ecc5..870bf7e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -42,6 +42,8 @@ ifndef CONFIG_ARCH_USES_GETTIMEOFFSET
 obj-y				+= clocksource/
 endif
 
+obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
+
 # tty/ comes before char/ so that the VT console is the boot-time
 # default.
 obj-y				+= tty/
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
new file mode 100644
index 0000000..82dc89e
--- /dev/null
+++ b/drivers/reset/Kconfig
@@ -0,0 +1,10 @@
+menuconfig RESET_CONTROLLER
+	bool "Reset Controller Support"
+	help
+	  Generic Reset Controller support.
+
+	  This framework is designed to abstract reset handling of devices
+	  via GPIOs or SoC-internal reset controller modules.
+
+	  If unsure, say no.
+
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
new file mode 100644
index 0000000..9a7b6df
--- /dev/null
+++ b/drivers/reset/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_RESET_CONTROLLER) += core.o
+
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
new file mode 100644
index 0000000..f0ed61b
--- /dev/null
+++ b/drivers/reset/core.c
@@ -0,0 +1,241 @@
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
+ *
+ * @id: ID of the reset controller in the reset
+ *      controller device
+ */
+struct reset_control {
+	struct reset_controller_dev *rcdev;
+	unsigned int id;
+};
+
+/**
+ * reset_controller_register - register a reset controller
+ *
+ * @ops: a pointer to struct reset_controller_ops callbacks
+ *
+ * Returns a struct reset_controller_dev or IS_ERR() condition
+ * containing errno.
+ */
+int reset_controller_register(struct reset_controller_dev *rcdev)
+{
+	mutex_lock(&reset_controller_list_mutex);
+	list_add(&rcdev->list, &reset_controller_list);
+	mutex_unlock(&reset_controller_list_mutex);
+
+	return 0;
+}
+
+/**
+ * reset_control_reset - reset the controlled device
+ * @rstc: reset controller
+ */
+int reset_control_reset(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->reset)
+		return rstc->rcdev->ops->reset(rstc->id);
+
+	return 0;
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
+		return rstc->rcdev->ops->assert(rstc->id);
+
+	return 0;
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
+		return rstc->rcdev->ops->deassert(rstc->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_control_deassert);
+
+/**
+ * reset_control_is_asserted - deasserts the reset line
+ * @rstc: reset controller
+ */
+int reset_control_is_asserted(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->is_asserted)
+		return rstc->rcdev->ops->is_asserted(rstc->id);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_control_is_asserted);
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
+	struct device_node *rcdev_node;
+	struct of_phandle_args args;
+	int rcdev_index;
+	int ret;
+	int i;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	rcdev_node = NULL;
+	for (i = 0; rcdev_node == NULL; i++) {
+		ret = of_parse_phandle_with_args(dev->of_node, "resets",
+						 "#reset-cells", i, &args);
+		if (ret)
+			return ERR_PTR(ret);
+		of_node_put(args.np);
+		if (args.args_count <= 0)
+			return ERR_PTR(-EINVAL);
+
+		if (id) {
+			const char *reset_name;
+			ret = of_property_read_string_index(dev->of_node,
+							    "reset-names", i,
+							    &reset_name);
+			if (ret)
+				return ERR_PTR(ret);
+			if (strcmp(id, reset_name) != 0)
+				continue;
+		}
+
+		rcdev_node = args.np;
+		rcdev_index = args.args[0];
+	}
+
+	mutex_lock(&reset_controller_list_mutex);
+	rcdev = NULL;
+	list_for_each_entry(r, &reset_controller_list, list) {
+		if (rcdev_node == r->of_node) {
+			rcdev = r;
+			break;
+		}
+	}
+	mutex_unlock(&reset_controller_list_mutex);
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
+	rstc->id = rcdev_index;
+
+	return rstc;
+}
+EXPORT_SYMBOL_GPL(reset_control_get);
+
+/**
+ * reset_control_put - free the reset controller
+ * @reset: reset controller
+ */
+
+void reset_control_put(struct reset_control *rstc)
+{
+	if (rstc == NULL || IS_ERR(rstc))
+		return;
+
+	kfree(rstc);
+	module_put(rstc->rcdev->owner);
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
+	kfree(rstc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_reset);
-- 
1.7.10.4
