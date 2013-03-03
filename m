From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun,  3 Mar 2013 23:01:44 +0800
Subject: [PATCH] pinctrl: single: avoid to set read only object
Message-ID: <1362322904-19570-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/pinctrl/pinctrl-single.c:1441:3: error: assignment of member
?is_generic? in read-only object
make[2]: *** [drivers/pinctrl/pinctrl-single.o] Error 1

Since pcs_pinconf_ops is changed to read only structure, probe()
function can't set is_generic variable any more. So append new
pcs_pinconf_generic_ops.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 drivers/pinctrl/pinctrl-single.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 4cdcf85..c80ffa8 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -734,6 +734,18 @@ static const struct pinconf_ops pcs_pinconf_ops = {
 	.pin_config_dbg_show = pcs_pinconf_dbg_show,
 	.pin_config_group_dbg_show = pcs_pinconf_group_dbg_show,
 	.pin_config_config_dbg_show = pcs_pinconf_config_dbg_show,
+	.is_generic = false,
+};
+
+static const struct pinconf_ops pcs_pinconf_generic_ops = {
+	.pin_config_get = pcs_pinconf_get,
+	.pin_config_set = pcs_pinconf_set,
+	.pin_config_group_get = pcs_pinconf_group_get,
+	.pin_config_group_set = pcs_pinconf_group_set,
+	.pin_config_dbg_show = pcs_pinconf_dbg_show,
+	.pin_config_group_dbg_show = pcs_pinconf_group_dbg_show,
+	.pin_config_config_dbg_show = pcs_pinconf_config_dbg_show,
+	.is_generic = true,
 };
 
 /**
@@ -1435,10 +1447,8 @@ static int pcs_probe(struct platform_device *pdev)
 	pcs->desc.name = DRIVER_NAME;
 	pcs->desc.pctlops = &pcs_pinctrl_ops;
 	pcs->desc.pmxops = &pcs_pinmux_ops;
-	pcs->desc.confops = &pcs_pinconf_ops;
+	pcs->desc.confops = match->data;
 	pcs->desc.owner = THIS_MODULE;
-	if (match->data)
-		pcs_pinconf_ops.is_generic = true;
 
 	ret = pcs_allocate_pin_table(pcs);
 	if (ret < 0)
@@ -1479,9 +1489,14 @@ static int pcs_remove(struct platform_device *pdev)
 }
 
 static struct of_device_id pcs_of_match[] = {
-	{ .compatible = "pinctrl-single", .data = (void *)false },
-	{ .compatible = "pinconf-single", .data = (void *)true },
-	{ },
+	{
+		.compatible = "pinctrl-single",
+		.data = (void *)&pcs_pinconf_ops,
+	}, {
+		.compatible = "pinconf-single",
+		.data = (void *)&pcs_pinconf_generic_ops,
+       	}, {
+	},
 };
 MODULE_DEVICE_TABLE(of, pcs_of_match);
 
-- 
1.7.10.4
