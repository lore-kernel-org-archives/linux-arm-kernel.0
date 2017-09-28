From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 28 Sep 2017 15:07:30 +0200
Subject: [RFC PATCH 4/4] drm/bridge/sii8620: use micro-USB cable detection
 logic to detect MHL
In-Reply-To: <20170928130730.8747-1-a.hajda@samsung.com>
References: <20170928130730.8747-1-a.hajda@samsung.com>
 <CGME20170928130737eucas1p15a82a6fd0f9175075249e02c072e6b0d@eucas1p1.samsung.com>
Message-ID: <20170928130730.8747-5-a.hajda@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maciej Purski <m.purski@samsung.com>

Currently MHL chip must be turned on permanently to detect MHL cable. It
duplicates micro-USB controller's (MUIC) functionality and consumes
unnecessary power. Lets use extcon attached to MUIC to enable MHL chip
only if it detects MHL cable.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
This is rework of the patch by Maciej with following changes:
- use micro-USB port bindings to get extcon, instead of extcon property,
- fixed remove sequence,
- fixed extcon get state logic.

Code finding extcon node is hacky IMO, I guess ultimately it should be done
via some framework (maybe even extcon), or at least via helper, I hope it
can stay as is until the proper solution will be merged.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 98 ++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 5131bfb94f06..6f40cbc2445e 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -17,6 +17,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/extcon.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -25,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
@@ -78,6 +80,10 @@ struct sii8620 {
 	struct edid *edid;
 	unsigned int gen2_write_burst:1;
 	enum sii8620_mt_state mt_state;
+	struct extcon_dev *extcon;
+	struct notifier_block extcon_nb;
+	struct work_struct extcon_wq;
+	int cable_state;
 	struct list_head mt_queue;
 	struct {
 		int r_size;
@@ -2102,6 +2108,78 @@ static void sii8620_cable_in(struct sii8620 *ctx)
 	enable_irq(to_i2c_client(ctx->dev)->irq);
 }
 
+static void sii8620_cable_out(struct sii8620 *ctx)
+{
+	disable_irq(to_i2c_client(ctx->dev)->irq);
+	sii8620_hw_off(ctx);
+}
+
+static void sii8620_extcon_work(struct work_struct *work)
+{
+	struct sii8620 *ctx =
+		container_of(work, struct sii8620, extcon_wq);
+	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
+
+	if (state == ctx->cable_state)
+		return;
+
+	ctx->cable_state = state;
+
+	if (state > 0)
+		sii8620_cable_in(ctx);
+	else
+		sii8620_cable_out(ctx);
+}
+
+static int sii8620_extcon_notifier(struct notifier_block *self,
+			unsigned long event, void *ptr)
+{
+	struct sii8620 *ctx =
+		container_of(self, struct sii8620, extcon_nb);
+
+	schedule_work(&ctx->extcon_wq);
+
+	return NOTIFY_DONE;
+}
+
+static int sii8620_extcon_init(struct sii8620 *ctx)
+{
+	struct extcon_dev *edev;
+	struct device_node *musb, *muic;
+	int ret;
+
+	/* get micro-USB connector node */
+	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
+	/* next get micro-USB Interface Controller node */
+	muic = of_graph_get_remote_node(musb, -1, 0);
+	of_node_put(musb);
+
+	if (!muic) {
+		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
+		return 0;
+	}
+
+	edev = extcon_get_edev_by_of_node(muic);
+	of_node_put(muic);
+	if (IS_ERR(edev)) {
+		if (PTR_ERR(edev) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_err(ctx->dev, "Invalid or missing extcon\n");
+		return PTR_ERR(edev);
+	}
+
+	ctx->extcon = edev;
+	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
+	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
+	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
+	if (ret) {
+		dev_err(ctx->dev, "failed to register notifier for MHL\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct sii8620, bridge);
@@ -2201,13 +2279,20 @@ static int sii8620_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	ret = sii8620_extcon_init(ctx);
+	if (ret < 0) {
+		dev_err(ctx->dev, "failed to initialize EXTCON\n");
+		return ret;
+	}
+
 	i2c_set_clientdata(client, ctx);
 
 	ctx->bridge.funcs = &sii8620_bridge_funcs;
 	ctx->bridge.of_node = dev->of_node;
 	drm_bridge_add(&ctx->bridge);
 
-	sii8620_cable_in(ctx);
+	if (!ctx->extcon)
+		sii8620_cable_in(ctx);
 
 	return 0;
 }
@@ -2216,9 +2301,16 @@ static int sii8620_remove(struct i2c_client *client)
 {
 	struct sii8620 *ctx = i2c_get_clientdata(client);
 
-	disable_irq(to_i2c_client(ctx->dev)->irq);
+	if (ctx->extcon) {
+		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
+					   &ctx->extcon_nb);
+		flush_work(&ctx->extcon_wq);
+		if (ctx->cable_state > 0)
+			sii8620_cable_out(ctx);
+	} else {
+		sii8620_cable_out(ctx);
+	}
 	drm_bridge_remove(&ctx->bridge);
-	sii8620_hw_off(ctx);
 
 	return 0;
 }
-- 
2.14.1
