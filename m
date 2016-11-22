From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Tue, 22 Nov 2016 13:57:47 +0100
Subject: [PATCH v2 1/2] bus: da8xx-mstpri: drop the call to
 of_flat_dt_get_machine_name()
In-Reply-To: <1479819468-4016-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479819468-4016-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479819468-4016-2-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to avoid a section mismatch use a locally implemented routine
instead of of_flat_dt_get_machine_name() when printing the error
message.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/bus/da8xx-mstpri.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/da8xx-mstpri.c b/drivers/bus/da8xx-mstpri.c
index 85f0b53..bd38170 100644
--- a/drivers/bus/da8xx-mstpri.c
+++ b/drivers/bus/da8xx-mstpri.c
@@ -16,7 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/regmap.h>
-#include <linux/of_fdt.h>
 
 /*
  * REVISIT: Linux doesn't have a good framework for the kind of performance
@@ -190,6 +189,25 @@ static const struct da8xx_mstpri_board_priorities da8xx_mstpri_board_confs[] = {
 	},
 };
 
+/*
+ * FIXME Remove this function once of/base gets a general routine for getting
+ * the machine model/compatible string.
+ */
+static const char *da8xx_mstpri_machine_get_compatible(void)
+{
+	struct device_node *root;
+	const char *compatible;
+	int ret = -1;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		ret = of_property_read_string(root, "compatible", &compatible);
+		of_node_put(root);
+	}
+
+	return ret ? NULL : compatible;
+}
+
 static const struct da8xx_mstpri_board_priorities *
 da8xx_mstpri_get_board_prio(void)
 {
@@ -227,7 +245,7 @@ static int da8xx_mstpri_probe(struct platform_device *pdev)
 	prio_list = da8xx_mstpri_get_board_prio();
 	if (!prio_list) {
 		dev_err(dev, "no master priotities defined for board '%s'\n",
-			of_flat_dt_get_machine_name());
+			da8xx_mstpri_machine_get_compatible());
 		return -EINVAL;
 	}
 
-- 
2.9.3
