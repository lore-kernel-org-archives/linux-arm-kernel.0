From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Mon, 23 Apr 2018 12:49:41 +0200
Subject: [RESEND PATCH v6 05/27] drm/bridge: analogix_dp: Wait for HPD signal
 before configuring link
In-Reply-To: <20180423105003.9004-1-enric.balletbo@collabora.com>
References: <20180423105003.9004-1-enric.balletbo@collabora.com>
Message-ID: <20180423105003.9004-6-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zain wang <wzz@rock-chips.com>

According to DP spec v1.3 chap 3.5.1.2 Link Training, Link Policy Maker
must first detect that the HPD signal is asserted high by the Downstream
Device before establishing a link with it.

Cc: St?phane Marchesin <marcheu@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Archit Taneja <architt@codeaurora.org>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index bf805f156272..3269deec739d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1169,6 +1169,17 @@ static int analogix_dp_set_bridge(struct analogix_dp_device *dp)
 	if (ret)
 		goto out_dp_init;
 
+	/*
+	 * According to DP spec v1.3 chap 3.5.1.2 Link Training,
+	 * We should first make sure the HPD signal is asserted high by device
+	 * when we want to establish a link with it.
+	 */
+	ret = analogix_dp_detect_hpd(dp);
+	if (ret) {
+		DRM_ERROR("failed to get hpd single ret = %d\n", ret);
+		goto out_dp_init;
+	}
+
 	ret = analogix_dp_commit(dp);
 	if (ret)
 		goto out_dp_init;
-- 
2.17.0
