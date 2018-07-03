From: dkos@cadence.com (Damian Kos)
Date: Tue, 3 Jul 2018 11:02:12 +0100
Subject: [PATCH 01/12] HACK: increase timeout for
 drm_atomic_helper_wait_for_vblanks
In-Reply-To: <1530612152-27555-1-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
Message-ID: <1530612152-27555-2-git-send-email-dkos@cadence.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Quentin Schulz <quentin.schulz@free-electrons.com>

Due to the DP IP being simulated in a different and way slower way than
the rest of the hardware, increase the timeout in
drm_atomic_helper_wait_for_vblanks so that we don't miss the vblank
event.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_atomic_helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index c356545..0171249 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1345,7 +1345,7 @@ int drm_atomic_helper_wait_for_fences(struct drm_device *dev,
 		ret = wait_event_timeout(dev->vblank[i].queue,
 				old_state->crtcs[i].last_vblank_count !=
 					drm_crtc_vblank_count(crtc),
-				msecs_to_jiffies(50));
+				msecs_to_jiffies(4000));
 
 		WARN(!ret, "[CRTC:%d:%s] vblank wait timed out\n",
 		     crtc->base.id, crtc->name);
-- 
1.7.1
