From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 16 Oct 2017 18:06:38 +0800
Subject: [RESEND PATCH v2 3/5] drm/rockchip: Fix error handling path in
 rockchip_dp_bind()
In-Reply-To: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
References: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
Message-ID: <20171016100640.26575-4-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing error handling in rockchip_dp_bind().

Fixes: 9e32e16e9e98 ("drm: rockchip: dp: add rockchip platform dp driver")
Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 4d3f6ad0abdd..cb8941e8bcdd 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -371,7 +371,7 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	ret = rockchip_dp_drm_create_encoder(dp);
 	if (ret) {
 		DRM_ERROR("failed to create drm encoder\n");
-		return ret;
+		goto err_deinit_dp;
 	}
 
 	dp->plat_data.encoder = &dp->encoder;
@@ -387,7 +387,17 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 
 	rockchip_drm_psr_register(&dp->encoder, analogix_dp_psr_set);
 
-	return analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
+	ret = analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
+	if (ret < 0)
+		goto err_unreg_psr;
+	return 0;
+
+err_unreg_psr:
+	rockchip_drm_psr_unregister(&dp->encoder);
+	rockchip_dp_drm_encoder_destroy(&dp->encoder);
+err_deinit_dp:
+	clk_disable_unprepare(dp->pclk);
+	return ret;
 }
 
 static void rockchip_dp_unbind(struct device *dev, struct device *master,
-- 
2.11.0
