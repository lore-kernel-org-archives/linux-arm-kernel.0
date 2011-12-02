From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  2 Dec 2011 11:52:57 +0200
Subject: [PATCH 2/5] ASoC: omap-mcpdm: Add device tree bindings
In-Reply-To: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1322819580-7424-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/sound/soc/omap/omap-mcpdm.txt         |   13 +++++++++++++
 sound/soc/omap/omap-mcpdm.c                        |    8 ++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt

diff --git a/Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt b/Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt
new file mode 100644
index 0000000..e94bb96
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/soc/omap/omap-mcpdm.txt
@@ -0,0 +1,13 @@
+* Texas Instruments OMAP4 McPDM
+
+Required properties:
+  - compatible : "ti,omap4-mcpdm"
+  - ti,hwmods  : List of hwmod names associated with McPDM, in most case
+                 it is "mcpdm".
+
+Example:
+
+mcpdm_dai: mcpdm at 40132000 {
+	compatible = "ti,omap4-mcpdm";
+	ti,hwmods = "mcpdm";
+};
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index b50ac60..c95fc70 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -33,6 +33,7 @@
 #include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_device.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -510,10 +511,17 @@ static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id omap_mcpdm_of_match[] = {
+	{ .compatible = "ti,omap4-mcpdm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, omap_mcpdm_of_match);
+
 static struct platform_driver asoc_mcpdm_driver = {
 	.driver = {
 		.name	= "omap-mcpdm",
 		.owner	= THIS_MODULE,
+		.of_match_table = omap_mcpdm_of_match,
 	},
 
 	.probe	= asoc_mcpdm_probe,
-- 
1.7.8.rc4
