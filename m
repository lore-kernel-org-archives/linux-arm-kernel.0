From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 19 Feb 2014 17:58:44 +0100
Subject: [PATCH RFC v1 3/3] clk: Add handling of clk parent and rate assigned
 from DT
In-Reply-To: <1392829124-25705-1-git-send-email-s.nawrocki@samsung.com>
References: <1392829124-25705-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1392829124-25705-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function adds a notifier callback run before a driver is bound to
its driver. It will configure parent clock and clock frequencies based
on [clk-name]-clk-parent and [clk-name]-clk-rate' DT properties.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 .../devicetree/bindings/clock/clock-bindings.txt   |   24 +++++
 drivers/clk/clk.c                                  |   92 ++++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
index 7c52c29..d618498 100644
--- a/Documentation/devicetree/bindings/clock/clock-bindings.txt
+++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
@@ -115,3 +115,27 @@ clock signal, and a UART.
   ("pll" and "pll-switched").
 * The UART has its baud clock connected the external oscillator and its
   register clock connected to the PLL clock (the "pll-switched" signal)
+
+==Static initial configuration of clock parent and clock frequency==
+
+Some platforms require static configuration of (parts of) the clock controller
+often determined by the board design. Such a configuration can be specified in
+a clock consumer node through [clk-name]-clk-parent and [clk-name]-clk-rate DT
+properties. The former should contain phandle and clock specifier of the parent
+clock, the latter the required clock's frequency value (one cell). "clk-name"
+should be listed in the clock-names property and a phandle and a clock specifier
+pair corresponding to it should be present in the clocks property.
+
+    uart at a000 {
+        compatible = "fsl,imx-uart";
+        reg = <0xa000 0x1000>;
+	...
+        clocks = <&clkcon 0>, <&clkcon 3>;
+        clock-names = "baud", "mux";
+
+	mux-clk-parent = <&pll 1>;
+	baud-clk-rate = <460800>;
+    };
+
+In this example the pll is set as parent of "mux" clock and frequency of "baud"
+clock is specified as 460800 Hz.
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 19f6f3f..9238e08 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/sched.h>
 
 #include "clk.h"
@@ -2527,6 +2528,97 @@ const char *of_clk_get_parent_name(struct device_node *np, int index)
 }
 EXPORT_SYMBOL_GPL(of_clk_get_parent_name);
 
+static void __of_clk_assigned_config_set(struct clk *clk, struct clk *pclk,
+					 u32 rate)
+{
+	int rc;
+
+	if (rate) {
+		rc = clk_set_rate(clk, rate);
+		if (rc < 0)
+			pr_err("clk: couldn't set rate of clock %s (%d)\n",
+			       __clk_get_name(clk), rc);
+		else
+			pr_debug("clk: set rate of clock %s to %u\n",
+				 __clk_get_name(clk), rate);
+	}
+
+	if (!IS_ERR(pclk)) {
+		rc = clk_set_parent(clk, pclk);
+		if (rc < 0)
+			pr_err("clk: couldn't set %s as parent of %s (%d)\n",
+			       __clk_get_name(pclk), __clk_get_name(clk), rc);
+		else
+			pr_debug("clk: set %s as parent of %s\n",
+				 __clk_get_name(pclk), __clk_get_name(clk));
+	}
+}
+
+static void of_clk_assigned_config_parse(struct device_node *node)
+{
+	char prop_name[OF_PROP_NAME_MAXLEN];
+	struct property *prop;
+	const char *clk_name;
+	int rc, index = 0;
+
+	of_property_for_each_string(node, "clock-names", prop, clk_name) {
+		struct clk *clk, *pclk;
+		u32 rate = 0;
+
+		snprintf(prop_name, OF_PROP_NAME_MAXLEN,
+					"%s-clk-parent", clk_name);
+		pclk = of_clk_get_list_entry(node, prop_name, 0);
+
+		snprintf(prop_name, OF_PROP_NAME_MAXLEN,
+					"%s-clk-rate", clk_name);
+		rc = of_property_read_u32(node, prop_name, &rate);
+
+		if (!rc || !IS_ERR(pclk)) {
+			/*
+			 * Assuming here of_property_for_each_string() returns
+			 * consecutive values of a DT property in ascending
+			 * index order.
+			 */
+			clk = of_clk_get(node, index);
+
+			if (!IS_ERR(clk))
+				__of_clk_assigned_config_set(clk, pclk, rate);
+			else
+				pr_err("clk: couldn't get clk %s\n", clk_name);
+		}
+		index++;
+	}
+}
+
+
+static int of_clk_setup_notifier_call(struct notifier_block *nb,
+					unsigned long event, void *data)
+{
+	struct device *dev = data;
+
+	if (!dev->of_node)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case BUS_NOTIFY_BIND_DRIVER:
+		/* Parse and configure DT assigned clock parents and rates */
+		of_clk_assigned_config_parse(dev->of_node);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block of_clk_setup_nb = {
+	.notifier_call = of_clk_setup_notifier_call,
+};
+
+int __init of_clk_setup_notifier_init(void)
+{
+	return bus_register_notifier(&platform_bus_type, &of_clk_setup_nb);
+}
+subsys_initcall(of_clk_setup_notifier_init);
+
 /**
  * of_clk_init() - Scan and init clock providers from the DT
  * @matches: array of compatible values and init functions for providers.
-- 
1.7.9.5
