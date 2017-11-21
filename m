From: leo.yan@linaro.org (Leo Yan)
Date: Tue, 21 Nov 2017 11:08:42 +0800
Subject: [PATCH v2 2/4] coresight: Add and delete dump node for
 registration/unregistration
In-Reply-To: <1511233724-11867-1-git-send-email-leo.yan@linaro.org>
References: <1511233724-11867-1-git-send-email-leo.yan@linaro.org>
Message-ID: <1511233724-11867-3-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Coresight device registration is a proper time point to insert dump
node, the dump code utilizes the coresight device has panic callback
function pointer as flag to indicate if need insert panic node or not.
If the coresight device has panic callback function isn't NULL, then
allocates dump node and inserts node into list, otherwise directly
bail out with success.

When coresight device unregistration, it removes dump node from list
and releases resource properly.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 drivers/hwtracing/coresight/coresight.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index b8091be..3248f9b 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1044,6 +1044,10 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	if (ret)
 		goto err_device_register;
 
+	ret = coresight_dump_add(csdev, desc->pdata ? desc->pdata->cpu : 0);
+	if (ret)
+		goto err_dump_add;
+
 	mutex_lock(&coresight_mutex);
 
 	coresight_fixup_device_conns(csdev);
@@ -1053,6 +1057,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	return csdev;
 
+err_dump_add:
+	device_unregister(&csdev->dev);
 err_device_register:
 	kfree(conns);
 err_kzalloc_conns:
@@ -1068,6 +1074,7 @@ void coresight_unregister(struct coresight_device *csdev)
 {
 	/* Remove references of that device in the topology */
 	coresight_remove_conns(csdev);
+	coresight_dump_del(csdev);
 	device_unregister(&csdev->dev);
 }
 EXPORT_SYMBOL_GPL(coresight_unregister);
-- 
2.7.4
