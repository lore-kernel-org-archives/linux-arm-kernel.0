From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Mon, 23 Apr 2018 12:49:45 +0200
Subject: [RESEND PATCH v6 09/27] drm/bridge: analogix_dp: Fix incorrect usage
 of enhanced mode
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
Message-ID: <20180423105003.9004-10-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zain wang <wzz@rock-chips.com>

Enhanced mode is required by the eDP 1.2 specification, and not doing it
early could result in a period of time where we have a link transmitting
idle packets without it. Since there is no reason to disable it, we just
enable it at the beginning of link training and then keep it on all the
time.

Cc: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 1f4f34149019..1e1743b59c77 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -281,6 +281,8 @@ static int analogix_dp_link_start(struct analogix_dp_device *dp)
 	retval = drm_dp_dpcd_write(&dp->aux, DP_LINK_BW_SET, buf, 2);
 	if (retval < 0)
 		return retval;
+	/* set enhanced mode if available */
+	analogix_dp_set_enhanced_mode(dp);
 
 	/* Set TX pre-emphasis to minimum */
 	for (lane = 0; lane < lane_count; lane++)
@@ -593,8 +595,6 @@ static int analogix_dp_process_equalizer_training(struct analogix_dp_device *dp)
 		dev_dbg(dp->dev, "fast link training %s\n",
 			dp->fast_train_enable ? "supported" : "unsupported");
 
-		/* set enhanced mode if available */
-		analogix_dp_set_enhanced_mode(dp);
 		dp->link_train.lt_state = FINISHED;
 
 		return 0;
@@ -940,8 +940,6 @@ static int analogix_dp_commit(struct analogix_dp_device *dp)
 	}
 
 	analogix_dp_enable_scramble(dp, 1);
-	analogix_dp_enable_rx_to_enhanced_mode(dp, 1);
-	analogix_dp_enable_enhanced_mode(dp, 1);
 
 	analogix_dp_init_video(dp);
 	ret = analogix_dp_config_video(dp);
-- 
2.17.0
