From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Fri,  9 Mar 2018 23:23:17 +0100
Subject: [PATCH v5 26/36] drm/bridge: analogix_dp: Properly disable aux chan
 retries on rockchip
In-Reply-To: <20180309222327.18689-1-enric.balletbo@collabora.com>
References: <20180309222327.18689-1-enric.balletbo@collabora.com>
Message-ID: <20180309222327.18689-27-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Douglas Anderson <dianders@chromium.org>

The comments in analogix_dp_init_aux() claim that we're disabling aux
channel retries, but then right below it for Rockchip it sets them to
3.  If we actually need 3 retries for Rockchip then we could adjust
the comment, but it seems more likely that we want the same retry
behavior across all platforms.

Cc: St?phane Marchesin <marcheu@chromium.org>
Cc: ?? ? <wzz@rock-chips.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---

 drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 58e8a28e99aa..a5f2763d72e4 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -481,15 +481,16 @@ void analogix_dp_init_aux(struct analogix_dp_device *dp)
 
 	analogix_dp_reset_aux(dp);
 
-	/* Disable AUX transaction H/W retry */
+	/* AUX_BIT_PERIOD_EXPECTED_DELAY doesn't apply to Rockchip IP */
 	if (dp->plat_data && is_rockchip(dp->plat_data->dev_type))
-		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(0) |
-		      AUX_HW_RETRY_COUNT_SEL(3) |
-		      AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
+		reg = 0;
 	else
-		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3) |
-		      AUX_HW_RETRY_COUNT_SEL(0) |
-		      AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
+		reg = AUX_BIT_PERIOD_EXPECTED_DELAY(3);
+
+	/* Disable AUX transaction H/W retry */
+	reg |= AUX_HW_RETRY_COUNT_SEL(0) |
+	       AUX_HW_RETRY_INTERVAL_600_MICROSECONDS;
+
 	writel(reg, dp->reg_base + ANALOGIX_DP_AUX_HW_RETRY_CTL);
 
 	/* Receive AUX Channel DEFER commands equal to DEFFER_COUNT*64 */
-- 
2.16.1
