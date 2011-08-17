From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 17 Aug 2011 12:47:27 +0100
Subject: [RFC PATCH 1/2] of: add a generic pinmux helper
In-Reply-To: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
References: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1313581648-22303-2-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a helper function of_pinmux_parse() that can be used to
extract common pinmux configuration to avoid each platform implementing
a parsing loop.  Platforms supply the node containing the pinmux
definitions and a platform specific callback for configuring a pingroup.

Cc: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/of/Kconfig        |    5 +++
 drivers/of/Makefile       |    1 +
 drivers/of/of_pinmux.c    |   80 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_pinmux.h |   67 +++++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 0 deletions(-)
 create mode 100644 drivers/of/of_pinmux.c
 create mode 100644 include/linux/of_pinmux.h

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index b3bfea5..d300c02 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -87,4 +87,9 @@ config OF_PCI_IRQ
 	help
 	  OpenFirmware PCI IRQ routing helpers
 
+config OF_PINMUX
+	def_bool y
+	help
+	  OpenFirmware pin multiplexing helpers
+
 endmenu # OF
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index 74b959c..04d7fa9 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_OF_SPI)	+= of_spi.o
 obj-$(CONFIG_OF_MDIO)	+= of_mdio.o
 obj-$(CONFIG_OF_PCI)	+= of_pci.o
 obj-$(CONFIG_OF_PCI_IRQ)  += of_pci_irq.o
+obj-$(CONFIG_OF_PINMUX) += of_pinmux.o
diff --git a/drivers/of/of_pinmux.c b/drivers/of/of_pinmux.c
new file mode 100644
index 0000000..adfdfc0
--- /dev/null
+++ b/drivers/of/of_pinmux.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * Generic pinmux bindings for device tree.
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
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_pinmux.h>
+
+/**
+ * of_pinmux_parse - configure a set of pinmux groups for a pinmux controller
+ *
+ * @controller: the controller to configure the pinmux entries for.  This
+ *	defines the controller device node and the callback for configuring
+ *	the pingroups.
+ *
+ * This helper loops over all of the child nodes of a pinmux controller and
+ * collects the configuration for each pinmux group.  A pinmux group is
+ * defined as one or more pins that are configured to a common function.  This
+ * handles common properties that many platforms may implement, but for
+ * platform specific properties these may be handled in the configure
+ * callback.
+ */
+int of_pinmux_parse(const struct of_pinmux_ctrl *controller)
+{
+	struct device_node *np;
+
+	if (!controller || !controller->pinmux || !controller->configure)
+		return -EINVAL;
+
+	for_each_child_of_node(controller->pinmux, np) {
+		struct of_pinmux_cfg config = {
+			.pin = np,
+		};
+		int ret;
+
+		ret = of_property_read_string(np, "function",
+					      &config.function);
+		if (ret < 0) {
+			pr_err("no function for pingroup %s\n", np->name);
+			continue;
+		}
+
+		if (of_find_property(np, "pull-up", NULL))
+			config.flags |= OF_PINMUX_PULL_UP;
+		if (of_find_property(np, "pull-down", NULL))
+			config.flags |= OF_PINMUX_PULL_DOWN;
+
+		if ((config.flags & OF_PINMUX_PULL_MASK) ==
+		    OF_PINMUX_PULL_MASK) {
+			pr_warn("pingroup %s has both pull-up and pull-down properties - defaulting to no pull\n",
+				np->name);
+			config.flags &= ~OF_PINMUX_PULL_MASK;
+		}
+
+		if (of_find_property(np, "tristate", NULL))
+			config.flags |= OF_PINMUX_TRISTATE;
+
+		pr_debug("configure pingroup %s, func=%s, flags=0x%lx\n",
+			 np->name, config.function, config.flags);
+		if (controller->configure(controller, &config))
+			pr_warn("failed to configure pingroup %s\n", np->name);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_pinmux_parse);
diff --git a/include/linux/of_pinmux.h b/include/linux/of_pinmux.h
new file mode 100644
index 0000000..61f2ab6
--- /dev/null
+++ b/include/linux/of_pinmux.h
@@ -0,0 +1,67 @@
+/*
+ * Copyright (c) 2011 Picochip Ltd., Jamie Iles
+ *
+ * Generic pinmux bindings for device tree.
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
+ */
+#ifndef __OF_PINMUX_H__
+#define __OF_PINMUX_H__
+
+struct device_node;
+
+#define OF_PINMUX_PULL_UP	(1 << 0)
+#define OF_PINMUX_PULL_DOWN	(1 << 1)
+#define OF_PINMUX_TRISTATE	(1 << 2)
+
+#define OF_PINMUX_PULL_MASK	(OF_PINMUX_PULL_UP | OF_PINMUX_PULL_DOWN)
+
+/**
+ * struct of_pinmux_cfg - configuration state for a single pinmux entry.
+ *
+ * @function: the name of the function that the pinmux entry should be
+ *	configured to.
+ * @pin: the device_node of the pinmux entry that should be configured.
+ *	Platform specific properties that aren't in the generic binding may be
+ *	obtained from this device node.
+ * @flags: flags for common pinmux options such as pull and tristate.
+ */
+struct of_pinmux_cfg {
+	const char		*function;
+	struct device_node	*pin;
+	unsigned long		flags;
+};
+
+/**
+ * struct of_pinmux_ctrl - platform specific pinmux control state.
+ *
+ * @pinmux: the pinmux device node.  All child nodes are required to be the
+ *	pinmux entry definitions.  Depending on the platform, this may either be
+ *	a single pin or a group of pins where they can be set to a common
+ *	function.
+ * @configure: platform specific callback to configure the pinmux entry.
+ */
+struct of_pinmux_ctrl {
+	struct device_node *pinmux;
+	int		   (*configure)(const struct of_pinmux_ctrl *ctrl,
+					const struct of_pinmux_cfg *cfg);
+};
+
+#ifdef CONFIG_OF
+extern int of_pinmux_parse(const struct of_pinmux_ctrl *controller);
+#else
+static inline int of_pinmux_parse(const struct of_pinmux_ctrl *controller)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_OF */
+
+#endif /* __OF_PINMUX_H__ */
-- 
1.7.4.1
