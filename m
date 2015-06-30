From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 30 Jun 2015 23:44:10 +0200
Subject: [RFC 2/3] i2c: mux: demux-pinctrl: add driver
In-Reply-To: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
References: <1435700651-3543-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1435700651-3543-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

This driver allows an I2C bus to switch between multiple masters. This
is not hot-switching because connected I2C slaves will be
re-instantiated. It is meant to select the best I2C core at runtime once
the task is known. Example: Prefer i2c-gpio over another I2C core
because of HW errata affecting your use case.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/i2c/i2c-demux-pinctrl.txt  |  44 ++++
 drivers/i2c/muxes/Kconfig                          |   9 +
 drivers/i2c/muxes/Makefile                         |   2 +
 drivers/i2c/muxes/i2c-demux-pinctrl.c              | 266 +++++++++++++++++++++
 4 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
 create mode 100644 drivers/i2c/muxes/i2c-demux-pinctrl.c

diff --git a/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
new file mode 100644
index 00000000000000..2211f6acbf8c0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-demux-pinctrl.txt
@@ -0,0 +1,44 @@
+Pinctrl-based I2C Bus DeMux
+
+This binding describes an I2C bus demultiplexer that uses pin multiplexing to
+route the I2C signals, and represents the pin multiplexing configuration using
+the pinctrl device tree bindings. This may be used to select one I2C IP core at
+runtime which may have a better feature set for a given task than another I2C
+IP core on the SoC.
+
+    +------------------------------+
+    | SoC                          |
+    |                              |   +-----+  +-----+
+    |   +------------+             |   | dev |  | dev |
+    |   |I2C IP Core1|--\          |   +-----+  +-----+
+    |   +------------+   \------+  |      |        |
+    |                    |Pinmux|--|------+--------+
+    |   +------------+   +------+  |
+    |   |I2C IP Core2|--/          |
+    |   +------------+             |
+    |                              |
+    +------------------------------+
+
+Required properties:
+- compatible: "i2c-demux-pinctrl"
+- i2c-parent: List of phandles of I2C cores to be selected
+- i2c-bus-name: the name of this bus
+
+Also I2C mux properties and child nodes. See mux.txt in this directory.
+
+Also required:
+
+- pinctrl properties for the parent I2C controllers need a pinctrl state
+  with the same name as i2c-bus-name, not "default"!
+
+- the i2c masters must have their status "disabled". This driver will
+  enable them at runtime when needed.
+
+//FIXME: add example
+
+Changing I2C controllers:
+
+The created mux-device will have a file "cur_master" in its sysfs-entry. Write
+0 there for the first master listed in the "i2c-parent" property, 1 for the
+second etc. Reading the file will give you a list with the active master
+marked.
diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index f6d313e528de34..b99cc15d683a50 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -60,4 +60,13 @@ config I2C_MUX_PINCTRL
 	  This driver can also be built as a module. If so, the module will be
 	  called pinctrl-i2cmux.
 
+config I2C_DEMUX_PINCTRL
+	tristate "pinctrl-based I2C demultiplexer"
+	depends on PINCTRL
+	select OF_DYNAMIC
+	help
+	  If you say yes to this option, support will be included for an I2C
+	  demultiplexer that uses the pinctrl subsystem. This is useful if you
+	  want to change the I2C master at run-time depending on features.
+
 endmenu
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index 465778b5d5dc86..4d14cb88d83438 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -3,6 +3,8 @@
 
 obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE)	+= i2c-arb-gpio-challenge.o
 
