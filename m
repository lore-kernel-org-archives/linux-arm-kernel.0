From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:13 +0100
Subject: [PATCH 02/12] drm/dp: make dp_link_status and dp_get_lane_status
 usable from outside of the core
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-3-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

dp_link_status and dp_get_lane_status are pretty generic and can be used
for other means, so let's make it "public".

This adds drm_dp_link_status and drm_dp_get_lane_status to the header
file and add the appropriate EXPORT_SYMBOL for it so that it can be used
by other drivers, be they compiled built-in or as modules.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c |   20 +++++++++++---------
 include/drm/drm_dp_helper.h     |    3 +++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index ffe14ec..3bc2e98 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -43,19 +43,21 @@
  */
 
 /* Helpers for DP link training */
-static u8 dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
+u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r)
 {
 	return link_status[r - DP_LANE0_1_STATUS];
 }
+EXPORT_SYMBOL(drm_dp_link_status);
 
-static u8 dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE],
 			     int lane)
 {
 	int i = DP_LANE0_1_STATUS + (lane >> 1);
 	int s = (lane & 1) * 4;
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 	return (l >> s) & 0xf;
 }
+EXPORT_SYMBOL(drm_dp_get_lane_status);
 
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count)
@@ -64,12 +66,12 @@ bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	u8 lane_status;
 	int lane;
 
-	lane_align = dp_link_status(link_status,
-				    DP_LANE_ALIGN_STATUS_UPDATED);
+	lane_align = drm_dp_link_status(link_status,
+					DP_LANE_ALIGN_STATUS_UPDATED);
 	if ((lane_align & DP_INTERLANE_ALIGN_DONE) == 0)
 		return false;
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_CHANNEL_EQ_BITS) != DP_CHANNEL_EQ_BITS)
 			return false;
 	}
@@ -84,7 +86,7 @@ bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 	u8 lane_status;
 
 	for (lane = 0; lane < lane_count; lane++) {
-		lane_status = dp_get_lane_status(link_status, lane);
+		lane_status = drm_dp_get_lane_status(link_status, lane);
 		if ((lane_status & DP_LANE_CR_DONE) == 0)
 			return false;
 	}
@@ -99,7 +101,7 @@ u8 drm_dp_get_adjust_request_voltage(const u8 link_status[DP_LINK_STATUS_SIZE],
 	int s = ((lane & 1) ?
 		 DP_ADJUST_VOLTAGE_SWING_LANE1_SHIFT :
 		 DP_ADJUST_VOLTAGE_SWING_LANE0_SHIFT);
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 
 	return ((l >> s) & 0x3) << DP_TRAIN_VOLTAGE_SWING_SHIFT;
 }
@@ -112,7 +114,7 @@ u8 drm_dp_get_adjust_request_pre_emphasis(const u8 link_status[DP_LINK_STATUS_SI
 	int s = ((lane & 1) ?
 		 DP_ADJUST_PRE_EMPHASIS_LANE1_SHIFT :
 		 DP_ADJUST_PRE_EMPHASIS_LANE0_SHIFT);
-	u8 l = dp_link_status(link_status, i);
+	u8 l = drm_dp_link_status(link_status, i);
 
 	return ((l >> s) & 0x3) << DP_TRAIN_PRE_EMPHASIS_SHIFT;
 }
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 62903ba..a488af0 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -935,6 +935,9 @@
 #define DP_MST_LOGICAL_PORT_0 8
 
 #define DP_LINK_STATUS_SIZE	   6
+
+u8 drm_dp_link_status(const u8 link_status[DP_LINK_STATUS_SIZE], int r);
+u8 drm_dp_get_lane_status(const u8 link_status[DP_LINK_STATUS_SIZE], int lane);
 bool drm_dp_channel_eq_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
 			  int lane_count);
 bool drm_dp_clock_recovery_ok(const u8 link_status[DP_LINK_STATUS_SIZE],
-- 
1.7.1
