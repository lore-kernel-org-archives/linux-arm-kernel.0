From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 19 Oct 2017 11:48:07 +0800
Subject: [PATCH v6 05/10] drm/rockchip: analogix_dp: Add a sanity check for
 rockchip_drm_psr_register()
In-Reply-To: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
References: <20171019034812.13768-1-jeffy.chen@rock-chips.com>
Message-ID: <20171019034812.13768-6-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rockchip_drm_psr_register() can fail, so add a sanity check for that.

Also reorder the calls in unbind() to match bind().

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v6: None
Changes in v5: None

 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 117585df73e1..bd3567ad8b53 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -356,15 +356,22 @@ static int rockchip_dp_bind(struct device *dev, struct device *master,
 	dp->psr_state = ~EDP_VSC_PSR_STATE_ACTIVE;
 	INIT_WORK(&dp->psr_work, analogix_dp_psr_work);
 
-	rockchip_drm_psr_register(&dp->encoder, analogix_dp_psr_set);
+	ret = rockchip_drm_psr_register(&dp->encoder, analogix_dp_psr_set);
+	if (ret < 0)
+		goto err_cleanup_encoder;
 
 	dp->adp = analogix_dp_bind(dev, dp->drm_dev, &dp->plat_data);
 	if (IS_ERR(dp->adp)) {
-		dp->encoder.funcs->destroy(&dp->encoder);
-		return PTR_ERR(dp->adp);
+		ret = PTR_ERR(dp->adp);
+		goto err_unreg_psr;
 	}
 
 	return 0;
+err_unreg_psr:
+	rockchip_drm_psr_unregister(&dp->encoder);
+err_cleanup_encoder:
+	dp->encoder.funcs->destroy(&dp->encoder);
+	return ret;
 }
 
 static void rockchip_dp_unbind(struct device *dev, struct device *master,
@@ -372,8 +379,8 @@ static void rockchip_dp_unbind(struct device *dev, struct device *master,
 {
 	struct rockchip_dp_device *dp = dev_get_drvdata(dev);
 
-	rockchip_drm_psr_unregister(&dp->encoder);
 	analogix_dp_unbind(dp->adp);
+	rockchip_drm_psr_unregister(&dp->encoder);
 	dp->encoder.funcs->destroy(&dp->encoder);
 }
 
-- 
2.11.0
