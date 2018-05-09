From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  9 May 2018 12:06:03 -0600
Subject: [PATCH 1/6] coresight: use put_device() instead of kfree()
In-Reply-To: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
References: <1525889168-20574-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1525889168-20574-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arvind Yadav <arvind.yadav.cs@gmail.com>

Never directly free @dev after calling device_register(), even
if it returned an error. Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 389c4baeca9d..132dfbcd90c1 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1026,8 +1026,10 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	dev_set_name(&csdev->dev, "%s", desc->pdata->name);
 
 	ret = device_register(&csdev->dev);
-	if (ret)
-		goto err_device_register;
+	if (ret) {
+		put_device(&csdev->dev);
+		goto err_kzalloc_csdev;
+	}
 
 	mutex_lock(&coresight_mutex);
 
@@ -1038,8 +1040,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	return csdev;
 
-err_device_register:
-	kfree(conns);
 err_kzalloc_conns:
 	kfree(refcnts);
 err_kzalloc_refcnts:
-- 
2.7.4
