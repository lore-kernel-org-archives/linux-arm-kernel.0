From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 29 Mar 2017 17:33:34 +0100
Subject: [PATCH v2 1/2] coresight: Disable the path only when the source is
 disabled
In-Reply-To: <1490805215-8125-1-git-send-email-suzuki.poulose@arm.com>
References: <1490805215-8125-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1490805215-8125-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a coresight tracing session, the components along the path
from the source to sink are disabled after the source is disabled.
However, if the source was not actually disabled due to active
users, we should not disable the components in the path.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 0c37356..532a2ac 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -253,14 +253,22 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 	return 0;
 }
 
-static void coresight_disable_source(struct coresight_device *csdev)
+/**
+ *  coresight_disable_source - Drop the reference count by 1 and disable
+ *  the device if there are no users left.
+ *
+ *  @csdev - The coresight device to disable
+ *
+ *  Returns true if the device has been disabled.
+ */
+static bool coresight_disable_source(struct coresight_device *csdev)
 {
 	if (atomic_dec_return(csdev->refcnt) == 0) {
-		if (source_ops(csdev)->disable) {
+		if (source_ops(csdev)->disable)
 			source_ops(csdev)->disable(csdev, NULL);
-			csdev->enable = false;
-		}
+		csdev->enable = false;
 	}
+	return !csdev->enable;
 }
 
 void coresight_disable_path(struct list_head *path)
@@ -629,7 +637,7 @@ void coresight_disable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (!csdev->enable)
+	if (!csdev->enable || !coresight_disable_source(csdev))
 		goto out;
 
 	switch (csdev->subtype.source_subtype) {
@@ -647,7 +655,6 @@ void coresight_disable(struct coresight_device *csdev)
 		break;
 	}
 
-	coresight_disable_source(csdev);
 	coresight_disable_path(path);
 	coresight_release_path(path);
 
-- 
2.7.4
