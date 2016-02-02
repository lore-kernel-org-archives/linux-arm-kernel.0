From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  2 Feb 2016 14:13:57 -0700
Subject: [PATCH 3/7] coresight: coresight_unregister() function cleanup
In-Reply-To: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
References: <1454447641-29153-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1454447641-29153-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In its current form the code never frees csdev->refcnt allocated
in coresight_register().  There is also a problem with csdev->conns
that is freed before device_unregister() rather than in the device
release function.

This patch addresses both issues by moving kfree(csdev->conns) to
coresight_device_release() and freeing csdev->refcnt, also in
the same function.

Reported-by: Rabin Vincent <rabin@rab.in>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 41b42018b660..8872db4410eb 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -481,6 +481,8 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
+	kfree(csdev->conns);
+	kfree(csdev->refcnt);
 	kfree(csdev);
 }
 
@@ -713,7 +715,6 @@ EXPORT_SYMBOL_GPL(coresight_register);
 
 void coresight_unregister(struct coresight_device *csdev)
 {
-	kfree(csdev->conns);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
-- 
2.1.4
