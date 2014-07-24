From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 24 Jul 2014 15:57:39 +0100
Subject: [PATCH RFA 2/2] drm/i2c: tda998x: add component support
Message-ID: <E1XAKSh-0004YX-7c@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add component helper support to the tda998x driver.  This permits the
TDA998x to be declared as a separate device in device tree, and bound
at the appropriate moment with a co-operating card driver.

The existing slave_encoder interfaces are kept while there are existing
users of it in order to prevent regressions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
RFA = request for acks, but tested-by's are also welcome, particularly
for tilcdc hardware.

 drivers/gpu/drm/i2c/tda998x_drv.c | 212 +++++++++++++++++++++++++++++++++++---
 1 file changed, 198 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i2c/tda998x_drv.c b/drivers/gpu/drm/i2c/tda998x_drv.c
index 64e120c5299a..3b07ff7e6348 100644
--- a/drivers/gpu/drm/i2c/tda998x_drv.c
+++ b/drivers/gpu/drm/i2c/tda998x_drv.c
@@ -15,8 +15,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-
-
+#include <linux/component.h>
 #include <linux/hdmi.h>
 #include <linux/module.h>
 #include <linux/irq.h>
@@ -1252,18 +1251,6 @@ static struct drm_encoder_slave_funcs tda998x_encoder_slave_funcs = {
 
 /* I2C driver functions */
 
-static int
-tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
-{
-	return 0;
-}
-
-static int
-tda998x_remove(struct i2c_client *client)
-{
-	return 0;
-}
-
 static int tda998x_create(struct i2c_client *client, struct tda998x_priv *priv)
 {
 	struct device_node *np = client->dev.of_node;
@@ -1412,6 +1399,203 @@ static int tda998x_encoder_init(struct i2c_client *client,
 	return 0;
 }
 
+struct tda998x_priv2 {
+	struct tda998x_priv base;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
+};
+
+#define conn_to_tda998x_priv2(x) \
+	container_of(x, struct tda998x_priv2, connector);
+
+#define enc_to_tda998x_priv2(x) \
+	container_of(x, struct tda998x_priv2, encoder);
+
+static void tda998x_encoder2_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct tda998x_priv2 *priv = enc_to_tda998x_priv2(encoder);
+
+	tda998x_encoder_dpms(&priv->base, mode);
+}
+
+static void tda998x_encoder_prepare(struct drm_encoder *encoder)
+{
+	tda998x_encoder2_dpms(encoder, DRM_MODE_DPMS_OFF);
+}
+
+static void tda998x_encoder_commit(struct drm_encoder *encoder)
+{
+	tda998x_encoder2_dpms(encoder, DRM_MODE_DPMS_ON);
+}
+
+static void tda998x_encoder2_mode_set(struct drm_encoder *encoder,
+				      struct drm_display_mode *mode,
+				      struct drm_display_mode *adjusted_mode)
+{
+	struct tda998x_priv2 *priv = enc_to_tda998x_priv2(encoder);
+
+	tda998x_encoder_mode_set(&priv->base, mode, adjusted_mode);
+}
+
+static const struct drm_encoder_helper_funcs tda998x_encoder_helper_funcs = {
+	.dpms = tda998x_encoder2_dpms,
+	.save = tda998x_encoder_save,
+	.restore = tda998x_encoder_restore,
+	.mode_fixup = tda998x_encoder_mode_fixup,
+	.prepare = tda998x_encoder_prepare,
+	.commit = tda998x_encoder_commit,
+	.mode_set = tda998x_encoder2_mode_set,
+};
+
+static void tda998x_encoder_destroy(struct drm_encoder *encoder)
+{
+	struct tda998x_priv2 *priv = enc_to_tda998x_priv2(encoder);
+
+	tda998x_destroy(&priv->base);
+	drm_encoder_cleanup(encoder);
+}
+
+static const struct drm_encoder_funcs tda998x_encoder_funcs = {
+	.destroy = tda998x_encoder_destroy,
+};
+
+static int tda998x_connector_get_modes(struct drm_connector *connector)
+{
+	struct tda998x_priv2 *priv = conn_to_tda998x_priv2(connector);
+
+	return tda998x_encoder_get_modes(&priv->base, connector);
+}
+
+static int tda998x_connector_mode_valid(struct drm_connector *connector,
+					struct drm_display_mode *mode)
+{
+	struct tda998x_priv2 *priv = conn_to_tda998x_priv2(connector);
+
+	return tda998x_encoder_mode_valid(&priv->base, mode);
+}
+
+static struct drm_encoder *
+tda998x_connector_best_encoder(struct drm_connector *connector)
+{
+	struct tda998x_priv2 *priv = conn_to_tda998x_priv2(connector);
+
+	return &priv->encoder;
+}
+
+static
+const struct drm_connector_helper_funcs tda998x_connector_helper_funcs = {
+	.get_modes = tda998x_connector_get_modes,
+	.mode_valid = tda998x_connector_mode_valid,
+	.best_encoder = tda998x_connector_best_encoder,
+};
+
+static enum drm_connector_status
+tda998x_connector_detect(struct drm_connector *connector, bool force)
+{
+	struct tda998x_priv2 *priv = conn_to_tda998x_priv2(connector);
+
+	return tda998x_encoder_detect(&priv->base);
+}
+
+static void tda998x_connector_destroy(struct drm_connector *connector)
+{
+	drm_sysfs_connector_remove(connector);
+	drm_connector_cleanup(connector);
+}
+
+static const struct drm_connector_funcs tda998x_connector_funcs = {
+	.dpms = drm_helper_connector_dpms,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.detect = tda998x_connector_detect,
+	.destroy = tda998x_connector_destroy,
+};
+
+static int tda998x_bind(struct device *dev, struct device *master, void *data)
+{
+	struct tda998x_encoder_params *params = dev->platform_data;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct drm_device *drm = data;
+	struct tda998x_priv2 *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, priv);
+
+	priv->base.encoder = &priv->encoder;
+	priv->connector.interlace_allowed = 1;
+	priv->encoder.possible_crtcs = 1 << 0;
+
+	ret = tda998x_create(client, &priv->base);
+	if (ret)
+		return ret;
+
+	if (!dev->of_node && params)
+		tda998x_encoder_set_config(&priv->base, params);
+
+	tda998x_encoder_set_polling(&priv->base, &priv->connector);
+
+	drm_encoder_helper_add(&priv->encoder, &tda998x_encoder_helper_funcs);
+	ret = drm_encoder_init(drm, &priv->encoder, &tda998x_encoder_funcs,
+			       DRM_MODE_ENCODER_TMDS);
+	if (ret)
+		goto err_encoder;
+
+	drm_connector_helper_add(&priv->connector,
+				 &tda998x_connector_helper_funcs);
+	ret = drm_connector_init(drm, &priv->connector,
+				 &tda998x_connector_funcs,
+				 DRM_MODE_CONNECTOR_HDMIA);
+	if (ret)
+		goto err_connector;
+
+	ret = drm_sysfs_connector_add(&priv->connector);
+	if (ret)
+		goto err_sysfs;
+
+	priv->connector.encoder = &priv->encoder;
+	drm_mode_connector_attach_encoder(&priv->connector, &priv->encoder);
+
+	return 0;
+
+err_sysfs:
+	drm_connector_cleanup(&priv->connector);
+err_connector:
+	drm_encoder_cleanup(&priv->encoder);
+err_encoder:
+	tda998x_destroy(&priv->base);
+	return ret;
+}
+
+static void tda998x_unbind(struct device *dev, struct device *master,
+			   void *data)
+{
+	struct tda998x_priv2 *priv = dev_get_drvdata(dev);
+
+	drm_connector_cleanup(&priv->connector);
+	drm_encoder_cleanup(&priv->encoder);
+	tda998x_destroy(&priv->base);
+}
+
+static const struct component_ops tda998x_ops = {
+	.bind = tda998x_bind,
+	.unbind = tda998x_unbind,
+};
+
+static int
+tda998x_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	return component_add(&client->dev, &tda998x_ops);
+}
+
+static int tda998x_remove(struct i2c_client *client)
+{
+	component_del(&client->dev, &tda998x_ops);
+	return 0;
+}
+
 #ifdef CONFIG_OF
 static const struct of_device_id tda998x_dt_ids[] = {
 	{ .compatible = "nxp,tda998x", },
-- 
1.8.3.1
