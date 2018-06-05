From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:12 +0100
Subject: [PATCH 01/20] coresight: Fix memory leak in coresight_register
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 6403587a930c ("coresight: use put_device() instead of kfree()")
introduced a memory leak where, if we fail to register the device
for coresight_device, we don't free the "coresight_device" object,
which was allocated via kzalloc(). Fix this by jumping to the
appropriate error path.

Fixes: commit 6403587a930c ("coresight: use put_device() instead of kfree()")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 4969b32..2893cfe 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1020,7 +1020,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	ret = device_register(&csdev->dev);
 	if (ret) {
 		put_device(&csdev->dev);
-		goto err_kzalloc_csdev;
+		goto err_kzalloc_refcnts;
 	}
 
 	mutex_lock(&coresight_mutex);
-- 
2.7.4
