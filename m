From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  9 Mar 2018 23:22:57 +0100
Subject: [PATCH v5 06/36] drm/rockchip: Only wait for panel ACK on PSR entry
In-Reply-To: <20180309222327.18689-1-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
Message-ID: <20180309222327.18689-7-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: zain wang <wzz@rock-chips.com>

We currently wait for the panel to mirror our intended PSR state
before continuing on both PSR enter and PSR exit. This is really
only important to do when we're entering PSR, since we want to
be sure the last frame we pushed is being served from the panel's
internal fb before shutting down the soc blocks (vop/analogix).

This patch changes the behavior such that we only wait for the
panel to complete the PSR transition when we're entering PSR, and
to skip verification when we're exiting.

Cc: St?phane Marchesin <marcheu@chromium.org>
Cc: Sonny Rao <sonnyrao@chromium.org>
Signed-off-by: zain wang <wzz@rock-chips.com>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.h | 2 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c  | 5 ++++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index 806c3878b3d6..5a2e35dc41e3 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -125,7 +125,7 @@ int analogix_dp_enable_psr(struct analogix_dp_device *dp)
 	psr_vsc.DB0 = 0;
 	psr_vsc.DB1 = EDP_VSC_PSR_STATE_ACTIVE | EDP_VSC_PSR_CRC_VALUES_VALID;
 
-	return analogix_dp_send_psr_spd(dp, &psr_vsc);
+	return analogix_dp_send_psr_spd(dp, &psr_vsc, true);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_enable_psr);
 
@@ -151,7 +151,7 @@ int analogix_dp_disable_psr(struct analogix_dp_device *dp)
 	if (ret != 1)
 		dev_err(dp->dev, "Failed to set DP Power0 %d\n", ret);
 
-	return analogix_dp_send_psr_spd(dp, &psr_vsc);
+	return analogix_dp_send_psr_spd(dp, &psr_vsc, false);
 }
 EXPORT_SYMBOL_GPL(analogix_dp_disable_psr);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
index 920607d7eb3e..6a96ef7e6934 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
@@ -253,7 +253,7 @@ void analogix_dp_enable_scrambling(struct analogix_dp_device *dp);
 void analogix_dp_disable_scrambling(struct analogix_dp_device *dp);
 void analogix_dp_enable_psr_crc(struct analogix_dp_device *dp);
 int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
-			     struct edp_vsc_psr *vsc);
+			     struct edp_vsc_psr *vsc, bool blocking);
 ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			     struct drm_dp_aux_msg *msg);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 005a3f7005d2..9df2f3ef000c 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1007,7 +1007,7 @@ static ssize_t analogix_dp_get_psr_status(struct analogix_dp_device *dp)
 }
 
 int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
-			     struct edp_vsc_psr *vsc)
+			     struct edp_vsc_psr *vsc, bool blocking)
 {
 	unsigned int val;
 	int ret;
@@ -1053,6 +1053,9 @@ int analogix_dp_send_psr_spd(struct analogix_dp_device *dp,
 	val |= IF_EN;
 	writel(val, dp->reg_base + ANALOGIX_DP_PKT_SEND_CTL);
 
+	if (!blocking)
+		return 0;
+
 	ret = readx_poll_timeout(analogix_dp_get_psr_status, dp, psr_status,
 		psr_status >= 0 &&
 		((vsc->DB1 && psr_status == DP_PSR_SINK_ACTIVE_RFB) ||
-- 
2.16.1
