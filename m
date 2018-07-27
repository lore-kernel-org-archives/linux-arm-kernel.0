From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri, 27 Jul 2018 11:15:29 +0100
Subject: [PATCH v3 1/9] coresight: Document error handling in
 coresight_register
In-Reply-To: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
References: <1532686537-12380-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1532686537-12380-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 6403587a930c ("coresight: use put_device() instead of kfree()")
fixes the double freeing of resources and ensures that the device
refcount is dropped properly. Add a comment to explain this to
help the readers and prevent people trying to "unfix" it again.

While at it, rename the labels for better readability.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Change since v1:
 - Document the error handling than trying to "unfix" the
   problem.
---
 drivers/hwtracing/coresight/coresight.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 3e07fd3..9fd0c38 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1006,7 +1006,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
 	if (!csdev) {
 		ret = -ENOMEM;
-		goto err_kzalloc_csdev;
+		goto err_out;
 	}
 
 	if (desc->type == CORESIGHT_DEV_TYPE_LINK ||
@@ -1022,7 +1022,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
 	if (!refcnts) {
 		ret = -ENOMEM;
-		goto err_kzalloc_refcnts;
+		goto err_free_csdev;
 	}
 
 	csdev->refcnt = refcnts;
@@ -1035,7 +1035,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
 		if (!conns) {
 			ret = -ENOMEM;
-			goto err_kzalloc_conns;
+			goto err_free_refcnts;
 		}
 
 		for (i = 0; i < csdev->nr_outport; i++) {
@@ -1062,7 +1062,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	ret = device_register(&csdev->dev);
 	if (ret) {
 		put_device(&csdev->dev);
-		goto err_kzalloc_csdev;
+		/*
+		 * All resources are free'd explicitly via
+		 * coresight_device_release(), triggered from put_device().
+		 */
+		goto err_out;
 	}
 
 	mutex_lock(&coresight_mutex);
@@ -1074,11 +1078,11 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	return csdev;
 
-err_kzalloc_conns:
+err_free_refcnts:
 	kfree(refcnts);
-err_kzalloc_refcnts:
+err_free_csdev:
 	kfree(csdev);
-err_kzalloc_csdev:
+err_out:
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(coresight_register);
-- 
2.7.4
