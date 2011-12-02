From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  2 Dec 2011 11:52:56 +0200
Subject: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
In-Reply-To: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/sound/soc/omap/omap-dmic.txt          |   13 +++++++++++++
 sound/soc/omap/omap-dmic.c                         |    8 ++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/soc/omap/omap-dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/soc/omap/omap-dmic.txt b/Documentation/devicetree/bindings/sound/soc/omap/omap-dmic.txt
new file mode 100644
index 0000000..f6d9e66
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/soc/omap/omap-dmic.txt
@@ -0,0 +1,13 @@
+* Texas Instruments OMAP4 Digital Microphone Module
+
+Required properties:
+  - compatible : "ti,omap4-dmic"
+  - ti,hwmods  : List of hwmod names associated with DMIC, in most case
+		 it is "dmic".
+
+Example:
+
+dmic_dai: dmic at 4012e000 {
+	compatible = "ti,omap4-dmic";
+	ti,hwmods = "dmic";
+};
diff --git a/sound/soc/omap/omap-dmic.c b/sound/soc/omap/omap-dmic.c
index 9c73c0c..b71bd11 100644
--- a/sound/soc/omap/omap-dmic.c
+++ b/sound/soc/omap/omap-dmic.c
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 #include <plat/dma.h>
 
 #include <sound/core.h>
@@ -532,10 +533,17 @@ static int __devexit asoc_dmic_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id omap_dmic_of_match[] = {
+	{ .compatible = "ti,omap4-dmic", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, omap_dmic_of_match);
+
 static struct platform_driver asoc_dmic_driver = {
 	.driver = {
 		.name = "omap-dmic",
 		.owner = THIS_MODULE,
+		.of_match_table = omap_dmic_of_match,
 	},
 	.probe = asoc_dmic_probe,
 	.remove = __devexit_p(asoc_dmic_remove),
-- 
1.7.8.rc4
