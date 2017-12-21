From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 21 Dec 2017 16:20:14 +0800
Subject: [PATCH v3 5/6] coresight: Add and delete sink callback for panic
 kdump list
In-Reply-To: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
References: <1513844415-11427-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1513844415-11427-6-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the sink device has panic kdump callback, this means the sink device
wants to save tracing data for panic happening.

This commit adds node into panic kdump list when the sink device is
enabled, and delete node when the sink device is disabled.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 389c4ba..56798b1 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -146,6 +146,14 @@ static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
 			if (ret)
 				return ret;
 		}
+
+		/* Add into panic kdump list */
+		if (sink_ops(csdev)->panic_cb) {
+			ret = coresight_kdump_add(csdev, 0);
+			if (ret)
+				return ret;
+		}
+
 		csdev->enable = true;
 	}
 
@@ -157,6 +165,10 @@ static int coresight_enable_sink(struct coresight_device *csdev, u32 mode)
 static void coresight_disable_sink(struct coresight_device *csdev)
 {
 	if (atomic_dec_return(csdev->refcnt) == 0) {
+		/* Delete from panic kdump list */
+		if (sink_ops(csdev)->panic_cb)
+			coresight_kdump_del(csdev);
+
 		if (sink_ops(csdev)->disable) {
 			sink_ops(csdev)->disable(csdev);
 			csdev->enable = false;
-- 
2.7.4
