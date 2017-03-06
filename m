From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Mon, 6 Mar 2017 22:40:43 +0100
Subject: [PATCH 1/2] drm/bridge: ti-tfp410: support hpd via gpio
Message-ID: <2e47786ab3d04078ae70d0c4064f7c4d@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

On some boards the hpd pin of a hdmi connector is wired up to a gpio
pin. Since in the DRM world the tfp410 driver is responsible for
handling the connector, add support for hpd gpios in this very driver.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 72 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index b054ea3..77c3390 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -8,6 +8,10 @@
  *
  */
 
+#include <linux/delay.h>
+#include <linux/fwnode.h>
+#include <linux/gpio/consumer.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
@@ -18,11 +22,15 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 
+#define HOTPLUG_DEBOUNCE_MS		1100
+
 struct tfp410 {
 	struct drm_bridge	bridge;
 	struct drm_connector	connector;
 
 	struct i2c_adapter	*ddc;
+	struct gpio_desc	*hpd;
+	struct delayed_work	hpd_work;
 
 	struct device *dev;
 };
@@ -76,6 +84,13 @@ tfp410_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct tfp410 *dvi = drm_connector_to_tfp410(connector);
 
+	if (dvi->hpd) {
+		if (gpiod_get_value_cansleep(dvi->hpd))
+			return connector_status_connected;
+		else
+			return connector_status_disconnected;
+	}
+
 	if (dvi->ddc) {
 		if (drm_probe_ddc(dvi->ddc))
 			return connector_status_connected;
@@ -106,6 +121,9 @@ static int tfp410_attach(struct drm_bridge *bridge)
 		return -ENODEV;
 	}
 
+	if (dvi->hpd)
+		dvi->connector.polled = DRM_CONNECTOR_POLL_HPD;
+
 	drm_connector_helper_add(&dvi->connector,
 				 &tfp410_con_helper_funcs);
 	ret = drm_connector_init(bridge->dev, &dvi->connector,
@@ -125,7 +143,27 @@ static const struct drm_bridge_funcs tfp410_bridge_funcs = {
 	.attach		= tfp410_attach,
 };
 
-static int tfp410_get_connector_ddc(struct tfp410 *dvi)
+static void tfp410_hpd_work_func(struct work_struct *work)
+{
+	struct tfp410 *dvi;
+
+	dvi = container_of(work, struct tfp410, hpd_work.work);
+
+	if (dvi->bridge.dev)
+		drm_helper_hpd_irq_event(dvi->bridge.dev);
+}
+
+static irqreturn_t tfp410_hpd_irq_thread(int irq, void *arg)
+{
+	struct tfp410 *dvi = arg;
+
+	mod_delayed_work(system_wq, &dvi->hpd_work,
+			msecs_to_jiffies(HOTPLUG_DEBOUNCE_MS));
+
+	return IRQ_HANDLED;
+}
+
+static int tfp410_get_connector_properties(struct tfp410 *dvi)
 {
 	struct device_node *ep = NULL, *connector_node = NULL;
 	struct device_node *ddc_phandle = NULL;
@@ -140,6 +178,17 @@ static int tfp410_get_connector_ddc(struct tfp410 *dvi)
 	if (!connector_node)
 		goto fail;
 
+	dvi->hpd = fwnode_get_named_gpiod(&connector_node->fwnode,
+					"hpd-gpios", 0, GPIOD_IN, "hpd");
+	if (IS_ERR(dvi->hpd)) {
+		ret = PTR_ERR(dvi->hpd);
+		dvi->hpd = NULL;
+		if (ret == -ENOENT)
+			ret = 0;
+		else
+			goto fail;
+	}
+
 	ddc_phandle = of_parse_phandle(connector_node, "ddc-i2c-bus", 0);
 	if (!ddc_phandle)
 		goto fail;
@@ -176,10 +225,23 @@ static int tfp410_init(struct device *dev)
 	dvi->bridge.of_node = dev->of_node;
 	dvi->dev = dev;
 
-	ret = tfp410_get_connector_ddc(dvi);
+	ret = tfp410_get_connector_properties(dvi);
 	if (ret)
 		goto fail;
 
+	if (dvi->hpd) {
+		INIT_DELAYED_WORK(&dvi->hpd_work, tfp410_hpd_work_func);
+
+		ret = devm_request_threaded_irq(dev, gpiod_to_irq(dvi->hpd),
+			NULL, tfp410_hpd_irq_thread, IRQF_TRIGGER_RISING |
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			"hdmi-hpd", dvi);
+		if (ret) {
+			DRM_ERROR("failed to register hpd interrupt\n");
+			goto fail;
+		}
+	}
+
 	ret = drm_bridge_add(&dvi->bridge);
 	if (ret) {
 		dev_err(dev, "drm_bridge_add() failed: %d\n", ret);
@@ -189,6 +251,8 @@ static int tfp410_init(struct device *dev)
 	return 0;
 fail:
 	i2c_put_adapter(dvi->ddc);
+	if (dvi->hpd)
+		gpiod_put(dvi->hpd);
 	return ret;
 }
 
@@ -196,10 +260,14 @@ static int tfp410_fini(struct device *dev)
 {
 	struct tfp410 *dvi = dev_get_drvdata(dev);
 
+	cancel_delayed_work_sync(&dvi->hpd_work);
+
 	drm_bridge_remove(&dvi->bridge);
 
 	if (dvi->ddc)
 		i2c_put_adapter(dvi->ddc);
+	if (dvi->hpd)
+		gpiod_put(dvi->hpd);
 
 	return 0;
 }
-- 
2.10.2
