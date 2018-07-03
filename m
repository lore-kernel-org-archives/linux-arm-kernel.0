From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:18 +0100
Subject: [PATCH 07/12] drm/dp: fix drm_dp_link_train_clock_recovery_delay for
 DP 1.4
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-8-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

In DP 1.4, interval between link status and adjust request read for the
clock recovery phase is fixed to 100us whatever the value of the
register is.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index b6a27ab..92f3880 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -152,6 +152,11 @@ void drm_dp_link_train_clock_recovery_delay(const u8 dpcd[DP_RECEIVER_CAP_SIZE])
 	unsigned int training_interval = dpcd[DP_TRAINING_AUX_RD_INTERVAL] &
 		DP_TRAINING_AUX_RD_INTERVAL_MASK;
 
+	if (dpcd[DP_DPCD_REV] == 0x14) {
+		udelay(100);
+		return;
+	}
+
 	if (training_interval == 0)
 		udelay(100);
 	else
-- 
1.7.1
