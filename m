From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 8 Jul 2015 16:00:03 +0300
Subject: [PATCH 07/10] drm: tegra: use of_get_i2c_adapter_by_node interface
In-Reply-To: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1436360095-9065-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1436360403-9462-1-git-send-email-vladimir_zapolskiy@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change is needed to properly lock I2C bus driver, which serves DDC.

On release of_get_i2c_adapter_by_node() requires i2c_put_adapter() call.

Note, that prior to the change put_device() coupled with
of_find_i2c_adapter_by_node() was missing on error path of
tegra_output_probe().

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/gpu/drm/tegra/output.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index 37db479..d7731cd 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -116,7 +116,7 @@ int tegra_output_probe(struct tegra_output *output)
 
 	ddc = of_parse_phandle(output->of_node, "nvidia,ddc-i2c-bus", 0);
 	if (ddc) {
-		output->ddc = of_find_i2c_adapter_by_node(ddc);
+		output->ddc = of_get_i2c_adapter_by_node(ddc);
 		if (!output->ddc) {
 			err = -EPROBE_DEFER;
 			of_node_put(ddc);
@@ -136,14 +136,13 @@ int tegra_output_probe(struct tegra_output *output)
 				       "HDMI hotplug detect");
 		if (err < 0) {
 			dev_err(output->dev, "gpio_request_one(): %d\n", err);
-			return err;
+			goto i2c_release;
 		}
 
 		err = gpio_to_irq(output->hpd_gpio);
 		if (err < 0) {
 			dev_err(output->dev, "gpio_to_irq(): %d\n", err);
-			gpio_free(output->hpd_gpio);
-			return err;
+			goto gpio_release;
 		}
 
 		output->hpd_irq = err;
@@ -156,8 +155,7 @@ int tegra_output_probe(struct tegra_output *output)
 		if (err < 0) {
 			dev_err(output->dev, "failed to request IRQ#%u: %d\n",
 				output->hpd_irq, err);
-			gpio_free(output->hpd_gpio);
-			return err;
+			goto gpio_release;
 		}
 
 		output->connector.polled = DRM_CONNECTOR_POLL_HPD;
@@ -171,6 +169,12 @@ int tegra_output_probe(struct tegra_output *output)
 	}
 
 	return 0;
+
+ gpio_release:
+	gpio_free(output->hpd_gpio);
+ i2c_release:
+	i2c_put_adapter(output->ddc);
+	return err;
 }
 
 void tegra_output_remove(struct tegra_output *output)
@@ -180,8 +184,7 @@ void tegra_output_remove(struct tegra_output *output)
 		gpio_free(output->hpd_gpio);
 	}
 
-	if (output->ddc)
-		put_device(&output->ddc->dev);
+	i2c_put_adapter(output->ddc);
 }
 
 int tegra_output_init(struct drm_device *drm, struct tegra_output *output)
-- 
2.1.4
