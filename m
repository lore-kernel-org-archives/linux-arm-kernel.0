From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu,  9 Mar 2017 15:27:11 +0000
Subject: [PATCH 1/2] coresight: Disable the path only when the source is
 disabled
In-Reply-To: <1489073232-5093-1-git-send-email-suzuki.poulose@arm.com>
References: <1489073232-5093-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1489073232-5093-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With a coresight tracing session, the components along the path
from the source to sink are disabled after the source is disabled.
However, if the source was not actually disabled due to active
users, we should not disable the components in the path.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 0c37356..34cd1ed 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -253,7 +253,8 @@ static int coresight_enable_source(struct coresight_device *csdev, u32 mode)
 	return 0;
 }
 
-static void coresight_disable_source(struct coresight_device *csdev)
+/* coresight_disable_source: Returns true if the device has been disabled */
+static bool coresight_disable_source(struct coresight_device *csdev)
 {
 	if (atomic_dec_return(csdev->refcnt) == 0) {
 		if (source_ops(csdev)->disable) {
@@ -261,6 +262,7 @@ static void coresight_disable_source(struct coresight_device *csdev)
 			csdev->enable = false;
 		}
 	}
+	return !csdev->enable;
 }
 
 void coresight_disable_path(struct list_head *path)
@@ -629,7 +631,7 @@ void coresight_disable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (!csdev->enable)
+	if (!csdev->enable || !coresight_disable_source(csdev))
 		goto out;
 
 	switch (csdev->subtype.source_subtype) {
@@ -647,7 +649,6 @@ void coresight_disable(struct coresight_device *csdev)
 		break;
 	}
 
-	coresight_disable_source(csdev);
 	coresight_disable_path(path);
 	coresight_release_path(path);
 
-- 
2.7.4
