From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 8 Jul 2015 15:59:56 +0300
Subject: [PATCH 06/10] drm: sti_hdmi: use of_get_i2c_adapter_by_node interface
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1436360396-9417-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed to properly lock I2C bus driver, which serves DDC.

On release of_get_i2c_adapter_by_node() requires i2c_put_adapter() call.

Note, that prior to the change put_device() coupled with
of_find_i2c_adapter_by_node() was incorrectly placed to sti_hdmi_remove()
instead of sti_hdmi_unbind().

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f28a4d5..580a413 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -698,14 +698,10 @@ static int sti_hdmi_bind(struct device *dev, struct device *master, void *data)
 
 	ddc = of_parse_phandle(dev->of_node, "ddc", 0);
 	if (ddc) {
-		hdmi->ddc_adapt = of_find_i2c_adapter_by_node(ddc);
-		if (!hdmi->ddc_adapt) {
-			err = -EPROBE_DEFER;
-			of_node_put(ddc);
-			return err;
-		}
-
+		hdmi->ddc_adapt = of_get_i2c_adapter_by_node(ddc);
 		of_node_put(ddc);
+		if (!hdmi->ddc_adapt)
+			return -EPROBE_DEFER;
 	}
 
 	/* Set the drm device handle */
@@ -762,14 +758,15 @@ err_sysfs:
 err_connector:
 	drm_connector_cleanup(drm_connector);
 err_adapt:
-	put_device(&hdmi->ddc_adapt->dev);
+	i2c_put_adapter(hdmi->ddc_adapt);
+
 	return -EINVAL;
 }
 
 static void sti_hdmi_unbind(struct device *dev,
 		struct device *master, void *data)
 {
-	/* do nothing */
+	i2c_put_adapter(hdmi->ddc_adapt);
 }
 
 static const struct component_ops sti_hdmi_ops = {
@@ -885,10 +882,8 @@ static int sti_hdmi_remove(struct platform_device *pdev)
 {
 	struct sti_hdmi *hdmi = dev_get_drvdata(&pdev->dev);
 
-	if (hdmi->ddc_adapt)
-		put_device(&hdmi->ddc_adapt->dev);
-
 	component_del(&pdev->dev, &sti_hdmi_ops);
+
 	return 0;
 }
 
-- 
2.1.4
