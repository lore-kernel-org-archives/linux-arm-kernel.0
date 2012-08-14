From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 14 Aug 2012 18:12:03 +0530
Subject: [PATCH 3/5] ASoC: Davinci: pcm: Add device tree bindings
In-Reply-To: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1344948125-5649-4-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree support for Davinci/OMAP2+ pcm driver.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
:000000 100644 0000000... be494bb... A	Documentation/devicetree/bindings/sound/davinci-pcm.txt
:100644 100644 fefb3d4... 0765101... M	sound/soc/davinci/davinci-pcm.c
 .../devicetree/bindings/sound/davinci-pcm.txt      |   13 +++++++++++++
 sound/soc/davinci/davinci-pcm.c                    |   11 +++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-pcm.txt b/Documentation/devicetree/bindings/sound/davinci-pcm.txt
new file mode 100644
index 0000000..be494bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/davinci-pcm.txt
@@ -0,0 +1,13 @@
+Texas Instruments - Davinci/OMAP2+ PCM module
+
+PCM module doesn't use/require any platform data. Hence only
+compatible field needs to be populated.
+
+Required properties:
+- compatible: "ti,davinci-pcm-audio"
+
+Example:
+
+pcm: davinci-pcm-audio {
+	compatible = "ti,davinci-pcm-audio";
+};
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index fefb3d4..0765101 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -16,6 +16,8 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -874,10 +876,19 @@ static int __devexit davinci_soc_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id davinci_pcm_dt_ids[] = {
+	{ .compatible = "ti,davinci-pcm-audio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, davinci_pcm_dt_ids);
+#endif
+
 static struct platform_driver davinci_pcm_driver = {
 	.driver = {
 			.name = "davinci-pcm-audio",
 			.owner = THIS_MODULE,
+			.of_match_table = of_match_ptr(davinci_pcm_dt_ids),
 	},
 
 	.probe = davinci_soc_platform_probe,
-- 
1.7.1
