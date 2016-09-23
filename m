From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 23 Sep 2016 16:06:40 +0200
Subject: [PATCH 2/2] drm/rockchip: analogix_dp: Refuse to enable PSR if panel
 doesn't support it
In-Reply-To: <1474639600-30090-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1474639600-30090-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1474639600-30090-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no point in enabling PSR when the panel doesn't support it.

This also avoids a problem when PSR gets enabled when a CRTC is being
disabled, because sometimes in that situation the DSP_HOLD_VALID_INTR
interrupt on which we wait will never arrive. This was observed on
RK3288 with a panel without PSR (veyron-jaq Chromebook).

It's very easy to reproduce by running the kms_rmfb test in IGT a few
times.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Yakir Yang <ykk@rock-chips.com>
Cc: Archit Taneja <architt@codeaurora.org>
---
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index e83be157cc2a..8548e8271639 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -85,6 +85,9 @@ static void analogix_dp_psr_set(struct drm_encoder *encoder, bool enabled)
 	struct rockchip_dp_device *dp = to_dp(encoder);
 	unsigned long flags;
 
+	if (!analogix_dp_psr_supported(dp->dev))
+		return;
+
 	dev_dbg(dp->dev, "%s PSR...\n", enabled ? "Entry" : "Exit");
 
 	spin_lock_irqsave(&dp->psr_lock, flags);
-- 
2.7.4
