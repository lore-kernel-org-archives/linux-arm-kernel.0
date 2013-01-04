From: gururaja.hebbar@ti.com (Hebbar Gururaja)
Date: Fri, 4 Jan 2013 15:24:36 +0530
Subject: [PATCH V2 1/2] ASoC: davinci-mcasp: Add pinctrl support
In-Reply-To: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
References: <1357293277-25543-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1357293277-25543-2-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
Changes in V2
	- no change

:100644 100644 55e2bf6... 83d96eb... M	sound/soc/davinci/davinci-mcasp.c
 sound/soc/davinci/davinci-mcasp.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 55e2bf6..83d96eb 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1080,6 +1081,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	struct resource *mem, *ioarea, *res;
 	struct snd_platform_data *pdata;
 	struct davinci_audio_dev *dev;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
@@ -1111,6 +1113,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev,
+				"pins are not configured from the driver\n");
+
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-- 
1.7.9.5
