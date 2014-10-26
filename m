From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 26 Oct 2014 17:38:45 +0800
Subject: [PATCH 2/3] soc: ti: knav_qmss_queue: Fix unbalanced locking in
 knav_pool_create()
In-Reply-To: <1414316264.4290.2.camel@phoenix>
References: <1414316264.4290.2.camel@phoenix>
Message-ID: <1414316325.4290.3.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't call mutex_unlock() in the error patch if the mutex_lock() is not called.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 0a2c863..d66aaf2 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -785,7 +785,7 @@ void *knav_pool_create(const char *name,
 		dev_err(kdev->dev, "out of descs in region(%d) for pool(%s)\n",
 			region_id, name);
 		ret = -ENOMEM;
-		goto err;
+		goto err_unlock;
 	}
 
 	/* Region maintains a sorted (by region offset) list of pools
@@ -815,15 +815,16 @@ void *knav_pool_create(const char *name,
 		dev_err(kdev->dev, "pool(%s) create failed: fragmented desc pool in region(%d)\n",
 			name, region_id);
 		ret = -ENOMEM;
-		goto err;
+		goto err_unlock;
 	}
 
 	mutex_unlock(&knav_dev_lock);
 	kdesc_fill_pool(pool);
 	return pool;
 
-err:
+err_unlock:
 	mutex_unlock(&knav_dev_lock);
+err:
 	kfree(pool->name);
 	devm_kfree(kdev->dev, pool);
 	return ERR_PTR(ret);
-- 
1.9.1
