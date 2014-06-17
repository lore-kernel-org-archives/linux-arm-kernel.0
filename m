From: guido@vanguardiasur.com.ar (=?UTF-8?q?Guido=20Mart=C3=ADnez?=)
Date: Tue, 17 Jun 2014 11:17:10 -0300
Subject: [PATCH/RESEND 8/9] drm/tilcdc: remove submodule destroy calls
In-Reply-To: <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
Message-ID: <1403014631-18072-9-git-send-email-guido@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TI tilcdc driver is designed with a notion of submodules. Currently,
at unload time, these submodules are iterated and destroyed.

Now that the tilcdc remove order is fixed, this can be handled perfectly
by the kernel using the device infrastructure, since each submodule
is a kernel driver itself, and they are only destroy()'ed at unload
time. Therefore we move the destroy() functionality to each submodule's
remove().

Also, remove some checks in the unloading process since the new code
guarantees the resources are allocated and need a release.

Signed-off-by: Guido Mart?nez <guido@vanguardiasur.com.ar>
---
 drivers/gpu/drm/tilcdc/Module.symvers  |  0
 drivers/gpu/drm/tilcdc/tilcdc_drv.c    |  6 ------
 drivers/gpu/drm/tilcdc/tilcdc_drv.h    |  1 -
 drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 36 +++++++++++++++++-----------------
 drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 26 +++++++++++++-----------
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 34 ++++++++++++++++----------------
 6 files changed, 50 insertions(+), 53 deletions(-)
 create mode 100644 drivers/gpu/drm/tilcdc/Module.symvers

