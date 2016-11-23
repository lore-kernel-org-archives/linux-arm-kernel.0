From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 23 Nov 2016 12:06:26 +0100
Subject: [PATCH v3 2/3] memory: da8xx-ddrctl: drop the call to
 of_flat_dt_get_machine_name()
In-Reply-To: <1479899187-10199-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479899187-10199-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479899187-10199-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid a section mismatch use a locally implemented routine
instead of of_flat_dt_get_machine_name() when printing the error
message.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/memory/da8xx-ddrctl.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/da8xx-ddrctl.c b/drivers/memory/da8xx-ddrctl.c
index a20e7bb..1b962ee 100644
--- a/drivers/memory/da8xx-ddrctl.c
+++ b/drivers/memory/da8xx-ddrctl.c
@@ -14,7 +14,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_fdt.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 
@@ -71,6 +70,26 @@ static const struct da8xx_ddrctl_board_settings da8xx_ddrctl_board_confs[] = {
 	},
 };
 
+/*
+ * FIXME Remove this function once of/base gets a general routine for getting
+ * the machine model/compatible string.
+ */
+static const char *da8xx_ddrctl_machine_get_compatible(void)
+{
+	struct device_node *root;
+	const char *compatible;
+	int ret = -1;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		ret = of_property_read_string_index(root, "compatible",
+						    0, &compatible);
+		of_node_put(root);
+	}
+
+	return ret ? NULL : compatible;
+}
+
 static const struct da8xx_ddrctl_config_knob *
 da8xx_ddrctl_match_knob(const struct da8xx_ddrctl_setting *setting)
 {
@@ -118,7 +137,7 @@ static int da8xx_ddrctl_probe(struct platform_device *pdev)
 	setting = da8xx_ddrctl_get_board_settings();
 	if (!setting) {
 		dev_err(dev, "no settings for board '%s'\n",
-			of_flat_dt_get_machine_name());
+			da8xx_ddrctl_machine_get_compatible());
 		return -EINVAL;
 	}
 
-- 
2.9.3