+obj-$(CONFIG_I2C_DEMUX_PINCTRL)		+= i2c-demux-pinctrl.o
+
 obj-$(CONFIG_I2C_MUX_GPIO)	+= i2c-mux-gpio.o
 obj-$(CONFIG_I2C_MUX_PCA9541)	+= i2c-mux-pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x)	+= i2c-mux-pca954x.o
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
new file mode 100644
index 00000000000000..5444c65de76c55
--- /dev/null
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -0,0 +1,266 @@
+/*
+ * Pinctrl based I2C DeMultiplexer V2 PROTOTYPE!
+ *
+ * Copyright (C) 2015 by Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015 by Renesas Electronics Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ *
+ * See the bindings doc for DTS setup.
+ */
+
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+
+struct i2c_demux_pinctrl_chan {
+	struct device_node *parent_np;
+	struct i2c_adapter *parent_adap;
+	struct of_changeset chgset;
+};
+
+struct i2c_demux_pinctrl_priv {
+	int cur_chan;
+	int num_chan;
+	struct device *dev;
+	const char *bus_name;
+	struct i2c_adapter cur_adap;
+	struct i2c_algorithm algo;
+	struct i2c_demux_pinctrl_chan chan[];
+};
+
+static struct property status_okay = { .name = "status", .length = 3, .value = "ok" };
+
+static int i2c_demux_master_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
+{
+	struct i2c_demux_pinctrl_priv *priv = adap->algo_data;
+	struct i2c_adapter *parent = priv->chan[priv->cur_chan].parent_adap;
+
+	return __i2c_transfer(parent, msgs, num);
+}
+
+static u32 i2c_demux_functionality(struct i2c_adapter *adap)
+{
+	struct i2c_demux_pinctrl_priv *priv = adap->algo_data;
+	struct i2c_adapter *parent = priv->chan[priv->cur_chan].parent_adap;
+
+	return parent->algo->functionality(parent);
+}
+
+static int i2c_demux_activate_master(struct i2c_demux_pinctrl_priv *priv, u32 new_chan)
+{
+	struct i2c_adapter *adap;
+	struct pinctrl *p;
+	int ret;
+
+	mutex_lock(&of_mutex);
+	ret = of_changeset_apply(&priv->chan[new_chan].chgset);
+	mutex_unlock(&of_mutex);
+	if (ret)
+		return ret;
+
+	adap = of_find_i2c_adapter_by_node(priv->chan[new_chan].parent_np);
+	if (!adap)
+		return -EPROBE_DEFER;
+
+	p = devm_pinctrl_get_select(adap->dev.parent, priv->bus_name);
+	if (IS_ERR(p)) {
+		put_device(&adap->dev);
+		return PTR_ERR(p);
+	}
+
+	priv->chan[new_chan].parent_adap = adap;
+	priv->cur_chan = new_chan;
+
+	/* Now fill out current adapter structure. cur_chan must be up to date */
+	priv->algo.master_xfer = i2c_demux_master_xfer;
+	priv->algo.functionality = i2c_demux_functionality;
+
+	snprintf(priv->cur_adap.name, sizeof(priv->cur_adap.name),
+		 "i2c-demux (master i2c-%d)", i2c_adapter_id(adap));
+	priv->cur_adap.owner = THIS_MODULE;
+	priv->cur_adap.algo = &priv->algo;
+	priv->cur_adap.algo_data = priv;
+	priv->cur_adap.dev.parent = priv->dev;
+	priv->cur_adap.class = adap->class;
+	priv->cur_adap.retries = adap->retries;
+	priv->cur_adap.timeout = adap->timeout;
+	priv->cur_adap.quirks = adap->quirks;
+	priv->cur_adap.dev.of_node = priv->dev->of_node;
+	ret = i2c_add_adapter(&priv->cur_adap);
+	if (ret < 0) {
+		dev_err(priv->dev, "failed to add demux-adapter (%d)\n", ret);
+		priv->cur_chan = -EINVAL;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int i2c_demux_deactivate_master(struct i2c_demux_pinctrl_priv *priv)
+{
+	int ret;
+
+	i2c_del_adapter(&priv->cur_adap);
+	put_device(&priv->chan[priv->cur_chan].parent_adap->dev);
+
+	mutex_lock(&of_mutex);
+	ret = of_changeset_revert(&priv->chan[priv->cur_chan].chgset);
+	mutex_unlock(&of_mutex);
+
+	return ret;
+}
+
+static int i2c_demux_change_master(struct i2c_demux_pinctrl_priv *priv, u32 new_chan)
+{
+	int ret;
+
+	if (new_chan == priv->cur_chan)
+		return 0;
+
+	ret = i2c_demux_deactivate_master(priv);
+	if (ret)
+		return ret;
+
+	return i2c_demux_activate_master(priv, new_chan);
+}
+
+static ssize_t cur_master_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
+	int count = 0, i;
+
+	for (i = 0; i < priv->num_chan; i++)
+		count += sprintf(buf + count, "%c %d - %s\n",
+				 i == priv->cur_chan ? '*' : ' ', i,
+				 priv->chan[i].parent_np->full_name);
+	//FIXME: Check count > PAGE_SIZE
+
+	return count;
+}
+
+static ssize_t cur_master_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct i2c_demux_pinctrl_priv *priv = dev_get_drvdata(dev);
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	if (val >= priv->num_chan)
+		return -EINVAL;
+
+	ret = i2c_demux_change_master(priv, val);
+
+	return ret < 0 ? ret : count;
+}
+static DEVICE_ATTR_RW(cur_master);
+
+static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct i2c_demux_pinctrl_priv *priv;
+	int num_chan, i, j, err;
+
+	num_chan = of_count_phandle_with_args(np, "i2c-parent", NULL);
+	if (num_chan < 2) {
+		dev_err(&pdev->dev, "Need at least two I2C masters to switch\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv)
+			   + num_chan * sizeof(struct i2c_demux_pinctrl_chan), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	err = of_property_read_string(np, "i2c-bus-name", &priv->bus_name);
+	if (err)
+		return err;
+
+	for (i = 0; i < num_chan; i++) {
+		struct device_node *adap_np;
+
+		adap_np = of_parse_phandle(np, "i2c-parent", i);
+		if (!adap_np) {
+			dev_err(&pdev->dev, "can't get phandle for parent %d\n", i);
+			err = -ENOENT;
+			goto err_rollback;
+		}
+		priv->chan[i].parent_np = adap_np;
+
+		of_changeset_init(&priv->chan[i].chgset);
+		of_changeset_update_property(&priv->chan[i].chgset, adap_np, &status_okay);
+	}
+
+	priv->num_chan = num_chan;
+	priv->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, priv);
+
+	/* switch to first parent as active master */
+	i2c_demux_activate_master(priv, 0);
+
+	err = device_create_file(&pdev->dev, &dev_attr_cur_master);
+	if (err)
+		goto err_rollback;
+
+	return 0;
+
+err_rollback:
+	for (j = 0; j < i; j++) {
+		of_node_put(priv->chan[j].parent_np);
+		of_changeset_destroy(&priv->chan[j].chgset);
+	}
+
+	return err;
+}
+
+static int i2c_demux_pinctrl_remove(struct platform_device *pdev)
+{
+	struct i2c_demux_pinctrl_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	device_remove_file(&pdev->dev, &dev_attr_cur_master);
+
+	i2c_demux_deactivate_master(priv);
+
+	for (i = 0; i < priv->num_chan; i++) {
+		of_node_put(priv->chan[i].parent_np);
+		of_changeset_destroy(&priv->chan[i].chgset);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id i2c_demux_pinctrl_of_match[] = {
+	{ .compatible = "i2c-demux-pinctrl", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, i2c_demux_pinctrl_of_match);
+
+static struct platform_driver i2c_demux_pinctrl_driver = {
+	.driver	= {
+		.name = "i2c-demux-pinctrl",
+		.of_match_table = i2c_demux_pinctrl_of_match,
+	},
+	.probe	= i2c_demux_pinctrl_probe,
+	.remove	= i2c_demux_pinctrl_remove,
+};
+module_platform_driver(i2c_demux_pinctrl_driver);
+
+MODULE_DESCRIPTION("pinctrl-based I2C demux driver");
+MODULE_AUTHOR("Wolfram Sang <wsa@sang-engineering.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:i2c-demux-pinctrl");
-- 
2.1.4
