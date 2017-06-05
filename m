From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon,  5 Jun 2017 14:15:03 -0600
Subject: [PATCH 02/17] coresight: Fix reference count for software sources
In-Reply-To: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1496693718-9191-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

For software sources (i.e STM), there could be multiple agents
generating the trace data, unlike the ETMs. So we need to
properly do the accounting for the active number of users
to disable the device when the last user goes away. Right
now, the reference counting is broken for sources as we skip
the actions when we detect that the source is enabled.

This patch fixes the problem by adding the refcounting for
software sources, even when they are enabled.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Reported-by: Robert Walker <robert.walker@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 532a2acfa8cc..6a0202b7384f 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -558,6 +558,9 @@ int coresight_enable(struct coresight_device *csdev)
 	int cpu, ret = 0;
 	struct coresight_device *sink;
 	struct list_head *path;
+	enum coresight_dev_subtype_source subtype;
+
+	subtype = csdev->subtype.source_subtype;
 
 	mutex_lock(&coresight_mutex);
 
@@ -565,8 +568,16 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (csdev->enable)
+	if (csdev->enable) {
+		/*
+		 * There could be multiple applications driving the software
+		 * source. So keep the refcount for each such user when the
+		 * source is already enabled.
+		 */
+		if (subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE)
+			atomic_inc(csdev->refcnt);
 		goto out;
+	}
 
 	/*
 	 * Search for a valid sink for this session but don't reset the
@@ -593,7 +604,7 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto err_source;
 
-	switch (csdev->subtype.source_subtype) {
+	switch (subtype) {
 	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
 		/*
 		 * When working from sysFS it is important to keep track
-- 
2.7.4
