From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:15 +0100
Subject: [PATCH 04/12] drm/dp: fix training interval formula for DP 1.3+
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-5-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

In DP standard v1.2, DP_TRAINING_AUX_RD_INTERVAL DPCD "register" only
has 0x0 to 0x4 values that are valid, the rest is reserved.

In DP standard v1.3+, DP_TRAINING_AUX_RD_INTERVAL DPCD "register" has
the same 0x0 to 0x4 valid values but there is an additional bit (bit 7)
that specifies if there is an Extended Receiver Capability field or not.

Thus, the formula for getting the training interval is now broken on DP
1.3+.

Let's add a mask for the training interval and a define for the Extended
Receiver Capability field presence.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c |   14 ++++++++++----
 include/drm/drm_dp_helper.h     |    2 ++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index ca2f469..7f5d568 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -149,18 +149,24 @@ void drm_dp_set_adjust_request_pre_emphasis(u8 link_status[DP_LINK_STATUS_SIZE],
 EXPORT_SYMBOL(drm_dp_set_adjust_request_pre_emphasis);
 
 void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]) {
-	if (dpcd[DP_TRAINING_AUX_RD_INTERVAL] == 0)
+	unsigned int training_interval = dpcd[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_INTERVAL_MASK;
+
+	if (training_interval == 0)
 		udelay(100);
 	else
-		mdelay(dpcd[DP_TRAINING_AUX_RD_INTERVAL] * 4);
+		mdelay(training_interval * 4);
 }
 EXPORT_SYMBOL(drm_dp_link_train_clock_recovery_delay);
 
 void drm_dp_link_train_channel_eq_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE]) {
-	if (dpcd[DP_TRAINING_AUX_RD_INTERVAL] == 0)
+	unsigned int training_interval = dpcd[DP_TRAINING_AUX_RD_INTERVAL] &
+		DP_TRAINING_AUX_RD_INTERVAL_MASK;
+
+	if (training_interval == 0)
 		udelay(400);
 	else
-		mdelay(dpcd[DP_TRAINING_AUX_RD_INTERVAL] * 4);
+		mdelay(training_interval * 4);
 }
 EXPORT_SYMBOL(drm_dp_link_train_channel_eq_delay);
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 6e64b2a..bd593df 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -119,6 +119,8 @@
 # define DP_DPCD_DISPLAY_CONTROL_CAPABLE     (1 << 3) /* edp v1.2 or higher */
 
 #define DP_TRAINING_AUX_RD_INTERVAL         0x00e   /* XXX 1.2? */
+# define DP_TRAINING_AUX_RD_INTERVAL_MASK   GENMASK(6, 0)
+# define DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT BIT(7) /* 1.3 */
 
 #define DP_ADAPTER_CAP			    0x00f   /* 1.2 */
 # define DP_FORCE_LOAD_SENSE_CAP	    (1 << 0)
-- 
1.7.1
