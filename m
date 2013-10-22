From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 22 Oct 2013 15:41:03 +0530
Subject: [PATCH v2 2/7] drm/exynos: remove dummy hdmiphy clock
In-Reply-To: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
References: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1382436668-15813-3-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hdmiphy is a dummy clock which actually controls the PMU bit
to enable/disable hdmiphy (before CCF). This clock is cleaned
from the hdmi driver.

Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index bbb9fbf..444541d 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -84,7 +84,6 @@ struct hdmi_resources {
 	struct clk			*sclk_hdmi;
 	struct clk			*sclk_pixel;
 	struct clk			*sclk_hdmiphy;
-	struct clk			*hdmiphy;
 	struct clk			*mout_hdmi;
 	struct regulator_bulk_data	*regul_bulk;
 	int				regul_count;
@@ -1442,7 +1441,6 @@ static void hdmi_poweron(struct hdmi_context *hdata)
 	if (regulator_bulk_enable(res->regul_count, res->regul_bulk))
 		DRM_DEBUG_KMS("failed to enable regulator bulk\n");
 
-	clk_prepare_enable(res->hdmiphy);
 	clk_prepare_enable(res->hdmi);
 	clk_prepare_enable(res->sclk_hdmi);
 
@@ -1467,7 +1465,6 @@ static void hdmi_poweroff(struct hdmi_context *hdata)
 
 	clk_disable_unprepare(res->sclk_hdmi);
 	clk_disable_unprepare(res->hdmi);
-	clk_disable_unprepare(res->hdmiphy);
 	regulator_bulk_disable(res->regul_count, res->regul_bulk);
 
 	mutex_lock(&hdata->hdmi_mutex);
@@ -1560,11 +1557,6 @@ static int hdmi_resources_init(struct hdmi_context *hdata)
 		DRM_ERROR("failed to get clock 'sclk_hdmiphy'\n");
 		goto fail;
 	}
-	res->hdmiphy = devm_clk_get(dev, "hdmiphy");
-	if (IS_ERR(res->hdmiphy)) {
-		DRM_ERROR("failed to get clock 'hdmiphy'\n");
-		goto fail;
-	}
 	res->mout_hdmi = devm_clk_get(dev, "mout_hdmi");
 	if (IS_ERR(res->mout_hdmi)) {
 		DRM_ERROR("failed to get clock 'mout_hdmi'\n");
-- 
1.7.10.4
