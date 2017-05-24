From: s-anna@ti.com (Suman Anna)
Date: Wed, 24 May 2017 13:09:30 -0500
Subject: [PATCH v5 2/2] reset: Add the TI SCI reset driver
In-Reply-To: <20170524180930.9290-1-s-anna@ti.com>
References: <20170524180930.9290-1-s-anna@ti.com>
Message-ID: <20170524180930.9290-3-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Andrew F. Davis" <afd@ti.com>

Some TI Keystone family of SoCs contain a system controller (like the
Power Management Micro Controller (PMMC) on 66AK2G SoCs) that manage
the low-level device control (like clocks, resets etc) for the various
hardware modules present on the SoC. These device control operations
are provided to the host processor OS through a communication protocol
called the TI System Control Interface (TI SCI) protocol.

This patch adds a reset driver that communicates to the system
controller over the TI SCI protocol for performing reset management
of various devices present on the SoC. Various reset functionalities
are achieved by the means of different TI SCI device operations
provided by the TI SCI framework.

Signed-off-by: Andrew F. Davis <afd@ti.com>
[s-anna at ti.com: documentation changes, revised commit message]
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
---
v5 Changes:
 - Dropped the dependency line on RESET_CONTROLLER in Kconfig
 - Updated license year to include 2017
 - Checkpatch fixes at the dev_ops->get_device_resets callsites

 MAINTAINERS                  |   1 +
 drivers/reset/Kconfig        |   8 ++
 drivers/reset/Makefile       |   1 +
 drivers/reset/reset-ti-sci.c | 269 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 279 insertions(+)
 create mode 100644 drivers/reset/reset-ti-sci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a4c48ec23a11..545ab28f006a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12631,6 +12631,7 @@ F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
 F:	include/dt-bindings/genpd/k2g.h
 F:	drivers/soc/ti/ti_sci_pm_domains.c
 F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
+F:	drivers/reset/reset-ti-sci.c
 
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 42d5631c6da0..671ef2a01529 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -80,6 +80,14 @@ config RESET_SUNXI
 	help
 	  This enables the reset driver for Allwinner SoCs.
 
+config RESET_TI_SCI
+	tristate "TI System Control Interface (TI-SCI) reset driver"
+	depends on TI_SCI_PROTOCOL
+	help
+	  This enables the reset driver support over TI System Control Interface
+	  available on some new TI's SoCs. If you wish to use reset resources
+	  managed by the TI System Controller, say Y here. Otherwise, say N.
+
 config RESET_TI_SYSCON
 	tristate "TI SYSCON Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 26270e0f8342..063dfdc7c400 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_STM32) += reset-stm32.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
+obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
 obj-$(CONFIG_RESET_UNIPHIER) += reset-uniphier.o
 obj-$(CONFIG_RESET_ZX2967) += reset-zx2967.o
