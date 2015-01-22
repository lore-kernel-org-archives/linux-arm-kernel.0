From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 22 Jan 2015 13:28:06 +0100
Subject: [PATCH v4 RESEND 9/9] drm/exynos: add support for 'hdmi' clock
In-Reply-To: <54BE4F8E.50605@collabora.co.uk>
References: <54BE4F8E.50605@collabora.co.uk>
Message-ID: <1421929686-19709-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mixed need to have hdmi clock enabled to properly perform power on/off
sequences, so add handling of this clock directly to the mixer driver.
Dependency between hdmi clock and mixer module has been observed on
Exynos4 based boards.

Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/devicetree/bindings/video/exynos_mixer.txt | 1 +
 drivers/gpu/drm/exynos/exynos_mixer.c                    | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/video/exynos_mixer.txt b/Documentation/devicetree/bindings/video/exynos_mixer.txt
index 08b394b..3e38128 100644
--- a/Documentation/devicetree/bindings/video/exynos_mixer.txt
+++ b/Documentation/devicetree/bindings/video/exynos_mixer.txt
@@ -15,6 +15,7 @@ Required properties:
 	a) mixer: Gate of Mixer IP bus clock.
 	b) sclk_hdmi: HDMI Special clock, one of the two possible inputs of
                mixer mux.
+	c) hdmi: Gate of HDMI IP bus clock, needed together with sclk_hdmi.
 
 Example:
 
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 820b762..e5ef1fc 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -72,6 +72,7 @@ struct mixer_resources {
 	spinlock_t		reg_slock;
 	struct clk		*mixer;
 	struct clk		*vp;
+	struct clk		*hdmi;
 	struct clk		*sclk_mixer;
 	struct clk		*sclk_hdmi;
 	struct clk		*mout_mixer;
@@ -774,6 +775,12 @@ static int mixer_resources_init(struct mixer_context *mixer_ctx)
 		return -ENODEV;
 	}
 
+	mixer_res->hdmi = devm_clk_get(dev, "hdmi");
+	if (IS_ERR(mixer_res->hdmi)) {
+		dev_err(dev, "failed to get clock 'hdmi'\n");
+		return -ENODEV;
+	}
+
 	mixer_res->sclk_hdmi = devm_clk_get(dev, "sclk_hdmi");
 	if (IS_ERR(mixer_res->sclk_hdmi)) {
 		dev_err(dev, "failed to get clock 'sclk_hdmi'\n");
@@ -1095,6 +1102,7 @@ static void mixer_poweron(struct exynos_drm_manager *mgr)
 	pm_runtime_get_sync(ctx->dev);
 
 	clk_prepare_enable(res->mixer);
+	clk_prepare_enable(res->hdmi);
 	if (ctx->vp_enabled) {
 		clk_prepare_enable(res->vp);
 		if (ctx->has_sclk)
@@ -1134,6 +1142,7 @@ static void mixer_poweroff(struct exynos_drm_manager *mgr)
 	ctx->powered = false;
 	mutex_unlock(&ctx->mixer_mutex);
 
+	clk_disable_unprepare(res->hdmi);
 	clk_disable_unprepare(res->mixer);
 	if (ctx->vp_enabled) {
 		clk_disable_unprepare(res->vp);
-- 
1.9.2