diff --git a/drivers/gpu/drm/tilcdc/Module.symvers b/drivers/gpu/drm/tilcdc/Module.symvers
new file mode 100644
index 0000000..e69de29
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 006a30e..2c860c4 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -120,7 +120,6 @@ static int cpufreq_transition(struct notifier_block *nb,
 static int tilcdc_unload(struct drm_device *dev)
 {
 	struct tilcdc_drm_private *priv = dev->dev_private;
-	struct tilcdc_module *mod, *cur;
 
 	drm_fbdev_cma_fini(priv->fbdev);
 	drm_kms_helper_poll_fini(dev);
@@ -149,11 +148,6 @@ static int tilcdc_unload(struct drm_device *dev)
 
 	pm_runtime_disable(dev->dev);
 
-	list_for_each_entry_safe(mod, cur, &module_list, list) {
-		DBG("destroying module: %s", mod->name);
-		mod->funcs->destroy(mod);
-	}
-
 	kfree(priv);
 
 	return 0;
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
index 0938036..7596c14 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
@@ -98,7 +98,6 @@ struct tilcdc_module;
 struct tilcdc_module_ops {
 	/* create appropriate encoders/connectors: */
 	int (*modeset_init)(struct tilcdc_module *mod, struct drm_device *dev);
-	void (*destroy)(struct tilcdc_module *mod);
 #ifdef CONFIG_DEBUG_FS
 	/* create debugfs nodes (can be NULL): */
 	int (*debugfs_init)(struct tilcdc_module *mod, struct drm_minor *minor);
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
index b085dcc..2f6efae 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
@@ -282,21 +282,8 @@ static int panel_modeset_init(struct tilcdc_module *mod, struct drm_device *dev)
 	return 0;
 }
 
-static void panel_destroy(struct tilcdc_module *mod)
-{
-	struct panel_module *panel_mod = to_panel_module(mod);
-
-	if (panel_mod->timings)
-		display_timings_release(panel_mod->timings);
-
-	tilcdc_module_cleanup(mod);
-	kfree(panel_mod->info);
-	kfree(panel_mod);
-}
-
 static const struct tilcdc_module_ops panel_module_ops = {
 		.modeset_init = panel_modeset_init,
-		.destroy = panel_destroy,
 };
 
 /*
@@ -372,6 +359,7 @@ static int panel_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mod = &panel_mod->base;
+	pdev->dev.platform_data = mod;
 
 	tilcdc_module_init(mod, "panel", &panel_module_ops);
 
@@ -379,17 +367,16 @@ static int panel_probe(struct platform_device *pdev)
 	if (IS_ERR(pinctrl))
 		dev_warn(&pdev->dev, "pins are not configured\n");
 
-
 	panel_mod->timings = of_get_display_timings(node);
 	if (!panel_mod->timings) {
 		dev_err(&pdev->dev, "could not get panel timings\n");
-		goto fail;
+		goto fail_free;
 	}
 
 	panel_mod->info = of_get_panel_info(node);
 	if (!panel_mod->info) {
 		dev_err(&pdev->dev, "could not get panel info\n");
-		goto fail;
+		goto fail_timings;
 	}
 
 	mod->preferred_bpp = panel_mod->info->bpp;
@@ -400,13 +387,26 @@ static int panel_probe(struct platform_device *pdev)
 
 	return 0;
 
-fail:
-	panel_destroy(mod);
+fail_timings:
+	display_timings_release(panel_mod->timings);
+
+fail_free:
+	kfree(panel_mod);
+	tilcdc_module_cleanup(mod);
 	return ret;
 }
 
 static int panel_remove(struct platform_device *pdev)
 {
+	struct tilcdc_module *mod = dev_get_platdata(&pdev->dev);
+	struct panel_module *panel_mod = to_panel_module(mod);
+
+	display_timings_release(panel_mod->timings);
+
+	tilcdc_module_cleanup(mod);
+	kfree(panel_mod->info);
+	kfree(panel_mod);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_slave.c b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
index 2f83ffb..1e568ca 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_slave.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_slave.c
@@ -296,17 +296,8 @@ static int slave_modeset_init(struct tilcdc_module *mod, struct drm_device *dev)
 	return 0;
 }
 
-static void slave_destroy(struct tilcdc_module *mod)
-{
-	struct slave_module *slave_mod = to_slave_module(mod);
-
-	tilcdc_module_cleanup(mod);
-	kfree(slave_mod);
-}
-
 static const struct tilcdc_module_ops slave_module_ops = {
 		.modeset_init = slave_modeset_init,
-		.destroy = slave_destroy,
 };
 
 /*
@@ -356,10 +347,13 @@ static int slave_probe(struct platform_device *pdev)
 	}
 
 	slave_mod = kzalloc(sizeof(*slave_mod), GFP_KERNEL);
-	if (!slave_mod)
-		return -ENOMEM;
+	if (!slave_mod) {
+		ret = -ENOMEM;
+		goto fail_adapter;
+	}
 
 	mod = &slave_mod->base;
+	pdev->dev.platform_data = mod;
 
 	mod->preferred_bpp = slave_info.bpp;
 
@@ -374,10 +368,20 @@ static int slave_probe(struct platform_device *pdev)
 	tilcdc_slave_probedefer(false);
 
 	return 0;
+
+fail_adapter:
+	i2c_put_adapter(slavei2c);
+	return ret;
 }
 
 static int slave_remove(struct platform_device *pdev)
 {
+	struct tilcdc_module *mod = dev_get_platdata(&pdev->dev);
+	struct slave_module *slave_mod = to_slave_module(mod);
+
+	tilcdc_module_cleanup(mod);
+	kfree(slave_mod);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index ce75ac8..32a0d2d 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -296,23 +296,8 @@ static int tfp410_modeset_init(struct tilcdc_module *mod, struct drm_device *dev
 	return 0;
 }
 
-static void tfp410_destroy(struct tilcdc_module *mod)
-{
-	struct tfp410_module *tfp410_mod = to_tfp410_module(mod);
-
-	if (tfp410_mod->i2c)
-		i2c_put_adapter(tfp410_mod->i2c);
-
-	if (!IS_ERR_VALUE(tfp410_mod->gpio))
-		gpio_free(tfp410_mod->gpio);
-
-	tilcdc_module_cleanup(mod);
-	kfree(tfp410_mod);
-}
-
 static const struct tilcdc_module_ops tfp410_module_ops = {
 		.modeset_init = tfp410_modeset_init,
-		.destroy = tfp410_destroy,
 };
 
 /*
@@ -342,6 +327,7 @@ static int tfp410_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mod = &tfp410_mod->base;
+	pdev->dev.platform_data = mod;
 
 	tilcdc_module_init(mod, "tfp410", &tfp410_module_ops);
 
@@ -365,6 +351,7 @@ static int tfp410_probe(struct platform_device *pdev)
 	tfp410_mod->i2c = of_find_i2c_adapter_by_node(i2c_node);
 	if (!tfp410_mod->i2c) {
 		dev_err(&pdev->dev, "could not get i2c\n");
+		of_node_put(i2c_node);
 		goto fail;
 	}
 
@@ -378,19 +365,32 @@ static int tfp410_probe(struct platform_device *pdev)
 		ret = gpio_request(tfp410_mod->gpio, "DVI_PDn");
 		if (ret) {
 			dev_err(&pdev->dev, "could not get DVI_PDn gpio\n");
-			goto fail;
+			goto fail_adapter;
 		}
 	}
 
 	return 0;
 
+fail_adapter:
+	i2c_put_adapter(tfp410_mod->i2c);
+
 fail:
-	tfp410_destroy(mod);
+	kfree(tfp410_mod);
+	tilcdc_module_cleanup(mod);
 	return ret;
 }
 
 static int tfp410_remove(struct platform_device *pdev)
 {
+	struct tilcdc_module *mod = dev_get_platdata(&pdev->dev);
+	struct tfp410_module *tfp410_mod = to_tfp410_module(mod);
+
+	i2c_put_adapter(tfp410_mod->i2c);
+	gpio_free(tfp410_mod->gpio);
+
+	tilcdc_module_cleanup(mod);
+	kfree(tfp410_mod);
+
 	return 0;
 }
 
-- 
2.0.0
