From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:29:03 +0100
Subject: [PATCH 5/6] staging: drm/imx: Add pinctrl support to parallel display
 driver
In-Reply-To: <1352734144-14897-1-git-send-email-s.hauer@pengutronix.de>
References: <1352734144-14897-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352734144-14897-6-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow the iomux to be configured for the display.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/staging/imx-drm/parallel-display.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/imx-drm/parallel-display.c b/drivers/staging/imx-drm/parallel-display.c
index 9b51d73..324283c 100644
--- a/drivers/staging/imx-drm/parallel-display.c
+++ b/drivers/staging/imx-drm/parallel-display.c
@@ -23,6 +23,7 @@
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <linux/videodev2.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "imx-drm.h"
 
@@ -195,11 +196,20 @@ static int __devinit imx_pd_probe(struct platform_device *pdev)
 	struct imx_parallel_display *imxpd;
 	int ret;
 	const char *fmt;
+	struct pinctrl *pinctrl;
 
 	imxpd = devm_kzalloc(&pdev->dev, sizeof(*imxpd), GFP_KERNEL);
 	if (!imxpd)
 		return -ENOMEM;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		dev_warn(&pdev->dev, "pinctrl_get_select_default failed with %d",
+				ret);
+		return ret;
+	}
+
 	edidp = of_get_property(np, "edid", &imxpd->edid_len);
 	if (edidp)
 		imxpd->edid = kmemdup(edidp, imxpd->edid_len, GFP_KERNEL);
-- 
1.7.10.4
