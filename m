From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  2 Jun 2017 18:10:13 +0800
Subject: [PATCH 08/19] drm/sun4i: hdmi: Support the TMDS clock in the A31's
 HDMI controller
In-Reply-To: <20170602101024.18940-1-wens@csie.org>
References: <20170602101024.18940-1-wens@csie.org>
Message-ID: <20170602101024.18940-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31's HDMI controller's TMDS clock is slightly different.
There is an offset of 1 between the divider value and the actual
value programmed into the registers.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi.h          | 1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index 2f2f2ff1ea63..3a4987ab8da8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -153,5 +153,6 @@ struct sun4i_hdmi {
 
 int sun4i_ddc_create(struct sun4i_hdmi *hdmi, struct clk *clk);
 int sun4i_tmds_create(struct sun4i_hdmi *hdmi);
+int sun6i_tmds_create(struct sun4i_hdmi *hdmi);
 
 #endif /* _SUN4I_HDMI_H_ */
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index 3c304e1fbe3b..6f25c7bd887e 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -240,3 +240,10 @@ int sun4i_tmds_create(struct sun4i_hdmi *hdmi)
 {
 	return _sun4i_tmds_create(hdmi, 0);
 }
+
+/* sun6i variant has a different value offset for the divider */
+
+int sun6i_tmds_create(struct sun4i_hdmi *hdmi)
+{
+	return _sun4i_tmds_create(hdmi, 1);
+}
-- 
2.11.0