diff --git a/drivers/reset/reset-ti-sci.c b/drivers/reset/reset-ti-sci.c
new file mode 100644
index 000000000000..2097abe1706a
--- /dev/null
+++ b/drivers/reset/reset-ti-sci.c
@@ -0,0 +1,269 @@
+/*
+ * Texas Instrument's System Control Interface (TI-SCI) reset driver
+ *
+ * Copyright (C) 2015-2017 Texas Instruments Incorporated - http://www.ti.com/
+ *	Andrew F. Davis <afd@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+
+/**
+ * struct ti_sci_reset_control - reset control structure
+ * @dev_id: SoC-specific device identifier
+ * @reset_mask: reset mask to use for toggling reset
+ * @lock: synchronize reset_mask read-modify-writes
+ */
+struct ti_sci_reset_control {
+	u32 dev_id;
+	u32 reset_mask;
+	struct mutex lock;
+};
+
+/**
+ * struct ti_sci_reset_data - reset controller information structure
+ * @rcdev: reset controller entity
+ * @dev: reset controller device pointer
+ * @sci: TI SCI handle used for communication with system controller
+ * @idr: idr structure for mapping ids to reset control structures
+ */
+struct ti_sci_reset_data {
+	struct reset_controller_dev rcdev;
+	struct device *dev;
+	const struct ti_sci_handle *sci;
+	struct idr idr;
+};
+
+#define to_ti_sci_reset_data(p)	\
+	container_of((p), struct ti_sci_reset_data, rcdev)
+
+/**
+ * ti_sci_reset_set() - program a device's reset
+ * @rcdev: reset controller entity
+ * @id: ID of the reset to toggle
+ * @assert: boolean flag to indicate assert or deassert
+ *
+ * This is a common internal function used to assert or deassert a device's
+ * reset using the TI SCI protocol. The device's reset is asserted if the
+ * @assert argument is true, or deasserted if @assert argument is false.
+ * The mechanism itself is a read-modify-write procedure, the current device
+ * reset register is read using a TI SCI device operation, the new value is
+ * set or un-set using the reset's mask, and the new reset value written by
+ * using another TI SCI device operation.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int ti_sci_reset_set(struct reset_controller_dev *rcdev,
+			    unsigned long id, bool assert)
+{
+	struct ti_sci_reset_data *data = to_ti_sci_reset_data(rcdev);
+	const struct ti_sci_handle *sci = data->sci;
+	const struct ti_sci_dev_ops *dev_ops = &sci->ops.dev_ops;
+	struct ti_sci_reset_control *control;
+	u32 reset_state;
+	int ret;
+
+	control = idr_find(&data->idr, id);
+	if (!control)
+		return -EINVAL;
+
+	mutex_lock(&control->lock);
+
+	ret = dev_ops->get_device_resets(sci, control->dev_id, &reset_state);
+	if (ret)
+		goto out;
+
+	if (assert)
+		reset_state |= control->reset_mask;
+	else
+		reset_state &= ~control->reset_mask;
+
+	ret = dev_ops->set_device_resets(sci, control->dev_id, reset_state);
+out:
+	mutex_unlock(&control->lock);
+
+	return ret;
+}
+
+/**
+ * ti_sci_reset_assert() - assert device reset
+ * @rcdev: reset controller entity
+ * @id: ID of the reset to be asserted
+ *
+ * This function implements the reset driver op to assert a device's reset
+ * using the TI SCI protocol. This invokes the function ti_sci_reset_set()
+ * with the corresponding parameters as passed in, but with the @assert
+ * argument set to true for asserting the reset.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int ti_sci_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return ti_sci_reset_set(rcdev, id, true);
+}
+
+/**
+ * ti_sci_reset_deassert() - deassert device reset
+ * @rcdev: reset controller entity
+ * @id: ID of the reset to be deasserted
+ *
+ * This function implements the reset driver op to deassert a device's reset
+ * using the TI SCI protocol. This invokes the function ti_sci_reset_set()
+ * with the corresponding parameters as passed in, but with the @assert
+ * argument set to false for deasserting the reset.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int ti_sci_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return ti_sci_reset_set(rcdev, id, false);
+}
+
+/**
+ * ti_sci_reset_status() - check device reset status
+ * @rcdev: reset controller entity
+ * @id: ID of reset to be checked
+ *
+ * This function implements the reset driver op to return the status of a
+ * device's reset using the TI SCI protocol. The reset register value is read
+ * by invoking the TI SCI device operation .get_device_resets(), and the
+ * status of the specific reset is extracted and returned using this reset's
+ * reset mask.
+ *
+ * Return: 0 if reset is deasserted, or a non-zero value if reset is asserted
+ */
+static int ti_sci_reset_status(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct ti_sci_reset_data *data = to_ti_sci_reset_data(rcdev);
+	const struct ti_sci_handle *sci = data->sci;
+	const struct ti_sci_dev_ops *dev_ops = &sci->ops.dev_ops;
+	struct ti_sci_reset_control *control;
+	u32 reset_state;
+	int ret;
+
+	control = idr_find(&data->idr, id);
+	if (!control)
+		return -EINVAL;
+
+	ret = dev_ops->get_device_resets(sci, control->dev_id, &reset_state);
+	if (ret)
+		return ret;
+
+	return reset_state & control->reset_mask;
+}
+
+static struct reset_control_ops ti_sci_reset_ops = {
+	.assert		= ti_sci_reset_assert,
+	.deassert	= ti_sci_reset_deassert,
+	.status		= ti_sci_reset_status,
+};
+
+/**
+ * ti_sci_reset_of_xlate() - translate a set of OF arguments to a reset ID
+ * @rcdev: reset controller entity
+ * @reset_spec: OF reset argument specifier
+ *
+ * This function performs the translation of the reset argument specifier
+ * values defined in a reset consumer device node. The function allocates a
+ * reset control structure for that device reset, and will be used by the
+ * driver for performing any reset functions on that reset. An idr structure
+ * is allocated and used to map to the reset control structure. This idr
+ * is used by the driver to do reset lookups.
+ *
+ * Return: 0 for successful request, else a corresponding error value
+ */
+static int ti_sci_reset_of_xlate(struct reset_controller_dev *rcdev,
+				 const struct of_phandle_args *reset_spec)
+{
+	struct ti_sci_reset_data *data = to_ti_sci_reset_data(rcdev);
+	struct ti_sci_reset_control *control;
+
+	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
+		return -EINVAL;
+
+	control = devm_kzalloc(data->dev, sizeof(*control), GFP_KERNEL);
+	if (!control)
+		return -ENOMEM;
+
+	control->dev_id = reset_spec->args[0];
+	control->reset_mask = reset_spec->args[1];
+	mutex_init(&control->lock);
+
+	return idr_alloc(&data->idr, control, 0, 0, GFP_KERNEL);
+}
+
+static const struct of_device_id ti_sci_reset_of_match[] = {
+	{ .compatible = "ti,sci-reset", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, ti_sci_reset_of_match);
+
+static int ti_sci_reset_probe(struct platform_device *pdev)
+{
+	struct ti_sci_reset_data *data;
+
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->sci = devm_ti_sci_get_handle(&pdev->dev);
+	if (IS_ERR(data->sci))
+		return PTR_ERR(data->sci);
+
+	data->rcdev.ops = &ti_sci_reset_ops;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.of_node = pdev->dev.of_node;
+	data->rcdev.of_reset_n_cells = 2;
+	data->rcdev.of_xlate = ti_sci_reset_of_xlate;
+	data->dev = &pdev->dev;
+	idr_init(&data->idr);
+
+	platform_set_drvdata(pdev, data);
+
+	return reset_controller_register(&data->rcdev);
+}
+
+static int ti_sci_reset_remove(struct platform_device *pdev)
+{
+	struct ti_sci_reset_data *data = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&data->rcdev);
+
+	idr_destroy(&data->idr);
+
+	return 0;
+}
+
+static struct platform_driver ti_sci_reset_driver = {
+	.probe = ti_sci_reset_probe,
+	.remove = ti_sci_reset_remove,
+	.driver = {
+		.name = "ti-sci-reset",
+		.of_match_table = ti_sci_reset_of_match,
+	},
+};
+module_platform_driver(ti_sci_reset_driver);
+
+MODULE_AUTHOR("Andrew F. Davis <afd@ti.com>");
+MODULE_DESCRIPTION("TI System Control Interface (TI SCI) Reset driver");
+MODULE_LICENSE("GPL v2");
-- 
2.12.0
