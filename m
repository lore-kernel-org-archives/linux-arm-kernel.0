From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 16:22:58 +0800
Subject: [PATCH v3 06/14] drm/sun4i: hdmi: create a regmap for later use
In-Reply-To: <20170929082306.16193-1-wens@csie.org>
References: <20170929082306.16193-1-wens@csie.org>
Message-ID: <20170929082306.16193-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI driver is written with readl/writel I/O to the registers.
However, to support the A31 variant, which has a different layout
for the DDC registers, it was recommended to use regfields to have
a cleaner implementation. To use regfields, we need to create an
underlying regmap.

This patch only adds the regmap. It does not convert the existing
driver accesses to use regmap.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index 1457750988da..b95512ec8eb6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -163,6 +163,7 @@ struct sun4i_hdmi {
 	struct device		*dev;
 
 	void __iomem		*base;
+	struct regmap		*regmap;
 
 	/* Parent clocks */
 	struct clk		*bus_clk;
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 3cf1a6932fac..5ab811cda00e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -22,6 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 #include "sun4i_backend.h"
 #include "sun4i_crtc.h"
@@ -267,6 +268,13 @@ static const struct cec_pin_ops sun4i_hdmi_cec_pin_ops = {
 };
 #endif
 
+static const struct regmap_config sun4i_hdmi_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x580,
+};
+
 static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -321,6 +329,13 @@ static int sun4i_hdmi_bind(struct device *dev, struct device *master,
 		goto err_disable_mod_clk;
 	}
 
+	hdmi->regmap = devm_regmap_init_mmio(dev, hdmi->base,
+					     &sun4i_hdmi_regmap_config);
+	if (IS_ERR(hdmi->regmap)) {
+		dev_err(dev, "Couldn't create HDMI encoder regmap\n");
+		return PTR_ERR(hdmi->regmap);
+	}
+
 	ret = sun4i_tmds_create(hdmi);
 	if (ret) {
 		dev_err(dev, "Couldn't create the TMDS clock\n");
-- 
2.14.2
