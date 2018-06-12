From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 12 Jun 2018 22:00:14 +0200
Subject: [PATCH v2 05/27] drm/sun4i: Add TCON TOP driver
In-Reply-To: <20180612200036.21483-1-jernej.skrabec@siol.net>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
Message-ID: <20180612200036.21483-6-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As already described in DT binding, TCON TOP is responsible for
configuring display pipeline. In this initial driver focus is on HDMI
pipeline, so TVE and LCD configuration is not implemented.

Implemented features:
- HDMI source selection
- clock driver (TCON and DSI gating)
- connecting mixers and TCONS

Something similar also existed in previous SoCs, except that it was part
of first TCON.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/Makefile         |   3 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 248 +++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h |  38 ++++
 3 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.c
 create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.h

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 2589f4acd5ae..09fbfd6304ba 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -16,7 +16,8 @@ sun8i-drm-hdmi-y		+= sun8i_hdmi_phy_clk.o
 
 sun8i-mixer-y			+= sun8i_mixer.o sun8i_ui_layer.o \
 				   sun8i_vi_layer.o sun8i_ui_scaler.o \
-				   sun8i_vi_scaler.o sun8i_csc.o
+				   sun8i_vi_scaler.o sun8i_csc.o \
+				   sun8i_tcon_top.o
 
 sun4i-tcon-y			+= sun4i_crtc.o
 sun4i-tcon-y			+= sun4i_dotclock.o
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
new file mode 100644
index 000000000000..60b17e893f08
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2018 Jernej Skrabec <jernej.skrabec@siol.net> */
+
+#include <drm/drmP.h>
+
+#include <dt-bindings/clock/sun8i-tcon-top.h>
+
+#include <linux/bitfield.h>
+#include <linux/component.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+
+#include "sun8i_tcon_top.h"
+
+struct sun8i_tcon_top_gate {
+	const char	*name;
+	u8		bit;
+	int		index;
+};
+
+static const struct sun8i_tcon_top_gate gates[] = {
+	{"bus-tcon-top-dsi", TCON_TOP_TCON_DSI_GATE, CLK_BUS_TCON_TOP_DSI},
+	{"bus-tcon-top-tv0", TCON_TOP_TCON_TV0_GATE, CLK_BUS_TCON_TOP_TV0},
+	{"bus-tcon-top-tv1", TCON_TOP_TCON_TV1_GATE, CLK_BUS_TCON_TOP_TV1},
+};
+
+static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
+					      int port_id)
+{
+	struct device_node *ep, *remote, *port;
+	struct of_endpoint endpoint;
+
+	port = of_graph_get_port_by_id(node, port_id);
+	if (!port)
+		return -ENOENT;
+
+	for_each_available_child_of_node(port, ep) {
+		remote = of_graph_get_remote_port_parent(ep);
+		if (!remote)
+			continue;
+
+		if (of_device_is_available(remote)) {
+			of_graph_parse_endpoint(ep, &endpoint);
+
+			of_node_put(remote);
+
+			return endpoint.id;
+		}
+
+		of_node_put(remote);
+	}
+
+	return -ENOENT;
+}
+
+static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
+			       void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct clk_hw_onecell_data *clk_data;
+	struct sun8i_tcon_top *tcon_top;
+	bool mixer0_unused = false;
+	struct resource *res;
+	void __iomem *regs;
+	const char *parent;
+	int ret, i, id;
+	u32 val;
+
+	tcon_top = devm_kzalloc(dev, sizeof(*tcon_top), GFP_KERNEL);
+	if (!tcon_top)
+		return -ENOMEM;
+
+	clk_data = devm_kzalloc(dev, sizeof(*clk_data) +
+				sizeof(*clk_data->hws) * CLK_NUM,
+				GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+	tcon_top->clk_data = clk_data;
+
+	spin_lock_init(&tcon_top->reg_lock);
+
+	tcon_top->rst = devm_reset_control_get(dev, "rst");
+	if (IS_ERR(tcon_top->rst)) {
+		dev_err(dev, "Couldn't get our reset line\n");
+		return PTR_ERR(tcon_top->rst);
+	}
+
+	tcon_top->bus = devm_clk_get(dev, "bus");
+	if (IS_ERR(tcon_top->bus)) {
+		dev_err(dev, "Couldn't get the bus clock\n");
+		return PTR_ERR(tcon_top->bus);
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	regs = devm_ioremap_resource(dev, res);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	ret = reset_control_deassert(tcon_top->rst);
+	if (ret) {
+		dev_err(dev, "Could not deassert ctrl reset control\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(tcon_top->bus);
+	if (ret) {
+		dev_err(dev, "Could not enable bus clock\n");
+		goto err_assert_reset;
+	}
+
+	val = 0;
+
+	/* check if HDMI mux output is connected */
+	if (sun8i_tcon_top_get_connected_ep_id(dev->of_node, 5) >= 0) {
+		/* find HDMI input endpoint id, if it is connected at all*/
+		id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 4);
+		if (id >= 0)
+			val = FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, id + 1);
+		else
+			DRM_DEBUG_DRIVER("TCON TOP HDMI input is not connected\n");
+	} else {
+		DRM_DEBUG_DRIVER("TCON TOP HDMI output is not connected\n");
+	}
+
+	writel(val, regs + TCON_TOP_GATE_SRC_REG);
+
+	val = 0;
+
+	/* process mixer0 mux output */
+	id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 1);
+	if (id >= 0) {
+		val = FIELD_PREP(TCON_TOP_PORT_DE0_MSK, id);
+	} else {
+		DRM_DEBUG_DRIVER("TCON TOP mixer0 output is not connected\n");
+		mixer0_unused = true;
+	}
+
+	/* process mixer1 mux output */
+	id = sun8i_tcon_top_get_connected_ep_id(dev->of_node, 3);
+	if (id >= 0) {
+		val |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, id);
+
+		/*
+		 * mixer0 mux has priority over mixer1 mux. We have to
+		 * make sure mixer0 doesn't overtake TCON from mixer1.
+		 */
+		if (mixer0_unused && id == 0)
+			val |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, 1);
+	} else {
+		DRM_DEBUG_DRIVER("TCON TOP mixer1 output is not connected\n");
+	}
+
+	writel(val, regs + TCON_TOP_PORT_SEL_REG);
+
+	parent = __clk_get_name(tcon_top->bus);
+
+	for (i = 0; i < CLK_NUM; i++) {
+		const struct sun8i_tcon_top_gate *gate = &gates[i];
+		struct clk_hw *hw;
+
+		hw = clk_hw_register_gate(dev, gate->name, parent, 0,
+					  regs + TCON_TOP_GATE_SRC_REG,
+					  gate->bit, 0, &tcon_top->reg_lock);
+		if (IS_ERR(hw)) {
+			ret = PTR_ERR(hw);
+			goto err_unregister_gates;
+		}
+
+		clk_data->hws[gate->index] = hw;
+	}
+
+	clk_data->num = CLK_NUM;
+
+	ret = of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
+				     clk_data);
+	if (ret)
+		goto err_unregister_gates;
+
+	dev_set_drvdata(dev, tcon_top);
+
+	return 0;
+
+err_unregister_gates:
+	for (i = 0; i < CLK_NUM; i++)
+		if (clk_data->hws[i])
+			clk_hw_unregister_gate(clk_data->hws[i]);
+	clk_disable_unprepare(tcon_top->bus);
+err_assert_reset:
+	reset_control_assert(tcon_top->rst);
+
+	return ret;
+}
+
+static void sun8i_tcon_top_unbind(struct device *dev, struct device *master,
+				  void *data)
+{
+	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	struct clk_hw_onecell_data *clk_data = tcon_top->clk_data;
+	int i;
+
+	of_clk_del_provider(dev->of_node);
+	for (i = 0; i < CLK_NUM; i++)
+		clk_hw_unregister_gate(clk_data->hws[i]);
+
+	clk_disable_unprepare(tcon_top->bus);
+	reset_control_assert(tcon_top->rst);
+}
+
+static const struct component_ops sun8i_tcon_top_ops = {
+	.bind	= sun8i_tcon_top_bind,
+	.unbind	= sun8i_tcon_top_unbind,
+};
+
+static int sun8i_tcon_top_probe(struct platform_device *pdev)
+{
+	return component_add(&pdev->dev, &sun8i_tcon_top_ops);
+}
+
+static int sun8i_tcon_top_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &sun8i_tcon_top_ops);
+
+	return 0;
+}
+
+/* sun4i_drv uses this list to check if a device node is a TCON TOP */
+const struct of_device_id sun8i_tcon_top_of_table[] = {
+	{ .compatible = "allwinner,sun8i-r40-tcon-top" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sun8i_tcon_top_of_table);
+EXPORT_SYMBOL(sun8i_tcon_top_of_table);
+
+static struct platform_driver sun8i_tcon_top_platform_driver = {
+	.probe		= sun8i_tcon_top_probe,
+	.remove		= sun8i_tcon_top_remove,
+	.driver		= {
+		.name		= "sun8i-tcon-top",
+		.of_match_table	= sun8i_tcon_top_of_table,
+	},
+};
+module_platform_driver(sun8i_tcon_top_platform_driver);
+
+MODULE_AUTHOR("Jernej Skrabec <jernej.skrabec@siol.net>");
+MODULE_DESCRIPTION("Allwinner R40 TCON TOP driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
new file mode 100644
index 000000000000..6cbb9f90d702
--- /dev/null
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2018 Jernej Skrabec <jernej.skrabec@siol.net> */
+
+#ifndef _SUN8I_TCON_TOP_H_
+#define _SUN8I_TCON_TOP_H_
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/reset.h>
+#include <linux/spinlock.h>
+
+#define TCON_TOP_PORT_SEL_REG		0x1C
+#define TCON_TOP_PORT_DE0_MSK			GENMASK(1, 0)
+#define TCON_TOP_PORT_DE1_MSK			GENMASK(5, 4)
+
+#define TCON_TOP_GATE_SRC_REG		0x20
+#define TCON_TOP_HDMI_SRC_MSK			GENMASK(29, 28)
+#define TCON_TOP_TCON_TV1_GATE			24
+#define TCON_TOP_TCON_TV0_GATE			20
+#define TCON_TOP_TCON_DSI_GATE			16
+
+#define CLK_NUM					3
+
+struct sun8i_tcon_top {
+	struct clk			*bus;
+	struct clk_hw_onecell_data	*clk_data;
+	struct reset_control		*rst;
+
+	/*
+	 * spinlock is used for locking access to registers from different
+	 * places - tcon driver and clk subsystem.
+	 */
+	spinlock_t			reg_lock;
+};
+
+extern const struct of_device_id sun8i_tcon_top_of_table[];
+
+#endif /* _SUN8I_TCON_TOP_H_ */
-- 
2.17.1
