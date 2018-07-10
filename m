From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Tue, 10 Jul 2018 22:35:04 +0200
Subject: [PATCH v2 11/18] drm/sun4i: tcon-top: Add helpers for mux switching
In-Reply-To: <20180710203511.18454-1-jernej.skrabec@siol.net>
References: <20180710203511.18454-1-jernej.skrabec@siol.net>
Message-ID: <20180710203511.18454-12-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to be able to set TCON TOP muxes at runtime. Add helpers for
that.

Old, static configuration of muxes at probe time is preserved for now.
It will be removed when R40 TCON starts using them.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 74 ++++++++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun8i_tcon_top.h |  4 ++
 2 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 9fb51940156f..c09b15b64192 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -14,6 +14,79 @@
 
 #include "sun8i_tcon_top.h"
 
+static bool sun8i_tcon_top_node_is_tcon_top(struct device_node *node)
+{
+	return !!of_match_node(sun8i_tcon_top_of_table, node);
+}
+
+int sun8i_tcon_top_set_hdmi_src(struct device *dev, int tcon)
+{
+	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	unsigned long flags;
+	u32 val;
+
+	if (!sun8i_tcon_top_node_is_tcon_top(dev->of_node)) {
+		dev_err(dev, "Device is not TCON TOP!\n");
+		return -EINVAL;
+	}
+
+	if (tcon < 2 || tcon > 3) {
+		dev_err(dev, "TCON index must be 2 or 3!\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&tcon_top->reg_lock, flags);
+
+	val = readl(tcon_top->regs + TCON_TOP_GATE_SRC_REG);
+	val &= ~TCON_TOP_HDMI_SRC_MSK;
+	val |= FIELD_PREP(TCON_TOP_HDMI_SRC_MSK, tcon - 1);
+	writel(val, tcon_top->regs + TCON_TOP_GATE_SRC_REG);
+
+	spin_unlock_irqrestore(&tcon_top->reg_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(sun8i_tcon_top_set_hdmi_src);
+
+int sun8i_tcon_top_de_config(struct device *dev, int mixer, int tcon)
+{
+	struct sun8i_tcon_top *tcon_top = dev_get_drvdata(dev);
+	unsigned long flags;
+	u32 reg;
+
+	if (!sun8i_tcon_top_node_is_tcon_top(dev->of_node)) {
+		dev_err(dev, "Device is not TCON TOP!\n");
+		return -EINVAL;
+	}
+
+	if (mixer > 1) {
+		dev_err(dev, "Mixer index is too high!\n");
+		return -EINVAL;
+	}
+
+	if (tcon > 3) {
+		dev_err(dev, "TCON index is too high!\n");
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&tcon_top->reg_lock, flags);
+
+	reg = readl(tcon_top->regs + TCON_TOP_PORT_SEL_REG);
+	if (mixer == 0) {
+		reg &= ~TCON_TOP_PORT_DE0_MSK;
+		reg |= FIELD_PREP(TCON_TOP_PORT_DE0_MSK, tcon);
+	} else {
+		reg &= ~TCON_TOP_PORT_DE1_MSK;
+		reg |= FIELD_PREP(TCON_TOP_PORT_DE1_MSK, tcon);
+	}
+	writel(reg, tcon_top->regs + TCON_TOP_PORT_SEL_REG);
+
+	spin_unlock_irqrestore(&tcon_top->reg_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(sun8i_tcon_top_de_config);
+
 static int sun8i_tcon_top_get_connected_ep_id(struct device_node *node,
 					      int port_id)
 {
@@ -109,6 +182,7 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
+	tcon_top->regs = regs;
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
index 39838bbfeaee..0390584a330e 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.h
@@ -26,6 +26,7 @@
 struct sun8i_tcon_top {
 	struct clk			*bus;
 	struct clk_hw_onecell_data	*clk_data;
+	void __iomem			*regs;
 	struct reset_control		*rst;
 
 	/*
@@ -37,4 +38,7 @@ struct sun8i_tcon_top {
 
 extern const struct of_device_id sun8i_tcon_top_of_table[];
 
+int sun8i_tcon_top_set_hdmi_src(struct device *dev, int tcon);
+int sun8i_tcon_top_de_config(struct device *dev, int mixer, int tcon);
+
 #endif /* _SUN8I_TCON_TOP_H_ */
-- 
2.18.0
